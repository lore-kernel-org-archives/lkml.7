Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC69C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4322420675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbQDu/K6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfCFH6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:58:46 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39429 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfCFH6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:58:46 -0500
Received: by mail-io1-f66.google.com with SMTP id x3so9439939ior.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 23:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NM3xQT8ZCO4/Dlq3Ro+mfnRddwV3Pbik78B0afnrzLw=;
        b=UbQDu/K66YYoyGR+gDY2au5cxMtJ7vmotfGbOhXeob4n4R1tpmRGB6wewLBlkhI/f3
         CHoay/boJrgRoQb7b92duBEoTCMnAimjiAPBx3vlK4fJ/e7OtzFWTO8W67RRG/5xtA86
         IHA0CJ/EDAHdk4ZYWfFH4SvMyZ/gwVnsNVpyDPyvV9PmCKFRYikb5afEzHcDQJsksPvr
         HIIpEZjvX9CYXDRZXXcjcxWTKUibRGDfF+rtW1opurszAEI/F/SRiPW5JqO07mPMJa7r
         aOyuuja8zuGtZxck0yu0qzdciZw5b0x8QuwaH9BU63j0HykdwplCZobtQ4ZK9FRTDQpH
         KR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NM3xQT8ZCO4/Dlq3Ro+mfnRddwV3Pbik78B0afnrzLw=;
        b=KJfsCKQf8iai6TxhujiZZAl9khWDPLNzBwyDJ4X18ZBnODH/R1PonzjmgIaSie0LME
         hH4AiXcLcfnsMwcwC1dXxJyazw6Jyz5KzWz+WB70+4NlqZamGiRT6IedU3CnBiCBHASs
         EukyX2/ouBZ45+cnrQZ/Av5m+AEsGJeA7fsktMOomx+GtL9PlWV+7j8BK/Imcm7odb9v
         vu60dRzp+nyg11/NcPpQ1NnDNTgeN/rxl0Db4vnzGc9CcYJ6zSJlORCn7cO02urU3ZS+
         6BNYqwVbYyqKPiIDPS4DwPtACrpTIJhUoDL2twTAGNNlKJMDu7RmT/EniPl5AFCr5lJQ
         oWQg==
X-Gm-Message-State: APjAAAUL5b3pmecWmqSk4/9gfLzrXm3BgaPSn+hBEJcuSaqESyu1LQCQ
        QhWjmgnpaiH4ZSRQsfImIhpfAKNa2jjL3DPTVA==
X-Google-Smtp-Source: APXvYqx4WI3i+3worYG3ambSfq+7VbRpDQg4MfhUKE2wp8kPcoBVtcrMO6ifbfjhv5fgzzkkymSD4geaMJTbKvNniQs=
X-Received: by 2002:a6b:c889:: with SMTP id y131mr2517449iof.106.1551859125218;
 Tue, 05 Mar 2019 23:58:45 -0800 (PST)
MIME-Version: 1.0
References: <1551081596-2856-1-git-send-email-kernelfans@gmail.com>
 <20190225094522.GC26145@zn.tnic> <CAFgQCTtYp5mV0xmt4ZJbS0igBFe8S1ZbUnuTWE1-wj8CuHPJew@mail.gmail.com>
 <20190226104653.GB14836@zn.tnic> <20190227013034.GP14858@MiWiFi-R3L-srv> <20190227073958.GA1786@zn.tnic>
In-Reply-To: <20190227073958.GA1786@zn.tnic>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 6 Mar 2019 15:58:33 +0800
Message-ID: <CAFgQCTtR1YvzScYYj4LyLdZnWo5o-HCgatZLvP401EQ6hEpBxA@mail.gmail.com>
Subject: Re: [PATCH] x86/boot/KASLR: skip the specified crashkernel reserved region
To:     Borislav Petkov <bp@alien8.de>
Cc:     Baoquan He <bhe@redhat.com>, Kees Cook <keescook@chromium.org>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 3:40 PM Borislav Petkov <bp@alien8.de> wrote:
>
> + Kees.
>
> @Kees, you might want to go upthread a bit for context.
>
Seems not reply from Kees.
> On Wed, Feb 27, 2019 at 09:30:34AM +0800, Baoquan He wrote:
> > Agree that 'crashkernel=x' should be encouraged to use as the first
> > choice when reserve crashkernel. If we decide to not obsolete
> > 'crashkernel=x@y', it will leave a unstable kernel parameter.
>
> Is anyone even talking about obsoleting this?
>
> And if anyone is, anyone can think a bit why we can't do this.
>
As Dave said, some un-relocatable code should be loaded to a specified
space. Also the param is used by archs beside x86
> > Another worry is that KASLR won't always fail 'crashkernel=x@y',
> > customer may set and check in testing stage, then later in production
> > environment one time of neglect to not check may cause carashed kernel
> > uncaptured.
> >
> > IMHO, 'crashkernel=x@y' is similar to those specified memmap=ss[#$!]nn
> > which have been avoided in boot stage KASLR.
>
> So my worry is that by specifying too many exclusion ranges, we might
> limit the kaslr space too much and make it too predictable. Especially
> since distros slap those things automatically and most users take them
> for granted.
>
Kernel has already done this excluding 1gb pages. Do we need to worry
about 200-400 MB for crashkernel? And I think if a user specify the
region, then he/she should be aware of the limit of KASLR (can printk
to warn him/her).

> But I might be way off here because of something else I'm missing ...
>
So how do you think about this now? Just leaving a unstable kernel
parameter, or printk some info when crashkernel=x@y fails.

Thanks,
Pingfan
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
