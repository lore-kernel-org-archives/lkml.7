Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21DDC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 05:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5365320675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 05:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YQgHztCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfCFFH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 00:07:27 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:45297 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfCFFH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 00:07:27 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190306050723epoutp030d462341021b24f4c5142d6505a9056c~JRk0Aqd3m2622426224epoutp03B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2019 05:07:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190306050723epoutp030d462341021b24f4c5142d6505a9056c~JRk0Aqd3m2622426224epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551848843;
        bh=D9gEkdlfDU9pcbqELgHmwBVx62w4m2AwhGQlQyaYU4c=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YQgHztCxlwv3LMCrrJU0qh0G7AygCSNooUNe4LBxXt9EL2N7CwGyZFqQQFgXYPcbz
         8rwWZsCvuHvjPXLvyOvipd0UWE3t4+SxOmK+IF7CnWG8m/qR8rVMIUcLMhib1S0hbW
         tNAMd4XLdTxvFSVpRPCQfupMMiagpblJBFSP/2+o=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190306050718epcas1p400d39a3e93c04204a72c8e737b77ed1d~JRkvr66r12637926379epcas1p4m;
        Wed,  6 Mar 2019 05:07:18 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.FB.04173.3855F7C5; Wed,  6 Mar 2019 14:07:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190306050714epcas1p24e31aac164de5b3e0cc4109f11e85d05~JRksJekZR0257602576epcas1p2P;
        Wed,  6 Mar 2019 05:07:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190306050714epsmtrp21574d284e903e7f19ddfb61976d4bcea~JRksIlXPv0952309523epsmtrp2L;
        Wed,  6 Mar 2019 05:07:14 +0000 (GMT)
X-AuditID: b6c32a36-5d9ff7000000104d-d7-5c7f5583f443
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.E1.03971.2855F7C5; Wed,  6 Mar 2019 14:07:14 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190306050714epsmtip15af9864c90e95fd7923c217f52c29d1e~JRkr8krSv3015930159epsmtip1D;
        Wed,  6 Mar 2019 05:07:14 +0000 (GMT)
Subject: Re: [PATCH -next & mmotm] extcon: fix EXTCON_PTP5150 kconfig
 warnings and build errors
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9a85c4a4-5dc7-e69a-ffa1-490c8cb98e9f@samsung.com>
Date:   Wed, 6 Mar 2019 14:07:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <ff1784cd-6429-8597-fcba-55b383727515@infradead.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmgW5zaH2MwYNt7BZz1q9hs7i8aw6b
        xe3GFWwWb+9MZ7F4uX86qwOrx85Zd9k9Nq/Q8jgx4zeLR9+WVYwenzfJBbBGZdtkpCampBYp
        pOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAO1WUihLzCkFCgUkFhcr
        6dvZFOWXlqQqZOQXl9gqpRak5BRYFugVJ+YWl+al6yXn51oZGhgYmQIVJmRn/Ls+ma1gmXtF
        68ejjA2M3ZZdjJwcEgImEnP6D7J1MXJxCAnsYJS4v+4/K0hCSOATo8Sd5Y4QiW+MEhPffGGE
        6Th1ZhtUx15Gic8LFjFCdLxnlFh+TRDEFhZIlDj/7zdYXESgSuJx5ynmLkYODmaBeIm2+fwg
        YTYBLYn9L26wgdj8AooSV388ZgQp4RWwkzj7rAokzCKgInHzWCMTiC0qECHx/uluFhCbV0BQ
        4uTMJ2A2p4CjxPMtd8HGMAuIS9x6Mp8JwpaXaN46mxnkTAmB52wSN1btYoO430Xiwp+VTBC2
        sMSr41vYIWwpic/v9kLVVEusPHmEDaK5g1Fiy/4LrBAJY4n9SyczQfyiKbF+lz7EMj6Jd197
        WEHCEgK8Eh1tQhDVyhKXH9yFWiUpsbi9E2q8h8ScdedYJzAqzkLyziwkL8xC8sIshGULGFlW
        MYqlFhTnpqcWGxYYIUf1JkZwotQy28G46JzPIUYBDkYlHt4JrXUxQqyJZcWVuYcYJTiYlUR4
        gx3qY4R4UxIrq1KL8uOLSnNSiw8xmgJDeyKzlGhyPjCJ55XEG5oaGRsbW5gYmpkaGiqJ8653
        cI4REkhPLEnNTk0tSC2C6WPi4JRqYNx67qPv2+htvgUrlm39Pn/jJH9hv7SulwvPrm4Mz3jL
        te65Rf/xza/TPBv7AhXmM1t1R7XF1S6cX1nW/9KOZ+HlJaa7bmXE9Ho/uyGdLh5ketXt//+F
        MwouJ7JH/b2RsFNP9tQSQXYTZZGHa+KdJx00Wucu3h0c+eXOtviz0ZuLRQ+H/mM8fUuJpTgj
        0VCLuag4EQA2O2nUqgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJTrcptD7GYNNFZYs569ewWVzeNYfN
        4nbjCjaLt3ems1i83D+d1YHVY+esu+wem1doeZyY8ZvFo2/LKkaPz5vkAlijuGxSUnMyy1KL
        9O0SuDL+XZ/MVrDMvaL141HGBsZuyy5GTg4JAROJU2e2sXUxcnEICexmlFj0fi47REJSYtrF
        o8xdjBxAtrDE4cPFEDVvGSXuty5kBKkRFkiU2LK2lRnEFhGokpg+/zEbSD2zQLzEuT45iPop
        jBId90+C1bAJaEnsf3GDDcTmF1CUuPrjMSNIPa+AncTZZ1UgYRYBFYmbxxqZQGxRgQiJuxdf
        sIDYvAKCEidnPgGzOQUcJZ5vuQs2hllAXeLPvEvMELa4xK0n85kgbHmJ5q2zmScwCs9C0j4L
        ScssJC2zkLQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHDVamjsYLy+JP8Qo
        wMGoxMM7obUuRog1say4MvcQowQHs5IIb7BDfYwQb0piZVVqUX58UWlOavEhRmkOFiVx3qd5
        xyKFBNITS1KzU1MLUotgskwcnFINjJyOIdqnAtKPbdzhZvF1uc/yFzPWLWZ5+onLxH39OeOZ
        YevkXO07FvmLxSxcUek37aZg9MIlj+wfhN1xi9RgZ0rduWyH5rJWff6t6jONSi5eERX/OXWp
        /ZLXxTOqd5Xqz/p8zPXVXVWltRz7rJ5bLRe5IWwa2fb45TO+ax5sTnfmXcj7mlawRluJpTgj
        0VCLuag4EQCO0akblgIAAA==
X-CMS-MailID: 20190306050714epcas1p24e31aac164de5b3e0cc4109f11e85d05
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190226001817epcas4p1a7d9f952dccd38dcce178dad487268fa
References: <CGME20190226001817epcas4p1a7d9f952dccd38dcce178dad487268fa@epcas4p1.samsung.com>
        <ff1784cd-6429-8597-fcba-55b383727515@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Applied it for v5.1-rc2.
I'll send the pull request it for v5.1-rc2.

Best Regards,
Chanwoo Choi

On 19. 2. 26. 오전 9:17, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Having COMPILE_TEST here is causing problems.  I reported one
> last week and have another one today.  Although I support
> using COMPILE_TEST when possible, this one is better removed.
> 
> Fixes these warnings and build errors:
> 
> WARNING: unmet direct dependencies detected for REGMAP_I2C
>   Depends on [m]: I2C [=m]
>   Selected by [y]:
>   - EXTCON_PTN5150 [=y] && EXTCON [=y] && (I2C [=m] && GPIOLIB [=y] || COMPILE_TEST [=y])
>   Selected by [m]:
>   - EEPROM_AT24 [=m] && I2C [=m] && SYSFS [=y]
>   - KEYBOARD_CAP11XX [=m] && !UML && INPUT [=y] && INPUT_KEYBOARD [=y] && OF [=y] && I2C [=m]
>   - I2C_MUX_LTC4306 [=m] && I2C [=m] && I2C_MUX [=m]
>   - GPIO_TS4900 [=m] && GPIOLIB [=y] && I2C [=m] && (SOC_IMX6 || COMPILE_TEST [=y])
>   - SENSORS_LTC2945 [=m] && HWMON [=y] && I2C [=m]
>   - SENSORS_LTC4222 [=m] && HWMON [=y] && I2C [=m]
>   - SENSORS_MAX6621 [=m] && HWMON [=y] && I2C [=m]
>   - SENSORS_LM75 [=m] && HWMON [=y] && I2C [=m]
>   - SENSORS_NCT7802 [=m] && HWMON [=y] && I2C [=m]
>   - SENSORS_EMC1403 [=m] && HWMON [=y] && I2C [=m]
>   - SENSORS_ADS7828 [=m] && HWMON [=y] && I2C [=m]
>   - SENSORS_INA2XX [=m] && HWMON [=y] && I2C [=m]
>   - SENSORS_INA3221 [=m] && HWMON [=y] && I2C [=m]
>   - SENSORS_TMP102 [=m] && HWMON [=y] && I2C [=m]
>   - SENSORS_TMP103 [=m] && HWMON [=y] && I2C [=m]
>   - MFD_BCM590XX [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - MFD_AXP20X_I2C [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - MFD_MADERA_I2C [=m] && HAS_IOMEM [=y] && MFD_MADERA [=m] && I2C [=m]
>   - MFD_DA9062 [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - MFD_DA9063 [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - MFD_DA9150 [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - MFD_MC13XXX_I2C [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - MFD_88PM800 [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - MFD_88PM805 [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - MFD_MAX14577 [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - MFD_MAX77686 [=m] && HAS_IOMEM [=y] && I2C [=m] && (OF [=y] || COMPILE_TEST [=y])
>   - MFD_MAX8907 [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - MFD_RT5033 [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - MFD_RN5T618 [=m] && HAS_IOMEM [=y] && I2C [=m] && OF [=y]
>   - MFD_SI476X_CORE [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - MFD_SKY81452 [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - MFD_TI_LMU [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - TPS6105X [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - MFD_TPS65086 [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - MFD_TPS65217 [=m] && HAS_IOMEM [=y] && I2C [=m] && OF [=y]
>   - MFD_TI_LP873X [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - MFD_TPS65218 [=m] && HAS_IOMEM [=y] && I2C [=m] && OF [=y]
>   - MFD_TPS65912_I2C [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - MFD_LM3533 [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - MFD_WM8994 [=m] && HAS_IOMEM [=y] && I2C [=m]
>   - REGULATOR_88PG86X [=m] && REGULATOR [=y] && I2C [=m]
>   - REGULATOR_DA9211 [=m] && REGULATOR [=y] && I2C [=m]
>   - REGULATOR_FAN53555 [=m] && REGULATOR [=y] && I2C [=m]
>   - REGULATOR_LTC3676 [=m] && REGULATOR [=y] && I2C [=m]
>   - REGULATOR_MAX8649 [=m] && REGULATOR [=y] && I2C [=m]
>   - REGULATOR_MT6311 [=m] && REGULATOR [=y] && I2C [=m]
>   - REGULATOR_PFUZE100 [=m] && REGULATOR [=y] && I2C [=m]
>   - REGULATOR_PV88060 [=m] && REGULATOR [=y] && I2C [=m]
>   - REGULATOR_PV88080 [=m] && REGULATOR [=y] && I2C [=m]
>   - REGULATOR_SY8106A [=m] && REGULATOR [=y] && I2C [=m] && (OF [=y] || COMPILE_TEST [=y])
>   - REGULATOR_TPS62360 [=m] && REGULATOR [=y] && I2C [=m]
>   - REGULATOR_TPS65023 [=m] && REGULATOR [=y] && I2C [=m]
>   - DRM_ANALOGIX_ANX78XX [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_BRIDGE [=y]
>   - DRM_TOSHIBA_TC358767 [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_BRIDGE [=y] && OF [=y]
>   - DRM_TI_SN65DSI86 [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_BRIDGE [=y] && OF [=y]
>   - DRM_I2C_ADV7511 [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_BRIDGE [=y] && OF [=y]
>   - BACKLIGHT_LM3630A [=m] && HAS_IOMEM [=y] && BACKLIGHT_LCD_SUPPORT [=y] && BACKLIGHT_CLASS_DEVICE [=m] && I2C [=m] && PWM [=y]
>   - BACKLIGHT_LM3639 [=m] && HAS_IOMEM [=y] && BACKLIGHT_LCD_SUPPORT [=y] && BACKLIGHT_CLASS_DEVICE [=m] && I2C [=m]
>   - LEDS_LM3642 [=m] && NEW_LEDS [=y] && LEDS_CLASS [=y] && I2C [=m]
>   - LEDS_LP8860 [=m] && NEW_LEDS [=y] && LEDS_CLASS [=y] && I2C [=m] && OF [=y]
>   - LEDS_TLC591XX [=m] && NEW_LEDS [=y] && LEDS_CLASS [=y] && I2C [=m]
>   - LEDS_LM355x [=m] && NEW_LEDS [=y] && LEDS_CLASS [=y] && I2C [=m]
>   - LEDS_IS31FL319X [=m] && NEW_LEDS [=y] && LEDS_CLASS [=y] && I2C [=m] && OF [=y]
>   - EXTCON_RT8973A [=m] && EXTCON [=y] && I2C [=m]
>   - ADXL345_I2C [=m] && IIO [=y] && INPUT_ADXL34X [=n]=n && I2C [=m]
>   - BMC150_ACCEL_I2C [=m] && IIO [=y]
>   - MMA7455_I2C [=m] && IIO [=y] && I2C [=m]
>   - MXC4005 [=m] && IIO [=y] && I2C [=m]
>   - MXC6255 [=m] && IIO [=y] && I2C [=m]
>   - TI_ADS1015 [=m] && IIO [=y] && I2C [=m] && !SENSORS_ADS1015 [=n]
>   - BME680_I2C [=m] && IIO [=y] && I2C [=m] && BME680 [=m]
>   - AD5380 [=m] && IIO [=y] && (SPI_MASTER [=n] && I2C [=m]!=m || I2C [=m]) && I2C [=m]
>   - BMG160_I2C [=m] && IIO [=y]
>   - MPU3050_I2C [=m] && IIO [=y] && INPUT_MPU3050!=y && INPUT_MPU3050!=m && I2C [=m]
>   - AFE4404 [=m] && IIO [=y] && I2C [=m]
>   - MAX30100 [=m] && IIO [=y] && I2C [=m]
>   - HTS221_I2C [=m] && IIO [=y] && HTS221 [=m]
>   - INV_MPU6050_I2C [=m] && IIO [=y] && I2C_MUX [=m]
>   - IIO_ST_LSM6DSX_I2C [=m] && IIO [=y] && IIO_ST_LSM6DSX [=m]
>   - GP2AP020A00F [=m] && IIO [=y] && I2C [=m]
>   - SENSORS_ISL29028 [=m] && IIO [=y] && I2C [=m]
>   - JSA1212 [=m] && IIO [=y] && I2C [=m]
>   - RPR0521 [=m] && IIO [=y] && I2C [=m]
>   - LTR501 [=m] && IIO [=y] && I2C [=m]
>   - MAX44000 [=m] && IIO [=y] && I2C [=m]
>   - PA12203001 [=m] && IIO [=y] && I2C [=m]
>   - ST_UVIS25_I2C [=m] && IIO [=y] && ST_UVIS25 [=m]
>   - AK8974 [=m] && IIO [=y] && I2C [=m] && OF [=y]
>   - SENSORS_HMC5843_I2C [=m] && IIO [=y] && I2C [=m]
>   - SENSORS_RM3100_I2C [=m] && IIO [=y] && I2C [=m]
>   - LMP91000 [=m] && IIO [=y] && I2C [=m]
>   - BMP280_I2C [=m] && IIO [=y] && BMP280 [=m] && I2C [=m]
>   - HP03 [=m] && IIO [=y] && I2C [=m]
>   - ZPA2326_I2C [=m] && IIO [=y]
>   - MLX90632 [=m] && IIO [=y] && I2C [=m]
> 
> ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_smbus_byte_reg_read':
> regmap-i2c.c:(.text+0x122): undefined reference to `i2c_smbus_read_byte_data'
> ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_smbus_byte_reg_write':
> regmap-i2c.c:(.text+0x157): undefined reference to `i2c_smbus_write_byte_data'
> ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_smbus_word_reg_read':
> regmap-i2c.c:(.text+0x182): undefined reference to `i2c_smbus_read_word_data'
> ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_smbus_word_read_swapped':
> regmap-i2c.c:(.text+0x1b2): undefined reference to `i2c_smbus_read_word_data'
> ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_smbus_word_write_swapped':
> regmap-i2c.c:(.text+0x1ee): undefined reference to `i2c_smbus_write_word_data'
> ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_smbus_word_reg_write':
> regmap-i2c.c:(.text+0x217): undefined reference to `i2c_smbus_write_word_data'
> ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_i2c_smbus_i2c_read':
> regmap-i2c.c:(.text+0x254): undefined reference to `i2c_smbus_read_i2c_block_data'
> ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_i2c_smbus_i2c_write':
> regmap-i2c.c:(.text+0x2b0): undefined reference to `i2c_smbus_write_i2c_block_data'
> ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_i2c_read':
> regmap-i2c.c:(.text+0x312): undefined reference to `i2c_transfer'
> ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_i2c_gather_write':
> regmap-i2c.c:(.text+0x39c): undefined reference to `i2c_transfer'
> ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_i2c_write':
> regmap-i2c.c:(.text+0x3f4): undefined reference to `i2c_transfer_buffer_flags'
> ld: drivers/extcon/extcon-ptn5150.o: in function `ptn5150_i2c_init':
> extcon-ptn5150.c:(.init.text+0xb): undefined reference to `i2c_register_driver'
> 
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
> ---
>  drivers/extcon/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- mmotm-2019-0225-1340.orig/drivers/extcon/Kconfig
> +++ mmotm-2019-0225-1340/drivers/extcon/Kconfig
> @@ -116,7 +116,7 @@ config EXTCON_PALMAS
>  
>  config EXTCON_PTN5150
>  	tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
> -	depends on I2C && GPIOLIB || COMPILE_TEST
> +	depends on I2C && GPIOLIB
>  	select REGMAP_I2C
>  	help
>  	  Say Y here to enable support for USB peripheral and USB host
> 
> 
> 

