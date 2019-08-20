Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DFFC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2C82332B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="p+vl6bqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfHTXGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:06:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35763 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfHTXGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:06:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id d85so100721pfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=3ZdYND6Wl1bRQZobvgDGilBtsFiFe5f8MwN/RoglplU=;
        b=p+vl6bqwnZBpeaHiyriodr3YU5vPNi6dgqkRp3GiaA9JczUyoLile77Dj2B+BZggDJ
         NzlvH7CyYBerZlpjYj15RbbWMyJGouIgFI2T2IMOh0Aye5krAxOLBcXbXZaO3fM5C0/h
         hUUGR5wuWOwGkH10sOSgrfyyEGNPU8PX1FsNAGfHSISAOMQM/dR20jKpSyidDWMVnYU3
         gEqghkvroFGIBsJ9s+b3i/1R0ZbvMjdA3YSrdWgQJh2pU3bdRUNrB6vTH/T6Y0N7Mt/d
         /stEefEeTo4i0TNewxUdzqaM15UhIX5rWx63ufnkwEr7MaZcPeaYBa9JWg+w9N+xuwMz
         VEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3ZdYND6Wl1bRQZobvgDGilBtsFiFe5f8MwN/RoglplU=;
        b=PwynGOp8xrB7mGSASDOe+AMQLJkKDhWcYnv9tYsLrmbkwuIPUsCg58riPKis2nhEYF
         cyIuGh9G4kjQxqRB/98B+OYNJ/LMG98pJGgwd0swwtfDKTNAjXy7e7cD9Hg2SfZUfyVH
         vx03EWRelstSowJANJU2z87lVXidWY6/qii6koDpQbFBmMCzZbO6C5/KiPS7MTT6Hn2E
         uVFTGWFoDMApvPhxljze+p6tyGxlgGxWzvjttxktZgyflZOJKUN70vHZDBdpMCD/b0+F
         OOggowZOkthLhoXeZqqsKMsbHwIE+vomxLh3yOTDHzvSOcoBSbPIsYENwUHQC3hP7Y9P
         91Sw==
X-Gm-Message-State: APjAAAUbcxeGOPo4tE7gtlFsBd++YdwoGBxMooVTbL0iTRAXAw/oQqkK
        XpTPPUP7t+ruHojW4G6W82c/Yw==
X-Google-Smtp-Source: APXvYqxALtnddgGMFc2X2U+yCFu2yJS7dzJAjVYSdhFC5iity/GwPzH8lvuhFKcFPxyXSfOTqNZTzg==
X-Received: by 2002:a17:90b:8ca:: with SMTP id ds10mr2269923pjb.139.1566342408736;
        Tue, 20 Aug 2019 16:06:48 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id d18sm17691015pgi.40.2019.08.20.16.06.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 16:06:48 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] arm64: Add support for Amlogic SM1 SoC Family
In-Reply-To: <7h4l2bej1c.fsf@baylibre.com>
References: <20190820144052.18269-1-narmstrong@baylibre.com> <7h4l2bej1c.fsf@baylibre.com>
Date:   Tue, 20 Aug 2019 16:06:45 -0700
Message-ID: <7ho90jbfne.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Neil Armstrong <narmstrong@baylibre.com> writes:
>
>> The new Amlogic SM1 SoC Family is a derivative of the Amlogic G12A
>> SoC Family, with the following changes :
>> - Cortex-A55 cores instead of A53
>> - more power domains, including USB & PCIe
>> - a neural network co-processor (NNA)
>> - a CSI input and image processor
>> - some changes in the audio complex, thus not yet enabled
>> - new clocks, for NNA, CSI and a clock tree for each CPU Core
>>
>> This serie does not add support for NNA, CSI, Audio, USB, Display
>> or DVFS, it only aligns with the current G12A Support.
>>
>> With this serie, the SEI610 Board has supported :
>> - Default-boot CPU frequency
>> - Ethernet
>> - LEDs
>> - IR
>> - GPIO Buttons
>> - eMMC
>> - SDCard
>> - SDIO WiFi
>> - UART Bluetooth
>>
>> Audio (HDMI, Embedded HP, MIcs), USB, HDMI, IR Output, & RGB Led
>> would be supported in following patchsets.
>>
>> Dependencies:
>> - g12-common.dtsi from the DVFS patchset at [1]
>>
>> Changes from rfc at [2]:
>> - Removed Power domain patches & display/USB support, will resend separately
>> - Removed applied AO-CEC patches
>> - Fixed clk-measure IDs
>> - Collected reviewed-by tags
>>
>> [1] https://patchwork.kernel.org/cover/11025309/
>> [2] https://patchwork.kernel.org/cover/11025511/
>
> Series queued for v5.4...
>> Neil Armstrong (6):
>>   soc: amlogic: meson-gx-socinfo: Add SM1 and S905X3 IDs
>>   dt-bindings: soc: amlogic: clk-measure: Add SM1 compatible
>>   soc: amlogic: clk-measure: Add support for SM1
>
> ... these 3 in v5.4/drivers ...
>
>>   dt-bindings: arm: amlogic: add SM1 bindings
>>   dt-bindings: arm: amlogic: add SEI Robotics SEI610 bindings
>>   arm64: dts: add support for SM1 based SEI Robotics SEI610
>
> ... and these 3 in v5.4/dt64 with Rob's tag.

And I forgot to add that I boot-tested this on an SEI610 as well.

Tested-by: Kevin Hilman <khilman@baylibre.com>

