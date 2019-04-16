Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCFFC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A89206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nCULT+Ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfDPTW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:22:59 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41253 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPTW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:22:59 -0400
Received: by mail-oi1-f194.google.com with SMTP id v7so17953135oie.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 12:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTxW3fLtGMVxaNNxm+7tK8AkRxo6QtTaArjlwjFimwE=;
        b=nCULT+NeynqpzlbLCUgKJJOPmC2FU5yqzbqRpTa1OHbtEWUkDEpR1RUITY1aEF0I6m
         HYyMEU6W+HFTJTjkycdgckBDKY84O+Co6Bm4y6mkw9Et0sN52OjJeObEFgdcpgOuD3ez
         nWK7sAXPmIfx0avg2lwfd505JSYsVI8RXcQ8oe45DKskeGH7CE+nbg8ueNYF08LZokF5
         cU6gJ8Nw5X4mvk4HD6CMsZfdsKppTRL2C3tO/81ezBP60EOIlT0NHNdAxhiZV3UHa30C
         r3C+wG20HOT1utx19Cco7yaW37XqdNYpuS27sjuyAbSfYf/jOT20/u60nDej6mEgWy74
         fLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTxW3fLtGMVxaNNxm+7tK8AkRxo6QtTaArjlwjFimwE=;
        b=gt7h7A4sqgeV6tnzP/rJ5Ybqf4x0qC9wq4IuQYLU/ahFIfg4id8Jbz/rtKyqm0E+lZ
         Glesor4Wvbdj6eH1CtB2f6mfXF61oHb+8v+VBDIbgj2W9bo6GwV1uY287oxXK9o77iED
         6O3HtZgFxRVximgYUjB3/IYWSyM7LgZ+g431+WyPlrVXooiiLcGoLRjh/A5BITXPjY8n
         gg+r/Y9bY+FUXKuWgtmnZQytYqZ+cplp3D+X1JrLU6ygU2fHRHjXkqK2etGAv0IcCHK1
         wc60Xw9YMyzJ3KwuFG4h5yR6LtPWObiCB8xvR2CM5KCRJiZ8VXD+6oTATUdcpV+3LgtN
         Zg0g==
X-Gm-Message-State: APjAAAW1x1nplsy7JLKm/rJhVd+NGTJcNNydQNPGRKfAdLooyOc/sst3
        zyzn2HTklHCJQ0pq3TL/xJluBH3+gMDb/vmyTpWMpg==
X-Google-Smtp-Source: APXvYqywdBBuVdUNsRFqcyFXlfvqNzzyDHZZ7brdh0IueD467Vy9uLAJPUOLQzkRA+UangCk+v2KGJ+BIVS6jlUE/zw=
X-Received: by 2002:aca:5108:: with SMTP id f8mr23438714oib.55.1555442577743;
 Tue, 16 Apr 2019 12:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190412125136.28232-1-jbrunet@baylibre.com> <7h5zrdpytg.fsf@baylibre.com>
In-Reply-To: <7h5zrdpytg.fsf@baylibre.com>
From:   Kevin Hilman <khilman@baylibre.com>
Date:   Tue, 16 Apr 2019 12:22:46 -0700
Message-ID: <CAOi56cU0dHoyRzTXeKGoiFwTms4WuJ7LV2EXTJLoEmOsC8OyrA@mail.gmail.com>
Subject: Re: [PATCH 0/7] arm64: meson: g12a: add audio devices
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        patchwork-bot+notify@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:52 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Jerome Brunet <jbrunet@baylibre.com> writes:
>
> > This patchset adds most the audio devices of the g12a SoCs.
> >
> > Kevin, couple of things worth noting:
> >  * This patch depends of the new audio clocks binding recently applied
> >    by Neil [0].
>
> Was this supposed to be part of the clk-headers dependency PR I
> received?  /me looks... It looks like it's applied right after the tag I
> pulled, so I doesn't look like it.
>
> If I should queue $SUBJECT series up for 5.2, I'll need another stable
> tag.

Also, this doesn't apply cleanly anymore to my v5.2/dt64 branch.  When
the stable tag is ready, do you mind doing a rebase? (or telling me
what it currently applies to, and I will do the rebase.)

Thanks,

Kevin
