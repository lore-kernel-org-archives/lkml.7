Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AE3C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1DA2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uKaZA9Zx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfFMTdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:33:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37908 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfFMTds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:33:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id a186so12438055pfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 12:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=do2ZI6AB84f51HhCgs64o/OwEByfbyhqfdO3MCEI11w=;
        b=uKaZA9Zxh7dZs0jS87LP/3uLU+Xx4ZfnKYpIumrpHzc+bsYNKjAsjwm4dlWaYMbD7m
         22QjRog6LAoPdR2/G1bQojmdqmL4Ntx9Jz/So2VnLCauxnDP6oA2oTkF7we+4p5fvcQy
         L0ON+ARGO7XZkiS8Pea48mu09SaNhyc4seHQmMiy+mnMxifwi9tYmShnOy5Sh09gfHD2
         Edp/RI1qtnwPJ9vZy5skTF9m7Dx953HC5jThN3FXUXTfmQBXXQtMOhciWDqUygwJ47kG
         2jkywOogcNcI+F+lVU1S2RSHBfR8H4GzBGvhWiJHfjKZdX0ERpswZ9sqhboY1N1i+tZJ
         A+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=do2ZI6AB84f51HhCgs64o/OwEByfbyhqfdO3MCEI11w=;
        b=g2aarK6YmrSZp1kxQdxl15AV6jti82nOv1WZ/qdpMYlBltMP9kavBtlU5tJS1zZ69Z
         4S6x/pw60rpCsyadcXyr4OwUnKFhsIzL5g69gK2wYQI8RtfLpgCQNz1uU4INjrxR3MXY
         XJLo+biDLpmgvyWKGBThBH/73eSS1qmC0qVkjT7Ixzxf7qk+c/gTMH73sJpvzqGoKu19
         lL46PKiGuU13431Rq69Efj10D7Xv1CV7DAUMM/brxH98qlGMXU0liIxSISyZnFoUh7hR
         iufHrK2oc65o0JU9iUtll6jTwcNB0FHZ2nExYZLJWzG9lc1d1r2JytYslCzmdRRXxHue
         zTaw==
X-Gm-Message-State: APjAAAXdwj8mtFuQwmeHNMIQ/UQuzRFJ0oNvq1szCDCXNc/+4WR4SQuy
        Va4wqpezHZfDvYrZaPC3YNeSNg==
X-Google-Smtp-Source: APXvYqxQMYR4H3vojZQSKEgSWAnX0V+23fNF0VDvBBd/zGvF3dlCJJBIKHc8Mt23k45dhtm2gAwWwg==
X-Received: by 2002:a63:2d0:: with SMTP id 199mr31768286pgc.188.1560454427686;
        Thu, 13 Jun 2019 12:33:47 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id 135sm469175pfb.137.2019.06.13.12.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 12:33:47 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: meson: sei510: add sound card
In-Reply-To: <20190524140318.17608-1-jbrunet@baylibre.com>
References: <20190524140318.17608-1-jbrunet@baylibre.com>
Date:   Thu, 13 Jun 2019 12:33:46 -0700
Message-ID: <7hh88t46w5.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset adds the sound card of sei510 board.
>
> Note #1:
> The patchset (build) depends on the tohdmitx ASoC patch [0] for the dt
> bindings of the tohdmitx glue. It also (run) depends on the mpll clock
> series [1] to get a correct clock sources.

Queuing this for v5.3, but it's pending a stable tag/branch from ASoC
maintainers.  If that doesn't work out, I'll queue it up after v5.3-rc1.

Thanks,

Kevin
