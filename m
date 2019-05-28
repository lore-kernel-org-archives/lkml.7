Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE38C072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460F5206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1oqg2H/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfE1PIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:08:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45976 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfE1PIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:08:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id a5so8451342pls.12;
        Tue, 28 May 2019 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cVQZn5lz3Q0vs7h+4/FnhMNYBgv4Mcb2jY7H9Fnu5BY=;
        b=R1oqg2H/IFKhwqITMjbZ0xsM7Lrc1zRBej67W3Bd5+aiVUrFvQrxurlpzWPfYjWMlw
         Ua/8h4tCSu/n5qHHq0TOHtjLxuR5O8eSE6FvuMuExF+YUsxhn27I+AD9Fq8UZzC08IuU
         0euDcGFe/js5tpey1yoDCZOD2ds0ocvC4N+d/Gxes4b60MsQxhflY1YYRaIWMrawUxwo
         5PoZNQmsoelYbJ1q7gzyqUDMtjkiGXsGMAvZ27cS6qQkfkQQkpMGyUFVfpb6yKBuOell
         v0IdwBpO7GeEdTjNuib1wKNUX4mu+b7Eb6ZhRx5sqS77LlgjfGhqtzrmfNcnx9yCIh+l
         wzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cVQZn5lz3Q0vs7h+4/FnhMNYBgv4Mcb2jY7H9Fnu5BY=;
        b=pphjOTa3gPJovu7oU2/F/JqsYkWo7o0zygWgKW/Sn8vIwfAIYZh3wUexi5urw8nZ9Z
         kCpCatrrNbJGrXVRySw/DEVjQq/vyx1s1oBKs9Zy1DpptlAH9PkDzhJUiM6ykUmavLss
         3os46AV8XjvnyH2aI+AlhaOoxwLvXgDhHhLqIg53Cj+ZjbDolsDFs5G4F3t/ye7vudo+
         sAA0tYFPVnRrb4pKpOiyPRjpwG7l2lXCrbnixf0QhYRViQEG81Jw6AAu7EpWqo7rGCIO
         HdGotIjyW3x9Q48pJj7JqGTf5NXvjvd5rI12xbkYCC1f7snSDVbYr3mQdMQqd7574wlw
         WqmQ==
X-Gm-Message-State: APjAAAU44mySOcAsk3WoE6Wcw9ACCn0HXR8AQSLi3y5qRnZqB4H7IYy3
        z+uysSx73QMNfay1HbuvZTTJSsrL
X-Google-Smtp-Source: APXvYqxosQULHSJqsIKUCgxAVAdKBtywjSteeCZXeX7U+E0iv/a+Ioa6cRUqtq3rcsvRJPXsz39H5A==
X-Received: by 2002:a17:902:1347:: with SMTP id r7mr91812677ple.45.1559056103539;
        Tue, 28 May 2019 08:08:23 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e66sm17724593pfe.50.2019.05.28.08.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 08:08:22 -0700 (PDT)
Date:   Tue, 28 May 2019 08:08:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: core: add thermal sensors only if
 dev->of_node is present
Message-ID: <20190528150821.GB5516@roeck-us.net>
References: <20190517231337.27859-1-eduval@amazon.com>
 <20190517231337.27859-2-eduval@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517231337.27859-2-eduval@amazon.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eduardo,

On Fri, May 17, 2019 at 04:13:36PM -0700, Eduardo Valentin wrote:
> Drivers may register to hwmon and request for also registering
> with the thermal subsystem (HWMON_C_REGISTER_TZ). However,
> some of these driver, e.g. marvell phy, may be probed from
> Device Tree or being dynamically allocated, and in the later
> case, it will not have a dev->of_node entry.
> 
> Registering with hwmon without the dev->of_node may result in
> different outcomes depending on the device tree, which may
> be a bit misleading. If the device tree blob has no 'thermal-zones'
> node, the *hwmon_device_register*() family functions are going
> to gracefully succeed, because of-thermal,
> *thermal_zone_of_sensor_register() return -ENODEV in this case,
> and the hwmon error path handles this error code as success to
> cover for the case where CONFIG_THERMAL_OF is not set.
> However, if the device tree blob has the 'thermal-zones'
> entry, the *hwmon_device_register*() will always fail on callers
> with no dev->of_node, propagating -EINVAL.
> 
> If dev->of_node is not present, calling of-thermal does not
> make sense. For this reason, this patch checks first if the
> device has a of_node before going over the process of registering
> with the thermal subsystem of-thermal interface. And in this case,
> when a caller of *hwmon_device_register*() with HWMON_C_REGISTER_TZ
> and no dev->of_node will still register with hwmon, but not with
> the thermal subsystem. If all the hwmon part bits are in place,
> the registration will succeed.
> 
Makes sense. I'd apply it as-is, but it would be better if you resend
it to the list to give others a chance to comment.

Thanks,
Guenter

> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> ---
>  drivers/hwmon/hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index fcdbac4a56e3..6b3559f58b67 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -619,7 +619,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>  	if (err)
>  		goto free_hwmon;
>  
> -	if (dev && chip && chip->ops->read &&
> +	if (dev && dev->of_node && chip && chip->ops->read &&
>  	    chip->info[0]->type == hwmon_chip &&
>  	    (chip->info[0]->config[0] & HWMON_C_REGISTER_TZ)) {
>  		const struct hwmon_channel_info **info = chip->info;
> -- 
> 2.21.0
> 
