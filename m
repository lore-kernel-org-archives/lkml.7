Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA6BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836232085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnvbXjUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfHLG7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 02:59:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43370 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHLG7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 02:59:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so40513545pld.10;
        Sun, 11 Aug 2019 23:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lU9sd0t6+gG5Nv5bhUpF/5WxDNzHrTOFuSzTVXXmTl8=;
        b=YnvbXjUbXlQSkK3LpUAdhLpq46NSDWVuR665Ubu/270IW/4xBes43HY9xnyHv12M5L
         +Wx7wmzdJBh+uBRFuUUZm3XjZ2HNz24aSt2C0tnHJ3N0X5qZnLPwkFIGhzROicOathdX
         buPEuoqJdWYQUpDgQdVJAka7kd+5dOR64ba7JlpNiaaeGrvYnELpkHY1tEFeTbyWXdGo
         iEnvuWvOT+Jc/xCSbJMmHGTLyahNWiHXdg/Cdp2GY2REf+QoIJ+2/MfttFp4T7wNohjV
         Cgd5yZ4jZY1J4fHlp9NmGN1KS4pbrmsT/ParzL7gyOuhc+Vs880CYybK1BjIyTaP6bAl
         lLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lU9sd0t6+gG5Nv5bhUpF/5WxDNzHrTOFuSzTVXXmTl8=;
        b=HFBjE5TvlZG9ebyJg2N/oWJoSd1KMEZF2gGEMiDccvdtzZzkEs34p6nvMO7YuESLe5
         1nvcjQgdfxW+T3dkiPc0sd+lfpnd/pnMgAZlbJ5rGQfImg4pphhtBOWAUlgZ1+F5vMdd
         cOBgxz72AyNBDQArcOzrMUXXcZKWEX+i2imPvU7ZNIiXeW6eqC0E191l5pvfkMjUJUmm
         AtZHzjR7Qy3DZjhbdiZ4GT0oedE/gzR3J/fmvm+7kk5SXYfm64wt9L4lwkQpX2vZi2lv
         0vcH2rlj6vt2UX6o7ElAXbdIIsx+b+YIAj0BLS3F97eRXKSzJOqXiSE5bMHmn6LiIsKx
         5uNA==
X-Gm-Message-State: APjAAAVsdvH14ytA/3tjxMax/PMZYdVn7oFrpDP87Ih4IeTaiyUJ4Eww
        FbjKidr3B4KOI2CaO5HHqwI=
X-Google-Smtp-Source: APXvYqxGQtAAm/9bZEb20DwM5smEC6IAD75c2e4mNLcMD5COWxsN4uscMrkfBX+siT1jauyZejyO5g==
X-Received: by 2002:a17:902:b68f:: with SMTP id c15mr31825302pls.104.1565593158123;
        Sun, 11 Aug 2019 23:59:18 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id n7sm118800185pff.59.2019.08.11.23.59.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 23:59:17 -0700 (PDT)
Date:   Sun, 11 Aug 2019 23:59:15 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@linux.intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 03/10] input: keyboard: gpio_keys: convert platform
 driver to use dev_groups
Message-ID: <20190812065915.GU178933@dtor-ws>
References: <20190731124349.4474-1-gregkh@linuxfoundation.org>
 <20190731124349.4474-4-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731124349.4474-4-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 02:43:42PM +0200, Greg Kroah-Hartman wrote:
> Platform drivers now have the option to have the platform core create
> and remove any needed sysfs attribute files.  So take advantage of that
> and do not register "by hand" a bunch of sysfs files.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied, thank you.

> ---
>  drivers/input/keyboard/gpio_keys.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 03f4d152f6b7..1373dc5b0765 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -351,10 +351,7 @@ static struct attribute *gpio_keys_attrs[] = {
>  	&dev_attr_disabled_switches.attr,
>  	NULL,
>  };
> -
> -static const struct attribute_group gpio_keys_attr_group = {
> -	.attrs = gpio_keys_attrs,
> -};
> +ATTRIBUTE_GROUPS(gpio_keys);
>  
>  static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
>  {
> @@ -851,13 +848,6 @@ static int gpio_keys_probe(struct platform_device *pdev)
>  
>  	fwnode_handle_put(child);
>  
> -	error = devm_device_add_group(dev, &gpio_keys_attr_group);
> -	if (error) {
> -		dev_err(dev, "Unable to export keys/switches, error: %d\n",
> -			error);
> -		return error;
> -	}
> -
>  	error = input_register_device(input);
>  	if (error) {
>  		dev_err(dev, "Unable to register input device, error: %d\n",
> @@ -1026,6 +1016,7 @@ static struct platform_driver gpio_keys_device_driver = {
>  		.name	= "gpio-keys",
>  		.pm	= &gpio_keys_pm_ops,
>  		.of_match_table = gpio_keys_of_match,
> +		.dev_groups	= gpio_keys_groups,
>  	}
>  };
>  
> -- 
> 2.22.0
> 

-- 
Dmitry
