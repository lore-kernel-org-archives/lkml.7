Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80816C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AA82341B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIGowJQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfH2Oxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:53:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55558 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbfH2Ox2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:53:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id g207so78360wmg.5;
        Thu, 29 Aug 2019 07:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=rDl3XjmzWq1Bt/Mn9v6gfnxlgojJ+gdaOYg/Ia4k7aQ=;
        b=RIGowJQeoEjivCh/DN3Lv2KX6/nyX/A+Y8irhNkd+a2lHx7EikwzfiOIQpc48ZWGsV
         g5wMl+ixmo6o9IXMaEVS8OIRpDgQyTbGVVFHM+Cd0GCQ3du3BghkH1cjo2CVYzQvCdVS
         wKXJnGOIqGWwwopYDuFRNj5O6753hPd5yg88sX5gZ0QyO2C+1IaPBHxSNPhiGMiJoQe1
         GQkrxVcVszqQaL7eAp84YmPWgfXQpip3fXWrLPn93tW5H+mrGVAqy0mFv7+4JV8+lkSp
         1CaVU15mFTHAYctRFC35og30Sl/TyHwMTlELBMPRhkA6TmbDXsQnMcUeK791D8BYUQ/T
         ki+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=rDl3XjmzWq1Bt/Mn9v6gfnxlgojJ+gdaOYg/Ia4k7aQ=;
        b=tN8iqYUySMhxfeBixaARbi8ym0klnDRln3q8ih+79VL0j3l0wgA/XOyZpapfMNnlnW
         pmJrvRWLZ7gMXX/+fGzBH5SQUo/rqMaK5p11KyXIJEgty7nGofGfH7rAaiYkV4OQWCCi
         C6CN+0zcvi1bSRrQch3iLKyphBMlTnPytK1F1nVy2tfGPVHyK+qylFVa6KQYKScg3aVB
         BMT6lTx+rb3tI4U1tibva1jlVVJY6qn+lsqIU0lS3z/ETz7lcMLJa9H+4AHv77LCpgJH
         SRp+08/Br00WUj4oinT4ilTODAmbWkhk/MDuoGnyG4+J0XzlFpjjr79m2Ut45zxgOEjk
         xOTQ==
X-Gm-Message-State: APjAAAX/Yh25E69ymGEuoeXLQoDQ9C3lxrBSoUu1h2uhPcxST6l50QSu
        yF9Zr95/WvNhFGjGB1VAk6fRaPlw4WI=
X-Google-Smtp-Source: APXvYqyuColfybcl19EFArHYWnVMSMThE1XsoWoel4pqWY5H4K++iOkEOzm36CFw4522OL1h4Z3+jw==
X-Received: by 2002:a1c:4e19:: with SMTP id g25mr6193427wmh.30.1567090405896;
        Thu, 29 Aug 2019 07:53:25 -0700 (PDT)
Received: from arch-late ([87.196.81.67])
        by smtp.gmail.com with ESMTPSA id e14sm1958252wma.37.2019.08.29.07.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 07:53:24 -0700 (PDT)
References: <20190829122839.GA20116@mwanda>
User-agent: mu4e 1.2.0; emacs 27.0.50
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: light: fix a couple double frees
In-reply-to: <20190829122839.GA20116@mwanda>
Date:   Thu, 29 Aug 2019 15:53:20 +0100
Message-ID: <m35zmgvx9b.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,
On Thu 29 Aug 2019 at 13:28, Dan Carpenter wrote:
> The problem is in gb_lights_request_handler().  If we get a request to
> change the config then we release the light with gb_lights_light_release()
> and re-allocated it.  However, if the allocation fails part way through
> then we call gb_lights_light_release() again.  This can lead to a couple
> different double frees where we haven't cleared out the original values:
>
> 	gb_lights_light_v4l2_unregister(light);
> 	...
> 	kfree(light->channels);
> 	kfree(light->name);
>
> I also made a small change to how we set "light->channels_count = 0;".
> The original code handled this part fine and did not cause a use after
> free but it was sort of complicated to read.
>
> Fixes: 2870b52bae4c ("greybus: lights: add lights implementation")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>

Thanks so much for this, I was looking for some time at this and
was half way to a much less elegant fix then yours.

Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>

Cheers,
    Rui

> ---
>  drivers/staging/greybus/light.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
> index 010ae1e9c7fb..40680eaf3974 100644
> --- a/drivers/staging/greybus/light.c
> +++ b/drivers/staging/greybus/light.c
> @@ -1098,21 +1098,21 @@ static void gb_lights_channel_release(struct gb_channel *channel)
>  static void gb_lights_light_release(struct gb_light *light)
>  {
>  	int i;
> -	int count;
>
>  	light->ready = false;
>
> -	count = light->channels_count;
> -
>  	if (light->has_flash)
>  		gb_lights_light_v4l2_unregister(light);
> +	light->has_flash = false;
>
> -	for (i = 0; i < count; i++) {
> +	for (i = 0; i < light->channels_count; i++)
>  		gb_lights_channel_release(&light->channels[i]);
> -		light->channels_count--;
> -	}
> +	light->channels_count = 0;
> +
>  	kfree(light->channels);
> +	light->channels = NULL;
>  	kfree(light->name);
> +	light->name = NULL;
>  }
>
>  static void gb_lights_release(struct gb_lights *glights)

