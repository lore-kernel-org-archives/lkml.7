Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8E1C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CCB2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xaIpOWBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbfETL0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:26:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40499 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730727AbfETL0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:26:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so14174988wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 04:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HtfyxUMJLQAcq0KfWDawQoWqIdIlp3vHf/VikFApqLs=;
        b=xaIpOWBoT4uKzuJxww+snLRcZXPpym7ybsnPLh8k0BHxj71Mc2lVJUqyOmhK6qVS2Y
         ndzvMHayaScDIlQ5fdNuZ584x6OcvfVcu81AX4PMOswoJyRRL8W2Jr6CYt62YZQqn4Bg
         kOgEfppb3tw2j1n7jjFRqRoZyUHxPFbpQkSFbPdD73vduod3SlLfE8x7bzaFmhBvuVLe
         Pz34zll8AqvGPghWpF+vslF4MwrLhgteqOAwtzaKFljOvo9yGK0zXr04onSF1TcCKtl/
         c3m0zVGWXfsma2qdqGgpM170t9e7inYjpYbPIRCi52XBA7FukoxGGz29oEBOAyoPUrXI
         mlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HtfyxUMJLQAcq0KfWDawQoWqIdIlp3vHf/VikFApqLs=;
        b=KnGASLibkr6SUk2Kx52k11RSohcJodvfnODLWbLvadVZtuzFUUre1N9EAc9KbyLPR6
         Mfx3P2hLBv+vm5pP+M3Tgy9CuEW76vIUoMMzXhjcohPfxGPyZlI1dzOnN7G4N0WPZK3x
         ZHHuWVRvCLZPk5Fxb8H+L/oNUU1trN5Aam8F7H4ilbUeWyy4FJrK3FQo8E7Z54FgX/Ql
         bnPQ1QqOSQfN1cK9s4S7Yvfl6C8XGipuwdxNyh+X9bhtddEF2iJEO5Ub0y5gVi3mPbMy
         wZsFBMu/t0peCX0RSWYYLYrtpF3FrEUEILQtszYTl46Wot07OVcfm/94b8nn9Po5FJwT
         clYQ==
X-Gm-Message-State: APjAAAVor+DuweVMTrQRMnHvUmL0uKxdnnbJ15HOyElfe4bgV7OfVa4R
        rMMqu2HdQP3Bw/JxqEhygJ5r5Q==
X-Google-Smtp-Source: APXvYqw4UiCpX3rKI6633yiMqqQyEYhGUUtxX+2oz4H6tQ9iVRuwKYecsWkeZ8CFqwdWHbMKMBd44g==
X-Received: by 2002:a5d:6610:: with SMTP id n16mr36510123wru.250.1558351610484;
        Mon, 20 May 2019 04:26:50 -0700 (PDT)
Received: from boomer.baylibre.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s18sm15016292wmc.41.2019.05.20.04.26.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 04:26:49 -0700 (PDT)
Message-ID: <b754893eef91aacb309f257beba977610348b9fb.camel@baylibre.com>
Subject: Re: [PATCH v2 0/7] clk: meson: fix mpll jitter
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 20 May 2019 13:26:48 +0200
In-Reply-To: <20190513123115.18145-1-jbrunet@baylibre.com>
References: <20190513123115.18145-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-13 at 14:31 +0200, Jerome Brunet wrote:
> This patchset is a squash of these previous patchsets [0], [1] without
> modification, beside a re-ordering of the changes to facilitate backports
> 
> We are observing a lot of jitter on the MPLL outputs of the g12a.
> No such jitter is seen on gx family. On the axg family, only MPLL2
> seems affected. This was not a problem so far since this MPLL output
> is not used.
> 
> The jitter can be as high as +/- 4%.
> 
> This is a problem for audio application. This may cause distortion on
> i2s and completely break SPDIF.
> 
> After exchanging with Amlogic, it seems we have activated (by mistake)
> the 'spread spectrum' feature.
> 
> The 3 first patches properly set the bit responsible for the spread
> spectrum in the mpll driver and add the required correction in the
> related clock controllers.
> 
> When the g12a support has been initially submitted, the MPLL appeared
> (overall) fine. At the time, the board I used was flashed with Amlogic
> vendor u-boot. Since then, I moved to an early version on mainline
> u-boot, which is likely to initialize the clock differently.
> 
> While debugging audio support, I noticed that MPLL based clocks were way
> above target. It appeared the fractional part of the divider was not
> working.
> 
> To work properly, the MPLLs each needs an initial setting in addition to
> a common one. No one likes those register sequences but sometimes, like
> here for PLL clocks, there is no way around it.
> 
> The last 4 patches add the possibility to set initial register sequence
> for the ee clock controller and the MPLL driver. It is then used to enable
> the fractional part of the g12a MPLL.
> 
> As agreed with the clock maintainers, I'll submit a series to CCF to
> remove the .init() callbacks and introduce register()/deregister()
> callbacks later on (pinky swear).
> 
> Jerome Brunet (7):
>   clk: meson: mpll: properly handle spread spectrum
>   clk: meson: gxbb: no spread spectrum on mpll0
>   clk: meson: axg: spread spectrum is on mpll2
>   clk: meson: mpll: add init callback and regs
>   clk: meson: g12a: add mpll register init sequences
>   clk: meson: eeclk: add init regs
>   clk: meson: g12a: add controller register init
> 
>  drivers/clk/meson/axg.c         | 10 ++++-----
>  drivers/clk/meson/clk-mpll.c    | 36 ++++++++++++++++++++++++---------
>  drivers/clk/meson/clk-mpll.h    |  3 +++
>  drivers/clk/meson/g12a.c        | 32 ++++++++++++++++++++++++++++-
>  drivers/clk/meson/gxbb.c        |  5 -----
>  drivers/clk/meson/meson-eeclk.c |  3 +++
>  drivers/clk/meson/meson-eeclk.h |  2 ++
>  7 files changed, 70 insertions(+), 21 deletions(-)
> 

series applied to v5.3/drivers


