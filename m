Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41126C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1888820727
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yCYdfDsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfKRKIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:08:14 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42059 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfKRKIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:08:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so18672430wrf.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 02:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=6FpHepaowUcTwi1m1otI5UX1Bte5ijrSggQqs1TMYnI=;
        b=yCYdfDsTG7kz2Py4AsxM03TsOto8rVrTnapxd1uM7UzvtALIiyKQn9FPNijF9T6wcI
         Li/l77ZTfj0rD20BLnqx9iYgVP2iS8yCVrcdra/janvjUTTOhRQ4LR/6hJWfio7x83Ko
         xSzztJl/+vlV10mIUjKdJ+lZScErMX3+J2xEVYA9Ockr/UPTW1Meqq8FiB8wWuBJvz08
         OnIw/PR+cc7COBl8z+uNsZiic0BxlENc0k6ldNnmOpMqie/ybEfE+IpYTOJQFh3nu0Co
         QT/NODRYize+4h4BsUGNvrEsLUMF45RFYhGWeB4YLrIEICQa903Np1PXXIMGVVfT/BAs
         6r3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=6FpHepaowUcTwi1m1otI5UX1Bte5ijrSggQqs1TMYnI=;
        b=kN2xSkGJzvP00od1R3+oNFJ0u4RuxzfoacchDxbAmKYevXdzluBRo63tFi1Y21Yoqx
         gkwPGHiGX+yoIRzL6o/LWPNCI1WzcMRsuHtW82Jbee8gZK1UV+wvMdBKeTsGxaw+6qrn
         LRjzqDi6afZTxZfGIMcYGHAV75UjXGmjac+lEN64JBidO30EYbFxZ/HZ7BeAT3UYMoly
         13MCltjvMMqQN/DJwAhjtWbAJJamE/ZdFFC8d6EpQr1GrPwkaSt8uLPtiGx8kCC99kMm
         Yco5lyK7heE7oH2eaG/yzNRLTbBqxGz4vXu3iH0FZCT0En1l0u9CLZm0iMD+jrmyUhFK
         M9Bw==
X-Gm-Message-State: APjAAAXtq4Iwd10W6Hk88Y2dmZK4nsHwriGHMGqRvezAiUQhVQsThk4Z
        hMkP/ih2akpXGKdgsNsYT4ywJA==
X-Google-Smtp-Source: APXvYqxeNQBPkh8HxkOqiVOXmcrv+bpCB6eEbJxM2eki/xYGalEX8LAGcqSAmVhoJmcigiOOMlvhTg==
X-Received: by 2002:adf:e444:: with SMTP id t4mr5851326wrm.50.1574071690635;
        Mon, 18 Nov 2019 02:08:10 -0800 (PST)
Received: from localhost ([2a01:e34:eeb6:4690:ecfa:1144:aa53:4a82])
        by smtp.gmail.com with ESMTPSA id w17sm23523133wrt.45.2019.11.18.02.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 02:08:09 -0800 (PST)
References: <20190924123954.31561-1-jbrunet@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] clk: let clock perform allocation in init
In-reply-to: <20190924123954.31561-1-jbrunet@baylibre.com>
Date:   Mon, 18 Nov 2019 11:08:08 +0100
Message-ID: <1j4kz1pkdz.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 24 Sep 2019 at 14:39, Jerome Brunet <jbrunet@baylibre.com> wrote:

> This patchset is a follow up on this pinky swear [0].
> Its purpose is:
>  * Clarify the acceptable use of clk_ops init() callback
>  * Let the init() callback return an error code in case anything
>    fail.
>  * Add the terminate() counter part of of init() to release the
>    resources which may have been claimed in init()
>
> After discussing with Stephen at LPC, I decided to drop the 2 last patches
> of the RFC [1]. I can live without it for now and nobody expressed a
> critical need to get the proposed placeholder.
>
> [0]: https://lkml.kernel.org/r/CAEG3pNB-143Pr_xCTPj=tURhpiTiJqi61xfDGDVdU7zG5H-2tA@mail.gmail.com
> [1]: https://lkml.kernel.org/r/20190828102012.4493-1-jbrunet@baylibre.com
>
> Jerome Brunet (3):
>   clk: actually call the clock init before any other callback of the
>     clock
>   clk: let init callback return an error code
>   clk: add terminate callback to clk_ops
>
>  drivers/clk/clk.c                     | 38 ++++++++++++++++++---------
>  drivers/clk/meson/clk-mpll.c          |  4 ++-
>  drivers/clk/meson/clk-phase.c         |  4 ++-
>  drivers/clk/meson/clk-pll.c           |  4 ++-
>  drivers/clk/meson/sclk-div.c          |  4 ++-
>  drivers/clk/microchip/clk-core.c      |  8 ++++--
>  drivers/clk/mmp/clk-frac.c            |  4 ++-
>  drivers/clk/mmp/clk-mix.c             |  4 ++-
>  drivers/clk/qcom/clk-hfpll.c          |  6 +++--
>  drivers/clk/rockchip/clk-pll.c        | 28 ++++++++++++--------
>  drivers/clk/ti/clock.h                |  2 +-
>  drivers/clk/ti/clockdomain.c          |  8 +++---
>  drivers/net/phy/mdio-mux-meson-g12a.c |  4 ++-
>  include/linux/clk-provider.h          | 13 ++++++---
>  14 files changed, 90 insertions(+), 41 deletions(-)

Hi Stephen,

Is this series Ok with you ?
Do you think you can take it at the beginning of the next cycle ?

Thx
Jerome

