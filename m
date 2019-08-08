Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370C1C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099E1217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QmimsXUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732996AbfHHQUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:20:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53540 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732427AbfHHQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:20:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id 10so2978087wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 09:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1NYy6jhNv5L/j22hMt/7zGYwXYT4XYZjeIveAA57XzM=;
        b=QmimsXUFgnp+EwH0ImQpoB5uS3ZkI7FvT4yL2KLH9G9axMEZLL7ehS21TM+wpNWR1D
         QdLyOe5botiNS8o/1uOh1WQe5a3XFWbKPbnOncXMjiT8fsIpzsEAOJftnlnoADdKpIzR
         PqYe5WQTrizr3EVyaRffq4tmjHPk2qjxECNHW6lYdT5ANfyK6rYSv6hhUu4fUGP6tzbI
         SkYx2AOWEEl1ggDl/d6bVSq4aTWA75o75IIuXYGksay4QTGsKBLXgPavWW515eFBAFqQ
         6mGDs4jziP6mttXaj+FIUFDjXzh6aS2S+jzPzKtbpkQ3loe9GMeEXmlYhpo+95ipGm5S
         Zbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1NYy6jhNv5L/j22hMt/7zGYwXYT4XYZjeIveAA57XzM=;
        b=csEn3aS6Zd6GAoOJLu5jwXZKc031TFmXYgVrcxlEcGIoc4wF8whe2ccjEJ+psCRE8q
         6QjLSclHXrQMeGHBdrBplVyIBxf73dR3Ad1RWkSLFNS7o7Y6Y9/JmkSmN9IitnnbJ2bI
         fq+ePCgrkj3n/pGsY+TmbWEen168cTUlA0H/8uWhSs2/twebx6YND4FWyrlhlNV+98XR
         H4bufx3hpi6aNHWLe4Xa4CimwpKV3ul8scrXHRcTvdTVsRTS9pd5MrD+R7+S12NRs/0t
         smJ8D9T8j3pZuE8zxO/4ZrXHBIoRqLuL9R8vV3I0FDYTS0x2vn/KSLrMpSDh5gm1wmtB
         mkeg==
X-Gm-Message-State: APjAAAUmLzY0D4EcRsDI1Iyr+fAKMB/3wZazwN5ojrZMpUotT2b1dDDA
        YNjuyHR6ZECCzqDKW1UXI8R0rg==
X-Google-Smtp-Source: APXvYqzlqUyMtb48QP37+XtZ8ncJsns5sI6OoNYtFyW+My/DiEv3ApO+4HgmoJKKF8gwnz1Y/7bNuQ==
X-Received: by 2002:a1c:f415:: with SMTP id z21mr5496582wma.34.1565281212220;
        Thu, 08 Aug 2019 09:20:12 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t140sm6315315wmt.0.2019.08.08.09.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 09:20:11 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2 4/4] ASoC: codecs: add wsa881x amplifier
 support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-5-srinivas.kandagatla@linaro.org>
 <3ad15652-9d6c-11e4-7cc3-0f076c6841bb@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <32516aae-8a43-6a74-c564-92dea8ff6e53@linaro.org>
Date:   Thu, 8 Aug 2019 17:20:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3ad15652-9d6c-11e4-7cc3-0f076c6841bb@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking time to review,

On 08/08/2019 16:18, Pierre-Louis Bossart wrote:
> 
>> +/* 4 ports */
>> +static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
>> +    {
>> +        /* DAC */
>> +        .num = 1,
>> +        .type = SDW_DPN_SIMPLE,
> 
> IIRC we added the REDUCED type in SoundWire 1.1 to cover the PDM case 
> with channel packing (or was it grouping) used by Qualcomm. I am not 
> sure the SIMPLE type works?
grouping I guess.

This is a simplified data port as there is no DPn_OffsetCtrl2 register 
implemented.

Having said below channel count looks incorrect, i should fix that.

> 
>> +        .min_ch = 1,
>> +        .max_ch = 8,
>> +        .simple_ch_prep_sm = true,
>> +    }, {
>> +        /* COMP */
>> +        .num = 2,
>> +        .type = SDW_DPN_SIMPLE,
>> +        .min_ch = 1,
>> +        .max_ch = 8,
>> +        .simple_ch_prep_sm = true,
>> +    }, {
>> +        /* BOOST */
>> +        .num = 3,
>> +        .type = SDW_DPN_SIMPLE,
>> +        .min_ch = 1,
>> +        .max_ch = 8,
>> +        .simple_ch_prep_sm = true,
>> +    }, {
>> +        /* VISENSE */
>> +        .num = 4,
>> +        .type = SDW_DPN_SIMPLE,
>> +        .min_ch = 1,
>> +        .max_ch = 8,
>> +        .simple_ch_prep_sm = true,
>> +    }
>> +};
> 
>> +static int wsa881x_update_status(struct sdw_slave *slave,
>> +                 enum sdw_slave_status status)
>> +{
>> +    struct wsa881x_priv *wsa881x = dev_get_drvdata(&slave->dev);
>> +
>> +    if (status == SDW_SLAVE_ATTACHED) {
> 
> there is an ambiguity here, the Slave can be attached but as device0 
> (not enumerated). We should check dev_num > 0
> 
Thanks for point that! will add a check!

>> +        if (!wsa881x->regmap) {
>> +            wsa881x->regmap = devm_regmap_init_sdw(slave,
>> +                               &wsa881x_regmap_config);
>> +            if (IS_ERR(wsa881x->regmap)) {
>> +                dev_err(&slave->dev, "regmap_init failed\n");
>> +                return PTR_ERR(wsa881x->regmap);
>> +            }
>> +        }
>> +
>> +        return snd_soc_register_component(&slave->dev,
>> +                          &wsa881x_component_drv,
>> +                          NULL, 0);
>> +    } else if (status == SDW_SLAVE_UNATTACHED) {
>> +        snd_soc_unregister_component(&slave->dev);
> 
> the update_status() is supposed to be called based on bus events, it'd 
> be very odd to register/unregister the component itself dynamically. In 
> our existing Realtek-based solutions the register_component() is called 
> in the probe function (and unregister_component() in remove). We do the 
> inits when the Slave becomes attached but the component is already 
> registered.
> 
looks less intrusive!  I will give that a try!

>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +
>> +static int wsa881x_remove(struct sdw_slave *sdw)
>> +{
>> +    return 0;
>> +}
>> +
>> +static const struct sdw_device_id wsa881x_slave_id[] = {
>> +    SDW_SLAVE_ENTRY(0x0217, 0x2010, 0),
>> +    {},
>> +};
>> +MODULE_DEVICE_TABLE(sdw, wsa881x_slave_id);
>> +
>> +static struct sdw_driver wsa881x_codec_driver = {
>> +    .probe    = wsa881x_probe,
>> +    .remove = wsa881x_remove,
> 
> is this needed since you do nothing in that function?

yes, it can be removed! will do that in next version.

--srini
