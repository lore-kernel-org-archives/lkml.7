Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96784C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 04:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F1B217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 04:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mxuU3lqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfEKE2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 00:28:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46543 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfEKE2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 00:28:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id y11so4241635pfm.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 21:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references:from
         :subject:cc:to:message-id:user-agent:date;
        bh=hRMart1iNsOfZ4XtJXaVBFmcLibgJ1Ww0Q9rcJYqncQ=;
        b=mxuU3lqGlXDteyUl0MMAp2DhltFQ/CtjpqvD8F3YkxvLDZN/zIoabjRQTvV8rcF69a
         usUWAH0yKi00jc2+uaHYCKIiaqiQYAF/4KaUPycf00WltUiTeOeYCuXY3kZKfQakuncV
         /SMTyG83pJ0UjEEsoZB5Ualr+BdGMQI1fe6jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:from:subject:cc:to:message-id:user-agent
         :date;
        bh=hRMart1iNsOfZ4XtJXaVBFmcLibgJ1Ww0Q9rcJYqncQ=;
        b=JVFs1bfckXuLMyggNAE4yY2NsRMWuFobKn6yXLavlgycH/R0AogkKAYEBFLeyv2kXw
         JDFbFiLSRSb50h3AcZtZxmn3BOnFJjFnFKQHJO/hUbNQv/UL/90RRPkfxa3wdnfErsgG
         ExWQtrcrsYVVqe1IJAODOeRSLg5BXAE2ZaPexEQY7MZx0n/mAZUpoUGfRurR/GOnmwmo
         rkYeQzs8nJHVl65QO8OTyblGMMCEXycf9jhJsFMMwEMsqvYANcEl7dkShPuJIz52Y0sL
         4yLGeK7pPMghD5qgnipEUDi7oCj8UPr8EeIYxU2cSqDJnqoor3U+7XQ60QXTYxH0VfKQ
         iMgQ==
X-Gm-Message-State: APjAAAVrQjMLaUpIBmHVj9RtkK60LKBaDvIY+ZEOumuW43B5CFp6osKV
        ehdlg7RVMcOWg47W7Iv5dsrovQ==
X-Google-Smtp-Source: APXvYqyzN5HRGYMbLWVdEGazvcCcceqk7ClqB7NwVd6g1nCPGn5gGQF88ZZhvF3fV1QDpgNPA2K1GA==
X-Received: by 2002:a62:6341:: with SMTP id x62mr18776769pfb.63.1557548917910;
        Fri, 10 May 2019 21:28:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s19sm8637374pfe.74.2019.05.10.21.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 21:28:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <36fab640-b98e-9781-f96f-0ed988a71077@rasmusvillemoes.dk>
References: <20190507045433.542-1-hsinyi@chromium.org> <CAL_Jsq+rGeFKAPVmPvv_Z+G=BppKUK-tEUphBajZVxFtbRBJvQ@mail.gmail.com> <CAJMQK-iVhScf0ybZ85kqP0B5_QPoYZ9PZt35jHRUh8FNHKvu7w@mail.gmail.com> <CAL_JsqJZ+mOnrLWt0Cpo_Ybr_ohxwWom1qiyV8_EFocULde7=Q@mail.gmail.com> <CAJMQK-jjzYwX3NZAKJ-8ypjcN75o-ZX4iOVD=84JecEd4qV1bA@mail.gmail.com> <CAL_JsqLnmedF5cJYH+91U2Q_WX755O8TQs6Ue9mqtEiFKcjGWQ@mail.gmail.com> <CAJMQK-hJUG855+TqX=droOjUfb-MKnU0n0FYtr_SW2KByKAW1w@mail.gmail.com> <36fab640-b98e-9781-f96f-0ed988a71077@rasmusvillemoes.dk>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] arm64: add support for rng-seed
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        Kees Cook <keescook@chromium.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rob Herring <robh+dt@kernel.org>
Message-ID: <155754891575.14659.7326257870940088515@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 10 May 2019 21:28:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rasmus Villemoes (2019-05-09 23:14:00)
>=20
> So, why not just have the bootloader add whatever entropy it has via the
> commandline, which already gets mixed in? That requires no kernel
> changes, and works for all architectures.
>=20
> If anything, perhaps instead of just adding gobbledygook=3Dabc123, make an
> official command line parameter (there was talk about this at some
> point), and have the kernel overwrite the value with xxx so it's not
> visible in /proc/cmdline.
>=20

Why is using the commandline desired? Just for ease of implementation
and cross-architecture support because we already mix in the
commandline?=20

The kernel commandline is limited in size so we would waste around
64-bytes of the buffer to get a random chunk of data from the bootloader
into the kernel instead of allowing more parameters. Or if we wanted a
large chunk of random bytes then we would start running into the length
limit. Given that EFI based systems already have a way to inject more
randomness into the kernel's RNG very early by means of an RNG seed EFI
protocol it looks irrelevant to want to be cross-architecture in this
way because EFI platforms wouldn't use it.=20

If DT based systems can all get support for this in the generic DT code
then we're able to make things work on both EFI and DT platforms with a
little extra __init code while keeping things away from the commandline.
That sounds like a win to me because the commandline is limited in size
and meant to pass things like parameters and flags to the kernel, not
raw data like seeds and binary gook.

