Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20EDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58DD22CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sAlc7dXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfH1RzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:55:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40153 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfH1RzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:55:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so124481pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=f0W0Cp/fSkd8gJkun/cT9sRSvNzsXJn2ArGwn/qLr+o=;
        b=sAlc7dXcFJ7XynLIVaBr9jmzzrLqttO5eOn9wviTbhuTZpdN5lkV8G8WjwQQGxwYDD
         zK2amnB3CVXPykbbz4LtLOVlahoLkoCTrccrp+gce1A7vRbkzfV0Tg7hlGt815S5tfl7
         xgjn4SMp6YVvZWZdNCPmj/0MQVE0M4nVE04DiIEZQX+a5lx2MJd1YG/jrPwe5DBmXnJu
         C4vD9EAzgXimZyNcJ9M5uXl5fA6G2bljsIFCoEyQewCZzwG2ItYFXIxSgInBIHNxmvr0
         fAdJNx5iH98Hxvc3r+o/BS1NcMKbwsNbiPgVS+4Pgjng86QGyynRQ6tYIM3p6zjMvpzY
         syuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=f0W0Cp/fSkd8gJkun/cT9sRSvNzsXJn2ArGwn/qLr+o=;
        b=JzuOArVcryHCRw14J4X7r4GKKh56S5Zqo6xUBQhZ3j/+ZL9w/75w9QOSkPFnYyh/p4
         50TlkKaG42O7P8i8RYod1KSJKP4WQCwAA13/HvGwvwYVG6jvmBbKBo7Xqb5jG+OM9Z74
         Muq5QOWQX+KpxFDaCIUiolXmzD1RPo6J4KOAMRJz6AGCiIYlzOmUwXHtXX67BSS1y6oQ
         GgLldSSuuXJAvBw5DHBMok2cUuSh+ZChstPym+Gw4bGwu4A5AJXbCZgxCTBp/2A0KsJu
         CNkjciX0l+IOGXX9IqRknIotnld6rtrpOY6jV2EnWjYphaHyaiIs5pQX3uvrFXKQWqp8
         q0nA==
X-Gm-Message-State: APjAAAWlFq388ue5e9v3zlCbDF6C6hD3TQmwcuvkho11o+inT3PX6zCW
        zARZfvzdz4bUIKH+l3wFM4P33Dj3gmw=
X-Google-Smtp-Source: APXvYqzDNAU4cL2FhF2Nahd2VeF5eZksAUdxqx6zpKeuv35+jfDw6Cb0kfSl44iJoneO8a/dlrMBSw==
X-Received: by 2002:a63:5765:: with SMTP id h37mr4406979pgm.183.1567014914250;
        Wed, 28 Aug 2019 10:55:14 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:cc35:e750:308e:47f])
        by smtp.gmail.com with ESMTPSA id s186sm3879496pfb.126.2019.08.28.10.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Aug 2019 10:55:13 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] arm64: meson-sm1: add support for the SM1 based VIM3L
In-Reply-To: <20190828141816.16328-1-narmstrong@baylibre.com>
References: <20190828141816.16328-1-narmstrong@baylibre.com>
Date:   Wed, 28 Aug 2019 10:55:12 -0700
Message-ID: <7hblw9rx8f.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patchset adds support for the Amlogic SM1 based Khadas VIM3L variant.
>
> The S903D3 package variant of SM1 is pin-to-pin compatible with the
> S922X and A311d, so only internal DT changes are needed :
> - DVFS support is different
> - Audio support not yet available for SM1
>
> This patchset moved all the non-g12b nodes to meson-khadas-vim3.dtsi
> and add the sm1 specific nodes into meson-sm1-khadas-vim3l.dts.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Basic boot test + suspend/resume test OK on my vim3L (thanks to Khadas
for the board!)

> Display has a color conversion bug on SM1 by using a more recent vendor
> bootloader on the SM1 based VIM3, this is out of scope of this patchset
> and will be fixed in the drm/meson driver.
>
> Dependencies:
> - patch 1,2: None
> - patch 3: Depends on the "arm64: meson-sm1: add support for DVFS" patchset at [1]

I tested in my integ branch where this series is applied, but I'm not
seeing any OPPs created (/sys/devices/system/cpu/cpufreq/)

Kevin
