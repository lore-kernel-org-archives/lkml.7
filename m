Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438BEC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BA52080F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Hc4qLWQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732739AbfK0VZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:25:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35907 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbfK0VBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:01:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id k13so11602643pgh.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 13:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=AU8WPHPcJwgxJBr+X5FwEaImchiySZo1ynMHnH/canY=;
        b=Hc4qLWQGgzdCLdShOcG5ZNTa/yab3KUhfeglShq0i2R4fmTs3ScV3yul6Gnes0iN1k
         wa9/8P0PcpHA+ovA7kwe+triOy0bT0vqoIviQcLuBfQwHx7+WSJN+2bl52WimqB7cq2r
         EpTMoES7T2vTdNSV61kd7vvJhAAcvxbaqK0OaDg8N6FqPPagNAUWRgttd/mgWr+MltOZ
         BBpNi5GjVHuIdyh5ntVVxZuDlJQg5SL00KBW373A5jUJtx7iuuHjAB39sNGsVZJaUKDB
         AK8UljEf6RpABB1H2XUhG7KlBYdhDUY4wipLYJCe1C7thbSY2HSKnC+YrYTpZhLTq4XU
         PxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=AU8WPHPcJwgxJBr+X5FwEaImchiySZo1ynMHnH/canY=;
        b=Vemw4S+LqwM5zJb0z7+i+Xlin1X1mNE7Y9VROs1NevydzLhQDEUKsMotpRVsQVDtp7
         qHwZ0osGUASKEoABIpsdbp6Li/f0ivaUXC/N7NsmwRahMyl5C1CknOHU79gs+ZGwZ9Mr
         TaJGPeCs/Ftc/+VX6i0U9y4zwWNZnXbLbpXBxQ0m7N5XktKCh5JrxXAkPYOhz3SOCYqY
         5jUA+HUIdGirgrEtqH28jjxJYynMJIPeC8gI6CzDHU8+LQfxLhy5p30llGskJlfIcmxx
         tCi/SKDBV2ozkzFYRTNV6EVV6j0prF4+gGcTeQS3W5Px5RuQn49kuZzETi6XK0Hk5AaQ
         Y1bw==
X-Gm-Message-State: APjAAAVoBFC510fBo7WkzNYZWTo/RKfdDePuTPM7Ilc8DIa2XagEXCu5
        P41ItiXoc0MnkqqqCT2zaCv5rg==
X-Google-Smtp-Source: APXvYqw2eYiOY7qHUrx2gd0AFV4DscYLFlAid/UrgT/WzOkK/60VIf2S04E8iQpIjLF5OagNNZ2efw==
X-Received: by 2002:aa7:9409:: with SMTP id x9mr49838829pfo.168.1574888502882;
        Wed, 27 Nov 2019 13:01:42 -0800 (PST)
Received: from ?IPv6:2600:1010:b01a:c632:65aa:1159:6a8b:716d? ([2600:1010:b01a:c632:65aa:1159:6a8b:716d])
        by smtp.gmail.com with ESMTPSA id s15sm7539145pjp.3.2019.11.27.13.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 13:01:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] lkdtm/bugs: Avoid ifdefs for DOUBLE_FAULT
Date:   Wed, 27 Nov 2019 13:01:40 -0800
Message-Id: <E359D543-FB4E-4EF5-85E6-40057B57C58F@amacapital.net>
References: <201911271118.FCC2D04F@keescook>
Cc:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        x86 <x86@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <201911271118.FCC2D04F@keescook>
To:     Kees Cook <keescook@chromium.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 27, 2019, at 11:19 AM, Kees Cook <keescook@chromium.org> wrote:
>=20
> =EF=BB=BFLKDTM test visibility shouldn't change, so remove the ifdefs on
> DOUBLE_FAULT and make sure test failure doesn't crash the system.
>=20
> Link: https://lore.kernel.org/lkml/20191127184837.GA35982@gmail.com
> Fixes: b09511c253e5 ("lkdtm: Add a DOUBLE_FAULT crash type on x86")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> applies on top of tip/x86/urgent
> ---
> drivers/misc/lkdtm/bugs.c  | 8 +++++---
> drivers/misc/lkdtm/core.c  | 4 +---
> drivers/misc/lkdtm/lkdtm.h | 2 --
> 3 files changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index a4fdad04809a..22f5293414cc 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -342,9 +342,9 @@ void lkdtm_UNSET_SMEP(void)
> #endif
> }
>=20
> -#ifdef CONFIG_X86_32
> void lkdtm_DOUBLE_FAULT(void)
> {
> +#ifdef CONFIG_X86_32
>    /*
>     * Trigger #DF by setting the stack limit to zero.  This clobbers
>     * a GDT TLS slot, which is okay because the current task will die
> @@ -373,6 +373,8 @@ void lkdtm_DOUBLE_FAULT(void)
>    asm volatile ("movw %0, %%ss; addl $0, (%%esp)" ::
>              "r" ((unsigned short)(GDT_ENTRY_TLS_MIN << 3)));
>=20
> -    panic("tried to double fault but didn't die\n");
> -}
> +    pr_err("FAIL: tried to double fault but didn't die!\n");
> +#else
> +    pr_err("FAIL: this test is only available on 32-bit x86.\n");
> #endif
> +}

I=E2=80=99m not familiar with the userspace tooling, but this seems unfortun=
ate. The first FAIL is =E2=80=9Cthe test case screwed up, and it=E2=80=99s a=
 bug.=E2=80=9D  The second FAIL is =E2=80=9Cnot applicable to this system.=E2=
=80=9D


ISTM simply not exposing the test on systems that don=E2=80=99t support make=
s sense. Can you clarify?=
