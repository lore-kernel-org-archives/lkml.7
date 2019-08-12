Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33A8C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3CE20684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2MsEqrq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfHLUyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:54:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41183 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLUyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:54:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id 196so3135366pfz.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 13:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=G96ttrylkozavtp+GkCFPZaZpJ1CXYrccgmyLzpILSM=;
        b=2MsEqrq6jeAHonuDnFidSEMvA40eV2EV9rHP09a8PVmfQV2q1l2rUXiOBofFeJytCi
         yI+eiJfH2QzC7hIdvHRPsVJrkoZa71GBYet+8I26skuXpSKSI6mp1hI99ctHa29GprZ2
         D/4QHSTBBh999SSdtRaZg4Rga9dfc1HV1AYHPPnxvfQKvLeYaRfUTi4mGfAxKSdbp0xQ
         xRoZd/5mUSybTsWNHCDHg3TkIxncgGBdxcipbrzEf7yrtBKbhoA2r8VNePoJpE/r4e0E
         Y6Id0y55Va4n6Rzm1NfozTcxT848JRvEm9+JoESTp70CMatneEjveslZJC4XPk6RIZqy
         O17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=G96ttrylkozavtp+GkCFPZaZpJ1CXYrccgmyLzpILSM=;
        b=RVQzhN3PZkOB/m3GGO2KPvojmYrqlqLQ81Cb3h1cia8ylR7nKn4RK3f/ssHGe8OtB1
         7Fxk68uIV0AU5nIX+AT4n5QkBTX0Z1ySvyTszUs5hDZen1cBMK8UVjBpQhbB9L52w5vb
         MEh85e9yDR5tPg44kSrXUlSILuaIs1SYvXKObZHV8HKCAuHwz/LwGnW9jtGUSTE919qQ
         oox2NsHvIqe5J92qOhZM7ukg2BK7hhguB2a9aspv5UGodKh05K+ljQEgSK6XWt4Kgi2R
         J0Z/xqeY2x2utdEmLRVWaWE7b5TjJC7L2x/8y7b0L0p8BmrcMZei17LrIBcXgzTvmLD0
         ijow==
X-Gm-Message-State: APjAAAUx//2M5YA5Aa+9umO4HmZDjDspeNhAG5Kv2YEtfT6zO1DVASCF
        QCbWMmL08UQUIToaZaxL/gownQ==
X-Google-Smtp-Source: APXvYqzbET0UNtAEOW/tFOjsj6Fj901cwmJjrYlflO9pmbo1TxhTMwyLzIaz0Ye07PH9P2f/B/glkw==
X-Received: by 2002:a62:f245:: with SMTP id y5mr3845900pfl.156.1565643285235;
        Mon, 12 Aug 2019 13:54:45 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:14bb:580e:e4d6:b3a8])
        by smtp.gmail.com with ESMTPSA id cx22sm405480pjb.25.2019.08.12.13.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 13:54:44 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] arm64: g12a: add support for DVFS
In-Reply-To: <7hk1bn43fq.fsf@baylibre.com>
References: <20190729132622.7566-1-narmstrong@baylibre.com> <7hwofrh1md.fsf@baylibre.com> <7hk1bn43fq.fsf@baylibre.com>
Date:   Mon, 12 Aug 2019 13:54:43 -0700
Message-ID: <7hpnla14vg.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Kevin Hilman <khilman@baylibre.com> writes:
>
>> Neil Armstrong <narmstrong@baylibre.com> writes:
>>
>>> The G12A & G12B SoCs has kernel controllable CPU clocks and PWMs for
>>> voltage regulators.
>>>
>>> This patchsets moves the meson-g12a.dtsi to meson-g12-common.dtsi to simplify
>>> handling the G12A & G12B differences in the meson-g12a.dtsi & meson-g12b.dtsi
>>> files, like the OPPs and CPU nodes.
>>>
>>> Then G12A & G12B OPP tables are added, followed by the CPU voltages regulators
>>> in each boards DT.
>>>
>>> It was voluntary chosen to enabled DVFS (CPU regulator and CPU clocks) only
>>> in boards, to make sure only tested boards has DVFS enabled.
>>>
>>> This patchset :
>>> - moves the G12A DT to a common g12a-common dtsi
>>> - adds the G12A and G12B OPPs
>>> - enables DVFS on all supported boards
>>>
>>> Dependencies:
>>> - None
>>
>> Not quite.  The last patch to enable DVFS on odroid-n2 has a build-time
>> dependency on the clock series that adds the CPUB clock.
>>
>> I'll apply the rest of the series to v5.4/dt64 until there's a stable
>> clock tag I can use for the clocks.
>
> In order to test this, I noticed another dependency needed for the PWM
> regulators to work:
>
>    https://lore.kernel.org/linux-amlogic/20190729125838.6498-1-narmstrong@baylibre.com/
>
> With that and the clock deps, it's working well on my odroid-n2.
>
> Tested-by: Kevin Hilman <khilman@baylibre.com>

After merging Jerome's tag for clk DT, I've queued this for v5.4,

Thanks,

Kevin
