Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B582C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640F520862
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfENQhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:37:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58660 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfENQhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:37:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20D58374;
        Tue, 14 May 2019 09:37:15 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99D5A3F703;
        Tue, 14 May 2019 09:37:13 -0700 (PDT)
Date:   Tue, 14 May 2019 17:37:07 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v5 2/2] hwmon: scmi: Scale values to target desired HWMON
 units
Message-ID: <20190514163707.GA20819@e107155-lin>
References: <20190508184635.5054-1-f.fainelli@gmail.com>
 <20190508184635.5054-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508184635.5054-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 11:46:35AM -0700, Florian Fainelli wrote:
> If the SCMI firmware implementation is reporting values in a scale that
> is different from the HWMON units, we need to scale up or down the value
> according to how far appart they are.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/hwmon/scmi-hwmon.c | 45 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index a80183a488c5..2c7b87edf5aa 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -18,6 +18,47 @@ struct scmi_sensors {
>  	const struct scmi_sensor_info **info[hwmon_max];
>  };
>  
> +static inline u64 __pow10(u8 x)
> +{
> +	u64 r = 1;
> +
> +	while (x--)
> +		r *= 10;
> +
> +	return r;
> +}
> +
> +static int scmi_hwmon_scale(const struct scmi_sensor_info *sensor, u64 *value)
> +{
> +	s8 scale = sensor->scale;
> +	u64 f;
> +
> +	switch (sensor->type) {
> +	case TEMPERATURE_C:
> +	case VOLTAGE:
> +	case CURRENT:
> +		scale += 3;
> +		break;
> +	case POWER:
> +	case ENERGY:
> +		scale += 6;
> +		break;
> +	default:
> +		break;
> +	}
> +

I was applying this and wanted to check if we can add a check for scale=0
here and return early here to above the below check and __pow10(0) ?

Let me know if you agree. I can fix up. Also I will try to test it on
Juno if firmware behaves correctly :)

--
Regards,
Sudeep
