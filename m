Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B72DC76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C3A217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAWyYFea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfGQHls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 03:41:48 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35248 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfGQHlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 03:41:44 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so22615378ljh.2;
        Wed, 17 Jul 2019 00:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/1lJB4MpR9XdUfonxq30j+7es79jIicA8w86kThLLrQ=;
        b=kAWyYFead9n/yArqNMRnAbRJIjnhlw/szW5y/vc0DsFcnV1NoURz5zHI1QZxZ7ZMk3
         i8/9NCcRRIjh19pVQ2yj3iV2+7oEctwkpUuLkifLZo8u8y0nIaHPfRwz48NdJmvjMaXq
         KD4q0uclW2v6acsYga90u/Qf/oOegZV8iPxS4OyFZUfQNifiIzmeeQaG/vKUffuQkOO9
         H9XwBBeN+ESQjPP8I2Z2kPm/MWXJlvhGrCHpTM/FU/bkmVo6MsKhsI0PHrGtvcw5NVkq
         7hdLlRnuHzxPhkUVQ727Fwj1u3AWdueQQQRrhazlk4QhzELvy0jM30cDFiWbf5jL3Q0D
         lslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/1lJB4MpR9XdUfonxq30j+7es79jIicA8w86kThLLrQ=;
        b=LMaURIOHd7VaJ3WLLSZ3b3gFiAJ9ANHkQPefiPfTbv7Y+gcHmPaWLjfktW3Ls/S9XI
         RELKas8K0pxq78Q11RZCH7ZeVYv9fpEkjnA7dx4TDPbMHtt6StuGH0GKgB+BzIQuhMXg
         KptBVjzqzKprJJ4VfTzQ1jX7d9CXOrAFsznnVS0CiqxJURyngTuHbR4Z01XwKxShsHwD
         hSe85mZ6LLbksq2QbZyDCLeQHwTt0a+PYb1AiOaloQHf4kiCShNZnNLsKVfWMM5abD0n
         N9olwzoiM/hTVxoB1JMsUNDt694CJ/t4r2XalPKGh1VuUArYe8oxMw/h19JqOyCPYaCE
         +Tug==
X-Gm-Message-State: APjAAAXCKI02Tzhk1P+KT1tdJno5qyJ7Mdw/hwN+0ESEP8/gmYfOaHmu
        WsfNnfxnQYq+m1ytUZMnGEA=
X-Google-Smtp-Source: APXvYqx05SdhqnpDZIDDqeVfI2lMoRijFqn6g7Ff8SCspton0SnkT0v7xtkPw0fW8jgbU7lP4VaiYA==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26mr20132301lja.230.1563349302513;
        Wed, 17 Jul 2019 00:41:42 -0700 (PDT)
Received: from localhost ([188.170.223.67])
        by smtp.gmail.com with ESMTPSA id x22sm3328651lfq.20.2019.07.17.00.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 00:41:41 -0700 (PDT)
Date:   Wed, 17 Jul 2019 06:36:55 +0300
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v3 3/3] input: touchscreen mc13xxx: Add mc34708 support
Message-ID: <20190717033655.GC621@penguin>
References: <20190716221929.3782-1-lukma@denx.de>
 <20190716221929.3782-4-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716221929.3782-4-lukma@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 12:19:29AM +0200, Lukasz Majewski wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The mc34708 has a different bit to enable pen detection. This
> adds the driver data and devtype necessary to probe the device
> and to distinguish between the mc13783 and the mc34708.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> 
> ---
> Changes for v3:
> - Replace forward declaration of mc13xxx_driver_data with
>   structure definition
> - Rename mc13xxx_driver_data with mc13xxx_chip
> - Move static struct mc13xxx_chip mc13783_chip and mc34708_chip
>   closer to ID table
> - Do not check mc13xxx device type

You do not even need to define or store the type. Once it is dropped
please feel free to add

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

and merge with the other 2 patches.

-- 
Dmitry
