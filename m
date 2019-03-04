Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FBBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 01:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA53E20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 01:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HBHs1ZR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfCDBCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 20:02:55 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43593 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfCDBCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 20:02:55 -0500
Received: by mail-qk1-f196.google.com with SMTP id f196so1951130qke.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 17:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZ8L3AK9nFah5RoucXb6574z84G9P6bkJYPZQpK8AT8=;
        b=HBHs1ZR1YNljbbrzpAgI/qvoSerqyAXQ8MHxX7H/APi3g4RWDGSt2pMGaaPMtApOkF
         HrfiNqiaDUOp08rpbo8Wb5k3qFzq8x+/5Z5oOaMUi+kPnkRvKWL+DEeUY3ILKIU0Gjlq
         jH44jctnJ85yfPrX/UkYZ8BEobUHjU1C10wBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZ8L3AK9nFah5RoucXb6574z84G9P6bkJYPZQpK8AT8=;
        b=JCf26KqzlLhUvA2RypEs+HRNZ8YnIiigFlHfbm5kcgTKy1XDc1sUkrbjUPgbAtJTHg
         yUh5iuLjAjbw9Sy/czOBjNorCVncMa5tYaONbLkHoDgRqq3Clsipi10vacKtm6hM1hyb
         TeN7CQYp5IUHJbPBLvOTT0vkgaxTIq9sLhGe4s5Tutm8RiSA6aAzPrKAawLJpEphENS7
         xE5kQLbhKLBC/9W/8526xyRD39Mn4TWjjLO9M8SCdis76QwcUf0ESf6ufkzy6lH4t5Mj
         GmGV3ljsQLXhOezjm3twp3Kw8kx6LsI8UtD/Fbrnh9dXHiFsNGLooLhwFmFwG+AEP3Im
         qiWw==
X-Gm-Message-State: APjAAAU7QwSnoWyX+ko46Or9sl9/o9laIwjhIwH69KNAEHbPqH7HvQWo
        Iv+Yex/AQyhPvDJK5nQEOFx/KBx8CEWypKuCYByV8A==
X-Google-Smtp-Source: APXvYqzK96pGBbOLVgfBAvhC4OKzTq5rxyEe77jdyCkQW+RWrJ0EqabPEFMppPTHj+HgM5vTnoSiSC1VJvY5mRdLNrs=
X-Received: by 2002:a37:4f44:: with SMTP id d65mr11441082qkb.287.1551661373752;
 Sun, 03 Mar 2019 17:02:53 -0800 (PST)
MIME-Version: 1.0
References: <20190301192156.253010-1-ravisadineni@chromium.org> <CABXOdTdXcCeqkqcH69dG62mLmurbDOcrhhVGm6BgnBzR-1KETg@mail.gmail.com>
In-Reply-To: <CABXOdTdXcCeqkqcH69dG62mLmurbDOcrhhVGm6BgnBzR-1KETg@mail.gmail.com>
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
Date:   Sun, 3 Mar 2019 17:02:42 -0800
Message-ID: <CAEZbON7ugRGpFuj6mwHoSqdyYNFyNKEsGkhFjV7XuwsW28JXcQ@mail.gmail.com>
Subject: Re: [PATCH] cros_ec: Expose sysfile to force battery cut-off on shutdown.
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Todd Broch <tbroch@google.com>,
        Daisuke Nojiri <dnojiri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Fri, Mar 1, 2019 at 1:00 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Fri, Mar 1, 2019 at 11:22 AM RaviChandra Sadineni <ravisadineni@chromium.org> wrote:
>>
>> On chromebooks, power_manager daemon normally shutsdown(S5) the device
>> when the battery charge falls below 4% threshold. ChromeOS EC then
>> normally spends an hour in S5 before hibernating. If the battery charge
>> falls below critical threshold in the mean time, EC does a battery cutoff
>> instead of hibernating. On some chromebooks, S5 is optimal enough
>> resulting in EC hibernating without battery cut-off. This results in
>> battery deep-discharging. This is a bad user experience as battery
>> has to trickle charge before booting when the A.C is plugged in the next
>> time.
>>
>> This patch exposes a sysfs file for an userland daemon to suggest EC if it
>> has to do a battery cut-off instead of hibernating when the system enters
>> S5 next time.
>>
>> Signed-off-by: RaviChandra Sadineni <ravisadineni@chromium.org>
>> ---
>>  drivers/platform/chrome/cros_ec_sysfs.c | 34 +++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
>> index f34a50121064..151c7c143941 100644
>> --- a/drivers/platform/chrome/cros_ec_sysfs.c
>> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
>> @@ -322,14 +322,48 @@ static ssize_t kb_wake_angle_store(struct device *dev,
>>         return count;
>>  }
>>
>> +/* Battery cut-off control */
>> +static ssize_t cutoff_battery_at_shutdown_store(struct device *dev,
>> +                                  struct device_attribute *attr,
>> +                                  const char *buf, size_t count)
>> +{
>> +       struct ec_params_battery_cutoff *param;
>> +       struct cros_ec_command *msg;
>> +       int ret;
>> +       struct cros_ec_dev *ec = container_of(
>> +                       dev, struct cros_ec_dev, class_dev);
>> +       uint8_t cutoff_battery;
>> +
>> +       if (kstrtou8(buf, 10, &cutoff_battery) || (cutoff_battery != 1))
>
>
> Excessive ( ). Also, why not kstrtobool() ?
Done.
>
>>
>> +               return -EINVAL;
>> +
>>
>> +       msg = kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL);
>> +       if (!msg)
>> +               return -ENOMEM;
>> +
>> +       param = (struct ec_params_battery_cutoff *)msg->data;
>> +       msg->command = EC_CMD_BATTERY_CUT_OFF + ec->cmd_offset;
>> +       msg->version = 1;
>> +       param->flags = EC_BATTERY_CUTOFF_FLAG_AT_SHUTDOWN;
>
>
> For some reason I fail to see where cutoff_battery is used to determine what to send to the EC. Am I missing something ?
Currently there is no way to reset the flag. i.e EC does not expose a
console command to reset the flag once set. So I intend to accept only
true bool flag. Is there a better way to do this ?
>
>>
>> +       msg->outsize = sizeof(*param);
>> +       msg->insize = 0;
>> +       ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
>> +       kfree(msg);
>> +       if (ret < 0)
>> +               return ret;
>> +       return count;
>> +}
>> +
>>  /* Module initialization */
>>
>>  static DEVICE_ATTR_RW(reboot);
>>  static DEVICE_ATTR_RO(version);
>>  static DEVICE_ATTR_RO(flashinfo);
>>  static DEVICE_ATTR_RW(kb_wake_angle);
>> +static DEVICE_ATTR_WO(cutoff_battery_at_shutdown);
>>
>
> I personally dislike excessively long sysfs attribute names. I would prefer to see a shorter name and have it documented in Documentation/ABI/testing/sysfs-class-chromeos.
>
> Is WO really desirable and warranted here ?
Currently EC does not expose a host command to read the status.
Maintaining the state in the kernel might not work as the state can go
out of sync. For example, when AC is plugged in, EC resets the flag
and the kernel will not be aware of it.
>
>>
>>  static struct attribute *__ec_attrs[] = {
>> +       &dev_attr_cutoff_battery_at_shutdown.attr,
>>         &dev_attr_kb_wake_angle.attr,
>>         &dev_attr_reboot.attr,
>>         &dev_attr_version.attr,
>> --
>> 2.20.1
>>

Thanks,
Ravi
