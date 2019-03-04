Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3C3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19FE2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ufv8MCE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfCDWsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:48:35 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41617 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDWsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:48:35 -0500
Received: by mail-ed1-f66.google.com with SMTP id x7so5603788eds.8;
        Mon, 04 Mar 2019 14:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=De/Srx7WUOyxz1DI+PoziMwGsiszFhXMZy0h9TpGmHQ=;
        b=ufv8MCE02RUD6oz+aakwASr+W0H0iVuYOw7AgTHBcRX9El78zphBohkSgnFi5E7y9+
         KBDZCFYvgQ6Ma96DsZKH59EIh1PV0u+eDTlNQvKKbC9G50urcs1rn0rcJzkiKi/+7tB1
         CbZF9wjBkFEmUBmRH53a0xZkBi1C6YvDrU10/shEjPMNKI/7+BMqbIxzX+AkP8X7mYsu
         DeDYo1h2UihmlavoyDFFBjIz7s4TxIT4DMwVM32BgswWPrliRft+K1S6W1iYK8Pa5C0i
         ASteu0C07aQuueGN/n1TAxdGfdClEeB66ASB8vkHmMRjBo5B8Ok118JeFdMrUf91tWNP
         k8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=De/Srx7WUOyxz1DI+PoziMwGsiszFhXMZy0h9TpGmHQ=;
        b=cmbADePz2Pdr9+SW1emIX80jUnRhN8rtPqja5j2XtQQvOXXhA8ySMLwJ+hl+1kkwm9
         /OcsXtFmdnEXJE221iYcGcmmlhg80MYRhbH0jZ+TfbAWKZ/C0zXXVgl84JyS7Jh/JBbO
         AsTFh8Q0kkVBTUE80wXSAkBTkoTUlzcOL6e/NEFUMfGkD2l5/vVUbgiZgvpwXV0/G40o
         48+DXcLP2r2KBOR/6w2a5a1QX7UaVfp58efAFxmVSzi2m8oYAl4PVNQW/FczuE6Z2e2c
         jUvkx8/utCJ3GtfGrBWmmty4PR/JHlwy59Rk9BQpAGBCGzCRSEeULgJYvmrV5hbDseX5
         fpFA==
X-Gm-Message-State: APjAAAV2djy6TuWrN7e5G2A4nlJXveg0zVgW2byzkJDjnYV9yNhhclkm
        7+Tu4sl4zdRBw4gLOQ0GNE0=
X-Google-Smtp-Source: APXvYqze37nUY2yFupDiyWGJBbJReptQyUn4llRFiq935vtCn28rZ08/TK8Gghje6KOg6nT2vuo6qA==
X-Received: by 2002:a17:906:1c02:: with SMTP id k2mr13886863ejg.119.1551739712846;
        Mon, 04 Mar 2019 14:48:32 -0800 (PST)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i42sm2427976eda.86.2019.03.04.14.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 14:48:32 -0800 (PST)
Subject: Re: [PATCH v3 1/4] drm: rockchip: introduce rk3066 hdmi
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     heiko@sntech.de, mark.rutland@arm.com, devicetree@vger.kernel.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190302104116.1535-1-jbx6244@gmail.com>
 <20190302104116.1535-2-jbx6244@gmail.com>
 <20190303202308.GD13157@ravnborg.org>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <b6b818d5-8c24-e01a-572e-97c1754c80e8@gmail.com>
Date:   Mon, 4 Mar 2019 23:48:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190303202308.GD13157@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the useful review comments.

With regard to the bugs something between rc1 and rc8 results
in a freeze on poweroff. Power domain doesn't seem to turn off
the vop and hdmi in rc8.
For testing only.

Forgot to ask rob+dt the prefered document name for "rockchip,rk3066-hdmi"
Please advise if this is OK? "rockchip_rk3066-hdmi.txt"

On 3/3/19 9:23 PM, Sam Ravnborg wrote:> Hi Johan.
>
> Thanks for this nive driver.
> A few review comments follows.
>
> 	Sam
>
> On Sat, Mar 02, 2019 at 11:41:13AM +0100, Johan Jonker wrote:
>> From: Zheng Yang <zhengyang@rock-chips.com>
>>
>> Introduce rk3066 hdmi.
> A little more info would be good here.
> Do not assume all reader knows as much as you do.

Will add more text in V4.

>> +#include <linux/clk.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <drm/drm_of.h>
>> +#include <drm/drmP.h>
>> +#include <drm/drm_probe_helper.h>
> Please do not use drmP.h in new files. The usage of drmP.h is deprecated.
> Also please sort the include files, but keep the nice grouping.

You try to get rid of it and now I add one more to it ...
Thank you for letting me know.
The file drmP.h is used for:
to_platform_device, platform_get_resource, platform_get_irq
Replaced <drm/drmP.h> by <linux/platform_device.h>

>> +	int vic;
> vic is used so much. It deserves an explanation.

Is this OK?
	int vic; // pointer to the current cea mode in the edid_cea_modes array

hdmi->hdmi_data.vic = drm_match_cea_mode(mode);

>> +	unsigned int enc_in_format;
>
> enc_in_format is in this patch only assinged.
> aybe drop it (if not used in later patches)

Will drop it. Possible leftover when they reused
the inno-hdmi driver as template?

>> +	u8 ddc_addr;
>> +	u8 segment_addr;
> The two members above are only used in rk3066_hdmi_i2c_write()
> Maybe they can be made local variables?

ddc_addr and segment_addr only get a value in the condition below and
are reused.
Should remain global.

	if (msgs->addr == DDC_SEGMENT_ADDR)
		hdmi->i2c->segment_addr = msgs->buf[0];
	if (msgs->addr == DDC_ADDR)
		hdmi->i2c->ddc_addr = msgs->buf[0];

>> +	struct mutex lock; /*for i2c operation*/
> Name the lock after what is protects, to avoid mis-use.

Will change the name to i2c_lock.

>> +	struct completion cmp;
>
> cmp is shorthand for "compare" - as we have a command named so.
> Find a better name.

Agree.

>> +	struct drm_device *drm_dev;
> The new way to do this is to embed the device.
> See latest patches by Noralf in drm-misc-next, which include a nice
example.

That sounds more like a job for the Rockchip maintainers and
not for a individual. With this driver they have 8 more to go ...

	ADD_ROCKCHIP_SUB_DRIVER(vop_platform_driver, CONFIG_DRM_ROCKCHIP);
	ADD_ROCKCHIP_SUB_DRIVER(rockchip_lvds_driver,
				CONFIG_ROCKCHIP_LVDS);
	ADD_ROCKCHIP_SUB_DRIVER(rockchip_dp_driver,
				CONFIG_ROCKCHIP_ANALOGIX_DP);
	ADD_ROCKCHIP_SUB_DRIVER(cdn_dp_driver, CONFIG_ROCKCHIP_CDN_DP);
	ADD_ROCKCHIP_SUB_DRIVER(dw_hdmi_rockchip_pltfm_driver,
				CONFIG_ROCKCHIP_DW_HDMI);
	ADD_ROCKCHIP_SUB_DRIVER(dw_mipi_dsi_rockchip_driver,
				CONFIG_ROCKCHIP_DW_MIPI_DSI);
	ADD_ROCKCHIP_SUB_DRIVER(inno_hdmi_driver, CONFIG_ROCKCHIP_INNO_HDMI);
	ADD_ROCKCHIP_SUB_DRIVER(rk3066_hdmi_driver,
				CONFIG_ROCKCHIP_RK3066_HDMI);

>> +	struct regmap *regmap;
> +1 for using regmap.
> But then there is still several readl_relaxed() writel_relaxed() calls?
> They are in hdmi_readb() and hdmi_writeb(). Should a regmap had been
used here too?

Will rename hdmi->regmap to hdmi->grf_regmap to make it look more different
between hdmi devm_ioremap and grf syscon_regmap.

>> +	value |= vsync_offset << 4;
> Replace 4 with HDMI_VIDEO_VSYNC_OFFSET_SHIFT??

Looks like it. That's something only the author can tell.

>> +	hdmi->regmap =
>> +		syscon_regmap_lookup_by_phandle(hdmi->dev->of_node,
>> +						"rockchip,grf");
>
> dev->of_node would be fine here. No reason to go via hdmi->

Will replace the other hdmi->dev in this function by dev as well.

>> +	hdmi->connector.funcs->destroy(&hdmi->connector);
>> +	hdmi->encoder.funcs->destroy(&hdmi->encoder);
> I think the destroy() function should not be called directly.

Don't know what should be used instead. Please advise.

>> +static const struct of_device_id rk3066_hdmi_dt_ids[] = {
>> +	{ .compatible = "rockchip,rk3066-hdmi",
>> +	},
> MAke this a one-liner.
>
>> +	{},
> Us { /* sentinal */ }, like most other drivers.

Agree. But I prefere sentinel ...

{ .compatible = "rockchip,rk3066-hdmi"},
{ /* sentinel */ },

>> +	.driver = {
>> +		.name = "rockchip-rk3066hdmi",
> Different naming are used for the driver in this file.
> Coniser using a macro to align the naming.

"rockchip,rk3066-hdmi" is related to "rockchip,rk3066-vop"

"rockchip-rk3066hdmi" should remain in line with the other debug messages,
else it gets a mess if you do a dmesg | grep ...

[    0.576237] rockchip-pm-domain 20004000.pmu:power-controller:
rockchip_pm_domain_probe
[    1.198354] rockchip-vop 1010c000.vop: attaching to power domain 'pd_vio'
[    1.437444] rockchip-drm display-subsystem: bound 10116000.hdmi (ops
0xc0842d38)
[    0.397567] rockchip-rk3066hdmi 10116000.hdmi: registered RK3066 HDMI
I2C bus driver

Not so good example.
[   12.726332] dwmmc_rockchip 10214000.dwmmc: Using external DMA controller.
