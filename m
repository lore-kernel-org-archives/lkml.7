Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4228C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49872084A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMAWbMVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfENQ6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:58:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33681 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfENQ6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:58:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id y3so8558178plp.0;
        Tue, 14 May 2019 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nEerwvg48fYTdSZWsjZwyZW5riUaDK+8t7KUgCGOYTw=;
        b=JMAWbMVrrVoLfoE4HYzWVflV05bL2CGTa6q47RwAfK3zpiNbfh1OY3hwlJmPJn7dKP
         o9I/a5Fw7dEi7ZDhctz68UfvQ7D94ZuUYktdVL008wqZ9iDK3E9nSnIGRIvO782aX0Xq
         aCwLU49cDQ0IMFqgfigqd/CbBIbknLyex9OL5MPwO7T3nmCQuMPYGcCLAn93I33BQ1rr
         AdcEEi4SH9LvZLBfFR1liu3aqJdqVvcKJTCpgOSo3UCUyMsUJo8ocp8fSV3DRdI5OeO+
         UhPmzkagcOe+xJZy6Zwzu0KMzTk5S2K9iCws3VLCjuSz7fooF3RnE4zKgqWE8NvfLfXp
         VRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nEerwvg48fYTdSZWsjZwyZW5riUaDK+8t7KUgCGOYTw=;
        b=NyIYS92lwUeHiO0rWYKgWgU07Re8ug8WYblkkTzhmmHnDj2PTzxXdkN97OFv2+tdr7
         W7SbeumPjJX0WCX1ch3CIpoh2p4vu05OISdYaGd4TnhFrliOzXp0DlEiK0jVfJwfPqHJ
         Jt++RVWyTJrMOZizZe2LRf1GU/pJ1oKr/Nh0+BtAcY++lJcxaGMQkPLzfbLfjrz7sKzo
         oMoyC22Xv/854x7qiPTnNDVYB2AFfidrDiW0onDH2hM0pB0hyNPuS5GULeRxaME9Ljkx
         l5DjC2wIbjHixWrq/uh2/lw9Xr5EPjBphlROO0f73kof7xDB58YNucQsdlJnCEn8Ukx/
         7PbQ==
X-Gm-Message-State: APjAAAWRT0PhWSQiMTzlJymCGnTlrg94rtW43xsUo998azRJ0IaBvkIX
        Fvqv94iIvy6UxsxFXzEA7I0=
X-Google-Smtp-Source: APXvYqwoYgc0OOHXxgA1BqnwTyv/tFPPJjQELqA+1BS2Mq4lDPbq2b3DoQyDoMgNWj0jkhIpCAGsFw==
X-Received: by 2002:a17:902:a40b:: with SMTP id p11mr10938121plq.306.1557853089014;
        Tue, 14 May 2019 09:58:09 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z187sm24656658pfb.132.2019.05.14.09.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 09:58:07 -0700 (PDT)
Date:   Tue, 14 May 2019 09:58:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Jean Delvare <jdelvare@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] hwmon: scmi: Scale values to target desired HWMON
 units
Message-ID: <20190514165806.GA30274@roeck-us.net>
References: <20190508184635.5054-1-f.fainelli@gmail.com>
 <20190508184635.5054-3-f.fainelli@gmail.com>
 <20190514163707.GA20819@e107155-lin>
 <2cbed0ac-fbfc-e66e-7cb9-908478466a34@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cbed0ac-fbfc-e66e-7cb9-908478466a34@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 09:44:02AM -0700, Florian Fainelli wrote:
> On 5/14/19 9:37 AM, Sudeep Holla wrote:
> > On Wed, May 08, 2019 at 11:46:35AM -0700, Florian Fainelli wrote:
> >> If the SCMI firmware implementation is reporting values in a scale that
> >> is different from the HWMON units, we need to scale up or down the value
> >> according to how far appart they are.
> >>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>  drivers/hwmon/scmi-hwmon.c | 45 ++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 45 insertions(+)
> >>
> >> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> >> index a80183a488c5..2c7b87edf5aa 100644
> >> --- a/drivers/hwmon/scmi-hwmon.c
> >> +++ b/drivers/hwmon/scmi-hwmon.c
> >> @@ -18,6 +18,47 @@ struct scmi_sensors {
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
> > 
> > I was applying this and wanted to check if we can add a check for scale=0
> > here and return early here to above the below check and __pow10(0) ?
> 
> Doing an early check for scale == 0 sounds like a good idea,good catch!
> Feel free to amend the patch directly when you apply it.
> 

Ok with me. Just make it == 0 :-).

Guenter

> > 
> > Let me know if you agree. I can fix up. Also I will try to test it on
> > Juno if firmware behaves correctly :)
> 
> Great, thanks.
> -- 
> Florian
