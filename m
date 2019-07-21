Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504CFC76196
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 15:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D11521738
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 15:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpY3q4wp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfGUPFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 11:05:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33753 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfGUPFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 11:05:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id c14so17862588plo.0;
        Sun, 21 Jul 2019 08:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OW6UM47dAL7GLkMvdaFJA/Cg/I0pLze2wUq1GKjvor0=;
        b=gpY3q4wpeU/JK9J/b7qAp152/LIpW2mX2xVRnK/Ol0N3BiW+ayUsLjXCTmJcn17e6i
         QlJCVlQliKqjRG/CZvcUtzDHEkpP6s8YnDso5L/9VfYmfPOIXVP8MSgUbgr58VQAIRMd
         KkqdZyN/6eyx66CPUAJlqXzZVSgnsNH2QxUYqOz8GSId/y4m/PVRHtqwJ9oGWgIqmmhS
         O9EqLHwWiWnzmMp5OqRzHnJh7ET8gRmc8kDaUS9/Lh+W/sR+5KxK31esfyVPQmC03kLN
         czL4SBpcze7xpvuP5350f9L8YhO2o9y1eyPC7KI7NAtRYYjJuS3s9DtcUasKeDdDPh+P
         6Ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OW6UM47dAL7GLkMvdaFJA/Cg/I0pLze2wUq1GKjvor0=;
        b=goDZx665w7BTxrlcrfQdV3BB1LdWJsVhqmFNlv25O5fs7/s52/H4Gqj1319Mh++cQ9
         k1kfpneR7QhzvBtAaphfL0waeDAjRM7A2DmBHqV8CWMHhUgKtxhdq28Ql5icyQs1m+Aa
         cakHVh429b9D741UYdvKsFeivahMqCxT/eVbswOgOi6vjiTtNgXqkC6DjH5lLiRsK/a+
         BL5VJRM2BVdCWc+hWUPO48iD2/t0VAE5O/+Gy5yilgm00I1SWvrcTPD0y2nxGD5LEbWE
         4S/Vvq0RAmIbtaonGxz1sy8TnLzYB47BzpnLWve9ceMDTttE/DADfkEaRgxq59swfR4a
         04Sw==
X-Gm-Message-State: APjAAAU6kDYDls0eo+jYb23JVhD/A+jDLW7ilkmtwaQSyrCTV9x5GaqN
        IV8XUAH5MRqo7c4NJVsGmNM=
X-Google-Smtp-Source: APXvYqwlNyeZC7HrpO/MWB8UhIHhsNtzI+Z2LYLCM05qBkTQyKLBdHeyUVZbgLqwRxt3Atlo/L3LHQ==
X-Received: by 2002:a17:902:6b86:: with SMTP id p6mr72009340plk.14.1563721510634;
        Sun, 21 Jul 2019 08:05:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k64sm16976946pge.65.2019.07.21.08.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 08:05:09 -0700 (PDT)
Date:   Sun, 21 Jul 2019 08:05:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus/max31785) Remove a useless #define
Message-ID: <20190721150508.GA8001@roeck-us.net>
References: <20190721101553.20911-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721101553.20911-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 12:15:53PM +0200, Christophe JAILLET wrote:
> There is a typo in MAX37185_NUM_FAN_PAGES. To be consistent, it should be
> MAX31785_NUM_FAN_PAGES (1 and 7 switched).
> 
> At line 24, we already have:
>    #define MAX31785_NR_FAN_PAGES		6
> and MAX37185_NUM_FAN_PAGES seems to be unused.
> 
> It is likely that it is only a typo and/or a left-over.
> So, axe it.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/max31785.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/max31785.c b/drivers/hwmon/pmbus/max31785.c
> index 69d9029ea410..254b0f98c755 100644
> --- a/drivers/hwmon/pmbus/max31785.c
> +++ b/drivers/hwmon/pmbus/max31785.c
> @@ -244,8 +244,6 @@ static int max31785_write_word_data(struct i2c_client *client, int page,
>  #define MAX31785_VOUT_FUNCS \
>  	(PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT)
>  
> -#define MAX37185_NUM_FAN_PAGES 6
> -
>  static const struct pmbus_driver_info max31785_info = {
>  	.pages = MAX31785_NR_PAGES,
>  
