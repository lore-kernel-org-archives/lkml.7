Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB3CC7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9194214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JN7vSXEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbfG2Kym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:54:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38452 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbfG2Kym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:54:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so31683208wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 03:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=eqfg5Eacmy1+/MhOFkxqCtwYHlycdYQaxotBimNO4tM=;
        b=JN7vSXEF75Oelp0EyviFYoaWimsb5xVHwKIwNhCJKpemuYt2P19a659u41EmU9aChL
         yODZRtKntrTQMkND9VKWTh3/CWtbDhCgXSNZPBByMpRkb1wveyF2ziL8brQWucZM09Df
         h5DY8xv6kItvcWN4idyU/uw91bzFa0QZ0n6k/oKQktSeoni48jh1f6qcI8HfNX85cXr5
         D5G7Yq9PLAH7WxozX1uhTTOUU/PU1ixyPhaP34lykwEOlQOgkWwwZeXfrBxXDYFfCzt7
         wW0mGlJsjhJHLsP7cdo3Dmlm6xKep00TNMIc5OQMZeS1dOW26fPzBTKTQuXk+pxI5om+
         vwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=eqfg5Eacmy1+/MhOFkxqCtwYHlycdYQaxotBimNO4tM=;
        b=F3H6jmgrC2BGISyY25GsuYF87N96G6tgEfYIUSThsKILsaHKR2F9T+AAzJyHffy5lU
         fqriv8AA8EfRUouetbSOhSFscl0XUmYukAYNo8Ah5JKjx/oTXnbaN6bPkbU73CKjOcxT
         ONUVfdiCuAlIbhTxU65kMNNIX6JJ+zoK+CpuZzB8LRkqYfx7rdWrQ5zGATn5/P38AiEw
         KeLDXaaC8uTe3FpoGfb8xPuZ6qPB1F89Kc8PVFjAFXJhV8Lu5HtwObfgCk/6p60p+ZyX
         RsJ2yAvH9oGf4QVwBudB3Lvy2OmI15Xxs5VYAUTarR1paRhCPSwnUijWk5el8j56NPrb
         7fJw==
X-Gm-Message-State: APjAAAXVnk7KOPIjtey8PfV+/qtw8RWbopeN737g9WN9ggCb0BRqLbLW
        0Wc86SVs6GKST7DQmFfo0e7TnQ==
X-Google-Smtp-Source: APXvYqwIfLdaKYHkYVTTbNZVS5iy+6EEZOZyCe/3q44b3hbfmzHduJ3sHM2CB1fUjblr88CN7uiAjQ==
X-Received: by 2002:a05:600c:23d2:: with SMTP id p18mr93463026wmb.160.1564397680266;
        Mon, 29 Jul 2019 03:54:40 -0700 (PDT)
Received: from localhost ([2a01:e34:eeb6:4690:ecfa:1144:aa53:4a82])
        by smtp.gmail.com with ESMTPSA id o26sm126645461wro.53.2019.07.29.03.54.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 03:54:39 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH v2 0/8] clk: meson: ee: use the new parent description method
In-Reply-To: <20190725164238.27991-1-amergnat@baylibre.com>
References: <20190725164238.27991-1-amergnat@baylibre.com>
Date:   Mon, 29 Jul 2019 12:54:38 +0200
Message-ID: <1jzhkx861d.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25 Jul 2019 at 18:42, Alexandre Mergnat <amergnat@baylibre.com> wrote:

> Meson SoCs clock controllers use the string comparison method to describe
> parent relation between the clocks, which is not optimized.
>
> Its also use bypass clock made from device-tree clock to provide an input
> clock which can be access through global name, but it still not optimal.
>
> A recent patch [0] allows parents to be directly specified with
> device-tree clock name or without string names from localy declared clocks.
>
> This patchset replaces clock string names by clock pointers (as possible),
> removes bypass clocks and uses directly device-tree clock names in parent
> assignment.
>
> Tested on GXL, GXBB, Meson8b, AXG SoCs by comparing the clock summary
> (orphan too) before and after migration.
>
> [0] commit fc0c209c147f ("clk: Allow parents to be specified without string names")
>
> Change since v1:
> - Improve comments in gxbb, g12a and meson8b files
>
> Alexandre Mergnat (8):
>   clk: meson: g12a: move clock declaration to dependency order
>   clk: meson: g12a: migrate to the new parent description method
>   clk: meson: gxbb: migrate to the new parent description method
>   clk: meson: axg: migrate to the new parent description method
>   clk: meson: meson8b: migrate to the new parent description method
>   clk: meson: clk-regmap: migrate to new parent description method
>   clk: meson: remove ee input bypass clocks
>   clk: meson: remove clk input helper

Squashed patch 1 and 2
Applied

Thanks !

>
>  drivers/clk/meson/Kconfig       |    4 -
>  drivers/clk/meson/Makefile      |    1 -
>  drivers/clk/meson/axg.c         |  207 ++++--
>  drivers/clk/meson/clk-input.c   |   49 --
>  drivers/clk/meson/clk-input.h   |   19 -
>  drivers/clk/meson/clk-regmap.h  |   12 +-
>  drivers/clk/meson/g12a.c        | 1093 ++++++++++++++++++++-----------
>  drivers/clk/meson/gxbb.c        |  657 +++++++++++++------
>  drivers/clk/meson/meson-eeclk.c |   10 -
>  drivers/clk/meson/meson-eeclk.h |    2 -
>  drivers/clk/meson/meson8b.c     |  710 ++++++++++++++------
>  11 files changed, 1805 insertions(+), 959 deletions(-)
>  delete mode 100644 drivers/clk/meson/clk-input.c
>  delete mode 100644 drivers/clk/meson/clk-input.h
>
> -- 
> 2.17.1
