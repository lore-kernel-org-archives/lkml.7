Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9778EC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 21:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C0A206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 21:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl5+xrlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfLWVZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 16:25:07 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44610 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLWVZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 16:25:07 -0500
Received: by mail-io1-f68.google.com with SMTP id b10so17405267iof.11;
        Mon, 23 Dec 2019 13:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+IJjZvvHtC9PAvUtdm8hS7l9OXtbifWK1RLCc5V4WY=;
        b=Wl5+xrlKbGFGYnthfIO9SHO5ApUh8vQWBXmcGMpRRvVuB6gs6PqMQFBVIm/g2t8AzK
         HXEUiMYnxZvIvcWroHkNpZbP87mF3AKa3F4dhAArDILGclHkus2foICoVsnnjdh9kQ0B
         Kvz4YAX6d4C0RphuDrTUinbVZ4jU52oiEiOIHnouP7JhNx7+sjzKP5MqUsf26z4RimwC
         5EsvlIzce1ZdPtelTNqBjkePl3sfxY3jGXhcSxmkKAmFii5W/+iMZRxHXE8qIzSn+cdx
         bvqr8UtVQQulT9sVH3v7URDcYRxkJ0iGZfPHWRxnwVaSgNVCC0d3KbvaYepi9LxUY3Ix
         tf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+IJjZvvHtC9PAvUtdm8hS7l9OXtbifWK1RLCc5V4WY=;
        b=bWxt29DAd8ntnjA5GRNBGE4MrLxjInfx9DOjNTAuvjCoG9uZgICpRIeFEYxox7/bj/
         Nw2XJ9eNsfWMxL5pBrui89mHPFxZuRATlFlAAhSkjSyR70cF2cgwnqdOfYOMGStK3vYR
         6veKbT/7CtKEZGn4HYJ6FVSrjn+4saBBnVDrYwQHrnL+d1DJ3zXOYvwkAFfxkrydNFMZ
         gX/dq4qLBdS5GXLoRzQ7wDyry5LRd4YWBOfzKthUMGtYNZWuVAydM3NkITYLiGskn8oJ
         AuQk4JUujmfNnbRjykidKKVlqc2xCebzlet+SV9xsEUh0o4ahZzotCbZE4QMLpoJvZke
         PLXQ==
X-Gm-Message-State: APjAAAU7FK/9Bwr0qBkIwT7bYJCRicaFBV1doeZAw2+fZwDOZDDPrfC6
        G3w0z0p0TWbwVx/ElWtblIfxcp9PQ4/1nPllFXY=
X-Google-Smtp-Source: APXvYqzKyI9ZqbATSTk7ykfFNhYpDDFOPlSEMmy0+nFSKVR+kGNuoVrsnD6uD8iSavnFvFP9qEXLqW4RaQHmQQfaGKM=
X-Received: by 2002:a6b:b20a:: with SMTP id b10mr21990461iof.87.1577136306071;
 Mon, 23 Dec 2019 13:25:06 -0800 (PST)
MIME-Version: 1.0
References: <20191210003135.32427-1-jassisinghbrar@gmail.com> <87eexclkj0.fsf@gmail.com>
In-Reply-To: <87eexclkj0.fsf@gmail.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 23 Dec 2019 15:24:54 -0600
Message-ID: <CABb+yY00xOZw2uw6oK3N6RBcOurJjhiPXHs0ShCSVauwZn6TNw@mail.gmail.com>
Subject: Re: [PATCHv1 2/2] usb: gadget: add udc driver for max3420
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On Tue, Dec 10, 2019 at 1:13 AM Felipe Balbi <balbi@kernel.org> wrote:

> > +#define MAX3420_MAX_EPS              4
> > +#define EP_MAX_PACKET                64  /* Same for all Endpoints */
> > +#define EPNAME_SIZE          16  /* Buffer size for endpoint name */
> > +
> > +#define ACKSTAT              BIT(0)
>
> Let's prepend everything with MAX3420_.
>
OK

> > +
> > +#define MAX3420_REG_EPSTALLS 9
> > +     #define bACKSTAT        BIT(6)
>
> let's avoid CaMeLcAsE :-)
>
ok

> > +#define field(val, bit)      ((val) << (bit))
>
> The kernel has a bunch of helpers for this. Look at BIT() and GENMASK()
> for example.
>
ok

> > +struct max3420_req {
> > +     struct usb_request usb_req;
> > +     struct list_head queue;
> > +     struct max3420_ep *ep;
> > +};
> > +
> > +struct max3420_ep {
> > +     struct max3420_udc *udc;
> > +     struct list_head queue;
> > +     char name[EPNAME_SIZE];
> > +     unsigned int maxpacket;
> > +     struct usb_ep ep_usb;
>
> considering you'll run container_of() on this ep_usb field, it's wise to
> put it as the first field in the struct. That way, compiler can optimize
> container_of() into a simple type cast.
>
ok

> > +struct max3420_udc {
> > +     struct max3420_ep ep[MAX3420_MAX_EPS];
> > +     struct usb_gadget_driver *driver;
> > +     struct task_struct *thread_task;
> > +     int remote_wkp, is_selfpowered;
> > +     bool vbus_active, softconnect;
> > +     struct usb_ctrlrequest setup;
> > +     struct mutex spi_bus_mutex;
> > +     struct max3420_req ep0req;
> > +     struct usb_gadget gadget;
>
> likewise with gadget field.
>
ok

>> +     spi_message_add_tail(&transfer, &msg);
>> +     spi_sync(spi, &msg);
> Not checking return code?
ok.

> > +     if (todo == ENABLE) {
> > +             epdis &= ~BIT(ep->id + 4);
> > +             epien |= BIT(ep->id + 1);
> > +     } else {
> > +             epdis |= BIT(ep->id + 4);
> > +             epien &= ~BIT(ep->id + 1);
> > +     }
> > +
> > +     spi_wr8(udc, MAX3420_REG_CLRTOGS, epdis);
> > +     spi_wr8(udc, MAX3420_REG_EPIEN, epien);
> > +
> > +     return 1;
>
> Usually we return 0 on success and a negative errno on failure. What do
> you mean here by return 1?
>
ok


> > +             ep->halted = 0;
> > +             epstalls &= ~BIT(ep->id + 1);
> > +             clrtogs = spi_rd8(udc, MAX3420_REG_CLRTOGS);
> > +             clrtogs |= BIT(ep->id + 1);
> > +             spi_wr8(udc, MAX3420_REG_CLRTOGS, clrtogs);
> > +     }
> > +     spi_wr8(udc, MAX3420_REG_EPSTALLS, epstalls | bACKSTAT);
> > +
> > +     return 1;
>
> and here?
>
ok


> > +
> > +     /* Clear Remote-WkUp Signal*/
> > +     usbctl = spi_rd8(udc, MAX3420_REG_USBCTL);
> > +     usbctl &= ~bSIGRWU;
> > +     spi_wr8(udc, MAX3420_REG_USBCTL, usbctl);
> > +
> > +     udc->suspended = false;
> > +
> > +     return 1;
>
> here?
>
ok


> > +
> > +static void __max3420_start(struct max3420_udc *udc)
> > +{
> > +     u8 val;
> > +
> > +     /* Need this delay if bus-powered */
> > +     msleep_interruptible(250);
>
> should you check if you're bus powered?
>
for some reason, even for self-powered, it helped reliability.


> > +
> > +static int do_data(struct max3420_udc *udc, int ep_id, int in)
>
> add a max3420_ prefix like all other functions
>
ok


> > +
> > +static int max3420_thread(void *dev_id)
>
> Why do you need this thread? Sure you can't live without it?
>
All the slow spi-bus transfers are handled at one place here without
blocking any api call. IMO it is cleaner and easier to manage.


> > +static struct usb_request *max3420_alloc_request(struct usb_ep *_ep,
> > +                                                 gfp_t gfp_flags)
> > +{
> > +     struct max3420_ep *ep = to_max3420_ep(_ep);
> > +     struct max3420_req *req;
> > +
> > +     req = kzalloc(sizeof(*req), gfp_flags);
> > +     if (!req)
> > +             return NULL;
> > +
> > +     req->ep = ep;
> > +     INIT_LIST_HEAD(&req->queue);
>
> unnecessary list initialization
>
ok.

Thank you!
