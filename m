Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4DEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BE1206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7SSI3hJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbfCYKBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:01:33 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35730 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbfCYKBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:01:32 -0400
Received: by mail-oi1-f196.google.com with SMTP id j132so6463106oib.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QwhCg3B6/Un3AFC6Nt3b3MPD02mF4rhTJlHoVqv3zhY=;
        b=a7SSI3hJe8Xxr63an4B0fRaFyl1HDSJ/YdPxQQQTZM69WDWA/7CVWxrKB/1JnY86vq
         W8tu2wgvObA1IX0jSJ99/Y+ZWVorctXtvbwac26whAy78J7YjiNKsMOYSDT8fpD1smfZ
         Wqpo3mQ3GXWcs1kiLyBr5BNRCaD2NFfFQ0sxTw44SM3Ums6ELvmnbO7o6m4CGPaMUeIo
         El6jd5P46uM+ekskDmfeEV8dfOgucPth3Soxmck4iWfzG9RczWonClE2ApJkVZ5AENhW
         dES97Z/ojaiQDSGTc5LH0mRqBgBuhuu+Qae+PNLt3WZezoziF9bESLs1KSsBNH8ZTK7M
         jL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QwhCg3B6/Un3AFC6Nt3b3MPD02mF4rhTJlHoVqv3zhY=;
        b=fh+rtCwVJGuG7QGx1KaXJQ9lKfu9KTp7kiTCypygjPnGrW9k8qQ4ZGEBm3WoAg0/ke
         FR+AAi6LNgxWsftt5g40dPGvdqv9HwyyfRJ4GwDKGfvIH/MMgEoQo3qfOEMp4ljvbNBm
         xXjYYH04KofLpfjuEg/RR2guebeJVpR0pKCt0vrLTuhQBJFqeTTL/81DBWG0dZ5oWvRv
         IXJ/qxEpFz//tViesmrhkcWwqj7X7fVLKRct9BRRqRX0+7CxVsO9EeMHFrmdB/drufxf
         wKX/oCeO3qwQ1bJv0Vgm+bi0t8Pm1Ix3xZbuSUzK3g2cCvzc7goh5aeMV3zpjMtD7e//
         PXZw==
X-Gm-Message-State: APjAAAV1h8yQ9L8TxOCEcjpB4O+GytsFzngMVkg5yvN0YmNaMQ7muhQL
        5eMOnqA1qk6Trzq9t7A9oOvZa4Jyh36l9dQ/KNTf45v7Zzw=
X-Google-Smtp-Source: APXvYqwdSH5T7tcjZ4I52oUp9mWoMmEHHS44hbyNdehtrMni8i3kHprXOPuRK1JowsjpsLmBYkLY/ac32IIV8VC4gJ0=
X-Received: by 2002:aca:7505:: with SMTP id q5mr10620768oic.126.1553508092041;
 Mon, 25 Mar 2019 03:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190313064557.GA14531@unicorn.suse.cz> <20190320211813.GE29968@unicorn.suse.cz>
 <CADVatmNVM3a=L6McdCsr5xzCwZnW6N4r9Cf55gjQZjsGGosBDg@mail.gmail.com>
 <1572645.oXzt2vILsi@alaris> <20190324193838.ubiljot22zhf5mjq@debian> <20190325073045.GC26076@unicorn.suse.cz>
In-Reply-To: <20190325073045.GC26076@unicorn.suse.cz>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 25 Mar 2019 10:00:54 +0000
Message-ID: <CADVatmMX-HcORGXUdiBZn6hx4CAqZzyz_TGx=e0HwuPm-xoLsw@mail.gmail.com>
Subject: Re: regression (bisected): "modprobe parport_pc" hangs in current mainline
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 7:30 AM Michal Kubecek <mkubecek@suse.cz> wrote:
>
> On Sun, Mar 24, 2019 at 07:38:38PM +0000, Sudip Mukherjee wrote:
> > And I was able to reproduce the problem using a vm and Suse Tumblewood with
> > next-20190322. Can you please try the attached patch and test on your vm and
> > machine and check if it fixes the problem.
> >
> > --
> > Regards
> > Sudip
>
> > diff --git a/drivers/parport/share.c b/drivers/parport/share.c
> > index 0171b8dbcdcd..f87948fbfc34 100644
> > --- a/drivers/parport/share.c
> > +++ b/drivers/parport/share.c
> > @@ -274,7 +274,7 @@ static int port_check(struct device *dev, void *dev_drv)
> >  int __parport_register_driver(struct parport_driver *drv, struct module *owner,
> >                             const char *mod_name)
> >  {
> > -     if (list_empty(&portlist))
> > +     if (list_empty(&portlist) && strcmp(drv->name, "daisy_drv"))
> >               get_lowlevel_driver();
> >
> >       if (drv->devmodel) {
>
> Yes, with this patch (on top of v5.1-rc2), both physical machine and VM
> let the module(s) load cleanly even with the alias line restored.
>
> Tested-by: Michal Kubecek <mkubecek@suse.cz>

Thanks Michal. I will add it to my queue with your Tested-by.

btw, I think I liked using Suse. :)


-- 
Regards
Sudip
