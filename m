Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C886C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 05:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001AC217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 05:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbfIBF6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 01:58:43 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34901 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfIBF6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 01:58:42 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1i4fMO-0007zm-FU; Mon, 02 Sep 2019 07:58:40 +0200
Subject: Re: [PATCH] [RFC] i2c: imx: make use of format specifier %dE
To:     Wolfram Sang <wsa@the-dreams.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Cc:     Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Enrico Weigelt <lkml@metux.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190829042905.4850-1-uwe@kleine-koenig.org>
 <20190829203912.GU3740@ninjato>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <aefbf1c5-d0b7-bb6e-0f97-d65575d549ff@pengutronix.de>
Date:   Mon, 2 Sep 2019 07:58:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829203912.GU3740@ninjato>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.08.19 22:39, Wolfram Sang wrote:
> On Thu, Aug 29, 2019 at 06:29:05AM +0200, Uwe Kleine-König wrote:
>> I created a patch that teaches printk et al to emit a symbolic error
>> name for an error valued integer[1]. With that applied
>>
>> 	dev_err(&pdev->dev, "can't enable I2C clock, ret=%dE\n", ret);
>>
>> emits
>>
>> 	... can't enable I2C clock, ret=EIO
>>
>> if ret is -EIO. Petr Mladek (i.e. one of the printk maintainers) had
>> concerns if this would be well received and worth the effort. He asked
>> to present it to a few subsystems. So for now, this patch converting the
>> i2c-imx driver shouldn't be applied yet but it would be great to get
>> some feedback about if you think that being able to easily printk (for
>> example) "EIO" instead of "-5" is a good idea. Would it help you? Do you
>> think it helps your users?
> 
> Yes, it would help me. And users, too, I am quite sure. For me, if I mix
> up two numbers while debugging, I am hunting ghosts for a while until I
> realize my mistake. So:
> 
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> 
> I think the main drawback is that ERRORCODES in vsprintf.c now need
> maintenance, but I think it is worth the effort. I'd be interested in
> the overhead in size this causes, but I also think it is worth the
> effort. (It could even be compiled out if we have some generic Kconfig
> symbol for smaller kernels).


I like it, at least it will safe me some time.
I tested this patch together with the vprintf patch, so result looks like:
[    0.281843] imx-i2c 21a0000.i2c: can't enable I2C clock, ret=EIO
[    0.281891] imx-i2c: probe of 21a0000.i2c failed with error -5

Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
