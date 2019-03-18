Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EA2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD482133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfCRRac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:30:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42544 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfCRRaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:30:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id j89so14236421edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ft4dh/J1aLEtnBlSvjpPS85uhaQolaIi/oFVoENU5wQ=;
        b=Onb4dD9hd1Qkp3ynXnX6r/BnSyHfHYRmsjLgjSIFDlQivk+C4Ve/go17pfszFMwuT8
         VtiD0gUsV0fhdEPtqyyAovZDSpdRLJzNoOg4xEELFzImLbG2pyoRLSKvbbejW8L7r2Qc
         hxHI4Qtb6Pn01ghKNn9gYy2RfsmFWHXSCyXCKonGVIn9DFzSWgiceVs4J4wH3o3ydOMk
         tUk526cAJ4Xl4qtQMGgyDRB7ecUm8A5NUxiLiuOamHJaNeWbCuHBUk63RyuLWUrS6C6M
         y/I8AnD+vyqbZT+YOPGlBL1gRT+nJazEg3a2Io2KEd7Yx1R4/er1RiHmQMTwBAUbESs3
         vGVg==
X-Gm-Message-State: APjAAAVe3Aj/ERODMdeEzXnK2sQZvtQwgqxcO6mLRNIY2YpIT8/THyVM
        KCmUblEuBJ/1FmkDmHGegkEhCgpsNxw=
X-Google-Smtp-Source: APXvYqxIn02n7hN+0pc6yQ/CxB0ohrI8dEnz87JfvFmHcQcTsM1Bhcq0cBB3lYkhqfrAX4pam5WaVg==
X-Received: by 2002:a50:ec93:: with SMTP id e19mr2337555edr.169.1552930228744;
        Mon, 18 Mar 2019 10:30:28 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id o42sm3634462edc.49.2019.03.18.10.30.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 10:30:27 -0700 (PDT)
Subject: Re: [PATCH] extcon: fix a missing check of regmap_read
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org
References: <20190318164121.13838-1-kjlu@umn.edu>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c2c7685a-fb11-5b31-05f4-e3938efba08b@redhat.com>
Date:   Mon, 18 Mar 2019 18:30:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190318164121.13838-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18-03-19 17:41, Kangjie Lu wrote:
> When regmap_read fails, it doesn't make sense to use the read
> value "val" because it can be uninitialized.
> 
> The fix returns if regmap_read fails.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>   drivers/extcon/extcon-axp288.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index a983708b77a6..b2ba5f073aa7 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -143,6 +143,10 @@ static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
>   	int ret;
>   
>   	ret = regmap_read(info->regmap, AXP288_PS_BOOT_REASON_REG, &val);
> +	if (ret) {
> +		dev_dbg(info->dev, "regmap_read error %d\n", ret);
> +		return;
> +	}
>   	for (i = 0, rsi = axp288_pwr_up_down_info; *rsi; rsi++, i++) {
>   		if (val & BIT(i)) {
>   			dev_dbg(info->dev, "%s\n", *rsi);

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
