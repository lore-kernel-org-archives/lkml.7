Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B64C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE5A216C4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355783;
	bh=Wfi5sjJAO0p3rdmcBrx/KKtYN2W7HX4627JgRQ/b/QQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1n+0XMcB+frJQ3tSM99sToEKPCd5Sb6R77RtZKgKk8HUaPR73a5erWrxcIsIa1EI7
	 a+Bprlp978IgdIlRLS1xWY2SNoAKwVdx6om6egoQDHTOFrY+hPBhJPqONYnPRvVc4R
	 PMiVKqT05Aq0mM6IXstzESJr88S2mzd1CuEEvJy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391269AbfETMgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391253AbfETMgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:36:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4C6721479;
        Mon, 20 May 2019 12:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355778;
        bh=Wfi5sjJAO0p3rdmcBrx/KKtYN2W7HX4627JgRQ/b/QQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dxre2+1sMnrwDGKDtZKwKEbWGf7q4lZXbjIjbCsVZctchphTpohkgnDOoMPLFU2Rn
         7GiC8pZnEWcznat0prIXxtoh0WVatGTpf7fV4k116QuOCDb3wzjhQH1FpnhOy/0i66
         2D4qZyfNha88FfQQZLoEJiGcOtqS1RpFRON+siRE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 5.1 121/128] xen/pvh: set xen_domain_type to HVM in xen_pvh_init
Date:   Mon, 20 May 2019 14:15:08 +0200
Message-Id: <20190520115256.833930543@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115249.449077487@linuxfoundation.org>
References: <20190520115249.449077487@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Pau Monne <roger.pau@citrix.com>

commit c9f804d64bb93c8dbf957df1d7e9de11380e522d upstream.

Or else xen_domain() returns false despite xen_pvh being set.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: stable@vger.kernel.org # 4.19+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/enlighten_pvh.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -27,6 +27,7 @@ void __init xen_pvh_init(void)
 	u64 pfn;
 
 	xen_pvh = 1;
+	xen_domain_type = XEN_HVM_DOMAIN;
 	xen_start_flags = pvh_start_info.flags;
 
 	msr = cpuid_ebx(xen_cpuid_base() + 2);


