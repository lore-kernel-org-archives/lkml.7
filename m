Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B5EC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479F920651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7ywdT+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfEBVRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:17:12 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34373 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfEBVRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:17:11 -0400
Received: by mail-qk1-f193.google.com with SMTP id n68so2484904qka.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 14:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c3Ez0m140xSyDk6GZbTwnctygutWgb3T6pH0/CtvK4w=;
        b=a7ywdT+k1ux1SvuK+qGboaTCTI7J6QJ20MhPY0rJ2zB0V2XcblZHaeufsU89IvUsI0
         d+UaqjFFg4TSz89tYijt5dls3LnoTVtnMeNJs3HhN2/zFNGm+nDr+t7PMvH1/QH0wG1s
         O4sX+8U2tREWE81lXoKUciZ3oADU0FReHlCuy2bZqZOXFMcrthySmxwe+0dl3Q5YLNQV
         f8dUfNFbzcTB5J2wu5Tb2v2jwYxhDDgl8aGsF5L3GGomKsGVvy3AUng45Lz5ImXoLSll
         XFJ4ELRUCwSRUPEDCDd7NGxhYwus+gMmlvRVLEYygcyg1HZhSqyi0k7tlepIzAcZv0YB
         060A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3Ez0m140xSyDk6GZbTwnctygutWgb3T6pH0/CtvK4w=;
        b=GpUYLBVaqGqQJJRosFn0ypZB1I0nw2unK4VkjnIbnCsnHdf6/6Fvwd6UtJ6ECqDB/S
         FNDjttWkNe1jruk1WdPVf4TbjlsPMf/sUkx3fN/dazV8DyznKVlmriDTgMs7K6wk53hE
         mZJUG3YDB4FrbD7+sSc6ExCOgKbsJi6gTWmaszObLO6SSp1lq1ULaZZx0aLDZA8LaXcM
         N7U7q4szVVe3tP7JWx4Pb9BDLF94oswlQv9zM/jW5KDU1c4JMbjJYzQo0OYNxqnRloaR
         415+BgGfiLF9y+yQ4WGMgN+I5PXppD9QSvwX7ppmrdB6SUi1IbYNDghWYy74uQWsdXR9
         9XqQ==
X-Gm-Message-State: APjAAAVfj3sfEwZAVP9EJVXZvhf39JTQf70JQaIMNe08YqMIoMCsXheq
        SfxQnrlxFwfl0hKroPlbsTn+IMlvvekgQvAI3XWtlXzY
X-Google-Smtp-Source: APXvYqw1d9wl0Ck6MFqgZGLMr5IrPvFzLtNk4LY7BylzcDwY/kcUjzs+NUI+uZff2y9IL0cXD+zvI83oeYZXZxNANio=
X-Received: by 2002:ae9:e204:: with SMTP id c4mr4880515qkc.16.1556831830620;
 Thu, 02 May 2019 14:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190327182040.112651-1-twawrzynczak@chromium.org> <20190502160931.84177-1-twawrzynczak@chromium.org>
In-Reply-To: <20190502160931.84177-1-twawrzynczak@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 2 May 2019 23:16:59 +0200
Message-ID: <CAFqH_53OvUWN48Uwv7ofaZTB_6Upu6zjcNzfG-aNt1YaLJyyhg@mail.gmail.com>
Subject: Re: [PATCH v4] platform/chrome: mfd/cros_ec_debugfs: Add debugfs
 entry to retrieve EC uptime.
To:     Tim Wawrzynczak <twawrzynczak@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

Missatge de Tim Wawrzynczak <twawrzynczak@chromium.org> del dia dj., 2
de maig 2019 a les 18:10:
>
> The new debugfs entry 'uptime' is being made available to userspace so that
> a userspace daemon can synchronize EC logs with host time.
>
> Signed-off-by: Tim Wawrzynczak <twawrzynczak@chromium.org>
> ---
> Enric, is there something I can do to help speed this along?  This patch
> is useful for ChromeOS board bringup, and we would like to see it upstreamed
> if at all possible.
>

The last version looks good to me. The patch is in my list but is too
late for the next merge window. Will be one of the first patches I'll
queue for 5.3

Thanks,
 Enric

> Also, AFAIK only the cros_ec supports the 'uptime' command for now.
> And yes, the file does need to be seekable; the userspace daemon that
> consumes the file keeps the file open and seeks back to the beginning
> to get the latest uptime value.
> Based on your second response to v3, I kept the separate 'create_uptime'
> function b/c of the logic for checking support for the uptime command.
> Let me know if you'd like me to move all of that logic into _probe.
>
> Changelist from v3:
>  1) Don't check return values of debugfs_* functions.
>  2) Only expose 'uptime' file if EC supports it.
> ---
>  Documentation/ABI/testing/debugfs-cros-ec | 10 +++
>  drivers/platform/chrome/cros_ec_debugfs.c | 78 +++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-cros-ec
>
> diff --git a/Documentation/ABI/testing/debugfs-cros-ec b/Documentation/ABI/testing/debugfs-cros-ec
> new file mode 100644
> index 000000000000..24b781c67a4c
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-cros-ec
> @@ -0,0 +1,10 @@
> +What:          /sys/kernel/debug/cros_ec/uptime
> +Date:          March 2019
> +KernelVersion: 5.1
> +Description:
> +               Read-only.
> +               Reads the EC's current uptime information
> +               (using EC_CMD_GET_UPTIME_INFO) and prints
> +               time_since_ec_boot_ms into the file.
> +               This is used for synchronizing AP host time
> +               with the cros_ec log.
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index 71308766e891..226545a2150b 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -201,6 +201,50 @@ static int cros_ec_console_log_release(struct inode *inode, struct file *file)
>         return 0;
>  }
>
> +static int cros_ec_get_uptime(struct cros_ec_device *ec_dev, u32 *uptime)
> +{
> +       struct {
> +               struct cros_ec_command msg;
> +               struct ec_response_uptime_info resp;
> +       } __packed ec_buf;
> +       struct ec_response_uptime_info *resp;
> +       struct cros_ec_command *msg;
> +
> +       msg = &ec_buf.msg;
> +       resp = (struct ec_response_uptime_info *)msg->data;
> +
> +       msg->command = EC_CMD_GET_UPTIME_INFO;
> +       msg->version = 0;
> +       msg->insize = sizeof(*resp);
> +       msg->outsize = 0;
> +
> +       ret = cros_ec_cmd_xfer_status(ec_dev, msg);
> +       if (ret < 0)
> +               return ret;
> +
> +       *uptime = resp->time_since_ec_boot_ms;
> +       return 0;
> +}
> +
> +static ssize_t cros_ec_uptime_read(struct file *file,
> +                                  char __user *user_buf,
> +                                  size_t count,
> +                                  loff_t *ppos)
> +{
> +       struct cros_ec_debugfs *debug_info = file->private_data;
> +       struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
> +       char read_buf[32];
> +       int ret;
> +       u32 uptime;
> +
> +       ret = cros_ec_get_uptime(ec_dev, &uptime);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = scnprintf(read_buf, sizeof(read_buf), "%u\n", uptime);
> +       return simple_read_from_buffer(user_buf, count, ppos, read_buf, ret);
> +}
> +
>  static ssize_t cros_ec_pdinfo_read(struct file *file,
>                                    char __user *user_buf,
>                                    size_t count,
> @@ -269,6 +313,13 @@ const struct file_operations cros_ec_pdinfo_fops = {
>         .llseek = default_llseek,
>  };
>
> +const struct file_operations cros_ec_uptime_fops = {
> +       .owner = THIS_MODULE,
> +       .open = simple_open,
> +       .read = cros_ec_uptime_read,
> +       .llseek = default_llseek,
> +};
> +
>  static int ec_read_version_supported(struct cros_ec_dev *ec)
>  {
>         struct ec_params_get_cmd_versions_v1 *params;
> @@ -413,6 +464,29 @@ static int cros_ec_create_pdinfo(struct cros_ec_debugfs *debug_info)
>         return 0;
>  }
>
> +static int cros_ec_create_uptime(struct cros_ec_debugfs *debug_info)
> +{
> +       struct cros_ec_debugfs *debug_info = file->private_data;
> +       struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
> +       u32 uptime;
> +       int ret;
> +
> +       /*
> +        * If the EC does not support the uptime command, which is
> +        * indicated by xfer_status() returning -EINVAL, then no
> +        * debugfs entry will be created.
> +        */
> +       ret = cros_ec_get_uptime(ec_dev, &uptime);
> +
> +       if (ret == -EINVAL)
> +               return supported;
> +
> +       debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
> +                       &cros_ec_uptime_fops);
> +
> +       return 0;
> +}
> +
>  static int cros_ec_debugfs_probe(struct platform_device *pd)
>  {
>         struct cros_ec_dev *ec = dev_get_drvdata(pd->dev.parent);
> @@ -442,6 +516,10 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
>         if (ret)
>                 goto remove_log;
>
> +       ret = cros_ec_create_uptime(debug_info);
> +       if (ret)
> +               goto remove_log;
> +
>         ec->debug_info = debug_info;
>
>         dev_set_drvdata(&pd->dev, ec);
> --
> 2.20.1
>
