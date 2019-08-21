Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B383C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4F4206DD
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="M41c94fB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbfHUVTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 17:19:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53720 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfHUVTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:19:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id 10so3533856wmp.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 14:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dbzkg0dehYA9XxXBy/tRWEwtyB89ujck03vcqauhtxk=;
        b=M41c94fBiRx04YN/D9LqPjJsO6altoSy7hmpL7ol/za2grZjkRDhSLO5v0GE4oqFcr
         sB1NADhpZQEX8bu+8z3ngPuXvDNMCnvmraEJ3pjT7pO4D7RFtsLKvpACV3d+wRTcbYS3
         kXiyqcUDbRVLfqAFOu1aQWi9KhSGOs/D7bXZH5FbeWTIBEsiE3Gq6Uasu8AoiGFjkegK
         gGauvlV6DC3y9og3jEJhbnL9tuYDdQ6Cj/qw58OVHgjo81rXZQTbiI8lu/htArVrxzmf
         go8bSDnidovR7Jy0DAm4NoDj/6PEdoI+wObbt2hwoh0VjwVbN95CdgNGGKyfL19/k8sP
         KHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dbzkg0dehYA9XxXBy/tRWEwtyB89ujck03vcqauhtxk=;
        b=L9uqBYxdspWSKoUFYOrXflWTzT1k9A4iLiosCzczLvka7qYaeEIaZNwuS40y+1vVi4
         OKQM3ULn9zKWK2kMjIkHhk60naeSMGTVSSRE+85dGGyRKuczpsImmCvZJQ21ZGk4jDZO
         0qIomhlRt7rxkicABiOZjLNNLoDkIVGASSIxdGb08kJ7QNi6sTT5GVkN54676Zc8aDzM
         t4Zh4U7lrPDIIEB9ymu8C/7T2qgHpuJ0+AWwR7nD1oF0YxxwHg7RsbjNiE3oEm3LZebG
         j4dqjUgZhVgTXy4loaGeiR3UuTKfCrjYfjan0bIetNIs8Z39hCYN9qA/3Bkay5nmQO90
         NdHQ==
X-Gm-Message-State: APjAAAXKOpB4qqX686pxujycMwaHXH+HRT3LsWR6txCPF4Qh+rkQ7gmP
        0t5AYoyu2xy5GbxCrNWP1YcymA==
X-Google-Smtp-Source: APXvYqz8RJbRsGB3Mt8HsUVbL8cKiur8eRibcotSAhwTRu5jFrKEfBVKTcGp7K5dPJ2MRLuU5YWVug==
X-Received: by 2002:a7b:c649:: with SMTP id q9mr2156413wmk.108.1566422379282;
        Wed, 21 Aug 2019 14:19:39 -0700 (PDT)
Received: from ?IPv6:2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca? ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id c11sm19183554wrs.86.2019.08.21.14.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 14:19:38 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] Add support of New Amlogic temperature sensor for
 G12 SoCs
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     daniel.lezcano@linaro.org, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20190806130506.8753-1-glaroque@baylibre.com>
 <357FACA6-6EAC-4E9D-B6F7-4D8D0D59A20A@gmail.com>
From:   guillaume La Roque <glaroque@baylibre.com>
Message-ID: <9a63d585-69b1-c9b2-8092-51361ff41991@baylibre.com>
Date:   Wed, 21 Aug 2019 23:19:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <357FACA6-6EAC-4E9D-B6F7-4D8D0D59A20A@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,


thanks for testing on this 3 boards.


guillaume

On 8/14/19 2:24 PM, Christian Hewitt wrote:
> On 6 Aug 2019, at 5:05 pm, Guillaume La Roque <glaroque@baylibre.com> wrote:
>> This patchs series add support of New Amlogic temperature sensor and minimal
>> thermal zone for SEI510 and ODROID-N2 boards.
>>
>> First implementation was doing on IIO[1] but after comments i move on thermal framework.
>> Formulas and calibration values come from amlogic.
>>
>> Changes since v2:
>>  - fix yaml documention 
>>  - remove unneeded status variable for temperature-sensor node
>>  - rework driver after Martin review
>>  - add some information in commit message
>>
>> Changes since v1:
>>  - fix enum vs const in documentation
>>  - fix error with thermal-sensor-cells value set to 1 instead of 0
>>  - add some dependencies needed to add cooling-maps
>>
>> Dependencies :
>> - patch 3,4 & 5: depends on Neil's patch and series :
>>              - missing dwc2 phy-names[2]
>>              - patchsets to add DVFS on G12a[3] which have deps on [4] and [5]
>>
>> [1] https://lore.kernel.org/linux-amlogic/20190604144714.2009-1-glaroque@baylibre.com/
>> [2] https://lore.kernel.org/linux-amlogic/20190625123647.26117-1-narmstrong@baylibre.com/
>> [3] https://lore.kernel.org/linux-amlogic/20190729132622.7566-1-narmstrong@baylibre.com/
>> [4] https://lore.kernel.org/linux-amlogic/20190731084019.8451-5-narmstrong@baylibre.com/
>> [5] https://lore.kernel.org/linux-amlogic/20190729132622.7566-3-narmstrong@baylibre.com/
>>
>> Guillaume La Roque (6):
>>  dt-bindings: thermal: Add DT bindings documentation for Amlogic
>>    Thermal
>>  thermal: amlogic: Add thermal driver to support G12 SoCs
>>  arm64: dts: amlogic: g12: add temperature sensor
>>  arm64: dts: meson: sei510: Add minimal thermal zone
>>  arm64: dts: amlogic: odroid-n2: add minimal thermal zone
>>  MAINTAINERS: add entry for Amlogic Thermal driver
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>
> I’ve tested this series with Odroid N2 and Khadas VIM3, X96-Max. Patches to add
> support for VIM3/X96-max will be submitted once the driver is merged.
>
> VIM3:~ # dmesg | grep thermal
> [    0.046375] thermal_sys: Registered thermal governor 'step_wise'
>
> VIM3:~ # cat /sys/devices/virtual/thermal/thermal_zone0/temp
> 51300
>
> VIM3:~ # cat /sys/devices/virtual/thermal/thermal_zone1/temp
> 52800
>
> Christian
