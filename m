Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3659C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C649920830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbfDBN6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:58:21 -0400
Received: from ns.iliad.fr ([212.27.33.1]:46084 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731186AbfDBN6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:58:21 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 3807320C39;
        Tue,  2 Apr 2019 15:58:19 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 28F5820B07;
        Tue,  2 Apr 2019 15:58:19 +0200 (CEST)
Subject: Re: [PATCH v2 00/13] qcom: dts: thermal cleanups
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <5583cae1-8fea-724a-24a4-59b38a205ac3@free.fr>
Date:   Tue, 2 Apr 2019 15:58:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Apr  2 15:58:19 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2019 11:12, Amit Kucheria wrote:

> Changes since v1:
> - Devices that are not associated with cooling-maps use the 'hot' type
> - Remove critical trip from such devices too and restrict that type of CPUs
> - For 8916, add the sensor on the modem
> 
> Description:
> - Expose all temperature sensors on msm8916, msm996, msm8998, sdm845
> - split up the register address map for msm8998
> - standardize names of the various thermal-zones across boards to make it
>   easy for test scripts to parse

This is what I see on msm8998 with your patch series applied on top of
yesterday's next:

# dmesg | grep of_parse_thermal_zones
of_parse_thermal_zones: build cpu0-thermal zone 0
of_parse_thermal_zones: build cpu1-thermal zone 0
of_parse_thermal_zones: build cpu2-thermal zone 0
of_parse_thermal_zones: build cpu3-thermal zone 0
of_parse_thermal_zones: build cpu4-thermal zone 0
of_parse_thermal_zones: build cpu5-thermal zone 0
of_parse_thermal_zones: build cpu6-thermal zone 0
of_parse_thermal_zones: build cpu7-thermal zone 0
of_parse_thermal_zones: build gpu-thermal-bottom zone 0
of_parse_thermal_zones: build gpu-thermal-top zone 0
of_parse_thermal_zones: build cluster0-mhm-thermal zone -22
of_parse_thermal_zones: build cluster1-mhm-thermal zone -22
of_parse_thermal_zones: build cluster1-l2-thermal zone 0
of_parse_thermal_zones: build modem-thermal zone 0
of_parse_thermal_zones: build mem-thermal zone 0
of_parse_thermal_zones: build wlan-thermal zone 0
of_parse_thermal_zones: build q6-dsp-thermal zone 0
of_parse_thermal_zones: build camera-thermal zone 0
of_parse_thermal_zones: build multimedia-thermal zone 0
of_parse_thermal_zones: build pm8998 zone 0
of_parse_thermal_zones: build battery-thermal zone 0
of_parse_thermal_zones: build skin-thermal zone 0

NB: -EINVAL for cluster0-mhm-thermal and cluster1-mhm-thermal


# cat /sys/devices/virtual/thermal/thermal_zone*/temp 
35800
35200
34500
34800
34500
34100
34100
33500
33800
cat: /sys/devices/virtual/thermal/thermal_zone17/temp: Invalid argument
36100
cat: /sys/devices/virtual/thermal/thermal_zone19/temp: Invalid argument
35500
36100
35800
35200
35500
36100
cat: /sys/devices/virtual/thermal/thermal_zone8/temp: Invalid argument
cat: /sys/devices/virtual/thermal/thermal_zone9/temp: Invalid argument


Are the failures expected?
(cluster*-mhm-thermal and thermal_zone*/temp)

Regards.
