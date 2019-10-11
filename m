Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CC9C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1435214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+WIECfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfJKF4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:56:43 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38138 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfJKF4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:56:43 -0400
Received: by mail-yw1-f65.google.com with SMTP id s6so3078923ywe.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 22:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pe6e9mNl/y0Gbnhlz0OK+rTALdS40mdMde2Yhq6pRx4=;
        b=J+WIECfJvoDfcmVnvSSBIZ4lNss2OgFow+NE64WEmLj/C9nSi5FbKuwHQr1GIMC0Yi
         OA/dKcBPrbvi2PsqXUglXBW0UsH9BPsNcRz5nR9xyCWKr1pBrh8RPor7oujvR3fnJweD
         E87uoLOUeUEtU2yJDO6g9bGzTblY+0i02TDSS9+E2n+PCk5QlknLelEdFq77/fvfmWoo
         yXab8s2H1jag3DQ+ydbKr4IJ/x/1sJG0BXwjm11tn1wXZnw/UpxjWKanh+xC53DKFQWY
         2fhgRfkrpdHpGGShABubbyl2MBd4GAW20/7A+j5xT8be423rVJFa9fMIAaUv31cemTHB
         s6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pe6e9mNl/y0Gbnhlz0OK+rTALdS40mdMde2Yhq6pRx4=;
        b=mqWsdkv6BdrgMOW8JhjAeRKcobgG0IkCD+ubzTSreJ5RaJCidQ2qZ1rIHdNFXQf3iN
         Y0JlIp5uAu1MOSTLzTwNS0niPNclsbrjF+M0WchbV1m7GRfuV3/x86AWG1sH//7cfYJo
         CskXjN7tiE5kJIKkv3Rju5M21COVzon5iJniGK9zArIWHFv94ih13B+mU8stjZE4IFJ4
         iFbIs/U3ZkKwoz/aK/uuVPNJlxIfnwrSFPvyFiI9X/MkVTua5XUzfDUUCcAj2zbM0kJF
         FxArojux5kenYAZekufyp1LAYaLSuLKYlQqDrf2jVNRX7dmBAsE7z5AyzYNjkXHMoGNp
         QUkA==
X-Gm-Message-State: APjAAAV++EyDMyXWGwbiWN+iMhyz0Anl+5b/XAtgnxWQbPlPqj7Ferhz
        IdtheHcvjbyy3DKsZbJf16xOPkJrR5dZqSqgjMc=
X-Google-Smtp-Source: APXvYqxX5Ag0UvYinmkF5SB7/dX0f1cfnLGQ4rgibnQ/l3STGcAuL5YynQVyOviGB+3r1+YI979fSLdXYgQZkCa4wKg=
X-Received: by 2002:a81:4320:: with SMTP id q32mr1039014ywa.464.1570773402419;
 Thu, 10 Oct 2019 22:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <1569483508-18768-1-git-send-email-candlesea@gmail.com>
 <20190930153437.ocatny7u4z3oj7k2@willie-the-truck> <CAPnx3XMqnQ4R=_gkL6Rye=4adV=qCRUs2sm5A6kJccDCQ82xnw@mail.gmail.com>
In-Reply-To: <CAPnx3XMqnQ4R=_gkL6Rye=4adV=qCRUs2sm5A6kJccDCQ82xnw@mail.gmail.com>
From:   Candle Sun <candlesea@gmail.com>
Date:   Fri, 11 Oct 2019 13:56:31 +0800
Message-ID: <CAPnx3XN99m8NH31eHrK+tpeUXy0DLUmTppd0Q3TskSGj2e_FPg@mail.gmail.com>
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

Will,
Is the patch useful for you? Would you please give me some suggestions?
Thank you.

Regards,
Candle


On Tue, Oct 8, 2019 at 3:20 PM Candle Sun <candlesea@gmail.com> wrote:
>
> Hi Will,
> Sorry for not instant respond.
>
>
> On Mon, Sep 30, 2019 at 11:34 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Thu, Sep 26, 2019 at 03:38:28PM +0800, Candle Sun wrote:
> > > From: Candle Sun <candle.sun@unisoc.com>
> > >
> > > When ARMv8.1/ARMv8.2 cores are used in AArch32 mode,
> > > arch_hw_breakpoint_init() in arch/arm/kernel/hw_breakpoint.c will be used.
> > >
> > > From ARMv8 specification, different debug architecture versions defined:
> > > * 0110 ARMv8, v8 Debug architecture.
> > > * 0111 ARMv8.1, v8 Debug architecture, with Virtualization Host Extensions.
> > > * 1000 ARMv8.2, v8.2 Debug architecture.
> > >
> > > So missing ARMv8.1/ARMv8.2 cases will cause enable_monitor_mode() function
> > > returns -ENODEV, and arch_hw_breakpoint_init() will fail.
> > >
> > > Signed-off-by: Candle Sun <candle.sun@unisoc.com>
> > > Signed-off-by: Nianfu Bai <nianfu.bai@unisoc.com>
> > > ---
> > >  arch/arm/include/asm/hw_breakpoint.h | 2 ++
> > >  arch/arm/kernel/hw_breakpoint.c      | 2 ++
> > >  2 files changed, 4 insertions(+)
> >
> > How did you test this?
> >
> > Will
>
> We have the SoC with A55 cores. On one Android project, for saving memory usage,
> we let A55 run in aarch32 mode.
> While the following failures occue on Android CtsBionicTestCases:
> --sys_ptrace#watchpoint_imprecisede
> --sys_ptrace#hardware_breakpoint
> --sys_ptrace#watchpoint_stress
>
> The code snippet for testing is:
>
> static void check_hw_feature_supported(pid_t child, HwFeature feature) {
> #if defined(__arm__)
>   long capabilities;
>   long result = ptrace(PTRACE_GETHBPREGS, child, 0, &capabilities);
>   if (result == -1) {
>     EXPECT_EQ(EIO, errno);
>     GTEST_SKIP() << "Hardware debug support disabled at kernel
> configuration time";
>   }
>   uint8_t hb_count = capabilities & 0xff;
>   capabilities >>= 8;
>   uint8_t wp_count = capabilities & 0xff;
>   capabilities >>= 8;
>   uint8_t max_wp_size = capabilities & 0xff;
>   if (max_wp_size == 0) {
>     GTEST_SKIP() << "Kernel reports zero maximum watchpoint size";
>   } else if (feature == HwFeature::Watchpoint && wp_count == 0) {
>     GTEST_SKIP() << "Kernel reports zero hardware watchpoints";
>   } else if (feature == HwFeature::Breakpoint && hb_count == 0) {
>     GTEST_SKIP() << "Kernel reports zero hardware breakpoints";
>   }
> #elif defined(__aarch64__)
>   user_hwdebug_state dreg_state;
>   iovec iov;
>   iov.iov_base = &dreg_state;
>   iov.iov_len = sizeof(dreg_state);
>
>   long result = ptrace(PTRACE_GETREGSET, child,
>                        feature == HwFeature::Watchpoint ?
> NT_ARM_HW_WATCH : NT_ARM_HW_BREAK, &iov);
>   if (result == -1) {
>     ASSERT_EQ(EINVAL, errno);
>   }
>   if ((dreg_state.dbg_info & 0xff) == 0) GTEST_SKIP() << "hardware
> support missing";
> #else
>   // We assume watchpoints and breakpoints are always supported on x86.
>   UNUSED(child);
>   UNUSED(feature);
> #endif
> }
>
> The max_wp_size field returned by __ptrace() from kernel is zero,
> which causes the test failures.
>
> After futher analysis, we found max_watchpoint_len variable is not
> right initialized in kernel
> arch_hw_breakpoint_init() function. Missing the case of ARM_DEBUG_ARCH_V8_2 in
> enable_monitor_mode() directly aborts the arch_hw_breakpoint_int().
>
> Candle
> Best regards
