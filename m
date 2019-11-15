Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F370FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B982073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfKOW3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:29:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44709 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfKOW3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:29:05 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iVk5D-0008CL-0v; Fri, 15 Nov 2019 23:28:51 +0100
Date:   Fri, 15 Nov 2019 23:28:49 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "kernelci.org bot" <bot@kernelci.org>
cc:     tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        mgalka@collabora.com, broonie@kernel.org, matthew.hart@linaro.org,
        khilman@baylibre.com, enric.balletbo@collabora.com,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <Babu.Moger@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: next/master bisection: boot on qemu_i386
In-Reply-To: <5dcf1f39.1c69fb81.409da.a39c@mx.google.com>
Message-ID: <alpine.DEB.2.21.1911152327020.28787@nanos.tec.linutronix.de>
References: <5dcf1f39.1c69fb81.409da.a39c@mx.google.com>
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

On Fri, 15 Nov 2019, kernelci.org bot wrote:
> -------------------------------------------------------------------------------
> commit bc1aca4ab8e08c01678e14138bea2fc433cd8068
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Mon Nov 11 23:03:16 2019 +0100
> 
>     x86/process: Unify copy_thread_tls()

Does the patch below fix it for you?

Thanks,

	tglx
---
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -148,6 +148,7 @@ int copy_thread_tls(unsigned long clone_
 	savesegment(es, p->thread.es);
 	savesegment(ds, p->thread.ds);
 #else
+	p->thread.sp0 = (unsigned long) (childregs + 1);
 	/* Clear all status flags including IF and set fixed bit. */
 	frame->flags = X86_EFLAGS_FIXED;
 #endif
