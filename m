Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12464C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0F82087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfC0MDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:03:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47762 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfC0MDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:03:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 27CC726074C
Subject: Re: [PATCH v2] platform/chrome: mfd/cros_ec_sysfs: Add sysfs entry to
 retrieve EC uptime.
To:     twawrzynczak@chromium.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20190325170250.2547-1-twawrzynczak@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <ca17b1c0-18a3-6c78-7a1b-28035a98aad8@collabora.com>
Date:   Wed, 27 Mar 2019 13:03:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325170250.2547-1-twawrzynczak@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On 25/3/19 18:02, twawrzynczak@chromium.org wrote:
> From: Tim Wawrzynczak <twawrzynczak@chromium.org>
> 
> The new sysfs entry 'uptime' is being made available to userspace so that
> a userspace daemon can synchronize EC logs with host time.
> 
> Signed-off-by: Tim Wawrzynczak <twawrzynczak@chromium.org>
> ---
> Enric, the use case for this is ChromeOS's userspace daemon, timberslide,
> which collects the EC logs for sending bug reports, etc.  This is part of
> a series of patches which is prefixing host timestamps before each EC
> log line.  The daemon matches up the EC log lines' seconds-since-boot
> with the time gotten from the new 'uptime' node and calculates the
> host time that the log line was printed at.

The EC log is under debugfs (I assume that the daemon reads the log from there)
so I think that this new attribute should be in debugfs instead of sysfs.

Also would be good if you can document this interface, I know that current
debugfs interface for cros-ec is not documented, but if you can at least start
documenting the ABI I'd appreciate. (Documentation/ABI/testing/debugfs-cros-ec)

Please add a changelog so is more to track what changed from v1 to v2.

> ---
>  drivers/platform/chrome/cros_ec_sysfs.c | 34 +++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
> index fe0b7614ae1b..b3915d3287c5 100644
> --- a/drivers/platform/chrome/cros_ec_sysfs.c
> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> @@ -107,6 +107,38 @@ static ssize_t reboot_store(struct device *dev,
>  	return count;
>  }
>  
> +static ssize_t uptime_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	struct ec_response_uptime_info *resp;
> +	struct cros_ec_command *msg;
> +	int ret;
> +	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
> +	u32 time_since_ec_boot_ms;
> +

Please sort function local variables declaration in a reverse christmas
tree order:

        <type_a> longest_variable_name;
        <type_b> shorter_var_name;
        <type_c> even_shorter;
        <type_d> i;

> +	msg = kmalloc(sizeof(*msg) + sizeof(*resp), GFP_KERNEL);

kzmalloc ?

> +	if (!msg)
> +		return -ENOMEM;
> +
> +	/* Get EC uptime information */
> +	msg->version = 0;

Not needed if you use kzmalloc.

> +	msg->command = EC_CMD_GET_UPTIME_INFO + ec->cmd_offset;
> +	msg->insize = sizeof(*resp);
> +	msg->outsize = 0;

Not needed if you use kzmalloc.

> +	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> +	if (ret < 0) {
> +		time_since_ec_boot_ms = 0;

You didn't take in consideration my comments on v1 ...

That an error (because the command is not supported or other
reason). You're overlaping the error. Why not just goto an exit label, free the
memory and return the error.

Or there is a problem on returning an error?

> +	} else {

Then that else is not needed.

> +		resp = (struct ec_response_uptime_info *)msg->data;
> +		time_since_ec_boot_ms = resp->time_since_ec_boot_ms;

And you can remove time_since_ec_boot_ms
> +	}
> +
> +	ret = scnprintf(buf, PAGE_SIZE, "%u\n", time_since_ec_boot_ms);

And print directly resp->time_since_ec_boot_ms

> +
> +	kfree(msg);
> +	return ret;
> +}
> +
>  static ssize_t version_show(struct device *dev,
>  			    struct device_attribute *attr, char *buf)
>  {
> @@ -314,12 +346,14 @@ static DEVICE_ATTR_RW(reboot);
>  static DEVICE_ATTR_RO(version);
>  static DEVICE_ATTR_RO(flashinfo);
>  static DEVICE_ATTR_RW(kb_wake_angle);
> +static DEVICE_ATTR_RO(uptime);
>  
>  static struct attribute *__ec_attrs[] = {
>  	&dev_attr_kb_wake_angle.attr,
>  	&dev_attr_reboot.attr,
>  	&dev_attr_version.attr,
>  	&dev_attr_flashinfo.attr,
> +	&dev_attr_uptime.attr,

Would be good if we can make this attribute only visible when is supported. I am
not sure if is possible though.

>  	NULL,
>  };
>  
> 

Thanks,
 Enric

