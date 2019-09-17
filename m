Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385CDC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D781206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NSecsQS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfIQOHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:07:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42792 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfIQOHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:07:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id n14so2437247wrw.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 07:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:references:user-agent:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=klNvHmn4dmHfYFGr5swA66ym/DQGM3Z/kdqx0uiahpE=;
        b=NSecsQS+hDnfX+rDlomI8H2OgtTXTsXgOIttvrEaypoS5p8Eb7uq3Kjwv8OskLfir9
         uMEG8ywqJETXCXNBwoBYYb0Yj5VH1X9vMwm/EQw1Pb+fHsaNMAgF0AudlFHkk3k8GbQd
         H4CazWHRz/zavuyBcm0zw+qyyfwooVI/x7gG8sMamqbYBffH4XB+luU3jNaaBk1H8wwH
         ojb/+JSLw/FNh+yuiXvVL71OyVgxbdjqKd68HHf3ZzVPEFUj5rwvN0hlNZAGyQwxWvcl
         MirXG4zUP54Uxfr7p6kuL+SAuxbyYAfyCTBA5xePg9tEPbV3tbebMi2719zy5zXQ+p8V
         ol7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:user-agent:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=klNvHmn4dmHfYFGr5swA66ym/DQGM3Z/kdqx0uiahpE=;
        b=iG4/hUPb0ZTo7dssjJiqv9AroRYHZZfLsPDY1GrIAJmAck/jGqntqU4DxCNSYcXP3Y
         e+9yM7zVumGaT2GR+BeMRdKjGj+6q3ZzFepnQ9EKRIy9u4b7/7ooDfbwCU3AN7kGfPg9
         VGHH8kaZG88NcVWFRadU4wpQwoUSSOa67ucX45uHTkZnrBYlgtDy0sHHD/AxSkYPV8hw
         5siTbsV4lFqCc/NQ3Lsh4O5+qn4bW32MVVIEvydIERHtpxym/6bLYhaWhg2wkJY8pmW/
         ocwPN7LGZOlb+AECuvdOh6hrvHnYh2GCQXCVTmuo5mRNK47OwewynYFHjHIhegUSfyqF
         2Osg==
X-Gm-Message-State: APjAAAVKw68Z7JiQ7w9hCyCw/5h4fUunuYJz03S8vS0Ka00yHWQZfQiy
        fR8198n8CxCPqdXjhyQa8rjJ0A==
X-Google-Smtp-Source: APXvYqxABF+5PaKhoVrX5R6Isn4saEC5uBpJxvivRCXdNynAdaHADyXVenpJPWk+leolVADkRJs0FA==
X-Received: by 2002:adf:f303:: with SMTP id i3mr3358580wro.242.1568729255973;
        Tue, 17 Sep 2019 07:07:35 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 33sm4458213wra.41.2019.09.17.07.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 07:07:35 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
X-Google-Original-From: Jerome Brunet <jbrunet@starbuckisacylon.baylibre.com>
References: <1568700442-18540-1-git-send-email-qianggui.song@amlogic.com> <1568700442-18540-3-git-send-email-qianggui.song@amlogic.com> <1jef0f46fj.fsf@starbuckisacylon.baylibre.com> <73dc56bd-d6c5-1de7-e97e-91479a89a29e@amlogic.com>
User-agent: mu4e 1.3.1; emacs 26.2
To:     Qianggui Song <qianggui.song@amlogic.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Xingyu Chen <xingyu.chen@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] pinctrl: meson-a1: add pinctrl driver for Meson A1 Soc
In-reply-to: <73dc56bd-d6c5-1de7-e97e-91479a89a29e@amlogic.com>
Date:   Tue, 17 Sep 2019 16:07:34 +0200
Message-ID: <1j8sqn3tjt.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 17 Sep 2019 at 13:51, Qianggui Song <qianggui.song@amlogic.com> wrote:
>>> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
>>> index 8bba9d0..885b89d 100644
>>> --- a/drivers/pinctrl/meson/pinctrl-meson.c
>>> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
>>> @@ -688,8 +688,12 @@ static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc,
>>>  
>>>  	pc->reg_ds = meson_map_resource(pc, gpio_np, "ds");
>>>  	if (IS_ERR(pc->reg_ds)) {
>>> -		dev_dbg(pc->dev, "ds registers not found - skipping\n");
>>> -		pc->reg_ds = NULL;
>>> +		if (pc->data->reg_layout == A1_LAYOUT) {
>>> +			pc->reg_ds = pc->reg_pullen;
>> 
>> IMO, this kind of ID based init fixup is not going to scale and will
>> lead to something difficult to maintain in the end.
>> 
>> The way the different register sets interract with each other is already
>> pretty complex to follow.
>> 
>> You could rework this in 2 different ways:
>> #1 - Have the generic function parse all the register sets and have all
>> drivers provide a specific (as in gxbb, gxl, axg, etc ...)  function to :
>>  - Verify the expected sets have been provided
>>  - Make assignement fixup as above if necessary
>> 
>> #2 - Rework the driver to have only one single register region
>>  I think one of your colleague previously mentionned this was not
>>  possible. It is still unclear to me why ...
>> 
> Appreciate your advice.  I have an idea based on #1, how about providing
> only two dt parse function, one is for chips before A1(the old one),
> another is for A1 and later chips that share the same layout. Assign
> these two functions to their own driver.

That's roughly the same thing as your initial proposition with function
pointer instead of IDs ... IMO, this would still be a quick fix to
address your immediate topic instead of dealing with the driver as
whole, which is my concern here.

>>> +		} else {
>>> +			dev_dbg(pc->dev, "ds registers not found - skipping\n");
>>> +			pc->reg_ds = NULL;
>>> +		}
>>>  	}
>>>  
>>>  	return 0;
>>> diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
>>> index c696f32..3d0c58d 100644
>>> --- a/drivers/pinctrl/meson/pinctrl-meson.h
>>> +++ b/drivers/pinctrl/meson/pinctrl-meson.h
>>> @@ -80,6 +80,14 @@ enum meson_pinconf_drv {
>>>  };
>>>  
>>>  /**
>>> + * enum meson_reg_layout - identify two types of reg layout
>>> + */
>>> +enum meson_reg_layout {
>>> +	LEGACY_LAYOUT,
>>> +	A1_LAYOUT,
>>> +};
>>> +
>>> +/**
>>>   * struct meson bank
>>>   *
>>>   * @name:	bank name
>>> @@ -114,6 +122,7 @@ struct meson_pinctrl_data {
>>>  	unsigned int num_banks;
>>>  	const struct pinmux_ops *pmx_ops;
>>>  	void *pmx_data;
>>> +	unsigned int reg_layout;
>>>  };
>>>  
>>>  struct meson_pinctrl {
>> 
>> .
>> 

