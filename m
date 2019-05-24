Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A95C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A952081C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JYahaxVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfEXEkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 00:40:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36799 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfEXEkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 00:40:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id z1so1966234ljb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 21:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rRM8a/2TtZzcDJu40/I1y3WAHnEd2NwaRkAkmAY7Pbs=;
        b=JYahaxVjVRWEcKQda8kVjGL2wDABM1W5WBX/QUgmobVeLwQojkfjKb9PRxyYNXasrg
         IKej1xeUqkWYvs8MSxYCSz2eckUPl9QYwVSvU9wIDRISXtICeXlDoiN8N5l+n9PUMdzU
         jxo0/kvTMRTgRSQG2nCCRK/khQNCwkVsaJo0TvU366iBxlTUum4/OG6jeY6R7y1xnM8M
         jfDFyOi6F+NaxhkHh/GSZ+AqLwXaMAKvGFRB29mD574459O/mnCaBIFERL+Bvdpd5PVv
         neMNBP/zkzT8R+0AoYdaWMtzS5azRHDPF82fbyGymiIy5PMglmcEksZZk0V1OaqWE80l
         rqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRM8a/2TtZzcDJu40/I1y3WAHnEd2NwaRkAkmAY7Pbs=;
        b=gEfvBdvtz8jWuhyvxR5beSMc6vDAhpcLdt2/AS7YXcTSXzCZkjpeYhW7IYBPIaP5HX
         jSChoRyPpvKaGhwAR+hgHTjvrsK7kj//hm5TGU6b1VfDGy/W6FVFeCtwTyieXVRDri8w
         Yutb1uoWbrjkX+2qTmS8wtCqcEqQcVwpcN9r1fiNJF+cETBm+kLgJ/EnBxyvQFrCVh5z
         Qj5HFDjkUtDx+KuEfCX1cKREwZeJFhM4NySpVhd6ThQzHSInT+iEAEyK8/jhKEI0iI5+
         xvCqidIXl3vLe67IGsjQeoDifR5OCf27tmpnP8/LxdukjW1qCufNdmy8cX1MMP/GJcXI
         jzKA==
X-Gm-Message-State: APjAAAWExbN2ldxNSrtJ/Mb9mAXdgCZ87xLirHU34eC/DannM9RQzlmR
        9d+NQ2YRG+JhhLCNhEGQoW1BGUoMc22s0f/67iqAuA==
X-Google-Smtp-Source: APXvYqyPMrr+pems5snP2y5pBVnjhlfmJgkwgMVDQOSPLPyKkA9ga7l8hVA6NbIaTAmeEBPJ+euWW69CwomX7WDRnxs=
X-Received: by 2002:a2e:82c5:: with SMTP id n5mr15440974ljh.175.1558672835426;
 Thu, 23 May 2019 21:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <1558611952-13295-1-git-send-email-yash.shah@sifive.com> <mvmwoihfi9f.fsf@suse.de>
In-Reply-To: <mvmwoihfi9f.fsf@suse.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Fri, 24 May 2019 10:09:58 +0530
Message-ID: <CAJ2_jOEr5J7_-81MjUE63OSFKL-p9whEZ_FDBihojXP2wvadVg@mail.gmail.com>
Subject: Re: [PATCH 0/2] net: macb: Add support for SiFive FU540-C000
To:     Andreas Schwab <schwab@suse.de>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        ynezz@true.cz, Paul Walmsley <paul.walmsley@sifive.com>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Thu, May 23, 2019 at 6:19 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On Mai 23 2019, Yash Shah <yash.shah@sifive.com> wrote:
>
> > On FU540, the management IP block is tightly coupled with the Cadence
> > MACB IP block. It manages many of the boundary signals from the MACB IP
> > This patchset controls the tx_clk input signal to the MACB IP. It
> > switches between the local TX clock (125MHz) and PHY TX clocks. This
> > is necessary to toggle between 1Gb and 100/10Mb speeds.
>
> Doesn't work for me:
>
> [  365.842801] macb: probe of 10090000.ethernet failed with error -17
>

Make sure you have applied all the patches needed for testing found at
dev/yashs/ethernet branch of:
https://github.com/yashshah7/riscv-linux.git

In addition to that, make sure in your kernel config GPIO_SIFIVE=y
In v2 of this patch, I will add this select GPIO_SIFIVE config in the
Cadence Kconfig file.

- Yash
