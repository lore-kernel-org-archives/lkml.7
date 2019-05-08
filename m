Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630DDC04AAE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DA3216C8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gA0wLPNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfEHTkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 15:40:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46291 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfEHTkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:40:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so520925pfm.13;
        Wed, 08 May 2019 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Xc+7OcJpMvDCLjFgyfFFHfxL3+Nwu8VrHOrlj3FvEg=;
        b=gA0wLPNq/n/8ixJaFO0KfTJuXx0bYSFib4d8PRnYnRoRWIlBAqZtQfqpPUrVQUkMw0
         yp6z42kaNOFUQFtgv+ObJmrn0ovteqmXR1lhOeNT2hFBhPPbEb56uXPQ9tlzK14DRgbO
         HvGP8PCjcsfrz4Cx9F7R/HboeKP6jcQLP30Y4Ua0bMOCV1dKSxsuR1WKHFjts+qExDvp
         QcW6CUnLtEC1xOeUCnqerVZ3fbVVQjCzPYtvBkQzFX0zmUUSf1M01g++Bl2NeJcxKN6j
         o0itCM8jpOn/80DmGTBVMaW3DnVu/hZ3qHU1yg6CCW3hGvpOIfKuHzizSbW+MQf2ASnD
         Z8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Xc+7OcJpMvDCLjFgyfFFHfxL3+Nwu8VrHOrlj3FvEg=;
        b=X6s/X5JrOq0nelRu0Xw1nCCcCL7HKc8xigkjD6WUlsNttPjtpiZxRkW9uc3Uq+ju6W
         nXWWy5xFejMy7BhEOCLTOfLeRJzf89R5VlnAocYAdU88/xvpQAS9pSHJEU/JtSMe1U80
         cHRTx+hKGDJKeHvR//St3M7Y2IDH45jST8QHdqQrLia41ntmHlbTrr/veLKIK4/aF1DS
         A0T9YlDLjSo7qrTI0PWwjri7WzVxRtqbcW+xyOX3s1fTVYCwkMHaZb4G2DjuOZbugEz6
         D54v15GbD4lgRrD6itE/Ry0NLDOyna8vD9B1O287BnfRtTQRK1kt8popqjuLG1hRF5HD
         g+gg==
X-Gm-Message-State: APjAAAVjVvGbm86h0JB2823k8EV82Yy0WTT19uI4qGiJ4fW52j/PdcH8
        JWlCLo/3T8rz/I9IQ5wHNj0=
X-Google-Smtp-Source: APXvYqy+Mps/PyObzV+AuLgHZJTJg7RaPtGqFSmI758A8f++3nmdl5bdmN6yqa/mgHxnHrytM0TiuQ==
X-Received: by 2002:a63:1048:: with SMTP id 8mr49167502pgq.70.1557344424885;
        Wed, 08 May 2019 12:40:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t7sm41031pfa.42.2019.05.08.12.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 12:40:23 -0700 (PDT)
Date:   Wed, 8 May 2019 12:40:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] hwmon: scmi: Scale values to target desired HWMON
 units
Message-ID: <20190508194022.GA28200@roeck-us.net>
References: <20190508170035.19671-1-f.fainelli@gmail.com>
 <20190508170035.19671-3-f.fainelli@gmail.com>
 <20190508183244.GA25133@roeck-us.net>
 <258aec23-055b-61c2-c0f6-2ff1abc006cd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <258aec23-055b-61c2-c0f6-2ff1abc006cd@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 11:34:50AM -0700, Florian Fainelli wrote:
> On 5/8/19 11:32 AM, Guenter Roeck wrote:
> > Hi Florian,
> > 
> > On Wed, May 08, 2019 at 10:00:35AM -0700, Florian Fainelli wrote:
> >> If the SCMI firmware implementation is reporting values in a scale that
> >> is different from the HWMON units, we need to scale up or down the value
> >> according to how far appart they are.
> >>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>  drivers/hwmon/scmi-hwmon.c | 46 ++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 46 insertions(+)
> >>
> >> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> >> index a80183a488c5..4399372e2131 100644
> >> --- a/drivers/hwmon/scmi-hwmon.c
> >> +++ b/drivers/hwmon/scmi-hwmon.c
> >> @@ -7,6 +7,7 @@
> >>   */
> >>  
> >>  #include <linux/hwmon.h>
> >> +#include <linux/limits.h>
> >>  #include <linux/module.h>
> >>  #include <linux/scmi_protocol.h>
> >>  #include <linux/slab.h>
> >> @@ -18,6 +19,47 @@ struct scmi_sensors {
> >>  	const struct scmi_sensor_info **info[hwmon_max];
> >>  };
> >>  
> >> +static inline u64 __pow10(u8 x)
> >> +{
> >> +	u64 r = 1;
> >> +
> >> +	while (x--)
> >> +		r *= 10;
> >> +
> >> +	return r;
> >> +}
> >> +
> >> +static int scmi_hwmon_scale(const struct scmi_sensor_info *sensor, u64 *value)
> >> +{
> >> +	s8 scale = sensor->scale;
> >> +	u64 f;
> >> +
> >> +	switch (sensor->type) {
> >> +	case TEMPERATURE_C:
> >> +	case VOLTAGE:
> >> +	case CURRENT:
> >> +		scale += 3;
> >> +		break;
> >> +	case POWER:
> >> +	case ENERGY:
> >> +		scale += 6;
> >> +		break;
> >> +	default:
> >> +		break;
> >> +	}
> >> +
> >> +	f = __pow10(abs(scale));
> >> +	if (f == U64_MAX)
> >> +		return -E2BIG;
> > 
> > Unfortunately that is not how integer overflows work.
> > 
> > A test program with increasing values of scale reports:
> > 
> > 0: 1
> > ...
> > 18: 1000000000000000000
> > 19: 10000000000000000000
> > 20: 7766279631452241920
> > 21: 3875820019684212736
> > 22: 1864712049423024128
> > 23: 200376420520689664
> > 24: 2003764205206896640
> > ...
> > 61: 11529215046068469760
> > 62: 4611686018427387904
> > 63: 9223372036854775808
> > 64: 0
> > ...
> > 
> > You'll have to check for abs(scale) > 19 if you want to report overflows.
> 
> Yes silly me, my test program was flawed, thanks for pointing out that.
> You are okay with returning E2BIG when we overflow?

Yes.

Thanks,
Guenter
