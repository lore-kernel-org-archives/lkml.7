Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9AAC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 09:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70C92148E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 09:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfDNJ7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 05:59:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42460 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfDNJ7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 05:59:34 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFbv9-0007is-90; Sun, 14 Apr 2019 11:59:31 +0200
Date:   Sun, 14 Apr 2019 11:59:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Xose Vazquez Perez <xose.vazquez@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86 team <x86@kernel.org>
Subject: Re: bug disabling NX (noexec=off)
In-Reply-To: <c090ad3c-1f2f-c148-dd44-a58df0788588@gmail.com>
Message-ID: <alpine.DEB.2.21.1904141158400.4917@nanos.tec.linutronix.de>
References: <c090ad3c-1f2f-c148-dd44-a58df0788588@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Apr 2019, Xose Vazquez Perez wrote:
> [    0.000000] NX (Execute Disable) protection: disabled by kernel command line option
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] attempted to set unsupported pgprot: 8000000000000163 bits: 8000000000000000 supported: 7fffffffffffffff

Does the below patch fix it for you?

Thanks,

	tglx

8<----------------
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 0029604af8a4..dd73d5d74393 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -825,7 +825,7 @@ void __init __early_set_fixmap(enum fixed_addresses idx,
 	pte = early_ioremap_pte(addr);
 
 	/* Sanitize 'prot' against any unsupported bits: */
-	pgprot_val(flags) &= __default_kernel_pte_mask;
+	pgprot_val(flags) &= __supported_pte_mask;
 
 	if (pgprot_val(flags))
 		set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
