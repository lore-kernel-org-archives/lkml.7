Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F913FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C8B20663
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXaaodg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393811AbfJPQTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:19:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34890 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfJPQTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:19:13 -0400
Received: by mail-io1-f66.google.com with SMTP id q10so54685545iop.2;
        Wed, 16 Oct 2019 09:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h32JWLot+gceae0jQn6+dpZ85M9IjTbgfAQ5j4grnTA=;
        b=UXaaodg3AFzS4aSYdIEd36mhiJEN7vilHRmzWu5tZGMnYleV6eUDOKw4ScHHm1iIo9
         YhV+fJpyY2lM/ApsjxfbQ41c7Bh9SxHYRzYZybNuFE9tB4D2sCUT+OXc65qbawa6rr/n
         UV8HHfghrJBRDgHhKSJ3A61llDuxCoCn9IgMl7xXWVb8AolKDi2B4N8vtlQWM6vmdSWO
         aO7204bSLfoLbtIynHam5CXwCUJyWj0od89S5T3cW5nCJXMS4PrhQWg0FWc4mXmcubY2
         mjW03XFhU3DSsP1EykwtCvouoektuZJhxOghw3m91RHSQ5XqnKKSGrj9B456LWjHdq5c
         Zdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h32JWLot+gceae0jQn6+dpZ85M9IjTbgfAQ5j4grnTA=;
        b=ZxZHHMW7OZpKHw4V/0SxIsPRIehy9RkD+jHaYPnYmJuD/PChkj5Fsnk0OnIPP9tRVQ
         H1o9PtjVVye7Z59Wty+IASEptM0LXbaCIO93PhZrOL4kJ/CEzxKzdWKdsS9aAkm6vowS
         lI56/WqXuCsO4lKrlG8RcKoOOZVfRO4MrUXI+ru1Dbvdhu7snqBhhsKixQGk51hHlZlI
         2/sICrAFbqvkWz17wVhO+MnpKKP9zJECUjb3Ew+ukm4yiP5CHuKWsz7aY9APKh4w0BNW
         fcCEENdVPEdgjihB5mzRPb5UgwIOMoIXIzJCwuXqYhsNG4qllUnqBmZujwAgWHG0GmNc
         qRxQ==
X-Gm-Message-State: APjAAAU1mMg0yynMQd9OSz56Q1RhCy1fEQVwjk1sw/nDUekLnXHDhm+E
        owTWldsdcuL8dlNI1ovYn7svnPf824bj8pOYdwI=
X-Google-Smtp-Source: APXvYqyhl5iUSYWpUQKJhr3nSoqeJuYCD1HiKNf1oQRQxqz8oX8fx+54lB4kBMH1RO7fz+6Vb8PFFolkd/cH6Qoz2Ps=
X-Received: by 2002:a05:6638:632:: with SMTP id h18mr31488191jar.55.1571242752159;
 Wed, 16 Oct 2019 09:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191002114626.12407-1-aford173@gmail.com> <20191002203149.g22igmfndbve7m3n@earth.universe>
In-Reply-To: <20191002203149.g22igmfndbve7m3n@earth.universe>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 16 Oct 2019 11:19:00 -0500
Message-ID: <CAHCN7xK2MFJbZkjaboDnfHJa4SgGMc7CL3+ZUL4UBCFV00W9+g@mail.gmail.com>
Subject: Re: [PATCH] Revert "Bluetooth: hci_ll: set operational frequency earlier"
To:     Sebastian Reichel <sre@kernel.org>
Cc:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Ford <adam.ford@logicpd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 3:31 PM Sebastian Reichel <sre@kernel.org> wrote:
>
> Hi,
>
> On Wed, Oct 02, 2019 at 06:46:26AM -0500, Adam Ford wrote:
> > As nice as it would be to update firmware faster, that patch broke
> > at least two different boards, an OMAP4+WL1285 based Motorola Droid
> > 4, as reported by Sebasian Reichel and the Logic PD i.MX6Q +
> > WL1837MOD.
> >
> > This reverts commit a2e02f38eff84f199c8e32359eb213f81f270047.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>
> This should be backported stable

Is there any chance of this getting picked up for the 5.4 kernel?
It's been a couple weeks, and I haven't seen any responses beyond
Sebastian's Ack and request for backport.

adam

>
> -- Sebastian
>
> > diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
> > index 285706618f8a..d9a4c6c691e0 100644
> > --- a/drivers/bluetooth/hci_ll.c
> > +++ b/drivers/bluetooth/hci_ll.c
> > @@ -621,13 +621,6 @@ static int ll_setup(struct hci_uart *hu)
> >
> >       serdev_device_set_flow_control(serdev, true);
> >
> > -     if (hu->oper_speed)
> > -             speed = hu->oper_speed;
> > -     else if (hu->proto->oper_speed)
> > -             speed = hu->proto->oper_speed;
> > -     else
> > -             speed = 0;
> > -
> >       do {
> >               /* Reset the Bluetooth device */
> >               gpiod_set_value_cansleep(lldev->enable_gpio, 0);
> > @@ -639,20 +632,6 @@ static int ll_setup(struct hci_uart *hu)
> >                       return err;
> >               }
> >
> > -             if (speed) {
> > -                     __le32 speed_le = cpu_to_le32(speed);
> > -                     struct sk_buff *skb;
> > -
> > -                     skb = __hci_cmd_sync(hu->hdev,
> > -                                          HCI_VS_UPDATE_UART_HCI_BAUDRATE,
> > -                                          sizeof(speed_le), &speed_le,
> > -                                          HCI_INIT_TIMEOUT);
> > -                     if (!IS_ERR(skb)) {
> > -                             kfree_skb(skb);
> > -                             serdev_device_set_baudrate(serdev, speed);
> > -                     }
> > -             }
> > -
> >               err = download_firmware(lldev);
> >               if (!err)
> >                       break;
> > @@ -677,7 +656,25 @@ static int ll_setup(struct hci_uart *hu)
> >       }
> >
> >       /* Operational speed if any */
> > +     if (hu->oper_speed)
> > +             speed = hu->oper_speed;
> > +     else if (hu->proto->oper_speed)
> > +             speed = hu->proto->oper_speed;
> > +     else
> > +             speed = 0;
> > +
> > +     if (speed) {
> > +             __le32 speed_le = cpu_to_le32(speed);
> > +             struct sk_buff *skb;
> >
> > +             skb = __hci_cmd_sync(hu->hdev, HCI_VS_UPDATE_UART_HCI_BAUDRATE,
> > +                                  sizeof(speed_le), &speed_le,
> > +                                  HCI_INIT_TIMEOUT);
> > +             if (!IS_ERR(skb)) {
> > +                     kfree_skb(skb);
> > +                     serdev_device_set_baudrate(serdev, speed);
> > +             }
> > +     }
> >
> >       return 0;
> >  }
> > --
> > 2.17.1
> >
