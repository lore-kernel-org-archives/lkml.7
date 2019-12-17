Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8568C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF92206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWEV3DCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfLQLsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:48:02 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33648 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfLQLsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:48:02 -0500
Received: by mail-oi1-f194.google.com with SMTP id v140so5191967oie.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 03:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EAdxW05i7d7gW+a6Wba66sBPKj5tpTYH9ExE5qq5cGU=;
        b=lWEV3DCJyy4L98m+vavG9UF/W/9ctfPRui0uJK+G8yw3G5Vpzin17Fyjjj8IE/71ot
         bonRRZfevyyKy0C99HJgyXeepnDEOBzZ6ZZ+K0c8RyCyeO5igLiD6h4a0Z4/OFxZDL2M
         dNlQbnYyESCziKRARI6owpeRG1pHTXe355OLKK5u5t0cNphlt+G2gcGcAXFoS9Pb/SgF
         +3wMvZ7beiDRbwPLMyGsQ7GnEPOh5EnqOHc581bXcdpM74xcRsyKl8FOudzZmuk9ISn0
         c+7bbqM4w+jPNGcumVnBWXNph2k1VERFhOz2ytYbDsbognT45MxeCbIAFSUZRutd9KFF
         tsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EAdxW05i7d7gW+a6Wba66sBPKj5tpTYH9ExE5qq5cGU=;
        b=W57WjpnjjrwZmg00asLlV93AM3ss08AM5cyVLxkTt+j09pEvVahilBpWNPTJB+4OY6
         6OYv7v2LACwGF5jppIGg1eDv5v5Xm8u9nXZbaKuR/vVYisW92f+uYfOBZNEBjMtCToIb
         yPnK55w2hNvOQnyDRRtGW/Cstxv7ndozQyq5Wz1w8fEGQizyVO3lxqTZBkpGzKWX9JGa
         eL4zWEUmldW7FGxD6UgVjV/v26AD1BRYyEtJZUgK5ywXsKfYHAA/jklRpb/5l2CBlsmo
         lk4zUx2MJxx/LakpJv/FN8Pq8crZYZZtdHwiOhi9bDysZjhjl9R8hV93Jjc2aKLbBY03
         wjdg==
X-Gm-Message-State: APjAAAUEqRkQzTd25qDl4cfv6sF9QvaOBmHuECUP1UY2v8WTZT3jJ5xH
        iwZ9T1Sz0+686xtjYaisymzBlx0xejaWAHj/bhjV9YkW
X-Google-Smtp-Source: APXvYqz+7DTgeFdpT15jtAObL66M3PmDh49qpopKxYwm2aGnFSuFDPh6WiuGcDIHkOUnWWYxsnaCsJeAazJ0twv+QFY=
X-Received: by 2002:a05:6808:312:: with SMTP id i18mr1384548oie.44.1576583281345;
 Tue, 17 Dec 2019 03:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20191121152239.28405-1-sudipm.mukherjee@gmail.com>
 <20191121152239.28405-2-sudipm.mukherjee@gmail.com> <20191121164138.GD651886@kroah.com>
 <20191121210155.limd7v6cpd5yz2e7@debian> <eef58b47-f208-2ac5-6e02-a87f9568c70f@suse.com>
 <20191210114147.ivple4ccr4bj6c4h@debian> <20191212111519.GA1534818@kroah.com>
In-Reply-To: <20191212111519.GA1534818@kroah.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Tue, 17 Dec 2019 11:47:25 +0000
Message-ID: <CADVatmMK=dCaAzdHbmQ6Qj5gqcvSiL3BRZDL6jnEM2G_C3pUpw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tty: use tty_init_dev_retry() to workaround a race condition
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Dec 12, 2019 at 11:15 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Dec 10, 2019 at 11:41:47AM +0000, Sudip Mukherjee wrote:
> > Hi Jiri,
> >
> > On Fri, Nov 22, 2019 at 10:05:09AM +0100, Jiri Slaby wrote:
> > > On 21. 11. 19, 22:01, Sudip Mukherjee wrote:
> > > > Hi Greg,
> > > >
> > > > On Thu, Nov 21, 2019 at 05:41:38PM +0100, Greg Kroah-Hartman wrote:
> > > >> On Thu, Nov 21, 2019 at 03:22:39PM +0000, Sudip Mukherjee wrote:
> > > >>> There seems to be a race condition in tty drivers and I could see on
> > > >>> many boot cycles a NULL pointer dereference as tty_init_dev() tries to
> > > >>> do 'tty->port->itty = tty' even though tty->port is NULL.
> > <snip>
> > > >>>
> > > >>> uart_add_one_port() registers the console, as soon as it registers, the
> > > >>> userspace tries to use it and that leads to tty_open() but
> > > >>> uart_add_one_port() has not yet done tty_port_link_device() and so
> > > >>> tty->port is not yet configured when control reaches tty_init_dev().
> > > >>
> > > >> Shouldn't we do tty_port_link_device() before uart_add_one_port() to
> > > >> remove that race?  Once you register the console, yes, tty_open() can
> > > >> happen, so the driver had better be ready to go at that point in time.
> > > >>
> > > >
> > > > But tty_port_link_device() is done by uart_add_one_port() itself.
> > > > After registering the console uart_add_one_port() will call
> > > > tty_port_register_device_attr_serdev() and tty_port_link_device() is
> > > > called from this. Thats still tty core.
> > >
> > > Interferences of console vs tty code are ugly. Does it help to simply
> > > put tty_port_link_device to uart_add_one_port before uart_configure_port?
> >
> > sorry for the late response, got busy with an out-of-tree driver.
> >
> > It fixes the problem if I put tty_port_link_device() before
> > uart_configure_port(). Please check the attached patch and that
> > completely fixes the problem. Do you want me to send a proper patch for
> > it or do you want me to check more into it?
>
> This looks a lot more sane to me, can you resend it in proper format so
> that I can apply it?

https://lore.kernel.org/lkml/20191212131602.29504-1-sudipm.mukherjee@gmail.com/


-- 
Regards
Sudip
