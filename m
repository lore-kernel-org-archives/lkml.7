Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FB0C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E531620836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfLJSUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:20:15 -0500
Received: from foss.arm.com ([217.140.110.172]:52978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbfLJSUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:20:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B26FC1FB;
        Tue, 10 Dec 2019 10:20:14 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B318B3F6CF;
        Tue, 10 Dec 2019 10:20:13 -0800 (PST)
Date:   Tue, 10 Dec 2019 18:20:11 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 14/15] hwmon: (scmi-hwmon) Match scmi device by both name
 and protocol id
Message-ID: <20191210182011.GB20962@bogus>
References: <20191210145345.11616-1-sudeep.holla@arm.com>
 <20191210145345.11616-15-sudeep.holla@arm.com>
 <20191210180643.GA10944@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210180643.GA10944@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 10:06:43AM -0800, Guenter Roeck wrote:
> On Tue, Dec 10, 2019 at 02:53:44PM +0000, Sudeep Holla wrote:
> > The scmi bus now has support to match the driver with devices not only
> > based on their protocol id but also based on their device name if one is
> > available. This was added to cater the need to support multiple devices
> > and drivers for the same protocol.
> >
> > Let us add the name "hwmon" to scmi_device_id table in the driver so
> > that in matches only with device with the same name and protocol id
> > SCMI_PROTOCOL_SENSOR. This will help to add IIO support in parallel if
> > needed.
>
> If you are planning to re-implement the driver as iio driver, it would
> make more sense to drop the hwmon driver entirely and use the iio->hwmon
> bridge to access the sensors as hwmon devices if needed.
>

Ah, does it provides the same interface as hwmon to userspace ? Sorry but
I haven't spent much time looking at IIO yet, but since there are similar
needs to share protocol between subsystems in the kernel, this was just
an example that I listed as recently some requirement to add IIO SCMI
support had come up. If we can achieve hwmon kind of interface with iio->hwmon,
we should do that. We have other examples like devfreq and cpufreq, genpd
and regulators.

This patch is optional at least as of now (but good to have for completeness),
if the driver provides no name, we just match on protocol id only.

--
Regards,
Sudeep
