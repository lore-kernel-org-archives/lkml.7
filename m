Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9C0CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1190C2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WWK8cR0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406217AbfJWNyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:54:10 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40672 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406081AbfJWNyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:54:10 -0400
Received: by mail-il1-f193.google.com with SMTP id d83so10495011ilk.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 06:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+nJtR75en6J8QICL+v2OuPcehUh1r6wrpSxbTyEcbA=;
        b=WWK8cR0zHz8FGV/wc4wJ9hmOqra/qh/+amrwLQvSsYZau0P+11uhje7JdBrJ9bRQbD
         Vo5dTbkbhYSjs4xyZsvfTTeqBc8IzWquLKw1jJ2upAa7NiBc2CSxPQfN2xozteDsGYtp
         4TIpGu3gXEB0zGAL6sWgWsuJCUhHY2kkQ8gpYO/G18fWkKj+i54mhfWleNZjRbziJto3
         8Gt5+FShiQBE/vNY258/UYHOX+XVniN7CDvVd9z4ItFFWXlwERfQDPoogWVm7Qhu9V2f
         i9GxOFypUy3TwUPZ1/KB4bw9iJ/3CAm1QGc3Z6l9Y30VBGu+It1RB5A7iQRzkLeR85qg
         2SNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+nJtR75en6J8QICL+v2OuPcehUh1r6wrpSxbTyEcbA=;
        b=KFUtWi53PiASnkzacVXDkYqXWgAd4NxhJXhlnk50o8r/U8UtpA0cr7NB01jhBS4vUA
         fc4RO8YIBt9b1MLomE7Y7RqTkIrmHD31xNlIAD4/PqG2fBAMknK9fpBa/JRyWhVcAOvq
         tWkcnpHZFX+8HOSTCxx6teYK8P92tOKUKhUkBT8jiMklGmZzrRgpVB0c2xqr34eGP+km
         IGAKdmxF6mDPH0sSldTFCLLIQncjh9smeIRyFo0T6vV73doatPiWbdRgam1v4eXDSpeI
         2+Fdesd7llM25UNb93twBbYTKR6JQKMuakOme4699D9Hkq3vlziZtqnkUbM/9rf01fay
         nrmg==
X-Gm-Message-State: APjAAAUlVvrkhoYRFSUIHUPRJ9Rl7guw4xZN3rfuPHSd6RtcmJLmLRrK
        8BP2geIqzRa2a849A/Klh11BYv5vC0WS8DuODswYTA==
X-Google-Smtp-Source: APXvYqyT6FIp6SoplgW2Lesof8PsJ7DRgg7IC7ob3I+RDguYiq6ow8XKNR5npNfjaWsQIvd7K8GdxzWKuWfFZ+s4Vp4=
X-Received: by 2002:a92:c509:: with SMTP id r9mr34257778ilg.79.1571838848426;
 Wed, 23 Oct 2019 06:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191022085924.92783-1-pumahsu@google.com> <20191023083221.GB8828@kuha.fi.intel.com>
 <644d890b-86e8-f05a-cd4c-32937d971a45@roeck-us.net>
In-Reply-To: <644d890b-86e8-f05a-cd4c-32937d971a45@roeck-us.net>
From:   Puma Hsu <pumahsu@google.com>
Date:   Wed, 23 Oct 2019 21:53:32 +0800
Message-ID: <CAGCq0La+sM2wtgVzj3WWq0yPUeX1irWY=LpSf7ny71HY3_T23A@mail.gmail.com>
Subject: Re: [PATCH V2] usb: typec: Add sysfs node to show connector orientation
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        gregkh@linuxfoundation.org,
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

Hi Guenter,

I think "unknown" here means that the USB port is disconnected in real usage.

Thanks in advance.
Puma Hsu







On Wed, Oct 23, 2019 at 9:44 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 10/23/19 1:32 AM, Heikki Krogerus wrote:
> > +Guenter
> >
> > On Tue, Oct 22, 2019 at 04:59:24PM +0800, Puma Hsu wrote:
> >> Export the Type-C connector orientation so that user space
> >> can get this information.
> >>
> >> Signed-off-by: Puma Hsu <pumahsu@google.com>
> >> ---
> >>   Documentation/ABI/testing/sysfs-class-typec | 11 +++++++++++
> >>   drivers/usb/typec/class.c                   | 18 ++++++++++++++++++
> >>   2 files changed, 29 insertions(+)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> >> index d7647b258c3c..b22f71801671 100644
> >> --- a/Documentation/ABI/testing/sysfs-class-typec
> >> +++ b/Documentation/ABI/testing/sysfs-class-typec
> >> @@ -108,6 +108,17 @@ Contact:        Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >>   Description:
> >>              Revision number of the supported USB Type-C specification.
> >>
> >> +What:               /sys/class/typec/<port>/connector_orientation
> >> +Date:               October 2019
> >> +Contact:    Puma Hsu <pumahsu@google.com>
> >> +Description:
> >> +            Indicates which typec connector orientation is configured now.
> >> +            cc1 is defined as "normal" and cc2 is defined as "reversed".
> >> +
> >> +            Valid value:
> >> +            - unknown (nothing configured)
> >
> > "unknown" means we do not know the orientation.
> >
> >> +            - normal (configured in cc1 side)
> >> +            - reversed (configured in cc2 side)
> >
> > Guenter, do you think "connector_orientation" OK. I proposed it, but
> > I'm now wondering if something like "polarity" would be better?
> >
>
> Yes, or just "orientation". I don't see the value in the "connector_" prefix.
> I also wonder if "unknown" is really correct. Is it really unknown, or
> does it mean that the port is disconnected ?
>
> Guenter
>
> >>   USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
> >>
> >> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> >> index 94a3eda62add..911d06676aeb 100644
> >> --- a/drivers/usb/typec/class.c
> >> +++ b/drivers/usb/typec/class.c >> @@ -1245,6 +1245,23 @@ static ssize_t usb_power_delivery_revision_show(struct device *dev,
> >>   }
> >>   static DEVICE_ATTR_RO(usb_power_delivery_revision);
> >>
> >> +static const char * const typec_connector_orientation[] = {
> >> +    [TYPEC_ORIENTATION_NONE]                = "unknown",
> >> +    [TYPEC_ORIENTATION_NORMAL]              = "normal",
> >> +    [TYPEC_ORIENTATION_REVERSE]             = "reversed",
> >> +};
> >> +
> >> +static ssize_t connector_orientation_show(struct device *dev,
> >> +                                            struct device_attribute *attr,
> >> +                                            char *buf)
> >> +{
> >> +    struct typec_port *p = to_typec_port(dev);
> >> +
> >> +    return sprintf(buf, "%s\n",
> >> +                   typec_connector_orientation[p->orientation]);
> >> +}
> >> +static DEVICE_ATTR_RO(connector_orientation);
> >> +
> >>   static struct attribute *typec_attrs[] = {
> >>      &dev_attr_data_role.attr,
> >>      &dev_attr_power_operation_mode.attr,
> >> @@ -1255,6 +1272,7 @@ static struct attribute *typec_attrs[] = {
> >>      &dev_attr_usb_typec_revision.attr,
> >>      &dev_attr_vconn_source.attr,
> >>      &dev_attr_port_type.attr,
> >> +    &dev_attr_connector_orientation.attr,
> >>      NULL,
> >>   };
> >>   ATTRIBUTE_GROUPS(typec);
> >
> > thanks,
> >
>
