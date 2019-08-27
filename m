Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A01C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DCD2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893632;
	bh=OY9SJmSrjhX2NBbtIla/LU/YBp0OWmNoJClT+LL2iyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LuJfm/EIfTMEbkXoVrtVFXG5iNhs13FI6UAO8kPRc6BpkDxRtobB+oiPrbjohNGzz
	 CZvKT+TWxYwF+J+ImBJjlmRg1hDx7N68lFGyOYpkXhK3EkVM4mX3ZF2Zhz4+Rlj+g0
	 k1MYj8KNwIuvnlD4HqDjdLEk7iBvFFhv0EGQxDTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbfH0INu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730818AbfH0H5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:57:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FCBD206BF;
        Tue, 27 Aug 2019 07:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892654;
        bh=OY9SJmSrjhX2NBbtIla/LU/YBp0OWmNoJClT+LL2iyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ca/I0T8j9CgQ9vrE+HU4YPMiF/lkPtIkr3WPfr92HJql7rpCUrXjFNDwW6/1BNFIM
         hC5oDy+X25TQHfkcSzNrHC9i4abYtr6i8Bn3CCKaGE8ouKcxAaTJE+KqOuozorJGNq
         avD5yH9bb224sjeVtDoB8mXBpVjgiAOzijP56Gj0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Juliana Rodrigueiro <juliana.rodrigueiro@intra2net.com>
Subject: [PATCH 4.19 68/98] Drivers: hv: vmbus: Fix virt_to_hvpfn() for X86_PAE
Date:   Tue, 27 Aug 2019 09:50:47 +0200
Message-Id: <20190827072721.837454768@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
References: <20190827072718.142728620@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

commit a9fc4340aee041dd186d1fb8f1b5d1e9caf28212 upstream.

In the case of X86_PAE, unsigned long is u32, but the physical address type
should be u64. Due to the bug here, the netvsc driver can not load
successfully, and sometimes the VM can panic due to memory corruption (the
hypervisor writes data to the wrong location).

Fixes: 6ba34171bcbd ("Drivers: hv: vmbus: Remove use of slow_virt_to_phys()")
Cc: stable@vger.kernel.org
Cc: Michael Kelley <mikelley@microsoft.com>
Reported-and-tested-by: Juliana Rodrigueiro <juliana.rodrigueiro@intra2net.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hv/channel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -38,7 +38,7 @@
 
 static unsigned long virt_to_hvpfn(void *addr)
 {
-	unsigned long paddr;
+	phys_addr_t paddr;
 
 	if (is_vmalloc_addr(addr))
 		paddr = page_to_phys(vmalloc_to_page(addr)) +


