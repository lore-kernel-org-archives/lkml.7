Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F41C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDAA20716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qjwE7K4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfLQM3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:29:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42412 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbfLQM3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:29:32 -0500
Received: from zn.tnic (p200300EC2F0BBF009DDBE489521279C1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:bf00:9ddb:e489:5212:79c1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 047001EC0B59;
        Tue, 17 Dec 2019 13:29:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576585771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7FIO8m4gw+qbpPaquABHLNLPbeVC3yHY/vncqs2E34A=;
        b=qjwE7K4HpZ22nrLwRCzBpIPcDOxRNbvTOR9RkYe2vQWuoqKS67fCiySh96Mtzk2UzAhA2X
        pKCL+8fxAmXwiSKWd2/hO5ijg8HTnQRZK3J9DN0N1YDRTJYgoaVNzwbsg+fWlv2eG4Fhhl
        Iaju9hLI/N/Sza4pSCJIgb0A25pUnGQ=
Date:   Tue, 17 Dec 2019 13:29:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, luto@kernel.org, riel@surriel.com,
        dave.hansen@intel.com, longman@redhat.com, mtosatti@redhat.com,
        linux-kernel@vger.kernel.org,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Subject: Re: [PATCH] x86/process: remove unused variable in __switch_to_xtra()
Message-ID: <20191217122922.GD28788@zn.tnic>
References: <0efac42a-1631-d93d-d8a2-e6cf65cdf16b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0efac42a-1631-d93d-d8a2-e6cf65cdf16b@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 08:09:08PM +0800, Yunfeng Ye wrote:
> After the commit ecc7e37d4dad ("x86/io: Speedup schedule out of I/O
> bitmap user") and commit 22fe5b0439dd ("x86/ioperm: Move TSS bitmap
> update to exit to user work"), warning is found:
> 
> arch/x86/kernel/process.c: In function ‘__switch_to_xtra’:
> arch/x86/kernel/process.c:618:31: warning: variable ‘next’ set but not
> used [-Wunused-but-set-variable]
>   struct thread_struct *prev, *next;
>                                ^~~~
> arch/x86/kernel/process.c:618:24: warning: variable ‘prev’ set but not
> used [-Wunused-but-set-variable]
>   struct thread_struct *prev, *next;
>                         ^~~~
> Fix this by removing the unused variable @prev and @next;
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
>  arch/x86/kernel/process.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 61e93a318983..839b5244e3b7 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -615,12 +615,8 @@ void speculation_ctrl_update_current(void)
> 
>  void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
>  {
> -	struct thread_struct *prev, *next;
>  	unsigned long tifp, tifn;
> 
> -	prev = &prev_p->thread;
> -	next = &next_p->thread;
> -
>  	tifn = READ_ONCE(task_thread_info(next_p)->flags);
>  	tifp = READ_ONCE(task_thread_info(prev_p)->flags);
> 
> -- 

Let me introduce you to your colleague yu kuai:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/cleanups&id=27353d5785bca61bb49cfd7c78e14f1d21e66ec5

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
