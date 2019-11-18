Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4AAC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B269A20692
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yHeksfB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKRJzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:55:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54891 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKRJzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:55:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id z26so16601281wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 01:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=1GoIOtsIzWbvDocOsz/C2x/FxA2jWzeW8mPBcgPBynw=;
        b=yHeksfB0yCZEYO2eOK8ptMeVrZeueoVGg2UOO3ATiBA0aaaPP1hEmqdWzLWIKpumnx
         AzIer1O0dyWnixlqwzzL+pQ1hkGYLzp8LV2SQ4ot9cTiavfn9FAk9fW06DTqOLfO8sDN
         8T4MMA8HY9MJ48TR9vQzPmD74VqGahXlpKc9doJLxRZEy6IGj+DkATdKYkTDjx3CtuaB
         U6nH9b2l3Kf/bV+R0zAp+0fwePmiZc3FFkqyRZJ/94dtnOWzn8yjC/PN48OhZh7APRK4
         vuSeOZI9+/hG3r9PD/W4x7Kc23+DAM6byQLhoSFoaPBs1C7ucdIVFqtKIP8sFjUr96rS
         o5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=1GoIOtsIzWbvDocOsz/C2x/FxA2jWzeW8mPBcgPBynw=;
        b=RelYKUd7KotSw3nXSSNQxYz4c7dez0SATEKjvg7PKgsYP5UEu5C7WmQbwwOJ+6VaiB
         7KEAXnxmpEMNdOPaGa9JgLuxrBQXgApemTJkfkl2P4J219a66TzvsdBVHZOk5lpPuM4m
         RUcAPq1ErFV5jX+V8jUd88e6aiqM1Bha1X9oM0sd2rEiSecHKfjMtbHg5Bg9A6t2nQBR
         2xwvLMUDAvlGuZrfRLjUZbwACPtF1jmKq5byTq7jjcQS74ObQEhZSJ9pD4C/SFyJcMpE
         m57YePQDEZnvvz4S6/OHCTd1zQsgiyPjAfAXlWsJsrL+BIhmZ4IJMkad5TT9Gu81/+j6
         4p/Q==
X-Gm-Message-State: APjAAAVUIa3Khp5HTC6dd5P1+E6FHiqyWQlhw4YP2pr6xZBv6kMB/HSB
        ih+3I2H4rWyPZaQsvkFPfFVa5A==
X-Google-Smtp-Source: APXvYqxLgDYsf/Ba6F+JNYjp/kbm2QlRkLDQTC8CZz5yMHMikquk5MbQttgoLDz2TMet+HxQblEKzg==
X-Received: by 2002:a05:600c:3cf:: with SMTP id z15mr28202920wmd.76.1574070949878;
        Mon, 18 Nov 2019 01:55:49 -0800 (PST)
Received: from localhost ([2a01:e34:eeb6:4690:ecfa:1144:aa53:4a82])
        by smtp.gmail.com with ESMTPSA id o189sm21154823wmo.23.2019.11.18.01.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 01:55:49 -0800 (PST)
References: <20191117135927.135428-1-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        narmstrong@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/5] provide the XTAL clock via OF on Meson8/8b/8m2
In-reply-to: <20191117135927.135428-1-martin.blumenstingl@googlemail.com>
Date:   Mon, 18 Nov 2019 10:55:47 +0100
Message-ID: <1j5zjhpkyk.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 17 Nov 2019 at 14:59, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> So far the HHI clock controller has been providing the XTAL clock on
> Amlogic Meson8/Meson8b/Meson8m2 SoCs.
> This is not correct because the XTAL is actually a crystal on the
> boards and the SoC has a dedicated input for it.
>
> This updates the dt-bindings of the HHI clock controller and defines
> a fixed-clock in meson.dtsi (along with switching everything over to
> use this clock).
> The clock driver needs three updates to use this:
> - patch #2 uses clk_hw_set_parent in the CPU clock notifier. This drops
>   the explicit reference to CLKID_XTAL while at the same time making
>   the code much easier (thanks to Neil for providing this new method
>   as part of the G12A CPU clock bringup!)
> - patch #3 ensures that the clock driver doesn't rely on it's internal
>   XTAL clock while not losing support for older .dtbs that don't have
>   the XTAL clock input yet
> - with patch #4 the clock controller's own XTAL clock is not registered
>   anymore when a clock input is provided via OF
>
> This series is a functional no-op. It's main goal is to better represent
> how the actual hardware looks like.
>
>
> Changes since v2 at [1]:
> - add .fw_name in addition to .name in patch #3 as suggested by Jerome
> - dropped the dts patch so this whole series targets clk-meson
> - moved patch #5 from another series to this one because once we drop
>   .name = "xtal" the clocks need to be aware of the OF node
>
> Changes since v1 at [0]:
> - add Rob's Reviewed-by to the dt-bindings patch
> - check that "xtal" clock is actually passed via OF instead of checking
>   that there's any parent at all (which in the worst case may not be the
>   xtal clock) as suggested by Jerome
>   
>
> [0] https://patchwork.kernel.org/cover/11155515/
> [1] https://patchwork.kernel.org/cover/11214189/
>
>
> Martin Blumenstingl (5):
>   dt-bindings: clock: meson8b: add the clock inputs
>   clk: meson: meson8b: use clk_hw_set_parent in the CPU clock notifier
>   clk: meson: meson8b: change references to the XTAL clock to use
>     [fw_]name
>   clk: meson: meson8b: don't register the XTAL clock when provided via
>     OF
>   clk: meson: meson8b: use of_clk_hw_register to register the clocks
>
>  .../bindings/clock/amlogic,meson8b-clkc.txt   |   5 +
>  drivers/clk/meson/meson8b.c                   | 113 ++++++++++--------
>  2 files changed, 67 insertions(+), 51 deletions(-)

Applied for v5.6
Please note this will get rebased once v5.5-rc1 is out
