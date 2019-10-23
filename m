Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066F2CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 03:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B2E207FA
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 03:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRquuot5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733019AbfJWD0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 23:26:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40290 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732542AbfJWD0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 23:26:42 -0400
Received: by mail-io1-f68.google.com with SMTP id p6so14931348iod.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 20:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+j4esZlyAn6Jj0G1LuKplgHe+Pu/B4eUeGKka5Wc1Q=;
        b=sRquuot576k5OEV69QqANCFmPKRu3I8HEHwtE8bDIFH4iTCUZFiLXeKrWFsOe2azT7
         z55TK3jLnrH5cNizZ4FnrfShy2c+Skof/p3Fjzbf57m1Z2iP+8JbrODlmxvF/JsuvUzG
         a8vHa9Ger6Fvv0eLHXW6gloXznk5lgiClj6OV02Vr7TQrGfnltuNNyNXH0xlQf9Bu+2h
         Qk+vocBSIP4uz9zkzPmQKi2cE1dBci4362Q9JG00tv7dfrFuUg5yEGOZ77QioaHuV+8X
         Ey6mdQTEv9fE41eHFQ14hHHeqf67oGHfke+tU1cla+f9Jl0vJsz1j07hZL/z+Eyc7AU6
         Mzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+j4esZlyAn6Jj0G1LuKplgHe+Pu/B4eUeGKka5Wc1Q=;
        b=p1noK/kMN9yiuxe83jBjdDAkrI/YqmV/WmOFvjHiTaNtAcgGnQpB614mo4CPRnzZg+
         ZKbKhZeV+o7UmavsvzJBWYedEXFebMWz2XZ58LBiKFJnElMhDmLVvgskssWyQr/7UWeU
         TnoGFtSzay1w/6gbYIPBiGc4mtGmsbc+6XE+wY4qbSSaPPtype1/G0sM9dMlsLJbR8Ua
         cIU5RU4xQm16g1oCuzBuuOhRCbPCqVb4eRiT8C+mrMLTWy6EAsAEzu0ZbF9SacUzcesF
         EPIpriJRnfNlCFvy6aJ86TK06fOHdq2HvDTDVzSguKRsTasf6vSLjRl6ou/gu40wJhoF
         yz5A==
X-Gm-Message-State: APjAAAU2EXBPn6c0YFgph0VArLTYcfL+E77TfTW+Bue5id3s4gGKFADw
        qpfZzcRV4WM1h0L9nwGHhjWLvo7rT7Df0EZNWx8eMg==
X-Google-Smtp-Source: APXvYqygqvKfL7Ykw3boZKQwFYF5duCex0GHhqhb/QKexuQBFeBJm0daroKda/Sx6MKbPCAfONIR6Gg+O6waKr/5XBg=
X-Received: by 2002:a6b:c701:: with SMTP id x1mr1239496iof.162.1571801199435;
 Tue, 22 Oct 2019 20:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191022085924.92783-1-pumahsu@google.com> <20191022172731.GA230934@kroah.com>
In-Reply-To: <20191022172731.GA230934@kroah.com>
From:   Puma Hsu <pumahsu@google.com>
Date:   Wed, 23 Oct 2019 11:26:03 +0800
Message-ID: <CAGCq0LYp4Ua052nSwuZwZBAqCMZcLyt9UMsCPThGg27P=YSjNA@mail.gmail.com>
Subject: Re: [PATCH V2] usb: typec: Add sysfs node to show connector orientation
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Kyle Tso <kyletso@google.com>,
        Albert Wang <albertccwang@google.com>,
        Chien Kun Niu <rickyniu@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,


On Wed, Oct 23, 2019 at 1:27 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 22, 2019 at 04:59:24PM +0800, Puma Hsu wrote:
> > Export the Type-C connector orientation so that user space
> > can get this information.
> >
> > Signed-off-by: Puma Hsu <pumahsu@google.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-typec | 11 +++++++++++
> >  drivers/usb/typec/class.c                   | 18 ++++++++++++++++++
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> > index d7647b258c3c..b22f71801671 100644
> > --- a/Documentation/ABI/testing/sysfs-class-typec
> > +++ b/Documentation/ABI/testing/sysfs-class-typec
> > @@ -108,6 +108,17 @@ Contact: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >  Description:
> >               Revision number of the supported USB Type-C specification.
> >
> > +What:                /sys/class/typec/<port>/connector_orientation
> > +Date:                October 2019
> > +Contact:     Puma Hsu <pumahsu@google.com>
> > +Description:
> > +             Indicates which typec connector orientation is configured now.
> > +             cc1 is defined as "normal" and cc2 is defined as "reversed".
>
> Why the blank line after "Description:"?  Shouldn't "Indicates..." be
> right after it?

I checked the coding style for sysfs-class-*, all of them put the
description at the next line behind "Description:"
Should I change it?

> > +
> > +             Valid value:
> > +             - unknown (nothing configured)
> > +             - normal (configured in cc1 side)
> > +             - reversed (configured in cc2 side)
> >
> >  USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
> >
> > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > index 94a3eda62add..911d06676aeb 100644
> > --- a/drivers/usb/typec/class.c
> > +++ b/drivers/usb/typec/class.c
> > @@ -1245,6 +1245,23 @@ static ssize_t usb_power_delivery_revision_show(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RO(usb_power_delivery_revision);
> >
> > +static const char * const typec_connector_orientation[] = {
> > +     [TYPEC_ORIENTATION_NONE]                = "unknown",
> > +     [TYPEC_ORIENTATION_NORMAL]              = "normal",
> > +     [TYPEC_ORIENTATION_REVERSE]             = "reversed",
> > +};
> > +
> > +static ssize_t connector_orientation_show(struct device *dev,
> > +                                             struct device_attribute *attr,
> > +                                             char *buf)
>
> Can you line this up properly?

Yes, I will update it in version3 once the previous problem is confirmed.

>
> thanks,
>
> greg k-h


Thanks in advance.
Puma Hsu
