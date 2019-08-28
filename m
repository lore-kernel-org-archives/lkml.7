Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9442EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E38208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9uRkJiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfH1Kw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:52:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51002 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfH1Kw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:52:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so2285449wml.0;
        Wed, 28 Aug 2019 03:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3bmOMK5FL6zFob4mCFt8AttEsF6S4HMbVALEegM1I+c=;
        b=A9uRkJiAkBq18NwoLSOtlupjAW8mlK4uc/rtPAqgyQui+yv3DyUIIZ8JmZSJ280TLo
         ZU9Muw7jMpo85ullp6/IwQcPsJ0QQZLlKhFsHJb8Po9a0cIKIrtkz8HOjnpW0ofnUQ+N
         x/HRL/Ho/OONbsmetTHZ/9BgBDT8kWKrS1+Tn7iD6AHPmjPvrkZXuKjJW75y827eg6EA
         GCfOSOeKYJ3l+WCmQpyHeG13iIWimS6/NeViIcpT/O5qJ2OOthpcye0F+j4g/125cmOG
         JbniZIVXg9gJSVCN3A8Q4sYgDOf9K/fAqbstKmwsIPLIBbtZM9I/u/JI3TgpY2OSCZBn
         EFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3bmOMK5FL6zFob4mCFt8AttEsF6S4HMbVALEegM1I+c=;
        b=Q2a63ciSns7ym08gkzorV5NtyluGbH23vKUZEwQFQfAcHSESjCfPOaeQ1E45WO3dow
         13MR2+xXtL9F9raYGj7/fcVOZA5SQm2TQ1mt+4cLL07WaSMCZsNQ+rKVrF56edwKZxLO
         fI+66Y2c/BfiP9oiqzWYLzTk049v7autsLH2tN7ljG+Dz3ye2icA2FE4BGG2CBf9OXYG
         w1E7OInWYEW/WE+e2mI9lCSZJV7fNIOPinK1WYAK/UnflrJI6ESrU261h9tFePshPdnN
         CrtHdcLdOATNHQ3aiLBGc3s4ZznQAHrmyn18eOfRr0/rOoOPS3Qicnguwt8A7pEhYZeV
         xFnA==
X-Gm-Message-State: APjAAAWjDcqOYIVcCvMBBh/zjTZQa3rYMPzryyRX10W5LB+Vf5Yoy5iq
        7axHO6F13S7ACir6pIsGdDlQJ2LA+2NMcQ==
X-Google-Smtp-Source: APXvYqyKxQtG6BjBhXJkeq2+oHYwaCMcBdW9tzCFT7rOhDmD4P3VOsBLn/ZkeCSzTep/JcLQfxqwCw==
X-Received: by 2002:a1c:f016:: with SMTP id a22mr4146777wmb.170.1566989574337;
        Wed, 28 Aug 2019 03:52:54 -0700 (PDT)
Received: from [192.168.0.8] (57.166.117.91.dynamic.reverse-mundo-r.com. [91.117.166.57])
        by smtp.gmail.com with ESMTPSA id g13sm2903957wrw.87.2019.08.28.03.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2019 03:52:53 -0700 (PDT)
Subject: Re: [PATCH] mmc: sunxi: fix unusuable eMMC on some H6 boards by
 disabling DDR
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
 <CAPDyKFr5opD2yBXmFRBY-9oA_3ShVv0GPFRO8Q_8TEiT+z2pQA@mail.gmail.com>
From:   =?UTF-8?Q?Alejandro_Gonz=c3=a1lez?= 
        <alejandro.gonzalez.correo@gmail.com>
Message-ID: <f84d62b7-da00-f2bd-36e9-972435080bfe@gmail.com>
Date:   Wed, 28 Aug 2019 12:52:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFr5opD2yBXmFRBY-9oA_3ShVv0GPFRO8Q_8TEiT+z2pQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El 27/8/19 a las 15:24, Ulf Hansson escribió:> Assuming this should go stable as well? Perhaps you can find a
> relevant commit that we can put as a fixes tag as well?
> 
> Kind regards
> Uffe

The most relevant commit I've found that is related to enabling DDR speeds
on H6 boards is this one: https://github.com/torvalds/linux/commit/07bafc1e3536a4e3c422dbd13341688b54f159bb .
But it doesn't address the H6 SoC specifically, so I doubted whether it would
be appropiate to mark this patch as fixing it, and opted to not do it. I don't
mind adding that tag if it's appropiate, though :-)

On the other hand, I'm not sure that I understood correctly what do you mean by
this patch going stable, but I might say the changes themselves are stable and work.
The only downside I can think of to them is that they are a kind of workaround that
reduces performance on H6 boards and/or eMMC not affected by this problem (are there
any?), unless device trees are changed.

El 27/8/19 a las 15:32, Maxime Ripard escribió:
> On Sun, Aug 25, 2019 at 05:05:58PM +0200, Alejandro González wrote:
>> Some Allwinner H6 boards have timing problems when dealing with
>> DDR-capable eMMC cards. These boards include the Pine H64 and Tanix TX6.
>>
>> These timing problems result in out of sync communication between the
>> driver and the eMMC, which renders the memory unsuable for every
>> operation but some basic commmands, like reading the status register.
>>
>> The cause of these timing problems is not yet well known, but they go
>> away by disabling DDR mode operation in the driver. Like on some H5
>> boards, it might be that the traces are not precise enough to support
>> these speeds. However, Jernej Skrabec compared the BSP driver with this
>> driver, and found that the BSP driver configures pinctrl to operate at
>> 1.8 V when entering DDR mode (although 3.3 V operation is supported), while
>> the mainline kernel lacks any mechanism to switch voltages dynamically.
>> Finally, other possible cause might be some timing parameter that is
>> different on the H6 with respect to other SoCs.
> 
> This should be a comment in the driver where this is disabled.
> 
> Maxime

Thank you for your review. I'll mention that briefly in a comment in the code for
the next revision of this patch.

Regards.
