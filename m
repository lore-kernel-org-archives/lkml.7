Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7AEC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1521214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTEnU3Pz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKKRCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 12:02:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39901 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfKKRCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:02:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id t26so31132wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 09:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8jKXzjFxiNI4cA5WpDfyfduHU/2/pOXFBSoPzmL4nYU=;
        b=YTEnU3Pz3xr/+kfF4zzZI3ZAM1zmHORin9tMZwTsM9l+ct/JqaEji+fKDcHvnxhsEh
         X7DwuYQ4vlZeb2FFOaOaVolBLb0xPLRy5+t+o6fMePdCgRWBSpVhjokjSFIPLsW+Qn3a
         QknLnZ9DA0lvgzoDFAFjy2wH5vh6maDO1ABDUCLCh5nZhTKYp2qMPMJqSRBMFh3OjgQa
         fgf6wuedNAnWqdec0YTMYZqlZB7NQXC2IZ5sulXl/R6m0VobzFTb1i/uSn3E2+bUA3Y1
         lwRTpxCg2Iq7hYLWDEcJ7axpqODMovCXflRyLmLnopWVngkBIaJ1aIoh6x+5FFPcPt+d
         suOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8jKXzjFxiNI4cA5WpDfyfduHU/2/pOXFBSoPzmL4nYU=;
        b=R8aqaNnKu7gb/LsfSoLc/ZxS44Z3eStelQoOmUO8ALgGw4FIW+z2XAp8JbGGh9oc8k
         Gtrv9NwA+CrJ3Nq55NuiWsPyaepOooPeKrfwCmt3ufHjFIzrV6Qdz8+r3xx+L3e5XXHb
         eqnmwGUGlCzNMAa7VFYkLMCktN7FxkVs2tIdJJ2m/IiGPtr35nGs8yMvgXSjwP0jq90Q
         yKkO2+3EURQSENblLYUtX/swX/renteiSPJfsBKNwqs25rh2lD3tNltUv85DZh4gSP36
         BrzrYsvsLftylRn2yWF3YIrjWQm5Yh5QtgW+tWo0lXHq1I88+bbMz1hH0D/xFj9XYMeB
         otqw==
X-Gm-Message-State: APjAAAUSxerL9RiQoyGXzrODbMFbCq/F6On972I/ZdJgNxBC8v+RU8+R
        uRFEUUz/pGKxw4a8Vaxh00e8sbL2iTaDmUOjIGY=
X-Google-Smtp-Source: APXvYqxMhV6kj3i0rr995Cd4g6vMKwFmSQfqHyFEqBW+IWvD8hMiXm+8IGuBX6Nwl5Uy5ooEQibN3yrfZJtYmXJjXEw=
X-Received: by 2002:a1c:9601:: with SMTP id y1mr20441359wmd.157.1573491720253;
 Mon, 11 Nov 2019 09:02:00 -0800 (PST)
MIME-Version: 1.0
References: <20191111133421.14390-1-anup.patel@wdc.com> <mvmv9rqcxpq.fsf@suse.de>
 <MN2PR04MB60616625B9BEFF634FA680728D740@MN2PR04MB6061.namprd04.prod.outlook.com>
 <mvm5zjqcwlr.fsf@suse.de> <MN2PR04MB60611FB55CDCF6AB5930C73A8D740@MN2PR04MB6061.namprd04.prod.outlook.com>
 <mvm1ruecpyv.fsf@suse.de>
In-Reply-To: <mvm1ruecpyv.fsf@suse.de>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Mon, 11 Nov 2019 19:01:23 +0200
Message-ID: <CAEn-LTrL_Dtka6So3Pj=G+BV2a-UoHxGGLLDF4dqAG68AnH_5g@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
To:     Andreas Schwab <schwab@suse.de>
Cc:     Anup Patel <Anup.Patel@wdc.com>, Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 6:55 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On Nov 11 2019, Anup Patel wrote:
>
> >> -----Original Message-----
> >> From: Andreas Schwab <schwab@suse.de>
> >> Sent: Monday, November 11, 2019 8:02 PM
> >> To: Anup Patel <Anup.Patel@wdc.com>
> >> Cc: Palmer Dabbelt <palmer@dabbelt.com>; Paul Walmsley
> >> <paul.walmsley@sifive.com>; Atish Patra <Atish.Patra@wdc.com>; Alistair
> >> Francis <Alistair.Francis@wdc.com>; Christoph Hellwig <hch@lst.de>; Anup
> >> Patel <anup@brainfault.org>; linux-riscv@lists.infradead.org; linux-
> >> kernel@vger.kernel.org
> >> Subject: Re: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
> >>
> >> On Nov 11 2019, Anup Patel wrote:
> >>
> >> >> -----Original Message-----
> >> >> From: Andreas Schwab <schwab@suse.de>
> >> >> Sent: Monday, November 11, 2019 7:38 PM
> >> >> To: Anup Patel <Anup.Patel@wdc.com>
> >> >> Cc: Palmer Dabbelt <palmer@sifive.com>; Paul Walmsley
> >> >> <paul.walmsley@sifive.com>; Atish Patra <Atish.Patra@wdc.com>;
> >> >> Alistair Francis <Alistair.Francis@wdc.com>; Christoph Hellwig
> >> >> <hch@lst.de>; Anup Patel <anup@brainfault.org>;
> >> >> linux-riscv@lists.infradead.org; linux- kernel@vger.kernel.org
> >> >> Subject: Re: [PATCH] RISC-V: Enable SYSCON reboot and poweroff
> >> >> drivers
> >> >>
> >> >> On Nov 11 2019, Anup Patel wrote:
> >> >>
> >> >> > We can use SYSCON reboot and poweroff drivers for the SiFive test
> >> >> > device found on QEMU virt machine and SiFive SOCs.
> >> >>
> >> >> I don't see any syscon-reboot compatible in the device tree.
> >> >
> >> > I have sent patch to QEMU as well for generating SYSCON DT nodes.
> >>
> >> What about the kernel DT?
> >
> > For QEMU virt machine, the DT is generated by QEMU at runtime
> > so we don't need an explicit DT file in Linux sources.
>
> What about the HiFiveU?

Unleashed uses gpio-restart which depends on gpio driver (not upstreamed and
not posted for review on mailing list). I have that working on my build.

david

>
> Andreas.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
