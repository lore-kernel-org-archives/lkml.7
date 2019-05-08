Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D271C04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349AA216C8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQXeQIsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfEHVDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 17:03:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40118 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfEHVDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 17:03:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so82359pfn.7;
        Wed, 08 May 2019 14:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2GG9jK07Kv2i8LvXwEMcbCms44zOL2mPSFZgVB4sK1I=;
        b=PQXeQIsxu9WnurzcNH3I3QB0pmwtxvYpgCio8dGn+oGxdILUINuxJa8mPTOjz9UIpD
         807bKsxnNyC155cTR4b+3gNnMCIEIm1xvTdG7VIbRrzJxYqI/nUBu4G9zoPqTDmEPJsu
         LxAuLdnmMvWVoZl64SaPphgTerWy/FyNZOL4CvkHFBmf+UBE5Ohkjh4PwGFCp3aLiJ1/
         EgQpIIv7NPJ2ffHfCbYsosgxyxeK5TMxdkLkhGoaPa/zN+fbhJ+4ALI9TuhF5RodiUzL
         k4kpNu+J0VwzqwDUiTfjUrXG5VOhiTIDf6ullwvuimyVH3ayMBSo4gC347ggX9A8RRrR
         JpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2GG9jK07Kv2i8LvXwEMcbCms44zOL2mPSFZgVB4sK1I=;
        b=uEb5DgX6c4mhP/zZBDM173d5uvmbsNGSt5JdzJW13OroCZsYPifdGDsSBRRmWci21w
         0lzrrD1tVQQKzpAt7syM67sJ6oOKzqC0eg9uChpfhtK22+BaKWgDNdpdVrhrxLuczKuZ
         WxWTBScxg9gg8QFaimOSE3D53rpbvDDXcvtvgLDcbgX3tqaEJJAZnyjAk19HofsFW8u/
         Cs5nmZVDv9VbJLy+ua+7uV/VLlI9QME7wpaPLNWBpedNDThS/gBdYdLhyGwZLA1IKDgP
         CgleQ/xkNLXfeyECNTOIZH4WagSJwvO40gOlq/mBNQODF1n3a10UIYYXA8CZF2Iaa0KM
         0J3w==
X-Gm-Message-State: APjAAAWeMwAfr/cfK0hQL1RFR0H0F4kj3AIHzgRlUZoNLka0z4gg+4EN
        hGcuVK1EMToEDc47GdLSItCK92o4
X-Google-Smtp-Source: APXvYqwIHodlYn8sdTsp7W0fS7vrkT8e6z9FZBjcycvCsxGKoIVk1x4HKN/aSExX+5P4OZy9Sl8iGg==
X-Received: by 2002:aa7:99dd:: with SMTP id v29mr53462463pfi.252.1557349419471;
        Wed, 08 May 2019 14:03:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a6sm100456pgd.67.2019.05.08.14.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 14:03:38 -0700 (PDT)
Date:   Wed, 8 May 2019 14:03:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com
Subject: Re: [PATCH] hwmon (occ): Switch power average to between poll
 responses
Message-ID: <20190508210336.GA29619@roeck-us.net>
References: <1557257751-12995-1-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557257751-12995-1-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 02:35:51PM -0500, Eddie James wrote:
> The average power reported in the hwmon OCC driver is not useful
> because the time it represents is too short. Instead, store the
> previous power accumulator reported by the OCC and average it with the
> latest accumulator to obtain an average between poll responses. This
> does operate under the assumption that the user polls regularly.
> 

That looks really bad. Effectively it means that the number reported
as average power is more or less useless/random. On top of that, the code
gets so complicated that it is all but impossible to understand.

Does it really make sense to report an average that has effectively
no useful meaning (and is, for example, influenced just by reading it) ?

Guenter

> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/hwmon/occ/common.c | 133 ++++++++++++++++++++++++++++++++-------------
>  drivers/hwmon/occ/common.h |   7 +++
>  2 files changed, 103 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index e6d3fb5..6ffcee7 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -118,6 +118,53 @@ struct extended_sensor {
>  	u8 data[6];
>  } __packed;
>  
> +static void occ_update_prev_power_avgs(struct occ *occ)
> +{
> +	u8 i;
> +	struct power_sensor_1 *ps1;
> +	struct power_sensor_2 *ps2;
> +	struct power_sensor_a0 *psa0;
> +	struct occ_sensor *power = &occ->sensors.power;
> +	struct occ_power_avg *prevs = occ->prev_power_avgs;
> +
> +	switch (power->version) {
> +	case 1:
> +		for (i = 0; i < power->num_sensors; ++i) {
> +			ps1 = ((struct power_sensor_1 *)power->data) + i;
> +
> +			prevs[i].accumulator =
> +				get_unaligned_be32(&ps1->accumulator);
> +			prevs[i].update_tag =
> +				get_unaligned_be32(&ps1->update_tag);
> +		}
> +		break;
> +	case 2:
> +		for (i = 0; i < power->num_sensors; ++i) {
> +			ps2 = ((struct power_sensor_2 *)power->data) + i;
> +
> +			prevs[i].accumulator =
> +				get_unaligned_be64(&ps2->accumulator);
> +			prevs[i].update_tag =
> +				get_unaligned_be32(&ps2->update_tag);
> +		}
> +		break;
> +	case 0xA0:
> +		for (i = 0; i < power->num_sensors; ++i) {
> +			psa0 = ((struct power_sensor_a0 *)power->data) + i;
> +
> +			prevs[i].accumulator = psa0->system.accumulator;
> +			prevs[i].update_tag = psa0->system.update_tag;
> +			prevs[i + 1].accumulator = psa0->proc.accumulator;
> +			prevs[i + 1].update_tag = psa0->proc.update_tag;
> +			prevs[i + 2].accumulator = psa0->vdd.accumulator;
> +			prevs[i + 2].update_tag = psa0->vdd.update_tag;
> +			prevs[i + 3].accumulator = psa0->vdn.accumulator;
> +			prevs[i + 3].update_tag = psa0->vdn.update_tag;
> +		}
> +		break;
> +	}
> +}
> +
>  static int occ_poll(struct occ *occ)
>  {
>  	int rc;
> @@ -135,6 +182,8 @@ static int occ_poll(struct occ *occ)
>  	cmd[6] = checksum & 0xFF;	/* checksum lsb */
>  	cmd[7] = 0;
>  
> +	occ_update_prev_power_avgs(occ);
> +
>  	/* mutex should already be locked if necessary */
>  	rc = occ->send_cmd(occ, cmd);
>  	if (rc) {
> @@ -208,6 +257,7 @@ int occ_update_response(struct occ *occ)
>  	/* limit the maximum rate of polling the OCC */
>  	if (time_after(jiffies, occ->last_update + OCC_UPDATE_FREQUENCY)) {
>  		rc = occ_poll(occ);
> +		occ->prev_update = occ->last_update;
>  		occ->last_update = jiffies;
>  	} else {
>  		rc = occ->last_error;
> @@ -364,6 +414,14 @@ static ssize_t occ_show_freq_2(struct device *dev,
>  	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
>  }
>  
> +static u64 occ_power_avg(struct occ *occ, u8 idx, u64 accum, u32 samples)
> +{
> +	struct occ_power_avg *avg = &occ->prev_power_avgs[idx];
> +
> +	return div_u64((accum - avg->accumulator) * 1000000ULL,
> +		       samples - avg->update_tag);
> +}
> +
>  static ssize_t occ_show_power_1(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> @@ -385,13 +443,12 @@ static ssize_t occ_show_power_1(struct device *dev,
>  		val = get_unaligned_be16(&power->sensor_id);
>  		break;
>  	case 1:
> -		val = get_unaligned_be32(&power->accumulator) /
> -			get_unaligned_be32(&power->update_tag);
> -		val *= 1000000ULL;
> +		val = occ_power_avg(occ, sattr->index,
> +				    get_unaligned_be32(&power->accumulator),
> +				    get_unaligned_be32(&power->update_tag));
>  		break;
>  	case 2:
> -		val = (u64)get_unaligned_be32(&power->update_tag) *
> -			   occ->powr_sample_time_us;
> +		val = jiffies_to_usecs(occ->last_update - occ->prev_update);
>  		break;
>  	case 3:
>  		val = get_unaligned_be16(&power->value) * 1000000ULL;
> @@ -403,12 +460,6 @@ static ssize_t occ_show_power_1(struct device *dev,
>  	return snprintf(buf, PAGE_SIZE - 1, "%llu\n", val);
>  }
>  
> -static u64 occ_get_powr_avg(u64 *accum, u32 *samples)
> -{
> -	return div64_u64(get_unaligned_be64(accum) * 1000000ULL,
> -			 get_unaligned_be32(samples));
> -}
> -
>  static ssize_t occ_show_power_2(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> @@ -431,12 +482,12 @@ static ssize_t occ_show_power_2(struct device *dev,
>  				get_unaligned_be32(&power->sensor_id),
>  				power->function_id, power->apss_channel);
>  	case 1:
> -		val = occ_get_powr_avg(&power->accumulator,
> -				       &power->update_tag);
> +		val = occ_power_avg(occ, sattr->index,
> +				    get_unaligned_be64(&power->accumulator),
> +				    get_unaligned_be32(&power->update_tag));
>  		break;
>  	case 2:
> -		val = (u64)get_unaligned_be32(&power->update_tag) *
> -			   occ->powr_sample_time_us;
> +		val = jiffies_to_usecs(occ->last_update - occ->prev_update);
>  		break;
>  	case 3:
>  		val = get_unaligned_be16(&power->value) * 1000000ULL;
> @@ -452,6 +503,8 @@ static ssize_t occ_show_power_a0(struct device *dev,
>  				 struct device_attribute *attr, char *buf)
>  {
>  	int rc;
> +	u32 samples;
> +	u64 accum;
>  	u64 val = 0;
>  	struct power_sensor_a0 *power;
>  	struct occ *occ = dev_get_drvdata(dev);
> @@ -469,12 +522,15 @@ static ssize_t occ_show_power_a0(struct device *dev,
>  		return snprintf(buf, PAGE_SIZE - 1, "%u_system\n",
>  				get_unaligned_be32(&power->sensor_id));
>  	case 1:
> -		val = occ_get_powr_avg(&power->system.accumulator,
> -				       &power->system.update_tag);
> +		accum = get_unaligned_be64(&power->system.accumulator);
> +		samples = get_unaligned_be32(&power->system.update_tag);
> +		val = occ_power_avg(occ, sattr->index, accum, samples);
>  		break;
>  	case 2:
> -		val = (u64)get_unaligned_be32(&power->system.update_tag) *
> -			   occ->powr_sample_time_us;
> +	case 6:
> +	case 10:
> +	case 14:
> +		val = jiffies_to_usecs(occ->last_update - occ->prev_update);
>  		break;
>  	case 3:
>  		val = get_unaligned_be16(&power->system.value) * 1000000ULL;
> @@ -483,12 +539,9 @@ static ssize_t occ_show_power_a0(struct device *dev,
>  		return snprintf(buf, PAGE_SIZE - 1, "%u_proc\n",
>  				get_unaligned_be32(&power->sensor_id));
>  	case 5:
> -		val = occ_get_powr_avg(&power->proc.accumulator,
> -				       &power->proc.update_tag);
> -		break;
> -	case 6:
> -		val = (u64)get_unaligned_be32(&power->proc.update_tag) *
> -			   occ->powr_sample_time_us;
> +		accum = get_unaligned_be64(&power->proc.accumulator);
> +		samples = get_unaligned_be32(&power->proc.update_tag);
> +		val = occ_power_avg(occ, sattr->index + 1, accum, samples);
>  		break;
>  	case 7:
>  		val = get_unaligned_be16(&power->proc.value) * 1000000ULL;
> @@ -497,12 +550,9 @@ static ssize_t occ_show_power_a0(struct device *dev,
>  		return snprintf(buf, PAGE_SIZE - 1, "%u_vdd\n",
>  				get_unaligned_be32(&power->sensor_id));
>  	case 9:
> -		val = occ_get_powr_avg(&power->vdd.accumulator,
> -				       &power->vdd.update_tag);
> -		break;
> -	case 10:
> -		val = (u64)get_unaligned_be32(&power->vdd.update_tag) *
> -			   occ->powr_sample_time_us;
> +		accum = get_unaligned_be64(&power->vdd.accumulator);
> +		samples = get_unaligned_be32(&power->vdd.update_tag);
> +		val = occ_power_avg(occ, sattr->index + 2, accum, samples);
>  		break;
>  	case 11:
>  		val = get_unaligned_be16(&power->vdd.value) * 1000000ULL;
> @@ -511,12 +561,9 @@ static ssize_t occ_show_power_a0(struct device *dev,
>  		return snprintf(buf, PAGE_SIZE - 1, "%u_vdn\n",
>  				get_unaligned_be32(&power->sensor_id));
>  	case 13:
> -		val = occ_get_powr_avg(&power->vdn.accumulator,
> -				       &power->vdn.update_tag);
> -		break;
> -	case 14:
> -		val = (u64)get_unaligned_be32(&power->vdn.update_tag) *
> -			   occ->powr_sample_time_us;
> +		accum = get_unaligned_be64(&power->vdn.accumulator);
> +		samples = get_unaligned_be32(&power->vdn.update_tag);
> +		val = occ_power_avg(occ, sattr->index + 3, accum, samples);
>  		break;
>  	case 15:
>  		val = get_unaligned_be16(&power->vdn.value) * 1000000ULL;
> @@ -719,6 +766,7 @@ static ssize_t occ_show_extended(struct device *dev,
>  static int occ_setup_sensor_attrs(struct occ *occ)
>  {
>  	unsigned int i, s, num_attrs = 0;
> +	unsigned int power_avgs_size = 0;
>  	struct device *dev = occ->bus_dev;
>  	struct occ_sensors *sensors = &occ->sensors;
>  	struct occ_attribute *attr;
> @@ -761,9 +809,13 @@ static int occ_setup_sensor_attrs(struct occ *occ)
>  		/* fall through */
>  	case 1:
>  		num_attrs += (sensors->power.num_sensors * 4);
> +		power_avgs_size = sizeof(struct occ_power_avg) *
> +			sensors->power.num_sensors;
>  		break;
>  	case 0xA0:
>  		num_attrs += (sensors->power.num_sensors * 16);
> +		power_avgs_size = sizeof(struct occ_power_avg) *
> +			sensors->power.num_sensors * 4;
>  		show_power = occ_show_power_a0;
>  		break;
>  	default:
> @@ -792,6 +844,13 @@ static int occ_setup_sensor_attrs(struct occ *occ)
>  		sensors->extended.num_sensors = 0;
>  	}
>  
> +	if (power_avgs_size) {
> +		occ->prev_power_avgs = devm_kzalloc(dev, power_avgs_size,
> +						    GFP_KERNEL);
> +		if (!occ->prev_power_avgs)
> +			return -ENOMEM;
> +	}
> +
>  	occ->attrs = devm_kzalloc(dev, sizeof(*occ->attrs) * num_attrs,
>  				  GFP_KERNEL);
>  	if (!occ->attrs)
> diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
> index c676e48..08970f8 100644
> --- a/drivers/hwmon/occ/common.h
> +++ b/drivers/hwmon/occ/common.h
> @@ -87,17 +87,24 @@ struct occ_attribute {
>  	struct sensor_device_attribute_2 sensor;
>  };
>  
> +struct occ_power_avg {
> +	u64 accumulator;
> +	u32 update_tag;
> +};
> +
>  struct occ {
>  	struct device *bus_dev;
>  
>  	struct occ_response resp;
>  	struct occ_sensors sensors;
> +	struct occ_power_avg *prev_power_avgs;
>  
>  	int powr_sample_time_us;	/* average power sample time */
>  	u8 poll_cmd_data;		/* to perform OCC poll command */
>  	int (*send_cmd)(struct occ *occ, u8 *cmd);
>  
>  	unsigned long last_update;
> +	unsigned long prev_update;
>  	struct mutex lock;		/* lock OCC access */
>  
>  	struct device *hwmon;
> -- 
> 1.8.3.1
> 
