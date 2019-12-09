Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A4AC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBFC2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVHqMyJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfLIJbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:31:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34318 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLIJbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:31:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id x17so298434pln.1;
        Mon, 09 Dec 2019 01:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BCh9dC7fcIHS//YV1KqLxuTq8XJDijjaKH2onWE4r9s=;
        b=rVHqMyJfU3FTJsAi+6+5E8fP5U0tplHEFmyTPdJc7o8hf6cvk2OsnESbc31CldCmgK
         bwcUibhQrTonMdl2ChcA6iOm041tSqXf7zov7z96t6tTKbFDSGyjr7N23vnR9qezvybF
         UrExOmQJRQYfG/ShZjOhsx2Xn3Dl2LaMSz2mAtd+2Gb7KJAFnsDEjurO9leT3mJ/a2Bz
         eJKqXCAfMwfLdAfSmCUHQhc4pbQ/Q2BlgrOHUv8Y9XZFqn6iz6c+zxnAn8WKIJgt7/Pw
         IHKu8h8a+xHrJydx+CNU6YHSXmKpcuI9xcsQ3zecdglf3yW7AL7nAEsIscuAIANA2yKc
         k37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BCh9dC7fcIHS//YV1KqLxuTq8XJDijjaKH2onWE4r9s=;
        b=MNvfn8nf96J2ikrAk2PHVu2Fh2DsapE9yPE1gZwxOvsjCLnVRB5c99kfz1UCwLT9O6
         kCBn+Iypk62m9ZiEXJRPJX047PdjEPGLNcumL7VP5RmjXdIzWxZ8Cag7yMe4uVGVYlpc
         S56+coNUzcGCpZUABjRwYT3OOIqIVvwVqesPZDlNiGr1OTM32ivNnV1EBSK4ZjYxR+R/
         278vpTX1iJclY+3cA9gy+bBfn5A6mvOqMI5cxmODQZZYbfOTT/K6tMlINr99dkZQ07rZ
         Zbwk9VLdJPnqZ9V23w5tAdkak3lfD5YOtsbK69KjdZNWCJ2reKcHnHIH8BdEF124Bwrz
         /PQQ==
X-Gm-Message-State: APjAAAXglCRH7Oxh/clGL7bD4yg39sizuQoPImpUMixoob1qffJVje58
        zerCEFckIbqz8KggZq/Ez2k=
X-Google-Smtp-Source: APXvYqznGDbrflqkItQETgIXhHrqVQiDQdjRYPK9RJNnGO3v0S8LQvD3Qrsa6m3IZG8T8GEP5rUNag==
X-Received: by 2002:a17:902:b403:: with SMTP id x3mr28816141plr.109.1575883893623;
        Mon, 09 Dec 2019 01:31:33 -0800 (PST)
Received: from udknight.localhost ([183.250.89.86])
        by smtp.gmail.com with ESMTPSA id z19sm24980429pfn.49.2019.12.09.01.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 01:31:32 -0800 (PST)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id xB99IlBX003828;
        Mon, 9 Dec 2019 17:18:47 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id xB99IfJA003808;
        Mon, 9 Dec 2019 17:18:41 +0800
Date:   Mon, 9 Dec 2019 17:18:41 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-realtek-soc@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: perf record doesn't work on rtd129x SoC
Message-ID: <20191209091841.GA3703@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-realtek-soc@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20191204045559.GA10458@udknight>
 <f90748d0-8112-3aa8-0c88-e35a8d6e72d3@suse.de>
 <1b2d2bc3-afcf-02c3-ccd6-e2a227c23fd3@arm.com>
 <b9788139-d2cb-9ed4-e887-04651968e5b1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9788139-d2cb-9ed4-e887-04651968e5b1@arm.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 02:51:24PM +0000, Robin Murphy wrote:
> On 04/12/2019 11:20 am, Robin Murphy wrote:
> > On 2019-12-04 7:28 am, Andreas Färber wrote:
> >> Hi YanQing,
> >>
> >> + LAKML + Mark + Will
> >>
> >> Am 04.12.19 um 05:55 schrieb Wang YanQing:
> >>> I use "perf record" to debug performance issue on RTD1296 SOC, it 
> >>> does't work, but
> >>> the "perf stat" is ok!
> >>
> >> Thanks for the report - which board, branch and (base) tag are you
> >> testing against? And are you building perf yourself from kernel sources,
> >> or are you using some distro package?
> >>
> >> I only have Busybox in my initrd on DS418; I have not tested perf.
> >>
> >>> After some dig in the kernel, I find the reason is no pmu overflow 
> >>> interrupt, I think
> >>> below pmu configuration isn't right for RTD1296:
> >>> "
> >>>          arm_pmu: arm-pmu {
> >>>                  compatible = "arm,cortex-a53-pmu";
> >>>                  interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> >>>          };
> >>> "
> >>>
> >>> We need 4 PMU SPI for RTD1296 (4 cores), and I guess the 48 isn't 
> >>> right too.
> >>
> >> Note that above rtd129x.dtsi snippet is not complete. See rtd1296.dtsi:
> >>
> >> &arm_pmu {
> >>     interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> >> };
> > 
> > That doesn't help much, since 4 affinities for one SPI is rather 
> > nonsensical.
> > 
> >> 48 and high/4 match what I see in the latest BSP:
> >>
> >> https://github.com/BPI-SINOVOIP/BPI-M4-bsp/blob/master/linux-rtk/arch/arm64/boot/dts/realtek/rtd129x/rtd-1296.dtsi#L116 
> >>
> >>
> >>> Any suggestion is welcome.
> >>>
> >>> Thanks!
> >>
> >> The only difference I see is "arm,cortex-a53-pmu" vs. "arm,armv8-pmuv3".
> >> By my reading of arch/arm64/kernel/perf_event.c the only difference
> >> between the two should be the name and an extra cache_map. You could try
> >> the other compatible string in your .dts, but I doubt it'll help.
> >>
> >> Hopefully the Realtek or Arm guys can shed some light.
> > 
> > If the SoC really has all 4 overflow interrupts combined into a single 
> > SPI line, then sampling just isn't going to be supported - it's 
> > unreasonably difficult to handle overflow when the IRQ may be taken on 
> > the wrong CPU.
> 
> On closer inspection, that BSP kernel implements a whole hrtimer-based 
> bodge in arm_pmu to apparently work around not having usable interrupts, 
> so yeah, this isn't going to be usable, sorry.
> 
> Robin.

Hi all!

Thanks for all suggestions and inspection, if we make sure it is a hardware
design blunder, then it is accpetable for me, I just need to make sure it
isn't the kernel's fault, if so that's will be our fault:)

Thanks.
