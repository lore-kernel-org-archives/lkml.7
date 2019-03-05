Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F65C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9F1206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GfAEFuBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfCEBA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:00:58 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42134 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEBA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 20:00:58 -0500
Received: by mail-qt1-f196.google.com with SMTP id u7so7296203qtg.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 17:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hqcdjBWS50F0+4ER5Ih0aCsM9BzWMFWuyy6Tn7FMXnA=;
        b=GfAEFuBBTUfA9/BKb9HY6JZL2atmYCrkFqFZMNYLybnddXpYzf0afg3ktUFHNx0iqN
         qCX/1fpYYv3K59itsbXdOhk+9UG6XnyLwZIQ+hKph+NPZqjHuxdm1CDD2CW5fnnddLz6
         lLpsT7f5s5UpGm2/MqtHowoZFx2ssNQCSPVUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hqcdjBWS50F0+4ER5Ih0aCsM9BzWMFWuyy6Tn7FMXnA=;
        b=BlKCunlr8ej6EOpBvpDiYpw2VIfA10SntHbURM3bv+5HTJxDNRl3Efczmf4h01G6fj
         I0aNAETnwAKUopEiGUwLuZ4KaDYrnfJ+9s2YCHAXstVJYMP3MlpFFQxWpDN1y3279FpN
         xYf0s6r2uPStCXuGM8Zyvr/tabNgd6RBLAcCEw0w1xV0OBzS8KKAgXHmoug81XbaxiNj
         SYz1WlJh2wqSuOQHzMqZ3QyOn5bGgcv3+V53/aEiRWFhTXTymqjwd62O8ypAUvUs6lYx
         HFe1JlzYf5vbEXGqc1GIGlgx41QU68mrgKFeaZfR43gz07Wr8LDSXewZVLfQJtPoBUgZ
         sZpQ==
X-Gm-Message-State: APjAAAVEbCG0ZSC/DMyy22ae563iQqi0r+YKH8tw+cQuKkAr8cO4puvb
        JHBymJLzCYk0V4E9lCvW/Ahvtm8h85RuJFD54ZVvxA==
X-Google-Smtp-Source: APXvYqx9rjYpdDh3a3YwTb6V2yKtQcYQJw3AZ9GMn7TpRk3WNwUG9qzg2yZp1G0u77J268L/U5QZEdgN89rb2aTn//E=
X-Received: by 2002:ac8:2a39:: with SMTP id k54mr17023292qtk.26.1551747656842;
 Mon, 04 Mar 2019 17:00:56 -0800 (PST)
MIME-Version: 1.0
References: <CABXOdTdXcCeqkqcH69dG62mLmurbDOcrhhVGm6BgnBzR-1KETg@mail.gmail.com>
 <20190304005414.218310-1-ravisadineni@chromium.org> <CABXOdTdvMKGHoE5JQBLca_6V+ihRiUedgnyb2or8GraBDsKYWQ@mail.gmail.com>
In-Reply-To: <CABXOdTdvMKGHoE5JQBLca_6V+ihRiUedgnyb2or8GraBDsKYWQ@mail.gmail.com>
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
Date:   Mon, 4 Mar 2019 17:00:45 -0800
Message-ID: <CAEZbON6PtNKpLQB+B5S6rRKjnvBo2dHtdaSQzVCsk3aP9U9wVw@mail.gmail.com>
Subject: Re: [PATCH V2] cros_ec: Expose sysfile to force battery cut-off on shutdown.
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Todd Broch <tbroch@google.com>,
        Daisuke Nojiri <dnojiri@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Sun, Mar 3, 2019 at 5:13 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Sun, Mar 3, 2019 at 4:54 PM RaviChandra Sadineni <ravisadineni@chromiu=
m.org> wrote:
>>
>> On chromebooks, power_manager daemon normally shutsdown(S5) the device
>> when the battery charge falls below 4% threshold. Chromeos EC then
>> normally spends an hour in S5 before hibernating. If the battery charge
>> falls below critical threshold in the mean time, EC does a battery cutof=
f
>> instead of hibernating. On some chromebooks, S5 is optimal enough
>> resulting in EC hibernating without battery cut-off. This results in
>> battery deep-discharging. This is a bad user experience as battery
>> has to trickle charge before booting when the A.C is plugged in the next
>> time.
>>
>> This patch exposes a sysfs file for an userland daemon to suggest EC if =
it
>> has to do a battery cut-off instead of hibernating when the system enter=
s
>> S5 next time.
>>
>> Signed-off-by: RaviChandra Sadineni <ravisadineni@chromium.org>
>> ---
>> V2: Use kstrtobool() instead of kstrtou8() and add documentation.
>>
>>  .../ABI/testing/sysfs-class-chromeos          |  8 ++++
>>  drivers/platform/chrome/cros_ec_sysfs.c       | 37 +++++++++++++++++++
>>  2 files changed, 45 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-chromeos b/Documentat=
ion/ABI/testing/sysfs-class-chromeos
>> new file mode 100644
>> index 000000000000..44d3cee6e7ae
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-chromeos
>> @@ -0,0 +1,8 @@
>> +What:           /sys/class/chromeos/cros_ec/cutoff_at_shutdown
>> +Date:           February 2019
>> +Contact:        Ravi Chandra Sadineni <ravisadineni@chromium.org>
>> +Description:
>> +                On writing '[Yy1]' to cutoff_at_shutdown property,
>> +                kernel sends a host command to EC requesting battery
>> +                cutoff on next shutdown. If AC is plugged in before
>> +                next shutdown, EC resets this flag.
>> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/=
chrome/cros_ec_sysfs.c
>> index f34a50121064..f5168ce8bfc7 100644
>> --- a/drivers/platform/chrome/cros_ec_sysfs.c
>> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
>> @@ -322,14 +322,51 @@ static ssize_t kb_wake_angle_store(struct device *=
dev,
>>         return count;
>>  }
>>
>> +/* Battery cut-off control */
>> +static ssize_t cutoff_at_shutdown_store(struct device *dev,
>> +                                  struct device_attribute *attr,
>> +                                  const char *buf, size_t count)
>> +{
>> +       struct ec_params_battery_cutoff *param;
>> +       struct cros_ec_command *msg;
>> +       int ret;
>> +       struct cros_ec_dev *ec =3D container_of(
>> +                       dev, struct cros_ec_dev, class_dev);
>> +       bool cutoff_battery;
>> +
>> +       if (kstrtobool(buf, &cutoff_battery))
>> +               return -EINVAL;
>> +
>> +       if (!cutoff_battery)
>> +               return count;
>> +
>
>
> It is quite unusual to only be able to set this option, but not to be abl=
e to reset it. I think that warrants an explanation and reasoning. Also, if=
 clearing the flag is not supported, I would expect an attempt to do so to =
return an error. There should also be an explanation in the code explaining=
 why the attribute is write-only.
Added documentation for the reason behind making this flag write only.
Instead of taking a boolean value, made this attribute more generic
and took 'at-shutdown' as an option. This way it will be easy to
extend this sysfs api in the future (if EC exposes more attributes for
this host command).
>
> Guenter
>
>>
>> +       msg =3D kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL);
>> +       if (!msg)
>> +               return -ENOMEM;
>> +
>> +       param =3D (struct ec_params_battery_cutoff *)msg->data;
>> +       msg->command =3D EC_CMD_BATTERY_CUT_OFF + ec->cmd_offset;
>> +       msg->version =3D 1;
>> +       param->flags =3D EC_BATTERY_CUTOFF_FLAG_AT_SHUTDOWN;
>> +       msg->outsize =3D sizeof(*param);
>> +       msg->insize =3D 0;
>> +       ret =3D cros_ec_cmd_xfer_status(ec->ec_dev, msg);
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
>> +static DEVICE_ATTR_WO(cutoff_at_shutdown);
>>
>>  static struct attribute *__ec_attrs[] =3D {
>> +       &dev_attr_cutoff_battery_at_shutdown.attr,
>>         &dev_attr_kb_wake_angle.attr,
>>         &dev_attr_reboot.attr,
>>         &dev_attr_version.attr,
>> --
>> 2.20.1
>>
Thanks,
Ravi
