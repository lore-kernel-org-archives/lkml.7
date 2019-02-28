Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602C4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377142171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbfB1Ixa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:53:30 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40708 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730930AbfB1Ixa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:53:30 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1S8kvMg030135;
        Thu, 28 Feb 2019 09:52:03 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qtvh3urvq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Feb 2019 09:52:02 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3A6D946;
        Thu, 28 Feb 2019 08:52:00 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BE3632AE9;
        Thu, 28 Feb 2019 08:52:00 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 28 Feb
 2019 09:52:00 +0100
Subject: Re: [PATCH v4 0/9] Introduce STMFX I2C Multi-Function eXpander
To:     Amelie Delaunay <amelie.delaunay@st.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1551260094-32570-1-git-send-email-amelie.delaunay@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <aefde9a4-2775-6c36-7c75-b60f39434a53@st.com>
Date:   Thu, 28 Feb 2019 09:51:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1551260094-32570-1-git-send-email-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amélie

On 2/27/19 10:34 AM, Amelie Delaunay wrote:
> This series adds support for STMicroelectronics Multi-Function eXpander
> (STMFX), used on some STM32 discovery and evaluation boards.
> 
> STMFX is an STM32L152 slave controller whose firmware embeds the following
> features:
> - I/O expander (16 GPIOs + 8 extra if the other features are not enabled),
> - resistive touchscreen controller,
> - IDD measurement.
> 
> I2C stuff and chip initialization is based on an MFD parent driver, which
> registers STMFX features MFD children.
> 
> ---
> Changes in v4:
> - mfd: move registers #define into the header
> - mfd: merge stmfx and stmfx_ddata structures into one stmfx structure
> - mfd: change stmfx_chip_init/exit and stmfx_irq_init/exit args: use
>    i2c_client struct and i2c_get_clientdata
> - mfd: fix typos
> - mfd: add MFD cells for IDD and TS features
> - pinctrl: rework registers #define
> - dts: add STMFX support on stm32mp157c-ev1
> Changes in v3:
> - fix MFD interrupt bindings
> - fix drivers/mfd/stmfx.c:103:8: warning: 'mask' may be used uninitialized
>    in this function
> Changes in v2:
> - move to MFD parent driver for i2c stuff and chip initialization
> - improve regmap configuration
> - take advantage of the use of gpio-ranges
> 
> Amelie Delaunay (9):
>    dt-bindings: mfd: Add ST Multi-Function eXpander (STMFX) core bindings
>    mfd: Add ST Multi-Function eXpander (STMFX) core driver
>    dt-bindings: pinctrl: document the STMFX pinctrl bindings
>    pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver
>    ARM: dts: stm32: add STMFX support on stm32746g-eval
>    ARM: dts: stm32: add joystick support on stm32746g-eval
>    ARM: dts: stm32: add orange and blue leds on stm32746g-eval
>    ARM: dts: stm32: add STMFX support on stm32mp157c-ev1
>    ARM: dts: stm32: add joystick support on stm32mp157c-ev1
> 

DT patches looks good. I'll take them in STM32 soc tree as soon as Lee 
takes driver part.

Regards
Alex

