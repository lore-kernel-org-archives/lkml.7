Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ACDC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BA82087B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="ye2gV4Jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfHLGQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 02:16:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41458 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfHLGQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 02:16:14 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so22846677qtj.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 23:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dbIpa3QvrtCejLces/pQZFJyjalWhG4M7rcRZ55EUa0=;
        b=ye2gV4JfL2nAT8vNoFz+z42w2bSfeQ8nCZnxxIN2EdGAhnxHWgkCeiEysTn/EDLv70
         3VZ4pL75GkSqpVs4E9hHzHpmfVNMkAfNfeeqhNoqEXjSA1EHOcTUmJe2ju1lbjqKaQMe
         6qSvAAbz4zjUbDPQsUpBo3R2RNQeyczkuX2p1rza/LwIgbVWaDkoR3Jmq/M4kWYsXkKA
         PAfewAKu7bEJ3eACUnGtrZXHmliSSAd0oISre5/4ba2foi1CUZLYo5ZbeSt/VF1L+vEv
         kfOlQXVldSrxKEArzabk2vIZ8dge0tjTuFTIfnsBx5HdRRJRKBIOXY8kWd7jXllrgvvg
         cWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dbIpa3QvrtCejLces/pQZFJyjalWhG4M7rcRZ55EUa0=;
        b=JHNC+djQ/A/7F1L92W6b4PZeZzNLoue0zh6Nm69ifhkG3dB7ps0Jz1/QW3AesCn9rG
         nzHwSfleY+0L/ieBA6/XozddAJNKRTBdvyvXZrMQJUw+I3T6e3MKcozZbft3vSOjOYws
         tahDm/RR3kNxN7Fc/dky/eh5IQVhXJu3wW8rhhBPvBsADPwSYXbzMbn18HMtXZ/Af04r
         JUUzfNrXvZrJKOg8UbGqLJQr33ZlNqCBY/PIGSpT+18+GwhQstPf7++b1TdwcJwb8nrV
         Vkd9GFaRb3UEEUI9JfzyfbAfAPEn0pPtDEe6wdl01oJM+HXXZ4UFmBKUwyzYRkC85BMo
         if+A==
X-Gm-Message-State: APjAAAX8RpXM7qwAoQgwklmI7F68uVgoZwmt+vROtvDjMLzkxNcfG+hR
        qlasrjtUvPXQYUDNThOMywaFWanIKF1bcMQIAoqdkw==
X-Google-Smtp-Source: APXvYqyJsPNY8U+cNbiZ2m8C5OiF4T5hAyCx9qMi80uH1GKx/9MQmt1INUmwrJ5V0DROxIyZNiEUp3L8jC/md2qEw5Y=
X-Received: by 2002:ad4:420c:: with SMTP id k12mr3385897qvp.94.1565590573743;
 Sun, 11 Aug 2019 23:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com>
 <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com>
 <alpine.DEB.2.21.1908010931550.1788@nanos.tec.linutronix.de>
 <CAERHkrtaVAQHDU1cj2_GLL59LPjp7E=3X0Zna0spfFB=Ve5__w@mail.gmail.com>
 <alpine.DEB.2.21.1908011011250.1788@nanos.tec.linutronix.de>
 <81666b28-d029-56c3-8978-90abc219d1b7@linux.intel.com> <alpine.DEB.2.21.1908011054210.1965@nanos.tec.linutronix.de>
 <3d14b0cc-3cca-1874-3521-4ee2ec52141d@amd.com> <alpine.DEB.2.21.1908082235590.2882@nanos.tec.linutronix.de>
 <5bf28ba4-b7c1-51de-88ae-feebae2a28db@amd.com> <alpine.DEB.2.21.1908082306220.2882@nanos.tec.linutronix.de>
 <75e59ac6-5165-bd0a-aec9-be16d662ece9@amd.com> <alpine.DEB.2.21.1908091443030.21433@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908091443030.21433@nanos.tec.linutronix.de>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 12 Aug 2019 14:16:02 +0800
Message-ID: <CAD8Lp46FgT6yoW9a4Yt8t=bVWzZbYHjw-Dqdk6Pvd2xzxfGHLQ@mail.gmail.com>
Subject: Re: [PATCH] x86/apic: Handle missing global clockevent gracefully
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>,
        Jiri Slaby <jslaby@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 8:54 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> Some newer machines do not advertise legacy timers. The kernel can handle
> that situation if the TSC and the CPU frequency are enumerated by CPUID or
> MSRs and the CPU supports TSC deadline timer. If the CPU does not support
> TSC deadline timer the local APIC timer frequency has to be known as well.
>
> Some Ryzens machines do not advertize legacy timers, but there is no
> reliable way to determine the bus frequency which feeds the local APIC
> timer when the machine allows overclocking of that frequency.
>
> As there is no legacy timer the local APIC timer calibration crashes due to
> a NULL pointer dereference when accessing the not installed global clock
> event device.
>
> Switch the calibration loop to a non interrupt based one, which polls
> either TSC (frequency known) or jiffies. The latter requires a global
> clockevent. As the machines which do not have a global clockevent installed
> have a known TSC frequency this is a non issue. For older machines where
> TSC frequency is not known, there is no known case where the legacy timers
> do not exist as that would have been reported long ago.

This solves the problem I described in the thread:
    setup_boot_APIC_clock() NULL dereference during early boot on
reduced hardware platforms

Thanks for your quick support!

> Note: Only lightly tested, but of course not on an affected machine.
>
>       If that works reliably, then this needs some exhaustive testing
>       on a wide range of systems so we can risk backports to stable
>       kernels.

I can do a bit of testing on other platforms too. Are there any
specific tests I should run, other than checking that the system boots
and doesn't have any timer watchdog complaints in the log?

Thanks
Daniel
