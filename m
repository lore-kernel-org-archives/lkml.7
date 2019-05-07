Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7DAC04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DD921019
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOcuYAIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfEGS0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:26:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37194 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfEGS0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:26:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id g3so9080879pfi.4;
        Tue, 07 May 2019 11:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ka6LMhnLUqE6odqHoqHbUWiiXGVvr4B6Nmgf+rChy8c=;
        b=cOcuYAIPrMY/Uq90XRPSi4cwB9on+DinYs/8giKSoraOxRpRFgcbT3A6dE4d2DKjUv
         SXbOQOv+3PyvNj527v/E9s7lqOOovuVcSomj9Pfk8n8qBuRP+sr8URGGVUP1vgGE7etT
         4x23lx6yYTZLM8N3lfTgLxgne1laMn1FFlf3cy/zl/CcfYbLF4qD6BrESasSNWvGvIeW
         gWBxisQbxafoJQxI3sckzXNufldEjSrnUnistzYprsfX3iUmVdfPS0yJwgiSjESAhu+B
         dtp6ip6P6bdUar1QCgOnYKw+6kyjsQSSaYnzCfw3aSc79sk+w4QoYNHVkBUk3MnSwkp8
         8/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Ka6LMhnLUqE6odqHoqHbUWiiXGVvr4B6Nmgf+rChy8c=;
        b=EJr8A0/YaK7+orKdv/LS0f14APZHluUGZhUWG8BHd/uXxb30Hp8zW0spGbAekV4Gqg
         1lpt6Py0nCEbeus/Gpu+tgyXCUhdJlSx7FlEPOMXSK+VXIm/Ln6BSUsqmbGNgl5oob6t
         n/L9rNQdfAASvE5hk71MpADXo88qrnrjdncu2IaTDcceMiZjV6Zk+Tyvcj403IAzx4x7
         Aiiq2hN3qlChhZdkdpOQVyhR3QM60hEd/fGupUGFyw64n6OAWYVyh9lny2REJMM8WxSb
         iZucDwcJJfz+p93/Hn4SonuNQOqfIRgto0+TrHcDGYRe0yZJcwjdl787nwO1mGzX0U2p
         YhqA==
X-Gm-Message-State: APjAAAWiSdfoKr9aV8SHkobcP2sto+La2It0kiPPSZ4IBxjYT8OmmlG/
        8gjvRJXxXSV8ZQdyiKriUak=
X-Google-Smtp-Source: APXvYqzb2/1UXpXeRyCSxRVpxZ155VBzZSFtSfXBZM1fiBmJtLpX7RPquqonlMC+TGl2KFDs/mKNZw==
X-Received: by 2002:a63:f707:: with SMTP id x7mr40797735pgh.343.1557253594058;
        Tue, 07 May 2019 11:26:34 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a80sm2725413pfj.105.2019.05.07.11.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 11:26:32 -0700 (PDT)
Date:   Tue, 7 May 2019 11:26:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: scmi: Scale values to target desired HWMON
 units
Message-ID: <20190507182631.GA29510@roeck-us.net>
References: <20190506224109.9357-1-f.fainelli@gmail.com>
 <20190506224109.9357-3-f.fainelli@gmail.com>
 <a4dd5f4f-af12-8783-c612-cf3e88a9b94f@roeck-us.net>
 <e67efa2b-813c-c9f3-8f3d-b32c1b61ebc8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e67efa2b-813c-c9f3-8f3d-b32c1b61ebc8@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Tue, May 07, 2019 at 10:44:00AM -0700, Florian Fainelli wrote:
> On 5/7/19 6:55 AM, Guenter Roeck wrote:
> > Hi Florian,
> > 
> > On 5/6/19 3:41 PM, Florian Fainelli wrote:
> >> If the SCMI firmware implementation is reporting values in a scale that
> >> is different from the HWMON units, we need to scale up or down the value
> >> according to how far appart they are.
> >>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>   drivers/hwmon/scmi-hwmon.c | 55 +++++++++++++++++++++++++++++++-------
> >>   1 file changed, 46 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> >> index a80183a488c5..e9913509cb88 100644
> >> --- a/drivers/hwmon/scmi-hwmon.c
> >> +++ b/drivers/hwmon/scmi-hwmon.c
> >> @@ -18,6 +18,51 @@ struct scmi_sensors {
> >>       const struct scmi_sensor_info **info[hwmon_max];
> >>   };
> >>   +static enum hwmon_sensor_types scmi_types[] = {
> >> +    [TEMPERATURE_C] = hwmon_temp,
> >> +    [VOLTAGE] = hwmon_in,
> >> +    [CURRENT] = hwmon_curr,
> >> +    [POWER] = hwmon_power,
> >> +    [ENERGY] = hwmon_energy,
> >> +};
> >> +
> >> +static u64 scmi_hwmon_scale(const struct scmi_sensor_info *sensor,
> >> u64 value)
> >> +{
> >> +    u64 scaled_value = value;
> > 
> > I don't think that variable is necessary.
> > 
> >> +    s8 desired_scale;
> > 
> > Just scale ? Also, you could assign scale here directly, and subtract
> > the offset below. Then "n" would not be necessary.
> > Such as
> >     s8 scale = sensor->scale;    // assuming scale is s8
> >     ...
> >     case CURRENT:
> >         scale += 3;
> >     ...
> > 
> > That would also be less confusing, since it would avoid the double
> > negation.
> > 
> >> +    int n, p;
> > 
> >> +
> >> +    switch (sensor->type) {
> >> +    case TEMPERATURE_C:
> >> +    case VOLTAGE:
> >> +    case CURRENT:
> >> +        /* fall through */
> > Unnecessary comment
> 
> Is not removing the comment going to upset gcc when using
> -Wimplicit-fallthrough?
> 

There is no implicit fallthrough, and the comment would have to be
ahead of the previous case statement. Such as:

	case VOLTAGE:
		scale++;
		/* fall through */
	case CURRENT:
		scale++;
		break;
	...

Two case statements together don't count as fall through.

Guenter

> > 
> >> +        desired_scale = -3;
> >> +        break;
> >> +    case POWER:
> >> +    case ENERGY:
> >> +        /* fall through */
> > Unnecessary comment.
> > 
> >> +        desired_scale = -6;
> >> +        break;
> >> +    default:
> >> +        return scaled_value;
> > 
> > Here we presumably want a scale of 0. However, if the scale passed
> > from SCMI is, say, -5 or +5, we return the original (unadjusted)
> > value. Seems to me we would still want to adjust the value to match
> > hwmon expectations. Am I missing something ?
> 
> You raise a valid point, not that could happen today because if the
> sensor type has a value we don't recognize, we have not registered it,
> so we would not even try to read rom it, but let's be future proof.
> 
> > 
> >> +    }
> >> +
> >> +    n = (s8)sensor->scale - desired_scale;
> >> +        if (n == 0)
> > 
> > Indentation seems off here.
> > 
> >> +                return scaled_value;
> >> +
> >> +    for (p = 0; p < abs(n); p++) {
> >> +        /* Need to scale up from sensor to HWMON */
> >> +        if (n > 0)
> >> +            scaled_value *= 10;
> >> +        else
> >> +            do_div(scaled_value, 10);
> >> +    }
> > 
> > Something like
> > 
> >     factor = pow10(abs(scale));
> >     if (scale > 0)
> >         value *= factor;
> >     else
> >         do_div(value, factor);
> > 
> > would avoid the repeated abs() and do_div(). Unfortunately there is
> > no pow10() helper, so you would have to write that. Still, I think
> > that would be much more efficient.
> 
> Sounds reasonable. Thanks for your feedback!
> -- 
> Florian
