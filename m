Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3207BC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AA721D82
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZhDjZILu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391853AbfJPJAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:00:08 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43847 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388817AbfJPJAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:00:08 -0400
Received: by mail-il1-f194.google.com with SMTP id t5so1808175ilh.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 02:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TZutJZLGF0s525Qo74hWUBEFtHjd5fY3wVdzlXrrh2g=;
        b=ZhDjZILuy3YhF2gSkbfiMnpR25Ut8GlVy3dzCgggDUq1Rl2yWFe7s6IUT85L+YoCtX
         zNav7Nkq4uWki/D5pvlMY3/clN8kIEcVEPdQNYkEunUcUKGes46sxszFRcTUfeRp27lh
         eTaeH407eXkavgtu8N5lihIVyrMoTHh22lV99W0RjYBC4zJgIbKELBPX5Z/eRtoiigye
         +1PzXL3KQ700Ccbo/PfV2hFAB5rj0TlZUMQw6DOtJgprAqnFFFmzG6mcdSv7RXaHKGg+
         lestp3pIU39bMzGAZM0yi9eU3GjA6uxwemlic7PkKXBD5WiV5dmadmIqCf12Z/Od4ov8
         G1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TZutJZLGF0s525Qo74hWUBEFtHjd5fY3wVdzlXrrh2g=;
        b=sXutyXrrreDbtnBnaltAWTSuu4qgctl5sUJoqhVV0rWFralGQsuttgTtcCYMMcJMBE
         7C55jkus2UtALNL0ADRfENtQJeG99BByleNENRhhxejQKYxheL7GsW7W3lkcJD0Q74bd
         WK4YeJd+9Q8YLmGoAVK8jHtO5TRk6pqOCLB2AGQVuGjIohssfViNjfjmxFrGWeiC0B5o
         OK8lP9R7VJGrX6J7nI/rle7HvJn/aCQiJ8f8FhP6tCFNTGcbXrHSvpvU+xmUL6dYcxp2
         gqoZERPnKLkA4FwWYYSGN0f0nr9cdaa9f8uFnkbesp3K900lyJYeqzMuk7eB1gMHIhLf
         Ztfg==
X-Gm-Message-State: APjAAAW3SlAoQL8mSsNlqWCnHLOGyG8T1g/Kh5iHi+vhhHrehs5xjKXE
        zYbljvxC3Y7fB4UH2pah2CfItdG4ITExbj6uUfWEMQ==
X-Google-Smtp-Source: APXvYqwJg57R7T7Y4R5Atp4LSTftEMxw9GTS82UTA6BSFSYXKdQ99EAqMtb6dSOBmHCC17Yr2KZ85giWiH60Bot35T4=
X-Received: by 2002:a92:c10c:: with SMTP id p12mr10520194ile.32.1571216406838;
 Wed, 16 Oct 2019 02:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191016034314.231363-1-pumahsu@google.com> <577ac2f6-f073-1bd0-0adb-33fa8243773c@infradead.org>
In-Reply-To: <577ac2f6-f073-1bd0-0adb-33fa8243773c@infradead.org>
From:   Puma Hsu <pumahsu@google.com>
Date:   Wed, 16 Oct 2019 16:59:30 +0800
Message-ID: <CAGCq0La71bzMKcRw-+QmnMtOH_eeA-5t0qYAq3fSrLgBToyUrw@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: Add sysfs node to show cc orientation
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        Badhri Jagan Sridharan <badhri@google.com>,
        Kyle Tso <kyletso@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Albert Wang <albertccwang@google.com>,
        Puma Hsu <pumahsu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

According to include/linux/usb/typec.h, The value of
/sys/class/typec/<port>/cc_orientation is usually =E2=80=9C1=E2=80=9D, =E2=
=80=9C2=E2=80=9D, or =E2=80=9C0=E2=80=9D
corresponding to =E2=80=9Cconfigured in NORMAL side=E2=80=9D, =E2=80=9Cconf=
igured in REVERSE
side=E2=80=9D, or =E2=80=9Cnothing configured=E2=80=9D.
Refer to the usage in tcpm.c, it claims CC1 is NORMAL and CC2 is REVERSE.
I will update this into Documentation description.

enum typec_orientation {
        TYPEC_ORIENTATION_NONE,
        TYPEC_ORIENTATION_NORMAL,
        TYPEC_ORIENTATION_REVERSE,
};

Thanks in advance.



  =E2=80=A2  Puma Hsu =E8=A8=B1=E8=AA=8C=E5=AE=8F
  =E2=80=A2  Software Engineer, Pixel Phone
  =E2=80=A2  Tel: +886 2 8729 0870
  =E2=80=A2  pumahsu@google.com


Thanks in advance.




  =E2=80=A2  Puma Hsu =E8=A8=B1=E8=AA=8C=E5=AE=8F
  =E2=80=A2  Software Engineer, Pixel Phone
  =E2=80=A2  Tel: +886 2 8729 0870
  =E2=80=A2  pumahsu@google.com





On Wed, Oct 16, 2019 at 11:47 AM Randy Dunlap <rdunlap@infradead.org> wrote=
:
>
> On 10/15/19 8:43 PM, pumahsu wrote:
> > Export the Type-C cc orientation so that user space can
> > get this information.
> >
> > Signed-off-by: pumahsu <pumahsu@google.com>
>
> Hi,
> what the * is cc orientation?
>
> > ---
> >  Documentation/ABI/testing/sysfs-class-typec |  7 +++++++
> >  drivers/usb/typec/class.c                   | 11 +++++++++++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentatio=
n/ABI/testing/sysfs-class-typec
> > index d7647b258c3c..419f952c991d 100644
> > --- a/Documentation/ABI/testing/sysfs-class-typec
> > +++ b/Documentation/ABI/testing/sysfs-class-typec
> > @@ -108,6 +108,13 @@ Contact: Heikki Krogerus <heikki.krogerus@linux.in=
tel.com>
> >  Description:
> >               Revision number of the supported USB Type-C specification=
.
> >
> > +What:                /sys/class/typec/<port>/cc_orientation
> > +Date:                September 2019
> > +Contact:     Puma Hsu <pumahsu@google.com>
> > +Description:
> > +             Indicates which cc orientation is active now, or 0 when
> > +             nothing is connected.
> > +
> >
> >  USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
> >
> > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > index 7d8805d9bf37..00edae63da8e 100644
> > --- a/drivers/usb/typec/class.c
> > +++ b/drivers/usb/typec/class.c
> > @@ -1238,6 +1238,16 @@ static ssize_t usb_power_delivery_revision_show(=
struct device *dev,
> >  }
> >  static DEVICE_ATTR_RO(usb_power_delivery_revision);
> >
> > +static ssize_t cc_orientation_show(struct device *dev,
> > +                                             struct device_attribute *=
attr,
> > +                                             char *buf)
> > +{
> > +     struct typec_port *p =3D to_typec_port(dev);
> > +
> > +     return sprintf(buf, "%d\n", typec_get_orientation(p));
> > +}
> > +static DEVICE_ATTR_RO(cc_orientation);
> > +
> >  static struct attribute *typec_attrs[] =3D {
> >       &dev_attr_data_role.attr,
> >       &dev_attr_power_operation_mode.attr,
> > @@ -1248,6 +1258,7 @@ static struct attribute *typec_attrs[] =3D {
> >       &dev_attr_usb_typec_revision.attr,
> >       &dev_attr_vconn_source.attr,
> >       &dev_attr_port_type.attr,
> > +     &dev_attr_cc_orientation.attr,
> >       NULL,
> >  };
> >  ATTRIBUTE_GROUPS(typec);
> >
>
>
> --
> ~Randy
