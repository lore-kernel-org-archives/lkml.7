Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933E0C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6273E20731
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419115;
	bh=Hrd8Tdvryc7oSkiufmHyOEffL6pZMUZ+GAVv0e3zuzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iRR2UvQr6CizZIwTf9pJNnPwxgERrx5JidwCkuOAnjaiLMPiYN497AXR9v+dv8Hcw
	 /bsUXCx6YW2n3YIZZrSRdrXF5NOR8Aa00lREAqpFIs5kW7i37gEeqKY91GVr4e6lMm
	 vyB0mqKsTCLiGw21ckQ/4NYbeoyl9llj4x3OA6NI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfKVKie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:38:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:40976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbfKVKic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:38:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D92CD20717;
        Fri, 22 Nov 2019 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419112;
        bh=Hrd8Tdvryc7oSkiufmHyOEffL6pZMUZ+GAVv0e3zuzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xxUeR0BExnBD7UdmeqVohSNQvPj5/eiEyDMOU+dB8zOm3LPWfCfsJe8YPqgMQuKVp
         gShzQowWFzdR6SvG1RHp0amN+dV8P1K/EfVwZiLNQVHEeSzGhC5+iw0yZclo7RVMR/
         oQcCezVTdceXv4nLdsiwr+sokSYI1LcPldO5AKKQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 124/159] powerpc/pseries: Fix DTL buffer registration
Date:   Fri, 22 Nov 2019 11:28:35 +0100
Message-Id: <20191122100831.665820415@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

[ Upstream commit db787af1b8a6b4be428ee2ea7d409dafcaa4a43c ]

When CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set, we register the DTL
buffer for a cpu when the associated file under powerpc/dtl in debugfs
is opened. When doing so, we need to set the size of the buffer being
registered in the second u32 word of the buffer. This needs to be in big
endian, but we are not doing the conversion resulting in the below error
showing up in dmesg:

	dtl_start: DTL registration for cpu 0 (hw 0) failed with -4

Fix this in the obvious manner.

Fixes: 7c105b63bd98 ("powerpc: Add CONFIG_CPU_LITTLE_ENDIAN kernel config option.")
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/dtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index 39049e4884fbd..37de83c5ef172 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -150,7 +150,7 @@ static int dtl_start(struct dtl *dtl)
 
 	/* Register our dtl buffer with the hypervisor. The HV expects the
 	 * buffer size to be passed in the second word of the buffer */
-	((u32 *)dtl->buf)[1] = DISPATCH_LOG_BYTES;
+	((u32 *)dtl->buf)[1] = cpu_to_be32(DISPATCH_LOG_BYTES);
 
 	hwcpu = get_hard_smp_processor_id(dtl->cpu);
 	addr = __pa(dtl->buf);
-- 
2.20.1



