Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788F4C28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEFF20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfFFLPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 07:15:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57620 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfFFLPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 07:15:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2C3F528546F
Subject: Re: [PATCH v4] platform/chrome: mfd/cros_ec_debugfs: Add debugfs
 entry to retrieve EC uptime.
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20190327182040.112651-1-twawrzynczak@chromium.org>
 <20190502160931.84177-1-twawrzynczak@chromium.org>
 <CAFqH_53OvUWN48Uwv7ofaZTB_6Upu6zjcNzfG-aNt1YaLJyyhg@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <b3b51df5-916a-3b28-81a8-ab77546a5719@collabora.com>
Date:   Thu, 6 Jun 2019 13:15:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFqH_53OvUWN48Uwv7ofaZTB_6Upu6zjcNzfG-aNt1YaLJyyhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

Sorry for making you wait so much, now that the patches about cros_ec_commands
include file has been accepted and the struct is up-to-date I can manage this.
I've some few comments though, one of them is a change I requested but that now
we should revert (sorry about that)

Please rebase the patch on top of chrome-platform-5.3, there are trivial conflicts.

On 2/5/19 23:16, Enric Balletbo Serra wrote:
> Hi Tim,
> 
> Missatge de Tim Wawrzynczak <twawrzynczak@chromium.org> del dia dj., 2
> de maig 2019 a les 18:10:
>>
>> The new debugfs entry 'uptime' is being made available to userspace so that
>> a userspace daemon can synchronize EC logs with host time.
>>
>> Signed-off-by: Tim Wawrzynczak <twawrzynczak@chromium.org>
>> ---
>> Enric, is there something I can do to help speed this along?  This patch
>> is useful for ChromeOS board bringup, and we would like to see it upstreamed
>> if at all possible.
>>
> 
> The last version looks good to me. The patch is in my list but is too
> late for the next merge window. Will be one of the first patches I'll
> queue for 5.3
> 
> Thanks,
>  Enric
> 
>> Also, AFAIK only the cros_ec supports the 'uptime' command for now.
>> And yes, the file does need to be seekable; the userspace daemon that
>> consumes the file keeps the file open and seeks back to the beginning
>> to get the latest uptime value.
>> Based on your second response to v3, I kept the separate 'create_uptime'
>> function b/c of the logic for checking support for the uptime command.
>> Let me know if you'd like me to move all of that logic into _probe.
>>
>> Changelist from v3:
>>  1) Don't check return values of debugfs_* functions.
>>  2) Only expose 'uptime' file if EC supports it.
>> ---
>>  Documentation/ABI/testing/debugfs-cros-ec | 10 +++
>>  drivers/platform/chrome/cros_ec_debugfs.c | 78 +++++++++++++++++++++++
>>  2 files changed, 88 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/debugfs-cros-ec
>>
>> diff --git a/Documentation/ABI/testing/debugfs-cros-ec b/Documentation/ABI/testing/debugfs-cros-ec
>> new file mode 100644
>> index 000000000000..24b781c67a4c
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/debugfs-cros-ec
>> @@ -0,0 +1,10 @@
>> +What:          /sys/kernel/debug/cros_ec/uptime

Although for now only cros_ec supports it, let's use <cros-ec-device> for
possible future uses.

/sys/kernel/debug/<cros-ec-device>/uptime

>> +Date:          March 2019
>> +KernelVersion: 5.1

Will be 5.3

>> +Description:
>> +               Read-only.
>> +               Reads the EC's current uptime information
>> +               (using EC_CMD_GET_UPTIME_INFO) and prints
>> +               time_since_ec_boot_ms into the file.
>> +               This is used for synchronizing AP host time
>> +               with the cros_ec log.
>> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
>> index 71308766e891..226545a2150b 100644
>> --- a/drivers/platform/chrome/cros_ec_debugfs.c
>> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
>> @@ -201,6 +201,50 @@ static int cros_ec_console_log_release(struct inode *inode, struct file *file)
>>         return 0;
>>  }
>>
>> +static int cros_ec_get_uptime(struct cros_ec_device *ec_dev, u32 *uptime)
>> +{
>> +       struct {
>> +               struct cros_ec_command msg;
>> +               struct ec_response_uptime_info resp;
>> +       } __packed ec_buf;
>> +       struct ec_response_uptime_info *resp;
>> +       struct cros_ec_command *msg;
>> +
>> +       msg = &ec_buf.msg;
>> +       resp = (struct ec_response_uptime_info *)msg->data;
>> +
>> +       msg->command = EC_CMD_GET_UPTIME_INFO;
>> +       msg->version = 0;
>> +       msg->insize = sizeof(*resp);
>> +       msg->outsize = 0;
>> +
>> +       ret = cros_ec_cmd_xfer_status(ec_dev, msg);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       *uptime = resp->time_since_ec_boot_ms;
>> +       return 0;
>> +}
>> +
>> +static ssize_t cros_ec_uptime_read(struct file *file,
>> +                                  char __user *user_buf,
>> +                                  size_t count,
>> +                                  loff_t *ppos)
>> +{
>> +       struct cros_ec_debugfs *debug_info = file->private_data;
>> +       struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
>> +       char read_buf[32];
>> +       int ret;
>> +       u32 uptime;
>> +
>> +       ret = cros_ec_get_uptime(ec_dev, &uptime);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       ret = scnprintf(read_buf, sizeof(read_buf), "%u\n", uptime);
>> +       return simple_read_from_buffer(user_buf, count, ppos, read_buf, ret);
>> +}
>> +
>>  static ssize_t cros_ec_pdinfo_read(struct file *file,
>>                                    char __user *user_buf,
>>                                    size_t count,
>> @@ -269,6 +313,13 @@ const struct file_operations cros_ec_pdinfo_fops = {
>>         .llseek = default_llseek,
>>  };
>>
>> +const struct file_operations cros_ec_uptime_fops = {
>> +       .owner = THIS_MODULE,
>> +       .open = simple_open,
>> +       .read = cros_ec_uptime_read,
>> +       .llseek = default_llseek,
>> +};
>> +
>>  static int ec_read_version_supported(struct cros_ec_dev *ec)
>>  {
>>         struct ec_params_get_cmd_versions_v1 *params;
>> @@ -413,6 +464,29 @@ static int cros_ec_create_pdinfo(struct cros_ec_debugfs *debug_info)
>>         return 0;
>>  }
>>
>> +static int cros_ec_create_uptime(struct cros_ec_debugfs *debug_info)
>> +{
>> +       struct cros_ec_debugfs *debug_info = file->private_data;
>> +       struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
>> +       u32 uptime;
>> +       int ret;
>> +
>> +       /*
>> +        * If the EC does not support the uptime command, which is
>> +        * indicated by xfer_status() returning -EINVAL, then no
>> +        * debugfs entry will be created.
>> +        */
>> +       ret = cros_ec_get_uptime(ec_dev, &uptime);
>> +
>> +       if (ret == -EINVAL)
>> +               return supported;

That doesn't apply anymore, xfer_status will not return -EINVAL (sorry to make
you change this before)

>> +
>> +       debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
>> +                       &cros_ec_uptime_fops);
>> +
>> +       return 0;
>> +}
>> +


Let's remove this function and just do

>>  static int cros_ec_debugfs_probe(struct platform_device *pd)
>>  {
>>         struct cros_ec_dev *ec = dev_get_drvdata(pd->dev.parent);
>> @@ -442,6 +516,10 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
>>         if (ret)
>>                 goto remove_log;
>>


If the command fails just don't create the file silently. No need to remove the
other files just because this fails.

if (cros_ec_get_uptime() == 0)
    debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
                        &cros_ec_uptime_fops);

Thanks,
 Enric

>> +       ret = cros_ec_create_uptime(debug_info);
>> +       if (ret)
>> +               goto remove_log;
>> +
>>         ec->debug_info = debug_info;
>>
>>         dev_set_drvdata(&pd->dev, ec);
>> --
>> 2.20.1
>>
