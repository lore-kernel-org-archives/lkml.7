Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAF1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C502073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f2338jd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfLKKa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 05:30:26 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42032 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfLKKa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 05:30:26 -0500
Received: by mail-pf1-f195.google.com with SMTP id 4so1594391pfz.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 02:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m5RPBzS27RTPX/pLjO63YZsQla7q8WFKSfN3yALVOAU=;
        b=f2338jd9MUtQXRgdrjHjQLyS3O5mZISNGUYevaTSwF3QRsJaJKma480XA52Toy4itJ
         peo1rVxJ8kbllcAao3v/PBTHLp7iHxp8TSFFHIDVt/9DYxkRyI8peAp92+uAIYM0yTUW
         1fvZ30tKv2ZC7sKJOXsT1obaZJL+9922mJIX0L6GXBYfRJ0520mBQzjoXjhBKKa3QbIo
         /oaNpvr4xkPU7vv7642RvsPv6tX9W4rcuoXS2SAfKsLjZ7o0PKTKlHjphFisNc7/cZ7l
         pj5AZLQE0yj2qR9S9fQjnDiHPFthnpqYIqaww8Rm68OlI3Ir5/2Oq1mVee3DX9scT/eo
         Wbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m5RPBzS27RTPX/pLjO63YZsQla7q8WFKSfN3yALVOAU=;
        b=E5xnkDDSda5bfG27AmhbG85OM1ZiY80R9XgqSXARdfG75p+Ib0g2d8x+bkxpO1IvkK
         68HgUoC1Iyt/I0uEiUXwYZCzj+VvzjjuQa4yujJLAv19pH5GZ6mZrjpAG4AbwdkokiAe
         456v4itsiG6gegVr4fQpsnzm6NV7GclDuFAAUHVenkV0xJZbwuo+6A0+KyfJ6FaiwZ/Z
         nutH7j21XTLLE+5QeZ3CiC715fVw8aIDFt4SPqF06DxevrRC1KHEx2QLCojBYjxP1ar8
         q4QsfL2FZAK8KuHu1AaIF1MoINCWDHFnpI4efCtbfS1AL9FQlyWclb/CGhB1CWhnhaai
         HSJw==
X-Gm-Message-State: APjAAAVXRmVw10KXiK6d7AuIZJNV3SK60lLKAqvVD3M8YZ3YFufcyVEQ
        f9Q9vFJl4M/CJEVRJ4ZUphIjAQ==
X-Google-Smtp-Source: APXvYqxP7ksjRkHEUpxo4dU1ZHuAgoQvCDvr983PA5I9GYEJRquI3QIy+fEeq9pX/dpEUYuFvRWmig==
X-Received: by 2002:a62:174b:: with SMTP id 72mr2926757pfx.185.1576060225844;
        Wed, 11 Dec 2019 02:30:25 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id j22sm2066161pji.16.2019.12.11.02.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2019 02:30:25 -0800 (PST)
Date:   Wed, 11 Dec 2019 16:00:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 13/15] cpufreq: scmi: Match scmi device by both name and
 protocol id
Message-ID: <20191211103023.ibduhblz6ohjaaa7@vireshk-i7>
References: <20191210145345.11616-1-sudeep.holla@arm.com>
 <20191210145345.11616-14-sudeep.holla@arm.com>
 <20191211023909.7iun7kdk6pjkync6@vireshk-i7>
 <20191211101302.GD20962@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211101302.GD20962@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-12-19, 10:13, Sudeep Holla wrote:
> On Wed, Dec 11, 2019 at 08:09:09AM +0530, Viresh Kumar wrote:
> > On 10-12-19, 14:53, Sudeep Holla wrote:
> > > The scmi bus now has support to match the driver with devices not only
> > > based on their protocol id but also based on their device name if one is
> > > available. This was added to cater the need to support multiple devices
> > > and drivers for the same protocol.
> > >
> > > Let us add the name "cpufreq" to scmi_device_id table in the driver so
> > > that in matches only with device with the same name and protocol id
> > > SCMI_PROTOCOL_PERF. This will help to add "devfreq" device/driver.
> > >
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > Cc: linux-pm@vger.kernel.org
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  drivers/cpufreq/scmi-cpufreq.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> > > index e6182c89df79..61623e2ff149 100644
> > > --- a/drivers/cpufreq/scmi-cpufreq.c
> > > +++ b/drivers/cpufreq/scmi-cpufreq.c
> > > @@ -261,7 +261,7 @@ static void scmi_cpufreq_remove(struct scmi_device *sdev)
> > >  }
> > >
> > >  static const struct scmi_device_id scmi_id_table[] = {
> > > -	{ SCMI_PROTOCOL_PERF },
> > > +	{ SCMI_PROTOCOL_PERF, "cpufreq" },
> > >  	{ },
> > >  };
> > >  MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> >
> > Applied. Thanks.
> 
> This will break the build without patch 1/15, so preferably must go as
> part of the series. Sorry for not missing to specify that detail.

Dropped now.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
