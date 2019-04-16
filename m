Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E580C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC2F20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QT8wkxVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbfDPVav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:30:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43974 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfDPVav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:30:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id n8so10944434plp.10;
        Tue, 16 Apr 2019 14:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ivrPHA4H2+SZIz4zuqKVjysFpMX2cQ3lIocjHgPstw=;
        b=QT8wkxVkbUHE7RknkkgEZuVEGXloJouk0CwLu4gGMEduF+EgfJmoH4mf6Xi4GiNzqf
         DsXPKBOfUuH+eXcwdgnzf73P/l8lWOFV1SOtrwSrB5jA5i4jeDJSWPoBSG6Xpr8OAn4a
         GsU3/oM0/hVRWczyG4hpX10JJe8X7/EYk20Ki83OtWES8BvyeQQrj+04lnUTziuvargW
         VWrRXWOMpRFj019xjYu2vXWpvvjXt7Vqsso/rJ0CgT+483A6Uv+lTe8n2kgfcCUCSZRC
         6OEuKOJSamoq8cmWUtbW5GHtSsbccYtW4berohhe9loKplEnSudALdpHFgjkHWJulCYB
         40xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ivrPHA4H2+SZIz4zuqKVjysFpMX2cQ3lIocjHgPstw=;
        b=Od3EyaHLIHp8gZwnO8sEKv9W/EX5asOpBvSF3jxVgscisVE8vu5RQXeQLo63GXg0Yn
         bQBUfPOFf/jTWAdcHfhfN9p2thkoTSeLMs6BU0o76ycgNXDTgPxNjGsgzl0hoMixQVPu
         Gjonq4Z99Bm+0ddUnYlSwzcFlftEz7Uz0hNpZl06YrCnaF/3lmWk0cIJ+rO2B1fS+owf
         k+dHKkQPM5+pNd3L8DlwQIJ50fxQi6MVVGuGWPzYHXqB+WVr71FnZ4pb8qzhatoFfgjA
         BqX+y6q+R9YhWBum1ZkYernkR16ahiNU5nzAJFCMIZfCRGbJQUCSWmtonMhXeS13E4b0
         qqUA==
X-Gm-Message-State: APjAAAXCevnxfx4dso0hBIj/aYDDsPArtY2ZgBXUDrG7kPqSPj5dkndc
        g029JDatp++5XrX257nNmJLK124X
X-Google-Smtp-Source: APXvYqzp/tZnw2L+FbRaKzys8EN/Ub7gUGFmsR13ZoZVaeyaHekRlgHGQ4qszJFcWtQZmqzBmUw09w==
X-Received: by 2002:a17:902:703:: with SMTP id 3mr85702525pli.224.1555450250682;
        Tue, 16 Apr 2019 14:30:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f63sm108827442pfc.180.2019.04.16.14.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 14:30:49 -0700 (PDT)
Date:   Tue, 16 Apr 2019 14:30:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ruslan Babayev <ruslan@babayev.com>
Cc:     xe-linux-external@cisco.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] hwmon: (pmbus) mark registers READ_VIN and READ_IIN
 as paged
Message-ID: <20190416213048.GA29411@roeck-us.net>
References: <20190416183620.39950-2-ruslan@babayev.com>
 <20190416194032.GB8093@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416194032.GB8093@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 12:40:33PM -0700, Guenter Roeck wrote:
> On Tue, Apr 16, 2019 at 11:36:17AM -0700, Ruslan Babayev wrote:
> > On some devices (like IR35215) READ_VIN and READ_IIN registers are
> > paged.
> > 
> > For devices where these registers are not paged the extra check
> > ensures we expose only the registers that are actually present.
> > 
> > Cc: xe-linux-external@cisco.com
> > Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
> > ---
> >  drivers/hwmon/pmbus/pmbus_core.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> > index f35b239961e3..fac966967816 100644
> > --- a/drivers/hwmon/pmbus/pmbus_core.c
> > +++ b/drivers/hwmon/pmbus/pmbus_core.c
> > @@ -1379,6 +1379,9 @@ static int pmbus_add_sensor_attrs(struct i2c_client *client,
> >  		for (page = 0; page < pages; page++) {
> >  			if (!(info->func[page] & attrs->func))
> >  				continue;
> > +			if (!pmbus_check_word_register(client, page,
> > +						       attrs->reg))
> > +				continue;
> 
> This won't work. Most other chips will just report the values from page 0
> when trying to read VIN/IIN from other pages.
> 
Another problem is that this would change the label for non-pages devices
to vin[0...]. I understand the need, but we'll need some means to tell the
core that the input (voltage, current, power, ..) registers are paged.

Another option, to specifically address this case, might be to report the
second voltage as vmon or vcap (and maybe add imon / icap), but that would
be a bit clumsy unless it is not really an "input" voltage but, for example,
the chip's VCC.

It is quite unfortunate that the datasheet is not public. It would be quite
useful to know what exactly is measured with those paged input sensors.

Guenter

> Guenter
> 
> >  			ret = pmbus_add_sensor_attrs_one(client, data, info,
> >  							 name, index, page,
> >  							 attrs);
> > @@ -1498,6 +1501,7 @@ static const struct pmbus_sensor_attr voltage_attributes[] = {
> >  		.reg = PMBUS_READ_VIN,
> >  		.class = PSC_VOLTAGE_IN,
> >  		.label = "vin",
> > +		.paged = true,
> >  		.func = PMBUS_HAVE_VIN,
> >  		.sfunc = PMBUS_HAVE_STATUS_INPUT,
> >  		.sbase = PB_STATUS_INPUT_BASE,
> > @@ -1602,6 +1606,7 @@ static const struct pmbus_sensor_attr current_attributes[] = {
> >  		.reg = PMBUS_READ_IIN,
> >  		.class = PSC_CURRENT_IN,
> >  		.label = "iin",
> > +		.paged = true,
> >  		.func = PMBUS_HAVE_IIN,
> >  		.sfunc = PMBUS_HAVE_STATUS_INPUT,
> >  		.sbase = PB_STATUS_INPUT_BASE,
> > -- 
> > 2.17.1
> > 
