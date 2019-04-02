Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A252BC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76AD82075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9iMoBrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbfDBSXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:23:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34932 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfDBSXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 14:23:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so6794628pfe.2;
        Tue, 02 Apr 2019 11:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JJiPKxbSyy7b9dUaVB5Fz2w74T+5mLpPbXIgrMfIfWk=;
        b=P9iMoBrWTcj1sVurtMnod9bbjjBv9l+QU9y/I1eh+3IuBx0ARtyiBkC+77mrxDB3KU
         kztnqm1ZdUFLT2YK9Z6EaSr/wUjW3ro9+HxqNbevGzms9FK9HKosZmfqSdTpndlP9h4M
         OI/PdTPebI8doolihNeAf36Pf1miNUDxnM8qlMbl/P4YU3e6sHyoLiw+MW69U1oU5lPD
         rJNFqOwAv7N0yhD+alqZKyIDeCaaj/Vptud7a8jmK1KhyAQYGweWMjgUwwPfQ+XIbxlu
         T+Qrq2lnC7f0qIK9oH589yTEi5e6NDu1uxVs3pJMe/wXSnSgcjtKXmE/gLEDoUwOQ5zz
         ASCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JJiPKxbSyy7b9dUaVB5Fz2w74T+5mLpPbXIgrMfIfWk=;
        b=GftOFpBIsDk71Y0VOhelE8NHMHfCB3SDWnKLvUgJ4zdMFCKK0Bupd/68HhEZPFoVEO
         +CvQt8tVR9R6AOYIfLQZc8aY1nsCljS/0cnfDTyJFxc5UnAUCyXBi09y0dpooFbvvRK5
         CDU2AQOTTQaI8VQB91HZHB1Gj/ZBeMKD15E2QT/BGLKinTUfdCevqhSX0MKvpFzRbpVe
         lnuDMa5Cn45dh5Nt6NYnfPTtQEHQTs4M5UPyDO/j4umf2MUWhmSO5+aU/k/vc/zVkkEw
         navguLb/PQ05D2pFTOTbsrXQQHHd6aaTAH39f7gxKlNAkyc8BSzT7FvjURFzy0XPrCdl
         Vf+A==
X-Gm-Message-State: APjAAAWbNESlnB7ItqfJFP/4+Nxp676an4PESo5NpL539LhHlQaXTAQh
        x4fHDPWnHlsFkebyuUT98Yw=
X-Google-Smtp-Source: APXvYqxl0rX+KrUJn2Pzh5Ba5aHl0uh1WBZoRB8KWV4JLKHBXq4gmiIGne0etOlkmhyxLqySRfF8Wg==
X-Received: by 2002:a62:4595:: with SMTP id n21mr25258075pfi.79.1554229434130;
        Tue, 02 Apr 2019 11:23:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h19sm21129846pfd.130.2019.04.02.11.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 11:23:52 -0700 (PDT)
Date:   Tue, 2 Apr 2019 11:23:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH 7/7] hwmon/drivers/core: Simplify complex dependency
Message-ID: <20190402182351.GA12622@roeck-us.net>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
 <20190402161256.11044-7-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402161256.11044-7-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 06:12:50PM +0200, Daniel Lezcano wrote:
> As the thermal framework does not longer compile as a module, we can
> simplify this condition below:
> 
>  if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
>        (!defined(CONFIG_THERMAL_HWMON) || \
>         !(defined(MODULE) && IS_MODULE(CONFIG_THERMAL)))
> 
>  if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
>        (!defined(CONFIG_THERMAL_HWMON) || \
>         !(defined(MODULE) && 0))
> 
> => (whatever && 0) = 0
> 
>  if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
>        (!defined(CONFIG_THERMAL_HWMON) || !(0))
> 
>  if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
>        (!defined(CONFIG_THERMAL_HWMON) || 1)
> 
> => (whatever || 1) = 1
> 
>  if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
>        (1)
> 
> => (whatever && 1) = whatever
> 
>  if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF)
> 
> CONFIG_THERMAL can not be a module anymore, then:
> 
>  if defined(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF)
> 
> And CONFIG_THERMAL_OF already depends on CONFIG_THERMAL, so:
> 
>  if defined(CONFIG_THERMAL_OF)
> 
> Thus,
> 
>  ifdef CONFIG_THERMAL_OF
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

... assuming this will be pushed with the series. Otherwise please
let me know.

Thanks,
Guenter

> ---
>  drivers/hwmon/hwmon.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index c22dc1e07911..6f76f2484db0 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -118,9 +118,7 @@ static DEFINE_IDA(hwmon_ida);
>   * The complex conditional is necessary to avoid a cyclic dependency
>   * between hwmon and thermal_sys modules.
>   */
> -#if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
> -	(!defined(CONFIG_THERMAL_HWMON) || \
> -	 !(defined(MODULE) && IS_MODULE(CONFIG_THERMAL)))
> +#ifdef CONFIG_THERMAL_OF
>  static int hwmon_thermal_get_temp(void *data, int *temp)
>  {
>  	struct hwmon_thermal_data *tdata = data;
> -- 
> 2.17.1
> 
