Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADE9C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573BA20870
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOFJWzec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfDNUHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:07:41 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43311 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfDNUHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:07:40 -0400
Received: by mail-io1-f68.google.com with SMTP id x3so12831893iol.10
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HnFCy7ZqED74wR1CjiPz4L97c+BzfOzmQB1kkOmZGYk=;
        b=GOFJWzecaOsNFOPZ3IgrXycGRodgGGav1bQcE0acUcf8LLtOnxjGofO3BFusitWHUN
         J8zbNSyG9Sl96zLJLNMWgaEDCSZrbZAdz0rnZ3TCw21vAQyq2vKt3OjkxqxnPlKGdyBo
         EYCD6xJh8KeZspiI3zLL+MEg0jTCB9+X1N2mR9mzxJrW+8XCaLpkiP/HGOhpwzDnOARU
         QcgXRTyoZiNS9LFbooKLtUa5UhunmGuz238bQ/kVUnfDCGr6dLv8snMHDBTEcxDlKMp9
         7CJI+0ipGtgMD0P6/60e/UFPZJ6eh+cJQL1/l/j88vZA+hbjAyOamYNPa91AYAGOgIGs
         +VFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HnFCy7ZqED74wR1CjiPz4L97c+BzfOzmQB1kkOmZGYk=;
        b=lnKiL8uEf8nta4LaAPw3ZKM5x38NZDGod5GlxjQtLjKmUdtDmyEd6U/mGBz3Mi7nrW
         CSHCD6nVm0BCquEUzRsuVoBO+Q8HSkYd50IGsDI97ETrITIkXCp53Wi3cbTw2AX60GL3
         0OEbQnW3Fa7LjjoI8uQ74DHLNCVbZuvBG3L0s6bCr0OxyynK82x5kkOqEf9yo2tgTJmf
         YVeWkMBCePuQ7zkpC4AluQIrbtQt/hy1Uq1FbgkBJiANM277+KgpyMKJ/a8tWys+2cAS
         /FOdfvYeaKwedoZE72ozYS6o54hOXJh0fe7Sy0B4WGUCeupNUM1YZ75Iqz0ise0aNJPP
         fWOw==
X-Gm-Message-State: APjAAAVOXI3u8MskXk3QlHuRlF7LwDACBPAZReszlG627jhf76PK2v5k
        f6rKkSPTnnd3nkO705o4miPibDSPC8dsOIJqEABfQeOxyTUltA==
X-Google-Smtp-Source: APXvYqyyhe3U9kq86WBF8LyPc/n/mPHJVwtSU0MgL9WLzN1ybAQCyFdwlDQlNnsOllNGlWLEhZr7uy0XppfTv4Fns7U=
X-Received: by 2002:a5d:9a8d:: with SMTP id c13mr11300067iom.195.1555272459764;
 Sun, 14 Apr 2019 13:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsM8gjvh8x9QyzbrbnSb-NmWpmmEUJnFiFv5MaPkcG=Ubg@mail.gmail.com>
 <CABXGCsMcS+H9jxEotmM3u8F28zhPobvT3+Hd_iWstFQN744v6Q@mail.gmail.com> <alpine.DEB.2.21.1904141948200.4917@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904141948200.4917@nanos.tec.linutronix.de>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 15 Apr 2019 01:07:28 +0500
Message-ID: <CABXGCsNaw=mb0YF4Bkd5_CTwMfU=dNZ=RTV96dwO=UQy=n_gOQ@mail.gmail.com>
Subject: Re: [5.0.0 rc3 BUG] possible irq lock inversion dependency detected
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Apr 2019 at 22:51, Thomas Gleixner <tglx@linutronix.de> wrote:
> Because mails fall through the cracks occasionally.
>
> Does the patch below cure your problem?
>
> Thanks,
>
>         tglx
>
> 8<------------------
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -426,6 +426,8 @@ static __always_inline void __speculatio
>         u64 msr = x86_spec_ctrl_base;
>         bool updmsr = false;
>
> +       lockdep_assert_irqs_disabled();
> +
>         /*
>          * If TIF_SSBD is different, select the proper mitigation
>          * method. Note that if SSBD mitigation is disabled or permanentely
> @@ -477,10 +479,12 @@ static unsigned long speculation_ctrl_up
>
>  void speculation_ctrl_update(unsigned long tif)
>  {
> +       unsigned long flags;
> +
>         /* Forced update. Make sure all relevant TIF flags are different */
> -       preempt_disable();
> +       local_irq_save(flags);
>         __speculation_ctrl_update(~tif, tif);
> -       preempt_enable();
> +       local_irq_restore(flags);
>  }
>
>  /* Called from seccomp/prctl update */

Thanks, with this patch problem was gone.
We have time land it in 5.1?

--
Best Regards,
Mike Gavrilov.
