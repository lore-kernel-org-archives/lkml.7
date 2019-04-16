Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE166C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD14F20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myZIrROz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfDPWOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:14:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46944 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfDPWOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 18:14:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so10985467pll.13;
        Tue, 16 Apr 2019 15:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F1yzREj0tSjJkhr7RflDEVx09Qn7IdKYGN6THxTDlAA=;
        b=myZIrROzP1P+4gic7xMy/TnMO6JVyXDmV0DF3PJEDOFURDG2j+5AUKBEYri5zsVHTp
         WUORnBmoUnELkZizVjwZggJMm9K/Im6GTCOoQ/4LjNhH0nCZ5bU1XbELcrr02HuEqgVh
         6G933slcHM8qnV0bfS/+uDQ5v440wrqRoyVm/w9rQPa3Unkvnbl+tq56amBAPnSWu+me
         7MRlP9knaWIRINeN3Ns5MfepKFVzsNUUORa9jflras0FvejlUjjh0HMkerr0cgFtevT8
         n7yJyot5gzi3FFMs+jjYcSNM8iFi+SHpsBEdaeYr5LlvxYutWtXTG72jVcaPdf1hPX5a
         ytnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=F1yzREj0tSjJkhr7RflDEVx09Qn7IdKYGN6THxTDlAA=;
        b=J5VCRwCC6D3ySzriP80QfkNJBtWqa0uLfwQeefJ/QGh51FaTQC+kTdaIO2RlFty2mM
         42QvNhgJpnNJzTQyDPnIRV852A7diMOZ3bnYXDNVY3flCYuioY+KrQgWHwuDB85Tjv/K
         ZDcpv4UMQ3IoZCNfRd7pFlUn5Ka0CiHcMebU2BCFq+MTeksVQV9/sj+pgfsyUSY0Y2+V
         UoqnqOJVgm8UfLQN5W5Hu1Xp1ZoMV1O3SxTfh6eKDLZqgjT+naejZdtTwlSoMoN9tPAj
         E6IOWgH9GKTqdLhOt00/cK/8uujX77Q7/uFw6bDX/fiKJhkOxLA6EmXIeSmoULHegT3l
         OeIQ==
X-Gm-Message-State: APjAAAVEmdw53mixXozW6fzD9JnObGIlcFH8LGE3yXl6W9KhgFzJ+mmB
        /QrvTKaSRyXKjFmPKQ6iJjI=
X-Google-Smtp-Source: APXvYqzWqUBvisrF6CmjmbYY2CBIiC1rH8bOVAgBcuivllZ02Vl2vAaHDcaEP5GpSikTHwmMbfD3wA==
X-Received: by 2002:a17:902:1007:: with SMTP id b7mr60778007pla.48.1555452856265;
        Tue, 16 Apr 2019 15:14:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j16sm71639467pfi.58.2019.04.16.15.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 15:14:15 -0700 (PDT)
Date:   Tue, 16 Apr 2019 15:14:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jdelvare@suse.com, andrew@aj.id.au, mine260309@gmail.com
Subject: Re: [PATCH 2/3] hwmon (occ): Prevent sysfs error attribute from
 returning error
Message-ID: <20190416221414.GA32126@roeck-us.net>
References: <1555429430-23118-1-git-send-email-eajames@linux.ibm.com>
 <1555429430-23118-2-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555429430-23118-2-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:43:49PM +0000, Eddie James wrote:
> The error sysfs attribute returns the stored error state of the OCC and
> doesn't depend on the OCC poll response. Therefore, split the error
> attribute into it's own function to avoid failing out of the function if
> the poll response fails.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/occ/sysfs.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/occ/sysfs.c b/drivers/hwmon/occ/sysfs.c
> index 1cb1e65..c73be07 100644
> --- a/drivers/hwmon/occ/sysfs.c
> +++ b/drivers/hwmon/occ/sysfs.c
> @@ -63,9 +63,6 @@ static ssize_t occ_sysfs_show(struct device *dev,
>  		else
>  			val = 1;
>  		break;
> -	case 8:
> -		val = occ->error;
> -		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -73,6 +70,16 @@ static ssize_t occ_sysfs_show(struct device *dev,
>  	return snprintf(buf, PAGE_SIZE - 1, "%d\n", val);
>  }
>  
> +static ssize_t occ_error_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct occ *occ = dev_get_drvdata(dev);
> +
> +	occ_update_response(occ);
> +
> +	return snprintf(buf, PAGE_SIZE - 1, "%d\n", occ->error);
> +}
> +
>  static SENSOR_DEVICE_ATTR(occ_master, 0444, occ_sysfs_show, NULL, 0);
>  static SENSOR_DEVICE_ATTR(occ_active, 0444, occ_sysfs_show, NULL, 1);
>  static SENSOR_DEVICE_ATTR(occ_dvfs_overtemp, 0444, occ_sysfs_show, NULL, 2);
> @@ -81,7 +88,7 @@ static SENSOR_DEVICE_ATTR(occ_mem_throttle, 0444, occ_sysfs_show, NULL, 4);
>  static SENSOR_DEVICE_ATTR(occ_quick_pwr_drop, 0444, occ_sysfs_show, NULL, 5);
>  static SENSOR_DEVICE_ATTR(occ_state, 0444, occ_sysfs_show, NULL, 6);
>  static SENSOR_DEVICE_ATTR(occs_present, 0444, occ_sysfs_show, NULL, 7);
> -static SENSOR_DEVICE_ATTR(occ_error, 0444, occ_sysfs_show, NULL, 8);
> +static DEVICE_ATTR_RO(occ_error);
>  
>  static struct attribute *occ_attributes[] = {
>  	&sensor_dev_attr_occ_master.dev_attr.attr,
> @@ -92,7 +99,7 @@ static struct attribute *occ_attributes[] = {
>  	&sensor_dev_attr_occ_quick_pwr_drop.dev_attr.attr,
>  	&sensor_dev_attr_occ_state.dev_attr.attr,
>  	&sensor_dev_attr_occs_present.dev_attr.attr,
> -	&sensor_dev_attr_occ_error.dev_attr.attr,
> +	&dev_attr_occ_error.attr,
>  	NULL
>  };
>  
> @@ -156,7 +163,7 @@ void occ_sysfs_poll_done(struct occ *occ)
>  	}
>  
>  	if (occ->error && occ->error != occ->prev_error) {
> -		name = sensor_dev_attr_occ_error.dev_attr.attr.name;
> +		name = dev_attr_occ_error.attr.name;
>  		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
>  	}
>  
