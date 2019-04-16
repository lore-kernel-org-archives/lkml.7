Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A085C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E15206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbfDPRZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:25:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57261 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDPRZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:25:01 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hGRpJ-00017y-Np; Tue, 16 Apr 2019 19:24:57 +0200
Message-ID: <1555435497.2317.17.camel@pengutronix.de>
Subject: Re: [PATCH v4 00/12] QorIQ TMU multi-sensor and HWMON support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Apr 2019 19:24:57 +0200
In-Reply-To: <20190413082748.29990-1-andrew.smirnov@gmail.com>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series is:

Tested-by: Lucas Stach <l.stach@pengutronix.de>

Regards,
Lucas

Am Samstag, den 13.04.2019, 01:27 -0700 schrieb Andrey Smirnov:
> Everyone:
> 
> This series contains patches adding support for HWMON integration, bug
> fixes and general improvements (hopefully) for TMU driver I made while
> working on it on i.MX8MQ.
> 
> Feedback is welcome!
> 
> Thanks,
> Andrey Smirnov
> 
> Changes since [v3]
> 
>     - Series reabse on top of [rfc]
>     
>     - Fixed incorrect goto label in "thermal: qoriq: Pass data to
>       qoriq_tmu_calibration()"
>       
>     - Added REGS_TRITSR() register description to "thermal: qoriq: Do
>       not report invalid temperature reading"
>       
>     - Reworded commit message of "thermal: qoriq: Remove unnecessary
>       DT node is NULL check"
> 
> Changes since [v2]
> 
>     - Patches rebased on v5.1-rc1
> 
> Changes since [v1]
> 
>     - Rebased on "linus" branch of
>       git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
>       that included latest chagnes adding multi-sensors support
> 
>     - Dropped
> 
> 	thermal: qoriq: Add support for multiple thremal sites
> 	thermal: qoriq: Be more strict when parsing
> 	thermal: qoriq: Simplify error handling in qoriq_tmu_get_sensor_id()
> 
>       since they are no longer relevant
> 
>     - Added
> 
> 	thermal: qoriq: Don't store struct thermal_zone_device reference
> 	thermal: qoriq: Add local struct qoriq_sensor pointer
> 	thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
> 	thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
> 
>       to simplify latest codebase
> 
>     - Changed "thermal: qoriq: Do not report invalid temperature
>       reading" to use regmap_read_poll_timeout() to make sure that
>       tmu_get_temp() waits for fist sample to be ready before
>       reporting it. This case is triggered on my setup if
>       qoriq_thermal is compiled as a module
> 
> [v1] lore.kernel.org/lkml/20190218191141.3729-1-andrew.smirnov@gmail.com
> [v2] lore.kernel.org/lkml/20190222200508.26325-1-andrew.smirnov@gmail.com
> [v3] lore.kernel.org/lkml/20190401041418.5999-1-andrew.smirnov@gmail.com
> [rfc] lore.kernel.org/lkml/20190404080647.8173-1-daniel.lezcano@linaro.org
> 
> Andrey Smirnov (12):
>   thermal: qoriq: Remove unnecessary DT node is NULL check
>   thermal: qoriq: Add local struct device pointer
>   thermal: qoriq: Don't store struct thermal_zone_device reference
>   thermal: qoriq: Drop per-sensor data
>   thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
>   thermal: qoriq: Pass data to qoriq_tmu_calibration() directly
>   thermal: qoriq: Convert driver to use devm_ioremap()
>   thermal: qoriq: Convert driver to use regmap API
>   thermal: qoriq: Enable all sensors before registering them
>   thermal: qoriq: Do not report invalid temperature reading
>   thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
>   thermal: qoriq: Add hwmon support
> 
>  drivers/thermal/qoriq_thermal.c | 287 +++++++++++++++-----------------
>  drivers/thermal/thermal_hwmon.c |  28 ++++
>  drivers/thermal/thermal_hwmon.h |   7 +
>  3 files changed, 171 insertions(+), 151 deletions(-)
> 
