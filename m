Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29895C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD8021874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI/8LhGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfCUQF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:05:26 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35441 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:05:26 -0400
Received: by mail-qk1-f195.google.com with SMTP id z13so16611964qki.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bKA785beao5hOykthPgzrgxeN4zmg34B2DzLO4cEfgw=;
        b=mI/8LhGSl7puk3MVLQ+0EqzC/RJqwt4n7cqIK8qMOKmzPOHgpKErJRGqb6V9iIKY/9
         7sxzebsghyJyHU6bIfMpI654Sh/P8jxDLF5ifamEoikfU1mYf6PZUyTm9kPqohBU1fqv
         edkTmmlhHA8nCOeAiEabdyPz5Gs/hgPPPDKxns4qD0iVvm9zH31lFLQixnMmol5qM4df
         KJtzF5IAYVu8UCOFo8MA8JhVNPQRe10DWuioE5db/xL+tMqXBfnu4HEXhmwnRqxR43Gr
         sw0xCx/qaZmIah1gylsyAwUrdkskqtXGVCnCpet5FUSaBO/yBgb3ZPi4qL/VAmLlgz7A
         xFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bKA785beao5hOykthPgzrgxeN4zmg34B2DzLO4cEfgw=;
        b=F4QO0XhnwizP5YKcjeAnnh6/RsFrt0q0DLmC5jJ/xxb1S9BeZcfAm7bjp+ugSqMC7c
         InhI4NmBGthGbK0NuKxVYN99JU+l8+Y2tWxpdwCmdkqLwjmK91kTNm5e0IXcF4oU2wk+
         apg34JyHXHOvhDBAh33Y6IunrO3eyv4Uu8Rvqm3snU81aARZO9+nSj6Q6ExWPwBXqNtB
         sQBnQhgxm6qm+Jtu5cdm9at54Ihuni2xfKNYHZ/RQfQ1NvFT8Fykwphwk4aj58xPFqjq
         zruWGDSxz5xpcQvk4YJM4hUm7swvisM3YBHv9xCxaXSUhpNj01rkKDMwhkvCzwyQYCml
         9yhQ==
X-Gm-Message-State: APjAAAX+UjQxz+zGCOCXtHonasSn8+HhcFcsyGcchVbv7T1ELlSAEkmM
        bdrmVM9IKM14V1bakxZP4VS0qmd71vhh3lz14G4=
X-Google-Smtp-Source: APXvYqwFjCFXlrFNj1Tch0iJc4Rk7mzFIk8pYBXlrGDI21EOo+7leLSbSwk6mv/R0rxuckqV++7eXO+TIRqXnzbZYUU=
X-Received: by 2002:a05:620a:1597:: with SMTP id d23mr3483942qkk.226.1553184324592;
 Thu, 21 Mar 2019 09:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190315170413.108114-1-twawrzynczak@chromium.org> <20190315170413.108114-2-twawrzynczak@chromium.org>
In-Reply-To: <20190315170413.108114-2-twawrzynczak@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 21 Mar 2019 17:05:13 +0100
Message-ID: <CAFqH_50m-fkPHHPbLx_o-hYmc1vfV9MkTgvGWdVOTmOO36N86A@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: mfd/cros_ec_sysfs: Add sysfs entry to
 retrieve EC uptime.
To:     Tim Wawrzynczak <twawrzynczak@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

Thanks for sending this upstream, some comments below

Missatge de Tim Wawrzynczak <twawrzynczak@chromium.org> del dia dv.,
15 de mar=C3=A7 2019 a les 18:07:
>
> Adds a new sysfs node under the cros_ec device which contains the uptime
> of the EC in milliseconds since boot.
>
> Signed-off-by: Tim Wawrzynczak <twawrzynczak@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_sysfs.c | 34 +++++++++++++++++++++++++

>  include/linux/mfd/cros_ec_commands.h    | 15 +++++++++++

All this is already included in the following patch so it's not really
needed, rebase your patch on top of this and just resend the patch
without these modifications and tell that depends on that patch.

https://lore.kernel.org/patchwork/patch/1046363/

>  2 files changed, 49 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/c=
hrome/cros_ec_sysfs.c
> index 5a6db3fe213a..7e5ca1e2900b 100644
> --- a/drivers/platform/chrome/cros_ec_sysfs.c
> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> @@ -123,6 +123,38 @@ static ssize_t reboot_store(struct device *dev,
>         return count;
>  }
>
> +static ssize_t uptime_show(struct device *dev,
> +                          struct device_attribute *attr, char *buf)
> +{
> +       struct ec_response_uptime_info *resp;
> +       struct cros_ec_command *msg;
> +       int ret;
> +       struct cros_ec_dev *ec =3D to_cros_ec_dev(dev);
> +       u32 time_since_ec_boot_ms;
> +

nit: Reversed X-mas tree order if you don't mind.

> +       msg =3D kmalloc(sizeof(*msg) + sizeof(*resp), GFP_KERNEL);
> +       if (!msg)
> +               return -ENOMEM;
> +
> +       /* Get EC uptime information */
> +       msg->version =3D 0;
> +       msg->command =3D EC_CMD_GET_UPTIME_INFO + ec->cmd_offset;
> +       msg->insize =3D sizeof(*resp);
> +       msg->outsize =3D 0;
> +       ret =3D cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> +       if (ret < 0) {
> +               time_since_ec_boot_ms =3D 0;

That's an error (because the command is not supported or other
reason).  Just goto the and exit label, free the memory and return the
error.

> +       } else {

else not needed

> +               resp =3D (struct ec_response_uptime_info *)msg->data;
> +               time_since_ec_boot_ms =3D resp->time_since_ec_boot_ms;
> +       }
> +
> +       ret =3D scnprintf(buf, PAGE_SIZE, "%u\n", time_since_ec_boot_ms);
> +
> +       kfree(msg);
> +       return ret;
> +}
> +
>  static ssize_t version_show(struct device *dev,
>                             struct device_attribute *attr, char *buf)
>  {
> @@ -330,12 +362,14 @@ static DEVICE_ATTR_RW(reboot);
>  static DEVICE_ATTR_RO(version);
>  static DEVICE_ATTR_RO(flashinfo);
>  static DEVICE_ATTR_RW(kb_wake_angle);
> +static DEVICE_ATTR_RO(uptime);
>

The time is stored in u32 which means that 2^32 in ms is less than 50
days. Overflow this counter doesn't seem too complicated. What happens
when overflows just starts from 0 again? I'm curious why is this
really useful show this in sysfs? There is a use case for that or is
just information.

>  static struct attribute *__ec_attrs[] =3D {
>         &dev_attr_kb_wake_angle.attr,
>         &dev_attr_reboot.attr,
>         &dev_attr_version.attr,
>         &dev_attr_flashinfo.attr,
> +       &dev_attr_uptime.attr,

Is the EC_CMD_GET_UPTIME_INFO supported by all the Cros EC|PD|FP|TP etc.?

I tested on my Samsung Chromebook Plus and seems to be not supported
(ectool fails)

If there is a way to filter if the command is supported or not will be
good only show the attribute when it is supposed to work.

>         NULL,
>  };
>
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cro=
s_ec_commands.h
> index a8c882b5c222..38e7e6dcca97 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -4697,6 +4697,21 @@ struct __ec_align4 ec_params_rwsig_action {
>         uint32_t action;
>  };
>
> +/* For getting EC uptime & AP reset information */
> +#define EC_CMD_GET_UPTIME_INFO 0x0121
> +
> +struct __ec_align4 ec_response_uptime_info {
> +       uint32_t time_since_ec_boot_ms;   /* uptime in ms */
> +       uint32_t ap_resets_since_ec_boot; /* AP resets recorded by EC */
> +       uint32_t ec_reset_flags;          /* RESET_* flags */
> +       /* Empty log entries have cause and timestamp set to zero */
> +       struct ap_reset_log_entry {
> +               uint16_t reset_cause;     /* enum chipset_*_reason */
> +               uint16_t reserved;        /* reserved for protocol growth=
 */
> +               uint32_t reset_time_ms;   /* time of reset assertion */
> +       } recent_ap_reset[4];
> +};
> +
>  /***********************************************************************=
******/
>  /* The command range 0x200-0x2FF is reserved for Rotor. */
>
> --
> 2.20.1
>

Thanks,
 Enric
