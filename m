Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EBAC04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50072084A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfENRAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:00:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58898 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfENRAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:00:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89FCF374;
        Tue, 14 May 2019 10:00:54 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F33F3F703;
        Tue, 14 May 2019 10:00:52 -0700 (PDT)
Date:   Tue, 14 May 2019 18:00:50 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Jean Delvare <jdelvare@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v5 2/2] hwmon: scmi: Scale values to target desired HWMON
 units
Message-ID: <20190514170050.GB20819@e107155-lin>
References: <20190508184635.5054-1-f.fainelli@gmail.com>
 <20190508184635.5054-3-f.fainelli@gmail.com>
 <20190514163707.GA20819@e107155-lin>
 <2cbed0ac-fbfc-e66e-7cb9-908478466a34@gmail.com>
 <20190514165806.GA30274@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514165806.GA30274@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 09:58:06AM -0700, Guenter Roeck wrote:
> On Tue, May 14, 2019 at 09:44:02AM -0700, Florian Fainelli wrote:
> > On 5/14/19 9:37 AM, Sudeep Holla wrote:
> > > On Wed, May 08, 2019 at 11:46:35AM -0700, Florian Fainelli wrote:
> > >> If the SCMI firmware implementation is reporting values in a scale that
> > >> is different from the HWMON units, we need to scale up or down the value
> > >> according to how far appart they are.
> > >>
> > >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > >> ---
> > >>  drivers/hwmon/scmi-hwmon.c | 45 ++++++++++++++++++++++++++++++++++++++
> > >>  1 file changed, 45 insertions(+)
> > >>
> > >> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> > >> index a80183a488c5..2c7b87edf5aa 100644
> > >> --- a/drivers/hwmon/scmi-hwmon.c
> > >> +++ b/drivers/hwmon/scmi-hwmon.c
> > >> @@ -18,6 +18,47 @@ struct scmi_sensors {
> > >>  	const struct scmi_sensor_info **info[hwmon_max];
> > >>  };
> > >>
> > >> +static inline u64 __pow10(u8 x)
> > >> +{
> > >> +	u64 r = 1;
> > >> +
> > >> +	while (x--)
> > >> +		r *= 10;
> > >> +
> > >> +	return r;
> > >> +}
> > >> +
> > >> +static int scmi_hwmon_scale(const struct scmi_sensor_info *sensor, u64 *value)
> > >> +{
> > >> +	s8 scale = sensor->scale;
> > >> +	u64 f;
> > >> +
> > >> +	switch (sensor->type) {
> > >> +	case TEMPERATURE_C:
> > >> +	case VOLTAGE:
> > >> +	case CURRENT:
> > >> +		scale += 3;
> > >> +		break;
> > >> +	case POWER:
> > >> +	case ENERGY:
> > >> +		scale += 6;
> > >> +		break;
> > >> +	default:
> > >> +		break;
> > >> +	}
> > >> +
> > >
> > > I was applying this and wanted to check if we can add a check for scale=0
> > > here and return early here to above the below check and __pow10(0) ?
> >
> > Doing an early check for scale == 0 sounds like a good idea,good catch!
> > Feel free to amend the patch directly when you apply it.
> >
>
> Ok with me. Just make it == 0 :-).
>

Thanks Guenter and Florian for quick response, done now.

--
Regards,
Sudeep
