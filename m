Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B8EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507DB2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="m0bqYITn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbfH0TMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:12:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41024 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbfH0TMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:12:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id 196so17970pfz.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=QlG0MCXrlsLf9bJR8f8bjOG6+UwZjxA04tjv5z1sPNs=;
        b=m0bqYITngjSGYta6fMhmwP9YQH2m9QkENNogl9TLA8dzoJ0grFsKJyyADSsDUGFKgl
         /lsrx+CnXSeR2yPHYhRo0ixyyTKX5o+K0XOW3OcLwnD4uDU83F9MRxTHzSKQKQ8a5/8B
         aM/9ojvpNGOWl9IBG9ymayfZcsD1SG7mDjPz7EB+S9XGkuUXqWnUN924CyQGlrHqp7kB
         kAFj8DUp9BYOPSi7tojk9KsDikWnTCCpqsXOJt/PN53gTGqluU1138cGMBaI0ZSM7AnV
         DbI9BFeHTFOU9I3a5Rqg2kc7TkI5eImebFMx47lzJ98BbHXw5ODCCZZ11AW2O36P5kE/
         McpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=QlG0MCXrlsLf9bJR8f8bjOG6+UwZjxA04tjv5z1sPNs=;
        b=QtElzAaQr0ES2zJcM62fsvTLrlfSMk71YBM+VrDleoJvTKPQYPa02VM6Nx1UbhWNg0
         gmg/h6TyIjOOQrWg+YoKjUlXA083flZUjknELAgtv0iXLAMHBkZKubApdciXF/FKfmvc
         WBr0zxX6DbQjfUhZVCEdge6HMX2n0R8sQ/F4DA5MFPyY6LHh/QOfZENZvAXnhzvYGVpR
         eVZHQIJL9UpcYRPNd3wXFN4DSDidkrzfAO083mhrv8lBuElTFn4yYyXlaocfCN09yJJW
         aDDrXbGMR0rfPuJEZL7HhR1rhBTLixhW+MzPfT6vP1ZNWuWaeH9qO1bZzd7v+jn0jIuu
         EX7Q==
X-Gm-Message-State: APjAAAXQX2PCF/htEgBwb8QVgea3CvrR6vmObdJoCjLkDkr7kXOCcgCq
        LGpUh6ZKsBk8daiY5Z1Jkq3myg==
X-Google-Smtp-Source: APXvYqzzoUzbs2yNWZLrVcTZcXe2K8bnbvlaeqGp8P/D5qzS/gw8hp34XezYimT2ZeaIuDknZJoZJg==
X-Received: by 2002:a65:60cd:: with SMTP id r13mr7312189pgv.315.1566933131786;
        Tue, 27 Aug 2019 12:12:11 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:cc35:e750:308e:47f])
        by smtp.gmail.com with ESMTPSA id 14sm56500pfy.40.2019.08.27.12.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 12:12:11 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] 0/6] arm64: meson-sm1: add support for DVFS
In-Reply-To: <1jblwc6wjq.fsf@starbuckisacylon.baylibre.com>
References: <20190826072539.27725-1-narmstrong@baylibre.com> <1jblwc6wjq.fsf@starbuckisacylon.baylibre.com>
Date:   Tue, 27 Aug 2019 12:12:09 -0700
Message-ID: <7h8srexw1i.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Mon 26 Aug 2019 at 09:25, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
>> Following DVFS support for the Amlogic G12A and G12B SoCs, this serie
>> enables DVFS on the SM1 SoC for the SEI610 board.
>>
>> The SM1 Clock structure is slightly different because of the Cortex-A55
>> core used, having the capability for each core of a same cluster to run
>> at a different frequency thanks to the newly used DynamIQ Shared Unit.
>>
>> This is why SM1 has a CPU clock tree for each core and for DynamIQ Shared Unit,
>> with a bypass mux to use the CPU0 instead of the dedicated trees.
>>
>> The DSU uses a new GP1 PLL as default clock, thus GP1 is added as read-only.
>>
>> The SM1 OPPs has been taken from the Amlogic Vendor tree, and unlike
>> G12A only a single version of the SoC is available.
>>
>> Dependencies:
>> - patch 6 is based on the "arm64: meson: add support for SM1 Power Domains" serie,
>> 	but is not a strong dependency, it will work without
>>
>> Changes since v1:
>> - exposed GP1, DSU and CPU 1,2,3 clock in patch 1
>>
>> Neil Armstrong (5):
>>   dt-bindings: clk: meson: add sm1 periph clock controller bindings
>>   clk: meson: g12a: add support for SM1 GP1 PLL
>>   clk: meson: g12a: add support for SM1 DynamIQ Shared Unit clock
>>   clk: meson: g12a: add support for SM1 CPU 1, 2 & 3 clocks
>>   arm64: dts: meson-sm1-sei610: enable DVFS
>>
>>  .../bindings/clock/amlogic,gxbb-clkc.txt      |   1 +
>>  .../boot/dts/amlogic/meson-sm1-sei610.dts     |  59 +-
>>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |  69 +++
>>  drivers/clk/meson/g12a.c                      | 544 ++++++++++++++++++
>>  drivers/clk/meson/g12a.h                      |  24 +-
>>  include/dt-bindings/clock/g12a-clkc.h         |   5 +
>>  6 files changed, 697 insertions(+), 5 deletions(-)
>
> Applied 1 to 4

Will there be a stable tag I can use for that so I can apply patch 5?

Kevin
