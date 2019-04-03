Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42D8C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BBC206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hCkWrRfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfDCTxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:53:53 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37336 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCTxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:53:53 -0400
Received: by mail-yb1-f196.google.com with SMTP id o1so72280ybo.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 12:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pc15GEkJMlnZyPlA04ohBA8jL5M0SXCgs6HZOVzQF5o=;
        b=hCkWrRfyyjXoVKdtDOXyrPYQrb2j+9pIOIEejGbjO83nV11ZdULTC91ogu5bDOHqyl
         agZVOAqAWQoG60CbdqoZVCj/0zKyFxfqXXA37ljXW0mpldFZ69pPpXTybDzFXyvKr4el
         +zyma+maHnCYN1kNqKxDiGoK6XqPzRkPo9z/mHfZyj/CcRkRTdQhNCFe9mvZcnmjMXL5
         UVkVOSK84DCs11V7SzMil3GsBoG2HUCis6H9VfJ9N395B66/GAgkRqDENG1foAtRqEXQ
         CIDQPvyXPpe5yi+Mq1NRV2J8GO97XY/VnTDLksZ4XoM2DTsCutZnIBJoejmGLIMFyDlk
         BHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pc15GEkJMlnZyPlA04ohBA8jL5M0SXCgs6HZOVzQF5o=;
        b=BKm3gXDosOV5pQLJonn9jz/9CuqehwJ6pyUOHgw38muFu5SBVt/AYp9vjsoL0taocD
         GeN2ODRqWfLlYgX6dj3IzpuUGImkhkboEJ5O/tHF9ZRFSfth9WeE9vFNLffiwnDAGCnP
         ZwERNAj93Y4msMlUANOziTlfCZl+5PKUHlertPal6qvIMz7I+m1w5jtzu6pFERsSTJdu
         TNmfDVa8FXwjpeB3v5ptxjJC+upznaj7DDwGHruIMayFhTX0WG0j4ugsoYyj535sGKJV
         uLEfA2rIA8aN8a3ZxkSRuQ3vkqnoixDRm5GFwZCKZIXVRQDdzx5Q953Sd3Fv60zgj4TD
         50VA==
X-Gm-Message-State: APjAAAXchCoOmlqH+OYXrYvx6ZgUv0scbewUpxdCqzDoRFjsVqdX8FSX
        +PAY4GIPCWuXV5HI00LoRr9TOQXT5ZU0Z3gr2d5Mug==
X-Google-Smtp-Source: APXvYqxM1KQ784C3mgPVWy/XypYz9S/PyYFzbsb/S1NI1J6D/+xTgBC/wXXR4R5m7iGSr6mnbOjE0XNnU8NRAQzbzp4=
X-Received: by 2002:a25:65d4:: with SMTP id z203mr1836151ybb.370.1554321231914;
 Wed, 03 Apr 2019 12:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190403183048.56750-1-egranata@chromium.org> <CABXOdTfvRryiMrFAe4wmvt5mm2k==b1BShbzHQ68vp5C3NFETA@mail.gmail.com>
 <CAPR809vTZSFtNp61WQsOFRkFacO_8XEdicqFq9uYMkUMdjEsqg@mail.gmail.com>
In-Reply-To: <CAPR809vTZSFtNp61WQsOFRkFacO_8XEdicqFq9uYMkUMdjEsqg@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 3 Apr 2019 12:53:40 -0700
Message-ID: <CABXOdTeE5=iF24+2JxwjvGtVtFmneYJWC4yXgX1Ah4y+=+ecEg@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros_ec: check for NULL transfer function
To:     Enrico Granata <egranata@google.com>
Cc:     Enrico Granata <egranata@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 12:40 PM Enrico Granata <egranata@google.com> wrote:
>
> I can certainly add a "did_print_error" flag or some such, but in practic=
e, if the transfer function is NULL, the initial handshake will fail, and t=
his will in turn cause EC registration to fail, and no further communicatio=
n should occur, so no further log entries will be printed.
>
Sorry, I am a bit lost. Why would dev_err_once() not work ?

Guenter

> Thanks
>
> Enrico Granata | egranata@google.com | ChromeOS | MTV1600
>
>
> On Wed, Apr 3, 2019 at 11:51 AM Guenter Roeck <groeck@google.com> wrote:
>>
>> On Wed, Apr 3, 2019 at 11:31 AM <egranata@chromium.org> wrote:
>> >
>> > From: Enrico Granata <egranata@chromium.org>
>> >
>> > As new transfer mechanisms are added to the EC codebase, they may
>> > not support v2 of the EC protocol.
>> >
>> > If the v3 initial handshake transfer fails, the kernel will try
>> > and call cmd_xfer as a fallback. If v2 is not supported, cmd_xfer
>> > will be NULL, and the code will end up causing a kernel panic.
>> >
>> > Add a check for NULL before calling the transfer function, along
>> > with a helpful comment explaining how one might end up in this
>> > situation.
>> >
>> > Signed-off-by: Enrico Granata <egranata@chromium.org>
>> > ---
>> >  drivers/platform/chrome/cros_ec_proto.c | 10 ++++++++++
>> >  1 file changed, 10 insertions(+)
>> >
>> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platfor=
m/chrome/cros_ec_proto.c
>> > index 97a068dff192d..953076ab401aa 100644
>> > --- a/drivers/platform/chrome/cros_ec_proto.c
>> > +++ b/drivers/platform/chrome/cros_ec_proto.c
>> > @@ -56,6 +56,16 @@ static int send_command(struct cros_ec_device *ec_d=
ev,
>> >         else
>> >                 xfer_fxn =3D ec_dev->cmd_xfer;
>> >
>> > +       if (xfer_fxn =3D=3D NULL) {
>> > +               /* This error can happen if a communication error happ=
ened and
>> > +                * the EC is trying to use protocol v2, on an underlyi=
ng
>> > +                * communication mechanism that does not support v2.
>> > +                */
>>
>> I am not personally a friend of networking-style multi-line comments.
>>
>> > +               dev_err(ec_dev->dev,
>> > +                       "missing EC transfer API, cannot send command\=
n");
>>
>> That message will be displayed each time a message is sent, ie in
>> practice for each message. Is there any value in that, other than
>> clogging the log ?
>>
>> Guenter
>>
>> > +               return -EIO;
>> > +       }
>> > +
>> >         ret =3D (*xfer_fxn)(ec_dev, msg);
>> >         if (msg->result =3D=3D EC_RES_IN_PROGRESS) {
>> >                 int i;
>> > --
>> > 2.21.0.392.gf8f6787159e-goog
>> >
