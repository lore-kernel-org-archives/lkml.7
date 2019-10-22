Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ABBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2DE218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL/FNY8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbfJVMiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 08:38:05 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38050 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfJVMiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 08:38:04 -0400
Received: by mail-yb1-f195.google.com with SMTP id r68so5083323ybf.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vqe+JDf7lxru1jxAApix4PrWiqgoGBD8c1cyEEgcqrE=;
        b=JL/FNY8AIG2cFwuPUArErStvGoncUr7Ku9MMD8uZ69Q1G21BYkrRLbsIlUKYSn7H06
         2dDG5woly8l7mPCHbZAmoh5ZSGfTpAo0dhPJxNveH0f0PYcgM084O9WM8pfugoP2zztG
         qYSybo2fclyUs1/KIcUQ9Ub3nff1hY8cZwtJkJESpRTMdxW7R+f/zkSMjYPfN1Lw8PZ5
         gk0CGIY3m08Ip/9jiD5QVAhpFMktXVP6j5WdQyAX4l+wmSB/ffucACjcfHd62GXi9vsl
         vmea+/YMSkID9Xy95yMwTcYYxb4f7LkXC72SbfEsdCdc5dpGagYwfnhssRD0bnU5uQPj
         hnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vqe+JDf7lxru1jxAApix4PrWiqgoGBD8c1cyEEgcqrE=;
        b=WkCfeP+p/7i1WzucIz3XnJZfHV0OxXCCrn2DbjJsOKPCzJHlmwSYCr5fkD5SidyVlR
         ozqMGeT5BROy/UDTb81x0ahz//Su7MYeB2ep3/z5U3x/06+10o5OtOtD2/a6eG4YbuPF
         FXxkeTo+y1j+nGqQ9U7/L0YSYfB/sWG/doawYq27vBAnlpPSIp4QnLQgMuN6msS8Dk5l
         EdB051p9GhXmCht6imcKjGTj8uUNSQJJAjz+q9fOU2U3lIAIXX9/atcEeKyDArlXx9hT
         +o5ECfJ4Nq3ahX8WMUHDR7KwvLfQgq7BKCN5FdXVU7A9mPt+gC3wj2knX5tMxLH0sufR
         AhIA==
X-Gm-Message-State: APjAAAUVZOmz3jxHqONWeH4vIhragXPBN1bCm8Zpnamn/QbuqYuJCADG
        g3BjAsRv0NWhUDkjR05CxGSKjZBmTOJQSnanOY4=
X-Google-Smtp-Source: APXvYqwM6+kvBzSdwrfHuERc1tibLhtRgB8VQ5xXy9dY5J59vNeFeO9D4XNBXJoXCz0aNpLTsJet6lWlQ9b83kq06Xw=
X-Received: by 2002:a25:5386:: with SMTP id h128mr2145519ybb.362.1571747883623;
 Tue, 22 Oct 2019 05:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <1569483508-18768-1-git-send-email-candlesea@gmail.com> <20191022122550.GA17232@willie-the-truck>
In-Reply-To: <20191022122550.GA17232@willie-the-truck>
From:   Candle Sun <candlesea@gmail.com>
Date:   Tue, 22 Oct 2019 20:37:51 +0800
Message-ID: <CAPnx3XP5nEMJwsT0tKD-Lm1MRf0cfR5KLfz0to+ZZ3pin6tEnA@mail.gmail.com>
Subject: Re: [RESEND PATCH] ARM/hw_breakpoint: add ARMv8.1/ARMv8.2 debug
 architecutre versions support in enable_monitor_mode()
To:     Will Deacon <will@kernel.org>
Cc:     mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        Candle Sun <candle.sun@unisoc.com>,
        Nianfu Bai <nianfu.bai@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 8:25 PM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Sep 26, 2019 at 03:38:28PM +0800, Candle Sun wrote:
> > From: Candle Sun <candle.sun@unisoc.com>
> >
> > When ARMv8.1/ARMv8.2 cores are used in AArch32 mode,
> > arch_hw_breakpoint_init() in arch/arm/kernel/hw_breakpoint.c will be used.
> >
> > From ARMv8 specification, different debug architecture versions defined:
> > * 0110 ARMv8, v8 Debug architecture.
> > * 0111 ARMv8.1, v8 Debug architecture, with Virtualization Host Extensions.
> > * 1000 ARMv8.2, v8.2 Debug architecture.
> >
> > So missing ARMv8.1/ARMv8.2 cases will cause enable_monitor_mode() function
> > returns -ENODEV, and arch_hw_breakpoint_init() will fail.
> >
> > Signed-off-by: Candle Sun <candle.sun@unisoc.com>
> > Signed-off-by: Nianfu Bai <nianfu.bai@unisoc.com>
> > ---
> >  arch/arm/include/asm/hw_breakpoint.h | 2 ++
> >  arch/arm/kernel/hw_breakpoint.c      | 2 ++
> >  2 files changed, 4 insertions(+)
>
> [...]
>
> > diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
> > index ac54c06..9137ef6 100644
> > --- a/arch/arm/include/asm/hw_breakpoint.h
> > +++ b/arch/arm/include/asm/hw_breakpoint.h
> > @@ -53,6 +53,8 @@ static inline void decode_ctrl_reg(u32 reg,
> >  #define ARM_DEBUG_ARCH_V7_MM 4
> >  #define ARM_DEBUG_ARCH_V7_1  5
> >  #define ARM_DEBUG_ARCH_V8    6
> > +#define ARM_DEBUG_ARCH_V8_1  7
> > +#define ARM_DEBUG_ARCH_V8_2  8
>
> Looks like you can also add:
>
> #define ARM_DEBUG_ARCH_V8_4     9
>
> and treat that the same way. With that, and a fix to $SUBJECT:
>
> Acked-by: Will Deacon <will@kernel.org>
>
> Please put this into the patch system [1].
>
> Will
>
> [1] https://www.arm.linux.org.uk/developer/patches/

Thanks, Will.
I will do it ASAP.

Best regards,
Candle
