Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E27C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF00920663
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfDHL3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:29:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45256 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfDHL3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:29:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 521C1260641
Subject: Re: [PATCH v3] platform/chrome: mfd/cros_ec_debugfs: Add debugfs
 entry to retrieve EC uptime.
To:     Tim Wawrzynczak <twawrzynczak@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@google.com>
References: <20190327182040.112651-1-twawrzynczak@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <147049bd-d661-bb6d-9631-fc15c5b4c9bb@collabora.com>
Date:   Mon, 8 Apr 2019 13:29:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190327182040.112651-1-twawrzynczak@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

Many thanks for sending this patch upstream, some comments below

On 27/3/19 19:20, Tim Wawrzynczak wrote:
> The new debugfs entry 'uptime' is being made available to userspace so that
> a userspace daemon can synchronize EC logs with host time.
> 
> Signed-off-by: Tim Wawrzynczak <twawrzynczak@chromium.org>
> ---
> Changelist:
>  - Moved uptime file from sysfs to debugfs (/sys/kernel/debug/cros_ec/uptime)
>  - Fixed ordering of local variables in cros_ec_uptime_read.
> Tested against ChromeOS kernel v4.14
> ---
>  Documentation/ABI/testing/debugfs-cros-ec | 10 +++++
>  drivers/platform/chrome/cros_ec_debugfs.c | 54 +++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-cros-ec
> 
> diff --git a/Documentation/ABI/testing/debugfs-cros-ec b/Documentation/ABI/testing/debugfs-cros-ec
> new file mode 100644
> index 000000000000..24b781c67a4c
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-cros-ec

Thanks to introduce the documentation!

> @@ -0,0 +1,10 @@
> +What:		/sys/kernel/debug/cros_ec/uptime

Is that propriety only supported for the standard cros-ec?

If the answer is yes, is fine, but if this could be supported for other variants
like cros_pd, cros_tp, cros_fp, cros_ish, etc. then I'd name it

/sys/kernel/debug/<ec-device-name>/uptime


> +Date:		March 2019
> +KernelVersion:	5.1
> +Description:
> +		Read-only.
> +		Reads the EC's current uptime information
> +		(using EC_CMD_GET_UPTIME_INFO) and prints
> +		time_since_ec_boot_ms into the file.
> +		This is used for synchronizing AP host time
> +		with the cros_ec log.
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index 71308766e891..3ea42008a59e 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -201,6 +201,40 @@ static int cros_ec_console_log_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +static ssize_t cros_ec_uptime_read(struct file *file,
> +				   char __user *user_buf,
> +				   size_t count,
> +				   loff_t *ppos)
> +{
> +	struct cros_ec_debugfs *debug_info = file->private_data;
> +	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
> +	struct {
> +		struct cros_ec_command msg;
> +		struct ec_response_uptime_info resp;
> +	} __packed ec_buf;
> +	struct ec_response_uptime_info *resp;
> +	struct cros_ec_command *msg;
> +	char read_buf[32];
> +	int ret;
> +
> +	msg = &ec_buf.msg;
> +	resp = (struct ec_response_uptime_info *)msg->data;
> +
> +	msg->command = EC_CMD_GET_UPTIME_INFO;
> +	msg->version = 0;
> +	msg->insize = sizeof(*resp);
> +	msg->outsize = 0;
> +
> +	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = scnprintf(read_buf, sizeof(read_buf), "%u\n",
> +			resp->time_since_ec_boot_ms);
> +
> +	return simple_read_from_buffer(user_buf, count, ppos, read_buf, ret);
> +}
> +
>  static ssize_t cros_ec_pdinfo_read(struct file *file,
>  				   char __user *user_buf,
>  				   size_t count,
> @@ -269,6 +303,13 @@ const struct file_operations cros_ec_pdinfo_fops = {
>  	.llseek = default_llseek,
>  };
>  
> +const struct file_operations cros_ec_uptime_fops = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.read = cros_ec_uptime_read,
> +	.llseek = default_llseek,

Should this file be seekable?

> +};
> +
>  static int ec_read_version_supported(struct cros_ec_dev *ec)
>  {
>  	struct ec_params_get_cmd_versions_v1 *params;
> @@ -413,6 +454,15 @@ static int cros_ec_create_pdinfo(struct cros_ec_debugfs *debug_info)
>  	return 0;
>  }
>  
> +static int cros_ec_create_uptime(struct cros_ec_debugfs *debug_info)
> +{
> +	if (!debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
> +				&cros_ec_uptime_fops))
> +		return -ENOMEM;

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this. This has been discussed recently on
the LKML.

I know that this is currently wrong for the other entries in this file but let's
try to do well and remove this function and just call debugfs_create_file in probe.

I plan to send patches to fix current status.

> +
> +	return 0;
> +}
> +
>  static int cros_ec_debugfs_probe(struct platform_device *pd)
>  {
>  	struct cros_ec_dev *ec = dev_get_drvdata(pd->dev.parent);
> @@ -442,6 +492,10 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
>  	if (ret)
>  		goto remove_log;
>  
> +	ret = cros_ec_create_uptime(debug_info);
> +	if (ret)
> +		goto remove_log;
> +

       debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
                           &cros_ec_uptime_fops);

>  	ec->debug_info = debug_info;
>  
>  	dev_set_drvdata(&pd->dev, ec);
> 

Thanks,
 Enric

