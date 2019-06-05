Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3B3C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354B52067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YOQf+6tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfFEPNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 11:13:14 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35660 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfFEPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:13:13 -0400
Received: by mail-oi1-f194.google.com with SMTP id y6so14826490oix.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 08:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMGVfzPtfY60vPUog1d+79YBY1k9yw26ur4Nhxw9kn4=;
        b=YOQf+6tkLUeembw/E9yLq0uz7iQuOXAwASoFhx0iirho7O5tSWjylX7zJMN2LqbATY
         1OiP/FYuUnbEIVmcTXr56i6f7jkoL50ivkwwqgcIJ15IbVz3PhmlL8HdrtHYYS68GXVV
         qyNRiXx/93QPiSlOfnbKKf5d9IiznfBldTAac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMGVfzPtfY60vPUog1d+79YBY1k9yw26ur4Nhxw9kn4=;
        b=bFZmbwDrHgO1ZnEzjZtmvQDY1x6qwFcIBNQdiMnOw89SU+fGChN1m29JAo7BtbyjPk
         5xV6mAsH0ezGJgfM8Ti/Foj/6nWhKt0X3plc9/AL0jU4CRHI0S9Hxo2E86qGm4imcqFW
         Ew+Ko1SkGOVV1tBSW4JeYuYcEExyRgvfbqgJun2FYKJPxpZBIAoARCUz+caBqXOF5tX8
         jnXwUhUxDMTagC+uKpZPA7oiaR+kpyhWOn0WdQ4S1kiRkhuvosyv05kNRfIqm7Wa3bC7
         qyVCsdy8ZI+vfSxp+5wi/aKst0FMsKfDevlWzTfgkcx76upx+MA3VWXRfFdqyIJV68uY
         SkiQ==
X-Gm-Message-State: APjAAAW88JG9VwyAqnNutX8h/GP2vb2N+aT/54N40VLvK4LA2DJpBQhU
        5al1Ckak8iHnsSnqjzPjWwP3CHt0wz8=
X-Google-Smtp-Source: APXvYqzJyO5GTovmLemCisi04z3cXkYoJUcurZrogNS6mt9WVq3zRS5DRlQo8PRwZTlswWCo94fzNA==
X-Received: by 2002:aca:45c3:: with SMTP id s186mr3863620oia.89.1559747592076;
        Wed, 05 Jun 2019 08:13:12 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id f186sm7639642oia.52.2019.06.05.08.13.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 08:13:10 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id t76so3395846oih.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 08:13:10 -0700 (PDT)
X-Received: by 2002:aca:ef42:: with SMTP id n63mr8793398oih.177.1559747589837;
 Wed, 05 Jun 2019 08:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190603181649.143640-1-rrangel@chromium.org> <073e1600-18fe-84ea-03df-7b53b9b7c690@collabora.com>
In-Reply-To: <073e1600-18fe-84ea-03df-7b53b9b7c690@collabora.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Wed, 5 Jun 2019 09:12:57 -0600
X-Gmail-Original-Message-ID: <CAHX4x8558sa8WX2n9ar94bJn6YsejqNgFFouY+3piT4jExF1DA@mail.gmail.com>
Message-ID: <CAHX4x8558sa8WX2n9ar94bJn6YsejqNgFFouY+3piT4jExF1DA@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: wilco_ec: Add version sysfs entries
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Raul E Rangel <rrangel@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Raul and Enric, this looks good to me.

On Mon, Jun 3, 2019 at 2:40 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Nick,
>
> On 3/6/19 20:16, Raul E Rangel wrote:
> > Add the ability to extract version information from the EC.
> >
> > Example Output:
> > $ cd /sys/bus/platform/devices/GOOG000C:00
> > $ tail build_date build_revision version model_number
> > ==> build_date <==
> > 04/25/19
> >
> > ==> build_revision <==
> > d2592cae0
> >
> > ==> version <==
> > 00.00.14
> >
> > ==> model_number <==
> > 08B6
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Reviewed-by: Nick Crews <ncrews@chromium.org>

>
> Can I get your rb here?
>
> Thanks,
>  Enric
>
> > ---
> > This patch is rebased on chromeos-platform/for-next. It was originally
> > developed on the chromiumos 4.19 kernel which has the following patch
> > applied: https://lore.kernel.org/patchwork/patch/1062995/. That patch is
> > not currently upstream.
> >
> > Changes in v2:
> > - Removed version directory
> > - Renamed label to version
> > - Sorted documentation
> >
> >  .../ABI/testing/sysfs-platform-wilco-ec       | 31 ++++++++
> >  drivers/platform/chrome/wilco_ec/sysfs.c      | 79 +++++++++++++++++++
> >  2 files changed, 110 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-platform-wilco-ec b/Documentation/ABI/testing/sysfs-platform-wilco-ec
> > index 8e5d6eee44db2..8827a734f9331 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-wilco-ec
> > +++ b/Documentation/ABI/testing/sysfs-platform-wilco-ec
> > @@ -7,3 +7,34 @@ Description:
> >               want to run their device headless or with a dock.
> >
> >               Input should be parseable by kstrtou8() to 0 or 1.
> > +
> > +What:          /sys/bus/platform/devices/GOOG000C\:00/build_date
> > +Date:          May 2019
> > +KernelVersion: 5.3
> > +Description:
> > +               Display Wilco Embedded Controller firmware build date.
> > +               Output will a MM/DD/YY string.
> > +
> > +What:          /sys/bus/platform/devices/GOOG000C\:00/build_revision
> > +Date:          May 2019
> > +KernelVersion: 5.3
> > +Description:
> > +               Display Wilco Embedded Controller build revision.
> > +               Output will a version string be similar to the example below:
> > +               d2592cae0
> > +
> > +What:          /sys/bus/platform/devices/GOOG000C\:00/model_number
> > +Date:          May 2019
> > +KernelVersion: 5.3
> > +Description:
> > +               Display Wilco Embedded Controller model number.
> > +               Output will a version string be similar to the example below:
> > +               08B6
> > +
> > +What:          /sys/bus/platform/devices/GOOG000C\:00/version
> > +Date:          May 2019
> > +KernelVersion: 5.3
> > +Description:
> > +               Display Wilco Embedded Controller firmware version.
> > +               The format of the string is x.y.z. Where x is major, y is minor
> > +               and z is the build number. For example: 95.00.06
> > diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
> > index f84f0480460ae..3b86a21005d3e 100644
> > --- a/drivers/platform/chrome/wilco_ec/sysfs.c
> > +++ b/drivers/platform/chrome/wilco_ec/sysfs.c
> > @@ -23,6 +23,25 @@ struct boot_on_ac_request {
> >       u8 reserved7;
> >  } __packed;
> >
> > +#define CMD_EC_INFO                  0x38
> > +enum get_ec_info_op {
> > +     CMD_GET_EC_LABEL        = 0,
> > +     CMD_GET_EC_REV          = 1,
> > +     CMD_GET_EC_MODEL        = 2,
> > +     CMD_GET_EC_BUILD_DATE   = 3,
> > +};
> > +
> > +struct get_ec_info_req {
> > +     u8 cmd;                 /* Always CMD_EC_INFO */
> > +     u8 reserved;
> > +     u8 op;                  /* One of enum get_ec_info_op */
> > +} __packed;
> > +
> > +struct get_ec_info_resp {
> > +     u8 reserved[2];
> > +     char value[9]; /* __nonstring: might not be null terminated */
> > +} __packed;
> > +
> >  static ssize_t boot_on_ac_store(struct device *dev,
> >                               struct device_attribute *attr,
> >                               const char *buf, size_t count)
> > @@ -57,8 +76,68 @@ static ssize_t boot_on_ac_store(struct device *dev,
> >
> >  static DEVICE_ATTR_WO(boot_on_ac);
> >
> > +static ssize_t get_info(struct device *dev, char *buf, enum get_ec_info_op op)
> > +{
> > +     struct wilco_ec_device *ec = dev_get_drvdata(dev);
> > +     struct get_ec_info_req req = { .cmd = CMD_EC_INFO, .op = op };
> > +     struct get_ec_info_resp resp;
> > +     int ret;
> > +
> > +     struct wilco_ec_message msg = {
> > +             .type = WILCO_EC_MSG_LEGACY,
> > +             .request_data = &req,
> > +             .request_size = sizeof(req),
> > +             .response_data = &resp,
> > +             .response_size = sizeof(resp),
> > +     };
> > +
> > +     ret = wilco_ec_mailbox(ec, &msg);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return scnprintf(buf, PAGE_SIZE, "%.*s\n", (int)sizeof(resp.value),
> > +                      (char *)&resp.value);
> > +}
> > +
> > +static ssize_t version_show(struct device *dev, struct device_attribute *attr,
> > +                       char *buf)
> > +{
> > +     return get_info(dev, buf, CMD_GET_EC_LABEL);
> > +}
> > +
> > +static DEVICE_ATTR_RO(version);
> > +
> > +static ssize_t build_revision_show(struct device *dev,
> > +                                struct device_attribute *attr, char *buf)
> > +{
> > +     return get_info(dev, buf, CMD_GET_EC_REV);
> > +}
> > +
> > +static DEVICE_ATTR_RO(build_revision);
> > +
> > +static ssize_t build_date_show(struct device *dev,
> > +                            struct device_attribute *attr, char *buf)
> > +{
> > +     return get_info(dev, buf, CMD_GET_EC_BUILD_DATE);
> > +}
> > +
> > +static DEVICE_ATTR_RO(build_date);
> > +
> > +static ssize_t model_number_show(struct device *dev,
> > +                              struct device_attribute *attr, char *buf)
> > +{
> > +     return get_info(dev, buf, CMD_GET_EC_MODEL);
> > +}
> > +
> > +static DEVICE_ATTR_RO(model_number);
> > +
> > +
> >  static struct attribute *wilco_dev_attrs[] = {
> >       &dev_attr_boot_on_ac.attr,
> > +     &dev_attr_build_date.attr,
> > +     &dev_attr_build_revision.attr,
> > +     &dev_attr_model_number.attr,
> > +     &dev_attr_version.attr,
> >       NULL,
> >  };
> >
> >
