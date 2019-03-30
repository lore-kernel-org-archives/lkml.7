Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D275CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 08:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BBD218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 08:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBYE9nMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbfC3IBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 04:01:52 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35922 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfC3IBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 04:01:51 -0400
Received: by mail-yw1-f66.google.com with SMTP id u197so1519695ywf.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 01:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ou/EcZgQ2kTCfnCpqt+bAtN9998cp2UD9Yy35ZEn2LA=;
        b=pBYE9nMDAZ+C4RWCEw30YschYJK8nAN56MvuWQ4+XPV3PpjMnLFOATHHwF6adyYhBU
         soGw3PIZa4pzcYEhPL1FUgfaRUX5ir9Q2RckqOTF+GqDYL5EoXv/+sBwEt3VREhfuqYL
         X9Z3HIjEtqKJEqoGQwW1nlsXlLQJJIXxL8bYhUYzVOpVFuoaTfNsGua85fcf/b8ag7do
         Go8XeEp/8ZZ6RdSDVRFbcG2bLcsDa5OBE1F145DxPl6xSZyg/HtZXOw1lY7ALLpaL7X1
         4wnkgLpK+EJUYf6PGK8b6/1/GqSqQrExWorNdeT75QcmZVK1Pv4H6dQy7eVf5etJCqrM
         48yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ou/EcZgQ2kTCfnCpqt+bAtN9998cp2UD9Yy35ZEn2LA=;
        b=PFLiqr1eB2rU86tk1f4vAosoGZ4VZCMRfl2hh8xX8o/4Jt0YCfMAbGoi5Z1nC9LKSl
         vxt6b9DyLSrBSerMxPB6AHGeVdouaLCbVaqQgd3tYoiSsquRoeW3wm0q23Ahdb0FV0wn
         l+tNgGmvha0MEYkOAEJCboOgqhpVzRXPRqfbdd1r1TDse75HeEKlmqc6nMTXmdnd5WBB
         K0Zz76Tq21rwJL8lByKF2+Ma5FtE0dX3xXCwMEc8/b4HavGqKkrcQYVg7l2xTv8yCR6H
         kL/t6q6WWDjjP0/TNCleAe7FHC9gHGtj7tEA4wl0BsW2ht6E1XeO4NrUeVDWyC9MHw+A
         BSsg==
X-Gm-Message-State: APjAAAWp41hCjY76SyiuWGpqbjZSg3q8tkpXzqUhTIPeQmwRBzm5ZrxX
        /3II5/D6uHDDpxuiEtNULBKzmFQv1wOEY/9/1kqznrKy
X-Google-Smtp-Source: APXvYqwGoMZoxw9YhLomX+24J4qFHd/zWXrOmjrt34eNL+WA4jCnAl6tVRcUZ5Er3VOhmeGgM2If/knh74P1UaidNZE=
X-Received: by 2002:a0d:e487:: with SMTP id n129mr35807007ywe.487.1553932911212;
 Sat, 30 Mar 2019 01:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <CABXRUiSUzuf+Ki1Pj9oUkgZC0ELkA4N1aZpwBrZ7Gu3nyGwPMQ@mail.gmail.com>
 <20190330071413.GA5507@kroah.com>
In-Reply-To: <20190330071413.GA5507@kroah.com>
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Date:   Sat, 30 Mar 2019 16:02:38 +0800
Message-ID: <CABXRUiSvSP=L3Twkya9HiuzQHmJngTET3XEKoxGGpSfPxb-_tw@mail.gmail.com>
Subject: Re: a kernel address leak via copy_to_user in drivers/tty/rocket.c
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I add a function to mask all pointer fields of struct r_port. (Other
pointer fields may have a similar issue, so I set all pointer fields
to NULL);
The modified code is marked with ">"

>1274 static void mask_pointer(struct r_port *info, struct r_port *masked_i=
nfo) {
>1275   memcpy(masked_info, info, sizeof (struct r_port));
>1276   masked_info->port.tty =3D NULL;
>1277   masked_info->port.itty =3D NULL;
>1278   masked_info->port.ops =3D NULL;
>1279   masked_info->port.client_ops =3D NULL;
>1280   memset(&masked_info->port.open_wait.head, 0, sizeof(struct list_hea=
d));
>1281   memset(&masked_info->port.delta_msr_wait.head, 0, sizeof(struct lis=
t_head));
>1282   memset(&masked_info->port.mutex.wait_list, 0, sizeof(struct list_he=
ad));
>1283   memset(&masked_info->port.buf_mutex.wait_list, 0, sizeof(struct lis=
t_head));
>1284   masked_info->port.xmit_buf =3D NULL;
>1285   masked_info->port.client_data =3D NULL;
>1286   masked_info->ctlp =3D NULL;
>1287   masked_info->xmit_buf =3D NULL;
>1288   memset(&masked_info->write_mtx.wait_list, 0, sizeof(struct list_hea=
d));
>1289 }
1290
1291 /*  IOCTL call handler into the driver */
1292 static int rp_ioctl(struct tty_struct *tty,
1293         unsigned int cmd, unsigned long arg)
1294 {
1295   struct r_port *info =3D tty->driver_data;
>1296   struct r_port *masked_info;
1297   void __user *argp =3D (void __user *)arg;
1298   int ret =3D 0;
1299
1300   if (cmd !=3D RCKP_GET_PORTS && rocket_paranoia_check(info, "rp_ioctl=
"))
1301     return -ENXIO;
1302   switch (cmd) {
1303   case RCKP_GET_STRUCT:
>1304     masked_info =3D kzalloc(sizeof (struct r_port), GFP_KERNEL);
>1305     mask_pointer(info, masked_info);
>1306     if (copy_to_user(argp, masked_info, sizeof (struct r_port)))
1307       ret =3D -EFAULT;

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2019=E5=B9=B43=E6=9C=8830=E6=
=97=A5=E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=883:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Sat, Mar 30, 2019 at 03:05:11PM +0800, Fuqian Huang wrote:
> > Hi, recently I found that there is a kernel address leaks to user
> > space via copy_to_user in
> > drivers/tty/rocket.c:1287 (linux-5.0.5)
> > static int rp_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned
> > long arg) {
> >   ...
> >   case RCKP_GET_STRUCT:
> >       if (copy_to_user(argp, info, sizeof(struct r_port))
> >   ...
> > }
> > The `info` is a struct r_port. and the field `r_port.port.ops` is an
> > constant pointer,
> > and it points to a constant object `rocket_port_ops` during the initial=
ization.
> > (function init_r_port) (drivers/tty/rocket.c:633)
> >
> > patch suggestion:
> > set the pointer field to null before the copy to user call.
>
> Great, can you send a patch to fix this so that you get the proper
> credit for finding and resolving it?
>
> thanks,
>
> greg k-h
