Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9774EC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6AD20879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BnqvVBms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfENJO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 05:14:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33827 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfENJO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:14:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id f8so476495wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 02:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WHxIikLCyzadwzBR9VCleTtgnBQzuu/J56HNxGMdIDw=;
        b=BnqvVBmslpi2JZdrAHWNmnzh291ev9Noqx2p1BSS5FFLZ/QmeMP/CPtcJLK98GZTw5
         hoqoo3cdxU1pg7p2kshCBipP1NfmlEevwSbtZDnCmZCaccD/xwUixYS/EoMnRy+v3Zrd
         Q61ro2lC+5dX5Q69cCwW7IWlmVOFSN+F5RVS0pw1ayU1+F/c+e6whO/RRoEotoL2kO7K
         s0DWFmR4+Tb5WefdOIuZLjA5vAi58w/HnbyJQFr/qS59I0VEmMtpIFpWowKTXKReV3b9
         Xt8MerNtojSZ6/ZzagiLJiAUfbHqm44KeJFSU91Gvxo1laO0gBUlQM13H2fKvHy/Pem8
         4wHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WHxIikLCyzadwzBR9VCleTtgnBQzuu/J56HNxGMdIDw=;
        b=OdK0Y6MMoTY7Wb+AwRJVQViHe17Gc9jORSucwBYDTC1HiDKlfIR95fvjVYq0LrvRqi
         iXSZnfnxZm8tj2BLL0BJwWH83oXPn2qhq+Y6Z6NYlYxLOn5zElT7mpe5gZESt1q7QyjQ
         4Or48SWWWiFc5xJGOtgbzjU0ouk/U6j54m5abFZPQEf6WbzEgWDTgPzFPKOQCzoFsQg1
         98+z3Bwmf2tVIbB0CxvTJsoCFCULCa4LTl+TAv7YON2UP4MwloBIIlAaR4bPAFX+V8Qw
         nqvavlHl0oQBmIOSx80PM3TBeT87IjgZq2bK3Bar++/ZJYJXqRZJazhYfMgdhpl4M4Pf
         CUww==
X-Gm-Message-State: APjAAAXs+gXhlB+TxNJ1Gc4wB2E+LhWlJANPoIG4y71zXHCsRlUJ+FJ0
        JMJS9sVLIjkxQL6hPLKyCdv86mPJAyKZMA==
X-Google-Smtp-Source: APXvYqzf+dSBEvOTHFEA7BpX9uCb381SseTb8LeMKVgOuG2PWYyraQWFwTH2qcHUwYjoH7p2xpk/Qw==
X-Received: by 2002:adf:ec8c:: with SMTP id z12mr10469376wrn.209.1557825294494;
        Tue, 14 May 2019 02:14:54 -0700 (PDT)
Received: from ?IPv6:2a01:cb1d:379:8b00:1910:6694:7019:d3a? ([2a01:cb1d:379:8b00:1910:6694:7019:d3a])
        by smtp.gmail.com with ESMTPSA id u14sm14706822wrn.30.2019.05.14.02.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 02:14:53 -0700 (PDT)
Subject: Re: [baylibre-upstreaming] [PATCH 0/3] mmc: meson-gx: add
 ddr-access-quirk support
To:     baylibre-upstreaming@groups.io, narmstrong@baylibre.com,
        ulf.hansson@linaro.org, khilman@baylibre.com
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190513091548.16674-1-narmstrong@baylibre.com>
From:   guillaume La Roque <glaroque@baylibre.com>
Message-ID: <65423579-52c0-40ca-143a-6bc6ed33c90e@baylibre.com>
Date:   Tue, 14 May 2019 11:14:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513091548.16674-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/13/19 11:15 AM, Neil Armstrong wrote:
> On the Amlogic G12A SoC family, (only) the SDIO controller fails to access
> the data from DDR, leading to a broken controller.
>
> Add the amlogic,ddr-access-quirk property so signal this particular
> controller has this bug and needs a quirk to work properly.
>
> But each MMC controller has 1,5KiB of SRAM after the registers, that can
> be used as bounce buffer to avoid direct DDR access from the integrated
> DMAs (this SRAM may be used by the boot ROM when DDR is not yet initialized).
>
> The quirk is to disable the chained descriptor for this controller, and
> use this SRAM memory zone as buffer for the bounce buffer fallback mode.
>
> The performance hit hasn't been evaluated, but the fix has been tested
> using a WiFi AP6398S SDIO module, and the iperf3 Bandwidth measurement gave
> 55.2 Mbits/sec over a 63 Hours long test, with the SDIO ios set as High-Speed
> at 50MHz clock. It gave around 170 Mbits/sec as SDR104 and 200MHz clock.
>
> Neil Armstrong (3):
>   dt-bindings: mmc: meson-gx: add ddr-access-quirk property
>   mmc: meson-gx: add ddr-access-quirk
>   arm64: dts: meson-g12a: add ddr-access-quirk property to SDIO
>     controller
>
>  .../bindings/mmc/amlogic,meson-gx.txt         |  4 ++
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |  1 +
>  drivers/mmc/host/meson-gx-mmc.c               | 65 +++++++++++++++----
>  3 files changed, 57 insertions(+), 13 deletions(-)
>
Test with SEI510 board no problem or regression seen

Tested-by: Guillaume La Roque <glaroque@baylibre.com>



