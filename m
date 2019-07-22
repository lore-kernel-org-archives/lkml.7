Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184F1C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87CD21955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563819778;
	bh=J9M7faZ41fDOYZssXZM6tk4l7o043dO6n8/RMOul8QQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uvF8wJrkPnNscOG4AIyxuHVVg1EDDYloQDaM6rE3ZMoG3JJmA+jJSEB2PKrCVTa7/
	 42ERiaJk8CpX4Zz9pOQ/JOaUjytNpx5H/ccjA3MDJC/aTkx8nDaPq9ZGuMd58g0FhT
	 OibIa8YhBVmTf3kPUYrrwnCLMj12hqLheQST6B0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbfGVSW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:22:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfGVSW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:22:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B52021901;
        Mon, 22 Jul 2019 18:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563819775;
        bh=J9M7faZ41fDOYZssXZM6tk4l7o043dO6n8/RMOul8QQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YlyyurH9m+xtpjE6DT+vlJNbAd1S2BPOTLxWBn89GnqD2uyJuv5XYTe2nU+DY0wV2
         awRf1tuM1dRG+t8rpdDPX36lb2irTphUakv8OwyH9vVXYqvS8VTJRh0PGPfHZpsXLK
         gWJ7eRbUoWwwWm6pXQaFOv7gx1WemlQNM+o8IwG0=
Date:   Mon, 22 Jul 2019 20:22:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, bhe@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tbroch@chromium.org
Subject: Re: [PATCH] power:sysfs: Expose device wakeup_event_count.
Message-ID: <20190722182252.GA24412@kroah.com>
References: <20190722180258.255949-1-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722180258.255949-1-ravisadineni@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:02:58AM -0700, Ravi Chandra Sadineni wrote:
> Device level event_count can help user level daemon to track if a
> praticular device has seen an wake interrupt during a suspend resume
> cycle. Thus expose it via sysfs.
> 
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---
>  Documentation/ABI/testing/sysfs-devices-power | 11 ++++++++++
>  drivers/base/power/sysfs.c                    | 20 +++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
> index 1ca04b4f0489..344549f4013f 100644
> --- a/Documentation/ABI/testing/sysfs-devices-power
> +++ b/Documentation/ABI/testing/sysfs-devices-power
> @@ -89,6 +89,17 @@ Description:
>  		attribute is not present. If the device is not enabled to wake
>  		up the system from sleep states, this attribute is empty.
>  
> +What:		/sys/devices/.../power/wakeup_event_count
> +Date:		July 2019
> +Contact:	Ravi Chandra sadineni <ravisadineni@chromium.org>
> +Description:
> +		The /sys/devices/.../wakeup_event_count attribute contains the
> +		number of signaled wakeup events associated with the device.
> +		This attribute is read-only. If the device is not capable to
> +		wake up the system from sleep states, this attribute is not
> +		present. If the device is not enabled to wake up the system
> +		from sleep states, this attribute is empty.

The attribute is not "empty" it returns just an empty line.

Is that really a good thing if you are expecting a number?

> +
>  What:		/sys/devices/.../power/wakeup_active_count
>  Date:		September 2010
>  Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index f42044d9711c..8dc1235b9784 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -357,6 +357,25 @@ static ssize_t wakeup_count_show(struct device *dev,
>  
>  static DEVICE_ATTR_RO(wakeup_count);
>  
> +static ssize_t wakeup_event_count_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	unsigned long count = 0;
> +	bool enabled = false;
> +
> +	spin_lock_irq(&dev->power.lock);
> +	if (dev->power.wakeup) {
> +		count = dev->power.wakeup->event_count;
> +		enabled = true;
> +	}
> +	spin_unlock_irq(&dev->power.lock);

Why do you need to lock?  The state and count can change right after the
lock, so what does this help with?

> +	return enabled ? sprintf(buf, "%lu\n", count) : sprintf(buf, "\n");

Use a real if statement please.

> +}
> +
> +static DEVICE_ATTR_RO(wakeup_event_count);
> +
> +
> +

too many empty lines :)

thanks,

greg k-h
