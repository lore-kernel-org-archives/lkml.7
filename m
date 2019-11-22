Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DF4C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F1220706
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfKVNba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:31:30 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47703 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKVNba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:31:30 -0500
Received: from [2001:67c:670:100:6a05:caff:fe2d:a9b1]
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1iY91y-0007Iq-PR; Fri, 22 Nov 2019 14:31:26 +0100
Subject: Re: [Linux-stm32] [PATCH v2 1/1] drivers: watchdog: stm32_iwdg: set
 WDOG_HW_RUNNING at probe
To:     Christophe ROULLIER <christophe.roullier@st.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
References: <20191122082442.21695-1-christophe.roullier@st.com>
 <ea80ec65-8621-453c-4d5b-af38d8afeb70@pengutronix.de>
 <70c319bd-866c-5305-e535-ead663652c5f@st.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <53b2f559-3456-d378-587d-d220920e9bf7@pengutronix.de>
Date:   Fri, 22 Nov 2019 14:31:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <70c319bd-866c-5305-e535-ead663652c5f@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:6a05:caff:fe2d:a9b1
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christophe,

On 11/22/19 2:15 PM, Christophe ROULLIER wrote:
>> On 11/22/19 9:24 AM, Christophe Roullier wrote:
>>> +	/*
>>> +	 * In case of CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is set
>>> +	 * (Means U-Boot/bootloaders leaves the watchdog running)
>>> +	 * When we get here we should make a decision to prevent
>>> +	 * any side effects before user space daemon will take care of it.
>>> +	 * The best option, taking into consideration that there is no
>>> +	 * way to read values back from hardware, is to enforce watchdog
>>> +	 * being run with deterministic values.
>> What about the "ONF: Watchdog enable status bit" in the IWDG_SR register?

> Thanks Ahmad for your feedback, it is a mistake in our ref manual. This 
> bit is not present
> 
> in our iwdg IP, we will update our documentation accordingly.

Thanks for the info. I think it would be nice to have this information in
the driver as well, something like:

* The best option, taking into consideration that that the ONF
* watchdog status bit is non-functional, is to enforce watchdog
* being run with deterministic values.

This way it's clear that it's a deliberate choice to do it this way.

Cheers
Ahmad



-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
