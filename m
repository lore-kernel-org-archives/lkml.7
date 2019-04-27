Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B13FC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 00:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC35206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 00:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHtr3nOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfD0A1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 20:27:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45193 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfD0A1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 20:27:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so2448040pfi.12;
        Fri, 26 Apr 2019 17:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ADgDbNgH3j7l/1wFVTnFZD0gYTVH7GAdNaBM+y5P3Uo=;
        b=qHtr3nOk+j2nNeJWHM6unzbequKWo57EFJ21Tvl8SNAVW1yemHs0V4gSFfgBL06Uxr
         3OhtH91smhkV3gzHrf2t2leE8dE2YouzBKCpacnq6AUg4KK8X9zkGI042VwyAlErHbiB
         X01L52VELBfmGQ9g9L6CtpzDqWTQ61J19rBwCF9N6ZXJuBO62ddmhq4NkNkHtIPZmW3M
         d0ve8BgfrpRl1DaI5admk+joQyWM5K9iGWb+057CZzn4eJHZNKwKwjgZ0r9I0SaMUC7u
         Nc/UBVteVUthDwbaivS2dbP/vrvy1GueI0cUKxLRSwJq/RbXTlwHE0UNJe6O2xTzJ+Eo
         fmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ADgDbNgH3j7l/1wFVTnFZD0gYTVH7GAdNaBM+y5P3Uo=;
        b=LgVkC+wdmFjdqwb1IViN3O92rhlDoeLJ7d70Yu4G5JT5L5VPuq1c6DINHaEt5fQlGz
         Z1o9lNlCbMCk62lv0doZBGgxVNs+h0C33DUSrKzSFsJsdggmwwYjErS6PNcpc2SPJB10
         OS1yiJsIzlj2Wc2uC88uwwaOBH7VmYCV4aJA73MOkAShRgfMdDxIXCSw0cALxze2fKbm
         /LhGtdhk1p3QI98sx+ukgHVFBBiVCRo2GewIlzY374lbYazdPwzL8fIOVmgenwbAMbBh
         KVdmnjFABwPfmaYlVh0kC9lWr5sinN+4XJ99yxUK+s8zIKxrKVzIYxe+VJNctEP8O3sH
         WYqw==
X-Gm-Message-State: APjAAAUffYu6q84kfazf76UAtPdqpzD1uEgacBZbX8evDolBBXtZk9UK
        PTd2wvkSs2pVtxUpqn2E4F4=
X-Google-Smtp-Source: APXvYqwFQ8qE5oRujDaQ9GeMCgP0ros/3exVMYFoylTcuSmcEt7z1RXnh3uIKOMAkswzfRH7N/v9Ug==
X-Received: by 2002:a65:6496:: with SMTP id e22mr4638908pgv.249.1556324830574;
        Fri, 26 Apr 2019 17:27:10 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id o2sm20430882pgq.1.2019.04.26.17.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 17:27:09 -0700 (PDT)
Date:   Fri, 26 Apr 2019 17:27:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: pm8xxx-vibrator: fix a potential NULL pointer
 dereference
Message-ID: <20190427002708.GC42369@dtor-ws>
References: <20190309053922.22212-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309053922.22212-1-kjlu@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kangjie,

On Fri, Mar 08, 2019 at 11:39:21PM -0600, Kangjie Lu wrote:
> In case of_device_get_match_data fails to find the matched data,
> returns -ENODEV

How can this happen? We will not match again the device if compatible is
not present in the table.

If this happens I'd rather we crash and burn instead of silently
ignoring the failure.

Thanks.

> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/input/misc/pm8xxx-vibrator.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
> index 7dd1c1fbe42a..740e59c11808 100644
> --- a/drivers/input/misc/pm8xxx-vibrator.c
> +++ b/drivers/input/misc/pm8xxx-vibrator.c
> @@ -196,6 +196,8 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
>  	vib->vib_input_dev = input_dev;
>  
>  	regs = of_device_get_match_data(&pdev->dev);
> +	if (unlikely(!regs))
> +		return -ENODEV;
>  
>  	/* operate in manual mode */
>  	error = regmap_read(vib->regmap, regs->drv_addr, &val);
> -- 
> 2.17.1
> 

-- 
Dmitry
