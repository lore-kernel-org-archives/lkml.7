Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD750C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9C32184B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2akjeky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732894AbfDQQSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:18:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34988 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732368AbfDQQSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:18:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so12244066pgf.2;
        Wed, 17 Apr 2019 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vBTqRH9YcvytkcSq8c0S3nqtN9HyITWuNrMSbFKLEpQ=;
        b=b2akjekyybnq0IiRbWsm+el76oTrbsh/rWb9N685bIvhNefUYhx0d4aXyg4fMxLg+F
         AyAfjpWati7Da8mzgXAUl7dP0XaxqpQhl2YDzUKsjbMoDaM7NKuW/sQSOYvMJXDGVdP+
         5hBcLNc/PeZrD3KKqXfVw3v9N1qF5cgeoEr3wOETas74dQzGQalA4SKje+uVXnh6YQV6
         TyIRknzg2uNdESNk7xI+4QZmwF1CKPqN277GNEywcsR++rFxvkW3agIc+M/xf9M4jhCG
         1nq4GvwogheV1b/URWzCk+LZQ7Av6mhFwG2X9NuwLwaiFmAggNF+u7GG24DKTVyfx4at
         AnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vBTqRH9YcvytkcSq8c0S3nqtN9HyITWuNrMSbFKLEpQ=;
        b=LU1S+FB7jPO6vQCWvsTQjwNR7MOhfsr7stEmWDsiI6MIKJ/UvIYLrQ9Jsi5zoVJwIQ
         5gA/CP0zAq8ojQW113y7x1WPz+iBeCBfsaWD69gCmTUAe447bgLJMBO1HbGlKMQN/f+F
         8Exhdl7cVFFUjhPMyPZ6qWxAcuMAyU4ERh5vd7xsob2CHAbvPw7G/7i5ACLyj8NzJiN5
         zMOSAsWCRuqYNmzvb9oNSTNs2ihkuDsVhRN3ks7iM9dNSq/IVq82xE0CwQITuARVnmPU
         a1KiMDdeEDtnYwtorjNF3PKpLOGyBBnUFDBG+SjMG8VK/AICLfTVl3qJ0nMiqU4wxH8N
         V1qA==
X-Gm-Message-State: APjAAAWUbCysbnBr1pLpMmmRWtRwSCFjR5S/Tt6x4F3/8RFlVT6E3XU7
        tNgA0W203l2iopZ7FgQ3/aw=
X-Google-Smtp-Source: APXvYqyaN1eN5p6XttZuxowwDacva5nL6VzFlwetB15EGaDXulUgRXeqG4BCuV/z3qDy/P82bZZEKA==
X-Received: by 2002:a62:7648:: with SMTP id r69mr70319901pfc.114.1555517899740;
        Wed, 17 Apr 2019 09:18:19 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e7sm57547735pfc.132.2019.04.17.09.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 09:18:18 -0700 (PDT)
Date:   Wed, 17 Apr 2019 09:18:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ruslan Babayev <ruslan@babayev.com>
Cc:     xe-linux-external@cisco.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] hwmon: (pmbus) add support for output voltage
 registers
Message-ID: <20190417161817.GA13109@roeck-us.net>
References: <20190416183620.39950-1-ruslan@babayev.com>
 <20190416195255.GC8093@roeck-us.net>
 <8736mhe6m9.fsf@babayev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736mhe6m9.fsf@babayev.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 06:57:18PM -0700, Ruslan Babayev wrote:
> Hi Guenter,
> 
> Thanks for taking the time to review these patches. Please see my
> comments inline.
> 
> Guenter Roeck writes:
> 
> > On Tue, Apr 16, 2019 at 11:36:16AM -0700, Ruslan Babayev wrote:
> >> +static ssize_t pmbus_show_operation(struct device *dev,
> >> +				    struct device_attribute *devattr, char *buf)
> >> +{
> >> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> >> +	struct pmbus_operation *operation = to_pmbus_operation(attr);
> >> +	struct i2c_client *client = to_i2c_client(dev->parent);
> >> +	int ret;
> >> +
> >> +	ret = pmbus_read_byte_data(client, operation->page, PMBUS_OPERATION);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	if (ret & PB_OPERATION_CONTROL_ON) {
> >> +		if (ret & PB_OPERATION_MARGIN_HIGH)
> >> +			return snprintf(buf, PAGE_SIZE, "high\n");
> >> +		else if (ret & PB_OPERATION_MARGIN_LOW)
> >> +			return snprintf(buf, PAGE_SIZE, "low\n");
> >> +		else
> >> +			return snprintf(buf, PAGE_SIZE, "on\n");
> >> +	} else {
> >> +			return snprintf(buf, PAGE_SIZE, "off\n");
> >> +	}
> >> +}
> >> +
> >> +static ssize_t pmbus_set_operation(struct device *dev,
> >> +				   struct device_attribute *devattr,
> >> +				   const char *buf, size_t count)
> >> +{
> >> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> >> +	struct pmbus_operation *operation = to_pmbus_operation(attr);
> >> +	struct i2c_client *client = to_i2c_client(dev->parent);
> >> +	int ret;
> >> +	u8 val;
> >> +
> >> +	/*
> >> +	 * sysfs_streq() doesn't need the \n's, but we add them so the strings
> >> +	 * will be shared with pmbus_show_operation() above.
> >> +	 */
> >
> > Saving a few bytes of data in the driver is not worth such limitations.
> > I would not want to have to deal with users sending "echo -n on" to the
> > driver and complain that it doesn't work.
> >
> 
> Sending "echo -n on" works just fine. sysfs_streq ignores \n's as
> mentioned in the comment. This was actually shamelessly stolen from
> drivers/regulator/virtual.c set_mode().
> 

Still not a reason to do this.

> >> +	if (sysfs_streq(buf, "on\n"))
> >> +		val = PB_OPERATION_CONTROL_ON;
> >> +	else if (sysfs_streq(buf, "off\n"))
> >> +		val = 0;
> >> +	else if (sysfs_streq(buf, "high\n"))
> >> +		val = PB_OPERATION_CONTROL_ON | PB_OPERATION_ACT_ON_FAULT |
> >> +		      PB_OPERATION_MARGIN_HIGH;
> >> +	else if (sysfs_streq(buf, "low\n"))
> >> +		val = PB_OPERATION_CONTROL_ON | PB_OPERATION_ACT_ON_FAULT |
> >> +		      PB_OPERATION_MARGIN_LOW;
> >> +	else
> >> +		return -EINVAL;
> >> +
> >> +	ret = pmbus_write_byte_data(client, operation->page,
> >> +				    PMBUS_OPERATION, val);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	return count;
> >> +}
> >> +
> > I am not convinced that it is a good idea to implement this as sysfs
> > attributes. It is notmally only used in manufacturing, and there the
> > registers can be acccessed directly.
> >
> > Either case, we can not implement this in the pmbus driver as generic code.
> > Operation commands are notoriously implemented with slight differences across
> > different devices. It would also probably be more appropriate to implement
> > as regulator, since it affects setting voltages, not limits.
> >
> 
> The OPERATION command as well as VOUT_COMMAND and VOUT_MARGIN_{HIGH,LOW}
> are standard registers specified in PMBus Spec Part II, Rev 1.2 Section
> 13. "Output Voltage Related Commands". The devices I have seen so far
> (the ones that support voltage margining) all seem to be compliant with
> the standard as far as the OPERATION register is concerned.
> 
> Some devices like TPS40422 use manufacturer specific registers instead of
> VOUT_MARGIN_{HIGH,LOW}. Those can be handled by overriding
> {read,write}_word_data to make it look standard to pmbus_core (as I have
> done in the PATCH 4/4)
> 
The more I think about it, the more I am convinced that it is a bad idea to
expose those values. It is not just about the hwmon subsystem, which again
is for monitoring, not for setting or enabling voltages. Much worse is that
your suggested code actually lets people _set_ arbitrary voltages. Write the
wrong value, and your board goes up in smoke (or fire). This goes way beyond
what the regulator subsystem permits, where voltages are (at least typically)
only adjustable within given limits.

On top of that, I would really argue that such attributes have no place
in a shipping system, ie should not be visible to users. The expected use case
for margin values is to be able to enable them during production tests.
But that does not (or should not) happen in the field.

Many if not most PMBus chips actually have such critical settings marked as
read-only, sometimes even password protected. Any shipping system should have
that protection enabled to prevent accidental writes into the chip registers.
At one of a previous employers, such write protection was not enabled. This
caused and i2cdump on the chip to reset it to manufacturing state, turning off
power to itself and thus turning the board into a brick. That is really not
something we would want to have exposed with sysfs attributes.

> >> +
> >> +static const struct pmbus_sensor_attr vout_attributes[] = {
> >> +	{
> >> +		.reg = PMBUS_VOUT_COMMAND,
> >> +		.class = PSC_VOLTAGE_OUT,
> >> +		.label = "command",
> >
> > Bad name for a label.
> 
> Could you please suggest a better name?
> 
"target" or "vout_target" maybe, for target voltage.

> >>  static int pmbus_find_attributes(struct i2c_client *client,
> >>  				 struct pmbus_data *data)
> >>  {
> >> @@ -1912,6 +2089,12 @@ static int pmbus_find_attributes(struct i2c_client *client,
> >>  	if (ret)
> >>  		return ret;
> >>
> >> +	/* Output Voltage sensors */
> >> +	ret = pmbus_add_vout_attrs(client, data, "out", vout_attributes,
> >> +				   ARRAY_SIZE(vout_attributes));
> >> +	if (ret)
> >> +		return ret;
> >> +
> >
> > The sensors you are adding are not output voltage sensors. They are not
> > sensors in the first place, and should probably not be reported as sensor
> > values. And setting voltages as limits is really not appropriate.
> >
> 
> I understand your concerns about exposing these registers as sysfs
> entries in hwmon. These devices _are_ voltage regulators, and these
> registers are not exactly "sensors", although a lot of the existing
> pmbus_core code can be reused by pretending they are. Like VOUT_MODE
> exponent handling, linear16 format etc.
> 

I understand, but code reusability isn't really a good argument here,
much less for exposing the values as hwmon sysfs attributes.

> I have looked at the regulator framework and into extending the
> pmbus_regulator_ops to support voltage margining with standard PMBUS
> VOUT_MARGIN registers. My predicament is that regulator framework
> 
> 1) Does NOT have the concept of "margining".
> 
> 2) Is not expected to be used at ALL on ACPI based systems. With ACPI
>    kernel assumes power control is done with Power Resource Objects
>    (ACPI section 7.1).
> 
> The latter is a bigger issue for us - our system is Intel based. It
> seems like sysfs attributes is our only option.
> 
> How would you feel if these registers (namely OPERATION and
> VOUT_MARGIN_{HIGH,LOW}) were exposed only in the drivers without making
> any changes to pmbus_core.c? Would these drivers have a chance of
> getting upstreamed? I hate the idea of maintaining out-of-tree drivers.
> 
Same thing. Again, I don't think the attributes should be exposed
to userspace in the first place. Please have a look at your use case.
The only use case I can imagine is manufacturing tests, and those can
use i2cset -f directly (potentially in conjunction with the necessary
commands to enable/disable write protection for the respective commands,
if the chip supports it).

Thanks,
Guenter
