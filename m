Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACC6C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC03217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOp+NkNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfEIVqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:46:35 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45918 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfEIVqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:46:34 -0400
Received: by mail-qt1-f193.google.com with SMTP id t1so4303117qtc.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YxezIjhXPdPqr4yOYxpk6zkQSoMSPArnt6eda+IWrx8=;
        b=iOp+NkNSBPlSUzhnKO+eEPEAcJ476OxpX3psHSzAr0pGnJciaBwyDVlkpaTikgTZgM
         diijSSacGoAifmjt97G8Qv1f8FVNvGly2ukvEM4KGJ/EyYtMDOI93bVpdPUhBxOJM/DP
         NRTCwvNTJKGwQ8M+em3CRBscMMsFk7q+y52SjrCv0boCs3G5Ne6Dkw31KIzdf7crRvds
         5ktJt0K2fX+w2COuZEw0eYKRkAlFjS9STZkt9ndUu0P/CD5Nk9Gn4hPV5029cEMqXx57
         ZzxfT6qXCcQaNuAm7h2aUHAXPz8pB7Ex+NnCTcKsX8OFTpzDs6osbySo3AFfm4bl6ui3
         a1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YxezIjhXPdPqr4yOYxpk6zkQSoMSPArnt6eda+IWrx8=;
        b=e/4E8r9jPM2i7pmmCsL0XoLVd7u2WlolrhGscutDkc+HS/ehap6y8spmwNAQEszhKb
         2HWyZpv7V1XBwPNLtZe9FIvsIIQvkO2Mm6aNlw1sWgD/oxqBx0nsQiELwFWCE6zZo2ao
         Tgpt5Y8Fhh/OYuRpDTQrdtDxQjbS9yR1QotVqJxGU94AP3uV9A5OFW/tld0ZUgjghQ4p
         +BH89uEn+U7HW8YoTc8Zc1LamslGVr4q3l9eUjlZkMiRI2JSv0+0lXNUne0Y5UQ+8EY1
         F6ubjx9nRDV5FxljGIhnkK6KUhoTtXHVeTrT4osJo7XUrvz780wPhdsq8A2v7rrM9XA1
         f+7Q==
X-Gm-Message-State: APjAAAVVqxv+ORTPmxE/sVKRDflwg6l3Cty/+sfh/55FRWCppzGEXDIx
        ND/ETnmbc8LmJ1QElKHzcR0h0PZxMRru41ozEeQ=
X-Google-Smtp-Source: APXvYqxlsW0LB1vLGnMwKADtlItrwTn6n0bkRds8hh1K7YC03jPmQ1gRbSp1BgUKQRalZdFSruKvXr2WIEWZUtlPmUg=
X-Received: by 2002:ac8:33bc:: with SMTP id c57mr5984099qtb.252.1557438393561;
 Thu, 09 May 2019 14:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190417012048.87977-1-ncrews@chromium.org> <20190417012048.87977-2-ncrews@chromium.org>
In-Reply-To: <20190417012048.87977-2-ncrews@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 9 May 2019 23:46:22 +0200
Message-ID: <CAFqH_53_rTSH2Qt=fJdLfC7bzij3E-6DTTwEh2G=i=J7nUFN4w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] platform/chrome: wilco_ec: Add USB PowerShare
 Policy control
To:     Nick Crews <ncrews@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dlaurie@chromium.org, Daniel Erat <derat@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Simon Glass <sjg@chromium.org>, bartfab@chromium.org,
        lamzin@google.com, jchwong@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Thanks for the patch, some few comments below...

Missatge de Nick Crews <ncrews@chromium.org> del dia dc., 17 d=E2=80=99abr.
2019 a les 3:21:
>
> USB PowerShare is a policy which affects charging via the special
> USB PowerShare port (marked with a small lightning bolt or battery icon)
> when in low power states:
> - In S0, the port will always provide power.
> - In S0ix, if power_share is enabled, then power will be supplied to
>   the port when on AC or if battery is > 50%. Else no power is supplied.
> - In S5, if power_share is enabled, then power will be supplied to
>   the port when on AC. Else no power is supplied.
>
> v3 changes:
> - Drop a silly blank line
> - Use val > 1 instead of val !=3D 0 && val !=3D 1
> v2 changes:
> - Move documentation to Documentation/ABI/testing/sysfs-platform-wilco-ec
> - Zero out reserved bytes in requests.
>
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
>  .../ABI/testing/sysfs-platform-wilco-ec       | 16 ++++
>  drivers/platform/chrome/wilco_ec/sysfs.c      | 92 +++++++++++++++++++
>  2 files changed, 108 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-wilco-ec b/Document=
ation/ABI/testing/sysfs-platform-wilco-ec
> index e074c203cd32..0c07d5e0b737 100644
> --- a/Documentation/ABI/testing/sysfs-platform-wilco-ec
> +++ b/Documentation/ABI/testing/sysfs-platform-wilco-ec
> @@ -9,3 +9,19 @@ Description:
>                 Input should be parseable by kstrtou8() to 0 or 1.
>                 Output will be either "0\n" or "1\n".
>
> +What:          /sys/bus/platform/devices/GOOG000C\:00/usb_power_share
> +Date:          April 2019
> +KernelVersion: 5.2
> +Description:
> +               Control the USB PowerShare Policy. USB PowerShare is a po=
licy
> +               which affects charging via the special USB PowerShare por=
t
> +               (marked with a small lightning bolt or battery icon) when=
 in
> +               low power states:
> +               - In S0, the port will always provide power.
> +               - In S0ix, if power_share is enabled, then power will be
> +                 supplied to the port when on AC or if battery is > 50%.
> +                 Else no power is supplied.
> +               - In S5, if power_share is enabled, then power will be su=
pplied
> +                 to the port when on AC. Else no power is supplied.
> +

So, basically, this is to enable/disable USB Powershare capability. I
think that this is not an uncommon capability can we give it a respin
and see if we can do this generic?

> +               Input should be either "0" or "1".
> diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/=
chrome/wilco_ec/sysfs.c
> index 959b5da2eb16..14e1eee95d42 100644
> --- a/drivers/platform/chrome/wilco_ec/sysfs.c
> +++ b/drivers/platform/chrome/wilco_ec/sysfs.c
> @@ -23,6 +23,26 @@ struct boot_on_ac_request {
>         u8 reserved7;
>  } __packed;
>
> +#define CMD_USB_POWER_SHARE 0x39
> +
> +enum usb_power_share_op {
> +       POWER_SHARE_GET =3D 0,
> +       POWER_SHARE_SET =3D 1,
> +};
> +
> +struct usb_power_share_request {
> +       u8 cmd;         /* Always CMD_USB_POWER_SHARE */
> +       u8 reserved;
> +       u8 op;          /* One of enum usb_power_share_op */
> +       u8 val;         /* When setting, either 0 or 1 */
> +} __packed;
> +
> +struct usb_power_share_response {
> +       u8 reserved;
> +       u8 status;      /* Set by EC to 0 on success, other value on fail=
ure */
> +       u8 val;         /* When getting, set by EC to either 0 or 1 */
> +} __packed;
> +
>  static ssize_t boot_on_ac_store(struct device *dev,
>                                 struct device_attribute *attr,
>                                 const char *buf, size_t count)
> @@ -57,8 +77,80 @@ static ssize_t boot_on_ac_store(struct device *dev,
>
>  static DEVICE_ATTR_WO(boot_on_ac);
>
> +static int send_usb_power_share(struct wilco_ec_device *ec,
> +                               struct usb_power_share_request *rq,
> +                               struct usb_power_share_response *rs)
> +{
> +       struct wilco_ec_message msg;
> +       int ret;
> +
> +       memset(&msg, 0, sizeof(msg));
> +       msg.type =3D WILCO_EC_MSG_LEGACY;
> +       msg.request_data =3D rq;
> +       msg.request_size =3D sizeof(*rq);
> +       msg.response_data =3D rs;
> +       msg.response_size =3D sizeof(*rs);
> +       ret =3D wilco_ec_mailbox(ec, &msg);
> +       if (ret < 0)
> +               return ret;
> +       if (rs->status)
> +               return -EIO;
> +
> +       return 0;
> +}
> +
> +static ssize_t usb_power_share_show(struct device *dev,
> +                                   struct device_attribute *attr, char *=
buf)
> +{
> +       struct wilco_ec_device *ec =3D dev_get_drvdata(dev);
> +       struct usb_power_share_request rq;
> +       struct usb_power_share_response rs;
> +       int ret;
> +
> +       memset(&rq, 0, sizeof(rq));
> +       rq.cmd =3D CMD_USB_POWER_SHARE;
> +       rq.op =3D POWER_SHARE_GET;
> +
> +       ret =3D send_usb_power_share(ec, &rq, &rs);
> +       if (ret < 0)
> +               return ret;
> +
> +       return sprintf(buf, "%d\n", rs.val);
> +}
> +
> +static ssize_t usb_power_share_store(struct device *dev,
> +                                    struct device_attribute *attr,
> +                                    const char *buf, size_t count)
> +{
> +       struct wilco_ec_device *ec =3D dev_get_drvdata(dev);
> +       struct usb_power_share_request rq;
> +       struct usb_power_share_response rs;
> +       int ret;
> +       u8 val;
> +
> +       ret =3D kstrtou8(buf, 10, &val);
> +       if (ret < 0)
> +               return ret;
> +       if (val > 1)
> +               return -EINVAL;
> +
> +       memset(&rq, 0, sizeof(rq));
> +       rq.cmd =3D CMD_USB_POWER_SHARE;
> +       rq.op =3D POWER_SHARE_SET;
> +       rq.val =3D val;
> +
> +       ret =3D send_usb_power_share(ec, &rq, &rs);
> +       if (ret < 0)
> +               return ret;
> +
> +       return count;
> +}
> +
> +static DEVICE_ATTR_RW(usb_power_share);
> +
>  static struct attribute *wilco_dev_attrs[] =3D {
>         &dev_attr_boot_on_ac.attr,
> +       &dev_attr_usb_power_share.attr,
>         NULL,
>  };
>
> --
> 2.20.1
>

Thanks,
 Enric
