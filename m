Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A73AC32770
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6118B22B48
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHyNKqPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgADQTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 11:19:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43057 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgADQTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 11:19:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id p27so20157322pli.10;
        Sat, 04 Jan 2020 08:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hr6gRku33sKOdBDlVVDjuwq72fwx5PUhef2D4L3tjhk=;
        b=fHyNKqPId2hcNHM00cM3J/5Hw40VdqRg4zE09e2VypJvRMvD88lA5LCQGTcv21ap5L
         F1fY2eHj6girziJI6+YWCHWbQgHcD4l4NZ18VsufHnFrk13F+aYyh4J8hxVWHml0aACC
         bajiabLvqkRLpc6f99xuYRyemBFly+o2UwVN/N98r1JoYL2fZQlS3RjDvjgWXjV8vKqs
         4PnyYwxECU8nhhVn0uYYudiVAcAzSmK/rRs6GXAOjVrLdCJn9U8GuV6KfMD2JutngGyX
         8Svj9VjCibTPJ3pO5nFU2r2oNFvHFXKkFj554TcT6ANDpHGaAZkPF3XBTFyJImLVo7CQ
         AoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hr6gRku33sKOdBDlVVDjuwq72fwx5PUhef2D4L3tjhk=;
        b=kSk8KmwEW3futKxwAK4XUw8htyOZBjnAVsnVZPsdZSGeyOCRCtUDCBbZZ80d0kz2EH
         HLL9dPP9iJgLwZlIREUKx4k13BLMbbOFF+vITfbRwMY/VbAA106D915b9R3HMxkcwRI7
         I9x1qRul1KbNZnU0cZAM0Eske3G1bX6AryFnxD+yE6eL2EfMfMJ3TR0diNhtA1x62bKe
         X4F3l2M/vJb8kEC7+H6ggUkCiIn0PrDx//qHiywW9Kgk4+fMyxi+u/YDhvwNiYOMvIek
         0YSpCz3MssboDCfmEx4zO+B6xsGmmjHq2cfqHjz/n3ulDvtpDLVHUt0ipk0NQB7zYzYR
         vnaA==
X-Gm-Message-State: APjAAAX5DgzZmTPPepCZcgTlc58RSDLAXfyNJapfLLcKIlRDve/y+QIP
        ee9NclLChom/8lejAxJHtJU=
X-Google-Smtp-Source: APXvYqy0JK3Q1yiH23rq1SeMoTgC8TBAei5Hnplpb4RKxhXr+8F817ZikIeiJACCMAPjwmWXOyAp+Q==
X-Received: by 2002:a17:902:6b8c:: with SMTP id p12mr81709530plk.290.1578154788174;
        Sat, 04 Jan 2020 08:19:48 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t65sm73026931pfd.178.2020.01.04.08.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Jan 2020 08:19:47 -0800 (PST)
Date:   Sat, 4 Jan 2020 08:19:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 10/11] hwmon: (scmi-hwmon) Match scmi device by both
 name and protocol id
Message-ID: <20200104161946.GA2974@roeck-us.net>
References: <20191218111742.29731-1-sudeep.holla@arm.com>
 <20191218111742.29731-11-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218111742.29731-11-sudeep.holla@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 11:17:41AM +0000, Sudeep Holla wrote:
> The scmi bus now has support to match the driver with devices not only
> based on their protocol id but also based on their device name if one is
> available. This was added to cater the need to support multiple devices
> and drivers for the same protocol.
> 
> Let us add the name "hwmon" to scmi_device_id table in the driver so
> that in matches only with device with the same name and protocol id
> SCMI_PROTOCOL_SENSOR. This is just for sake of completion and must
> not be used to add IIO support in parallel. Instead, if IIO support is
> added ever in future, we need to drop this hwmon driver entirely and
> use the iio->hwmon bridge to access the sensors as hwmon devices if
> needed.
> 

Acked-by: Guenter Roeck <linux@roeck-us.net>

[ assuming the series will be pushed into the kernel together ]

> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/hwmon/scmi-hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index 8a7732c0bef3..286d3cfda7de 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -259,7 +259,7 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
>  }
>  
>  static const struct scmi_device_id scmi_id_table[] = {
> -	{ SCMI_PROTOCOL_SENSOR },
> +	{ SCMI_PROTOCOL_SENSOR, "hwmon" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(scmi, scmi_id_table);
