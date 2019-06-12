Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D59C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3557C2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501934AbfFLPON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:14:13 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:46152 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbfFLPNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:13:16 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 4543B803BC;
        Wed, 12 Jun 2019 17:13:13 +0200 (CEST)
Date:   Wed, 12 Jun 2019 17:13:12 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Shobhit Kukreti <shobhitkukreti@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: backlight: Replace old GPIO APIs with GPIO
 Consumer APIs for sky81542-backlight driver
Message-ID: <20190612151312.GB5030@ravnborg.org>
References: <20190612043229.GA18179@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612043229.GA18179@t-1000>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=COmZixlhozaZKkr9zfUA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shobhit

> -	if (gpio_is_valid(pdata->gpio_enable)) {
> -		ret = devm_gpio_request_one(dev, pdata->gpio_enable,
> -					GPIOF_OUT_INIT_HIGH, "sky81452-en");


> +	pdata->gpiod_enable = devm_gpiod_get(dev, "sk81452-en", GPIOD_OUT_HIGH);
> +	if (IS_ERR(pdata->gpiod_enable)) {
> +		long ret = PTR_ERR(pdata->gpiod_enable);

In the old code the property was named "sky81452-en".
In the new code the property is named "sk81452-en".

Most likely a bug.

	Sam
