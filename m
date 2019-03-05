Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB66BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B281C2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="byS1Jc3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfCER7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:59:42 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36383 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfCER7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:59:41 -0500
Received: by mail-qt1-f196.google.com with SMTP id p25so9894585qtb.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 09:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ducrTQy4EJ6b45euawMl32eWMLfVfvh+YIze124RKAE=;
        b=byS1Jc3YZCkHmPzAXOXf0hgX/LRn16mjOZgtGzEyvr/W3sJ6EnRpsUzIR9KK+LmDy1
         hC1bicRY6oxYLPZ4OHe0WBI6uZRYD8yOKOhDevJYokVy8nul5LS+lagSxqH5AsMN6+4/
         dODYLyAceJPEi1n+Th9bweSNkSa4/w2smxAew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ducrTQy4EJ6b45euawMl32eWMLfVfvh+YIze124RKAE=;
        b=gUgPrAKShxTgBnv5T0oMAG6+D2+ogBfMnpglZpwJK2GmEQuEkQnUff0IgTeeHo+ri2
         3y3taMRyHTFeLFeHnFFyXcR78MIKpoIdWU8fK0H2J9jaUOSZDOOqmD2OdL3ulvROeO16
         htaKAyJAPMpkWIpGzR/R+/amDKkBSf6mszpYiQ+XRnlIm78VXL1gNVRD+j9KHRxpmJqA
         4CnIwmDiQKhMCK8XYk09ak1RNZabd+TJj2iKNOqDbAxwzxZPF4O9NkoKzE0CgiGCg3lM
         nsF9Izorm6XOirElb+IZKb+zs1w5A6WZbfAeL3i20nDaR7wShFUAPFRu+qj0nK6bgmeH
         BiCA==
X-Gm-Message-State: APjAAAU6si9qX/ofST9M5CSTvqi6mlzmBzIdPORdlMjJlQZ3313XOvKA
        U2E4KiYrs3yb80puMC/qbORpWSD/hZtivmuclrFK1g==
X-Google-Smtp-Source: APXvYqxQY+KLgD0JnQMxt/jOSQroH8Qt+K8LVaCvJEgcDw8pc3dDDia0aHz4TljrQh/IxCU3YNXOZ0d3uLxdERAou9M=
X-Received: by 2002:a0c:d968:: with SMTP id t37mr3025612qvj.195.1551808780420;
 Tue, 05 Mar 2019 09:59:40 -0800 (PST)
MIME-Version: 1.0
References: <CABXOdTdXcCeqkqcH69dG62mLmurbDOcrhhVGm6BgnBzR-1KETg@mail.gmail.com>
 <20190304005414.218310-1-ravisadineni@chromium.org> <CABXOdTdvMKGHoE5JQBLca_6V+ihRiUedgnyb2or8GraBDsKYWQ@mail.gmail.com>
 <CAEZbON6PtNKpLQB+B5S6rRKjnvBo2dHtdaSQzVCsk3aP9U9wVw@mail.gmail.com> <CAC0y+AgmxjQv5gm4Bc5mMhnX_PwrixGfraHxg+EGvZXhi2mGPg@mail.gmail.com>
In-Reply-To: <CAC0y+AgmxjQv5gm4Bc5mMhnX_PwrixGfraHxg+EGvZXhi2mGPg@mail.gmail.com>
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
Date:   Tue, 5 Mar 2019 09:59:29 -0800
Message-ID: <CAEZbON6Lcj2a4hVeQ-7BwmiCg-B-=ujeQ1aG+SKmWgjbT=aA9w@mail.gmail.com>
Subject: Re: [PATCH V2] cros_ec: Expose sysfile to force battery cut-off on shutdown.
To:     Daisuke Nojiri <dnojiri@google.com>
Cc:     Guenter Roeck <groeck@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Todd Broch <tbroch@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daisuke,

On Tue, Mar 5, 2019 at 9:29 AM Daisuke Nojiri <dnojiri@google.com> wrote:
>>
>> +       if (len =3D=3D 11 && !strncmp(buf, "at-shutdown", len)) {
>> +               param->flags =3D EC_BATTERY_CUTOFF_FLAG_AT_SHUTDOWN;
>> +       } else {
>> +               kfree(msg);
>> +               return -EINVAL;
>> +       }
>
>
> Why don't we just let the EC decide what flag is legal or illegal? If you=
 hard code 'at-shutdown', other calls to the sysfs will be blocked even if =
the EC supports other flags.
That might not be a wise option. Allowing random values can have
unintended effects. For example consider what would happen if write
random values to EC today.  Any flag value other than
EC_BATTERY_CUTOFF_FLAG_AT_SHUTDOWN will cause the battery to cutoff
immediately before the system shutdowns.
In future, if EC exposes more attributes, it will not be that
difficult to add support here.
>
> On Mon, Mar 4, 2019 at 5:00 PM Ravi Chandra Sadineni <ravisadineni@chromi=
um.org> wrote:
>>
>> Hi Guenter,
>>
>> On Sun, Mar 3, 2019 at 5:13 PM Guenter Roeck <groeck@google.com> wrote:
>> >
>> > On Sun, Mar 3, 2019 at 4:54 PM RaviChandra Sadineni <ravisadineni@chro=
mium.org> wrote:
>> >>
>> >> On chromebooks, power_manager daemon normally shutsdown(S5) the devic=
e
>> >> when the battery charge falls below 4% threshold. Chromeos EC then
>> >> normally spends an hour in S5 before hibernating. If the battery char=
ge
>> >> falls below critical threshold in the mean time, EC does a battery cu=
toff
>> >> instead of hibernating. On some chromebooks, S5 is optimal enough
>> >> resulting in EC hibernating without battery cut-off. This results in
>> >> battery deep-discharging. This is a bad user experience as battery
>> >> has to trickle charge before booting when the A.C is plugged in the n=
ext
>> >> time.
>> >>
>> >> This patch exposes a sysfs file for an userland daemon to suggest EC =
if it
>> >> has to do a battery cut-off instead of hibernating when the system en=
ters
>> >> S5 next time.
>> >>
>> >> Signed-off-by: RaviChandra Sadineni <ravisadineni@chromium.org>
>> >> ---
>> >> V2: Use kstrtobool() instead of kstrtou8() and add documentation.
>> >>
>> >>  .../ABI/testing/sysfs-class-chromeos          |  8 ++++
>> >>  drivers/platform/chrome/cros_ec_sysfs.c       | 37 +++++++++++++++++=
++
>> >>  2 files changed, 45 insertions(+)
>> >>  create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos
>> >>
>> >> diff --git a/Documentation/ABI/testing/sysfs-class-chromeos b/Documen=
tation/ABI/testing/sysfs-class-chromeos
>> >> new file mode 100644
>> >> index 000000000000..44d3cee6e7ae
>> >> --- /dev/null
>> >> +++ b/Documentation/ABI/testing/sysfs-class-chromeos
>> >> @@ -0,0 +1,8 @@
>> >> +What:           /sys/class/chromeos/cros_ec/cutoff_at_shutdown
>> >> +Date:           February 2019
>> >> +Contact:        Ravi Chandra Sadineni <ravisadineni@chromium.org>
>> >> +Description:
>> >> +                On writing '[Yy1]' to cutoff_at_shutdown property,
>> >> +                kernel sends a host command to EC requesting battery
>> >> +                cutoff on next shutdown. If AC is plugged in before
>> >> +                next shutdown, EC resets this flag.
>> >> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platfo=
rm/chrome/cros_ec_sysfs.c
>> >> index f34a50121064..f5168ce8bfc7 100644
>> >> --- a/drivers/platform/chrome/cros_ec_sysfs.c
>> >> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
>> >> @@ -322,14 +322,51 @@ static ssize_t kb_wake_angle_store(struct devic=
e *dev,
>> >>         return count;
>> >>  }
>> >>
>> >> +/* Battery cut-off control */
>> >> +static ssize_t cutoff_at_shutdown_store(struct device *dev,
>> >> +                                  struct device_attribute *attr,
>> >> +                                  const char *buf, size_t count)
>> >> +{
>> >> +       struct ec_params_battery_cutoff *param;
>> >> +       struct cros_ec_command *msg;
>> >> +       int ret;
>> >> +       struct cros_ec_dev *ec =3D container_of(
>> >> +                       dev, struct cros_ec_dev, class_dev);
>> >> +       bool cutoff_battery;
>> >> +
>> >> +       if (kstrtobool(buf, &cutoff_battery))
>> >> +               return -EINVAL;
>> >> +
>> >> +       if (!cutoff_battery)
>> >> +               return count;
>> >> +
>> >
>> >
>> > It is quite unusual to only be able to set this option, but not to be =
able to reset it. I think that warrants an explanation and reasoning. Also,=
 if clearing the flag is not supported, I would expect an attempt to do so =
to return an error. There should also be an explanation in the code explain=
ing why the attribute is write-only.
>> Added documentation for the reason behind making this flag write only.
>> Instead of taking a boolean value, made this attribute more generic
>> and took 'at-shutdown' as an option. This way it will be easy to
>> extend this sysfs api in the future (if EC exposes more attributes for
>> this host command).
>> >
>> > Guenter
>> >
>> >>
>> >> +       msg =3D kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL=
);
>> >> +       if (!msg)
>> >> +               return -ENOMEM;
>> >> +
>> >> +       param =3D (struct ec_params_battery_cutoff *)msg->data;
>> >> +       msg->command =3D EC_CMD_BATTERY_CUT_OFF + ec->cmd_offset;
>> >> +       msg->version =3D 1;
>> >> +       param->flags =3D EC_BATTERY_CUTOFF_FLAG_AT_SHUTDOWN;
>> >> +       msg->outsize =3D sizeof(*param);
>> >> +       msg->insize =3D 0;
>> >> +       ret =3D cros_ec_cmd_xfer_status(ec->ec_dev, msg);
>> >> +       kfree(msg);
>> >> +       if (ret < 0)
>> >> +               return ret;
>> >> +       return count;
>> >> +}
>> >> +
>> >>  /* Module initialization */
>> >>
>> >>  static DEVICE_ATTR_RW(reboot);
>> >>  static DEVICE_ATTR_RO(version);
>> >>  static DEVICE_ATTR_RO(flashinfo);
>> >>  static DEVICE_ATTR_RW(kb_wake_angle);
>> >> +static DEVICE_ATTR_WO(cutoff_at_shutdown);
>> >>
>> >>  static struct attribute *__ec_attrs[] =3D {
>> >> +       &dev_attr_cutoff_battery_at_shutdown.attr,
>> >>         &dev_attr_kb_wake_angle.attr,
>> >>         &dev_attr_reboot.attr,
>> >>         &dev_attr_version.attr,
>> >> --
>> >> 2.20.1
>> >>
>> Thanks,
>
>
>>
>> Ravi

Thanks,
Ravi
