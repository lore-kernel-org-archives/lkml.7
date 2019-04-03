Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2893C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB492084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FUQ1YtFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfDCTkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:40:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44107 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCTkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:40:49 -0400
Received: by mail-io1-f66.google.com with SMTP id u12so15097376iop.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 12:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w6htbD7bpeSSbPwrNrd992xBMhL5gvuzlwbreQ35tk4=;
        b=FUQ1YtFpa1VkYxxv9c0Fj/KiOe525ATJ38i+fKTtgcwPqRq8IQn4bZMTywiWlchnGE
         92T9sudVzcNSbD2bQGR8Azuogj9vu+S8feDeSulpjbazTg0dLauYxrZQBAFRLAV/WBWx
         jF4bzbnWx2FkIRuVv36EmSggOYcFmETO/+PhmHY/YuGlGzqHm09C5vprVhgw7uQCgPqm
         9kEf+KlqRSbpNSJlD+BclxkptlT+dpyc5Wo9VufuVcEeFe9iUVyeXsmAjhYa3rm42SuR
         dMWiDtwAE8y6B+uTHsZoqJmI5R35lcL14SCyTbzCoZuNrKKNd5SuY98o093nYAG/hShr
         y5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6htbD7bpeSSbPwrNrd992xBMhL5gvuzlwbreQ35tk4=;
        b=MC8Zn51yrsLxWQCMLcSOB5N0m7FvEGj/jSimyVy4b1Hk+aPj1hie861l1w8TujRawf
         lfDVYFMeQsuo/WbG1wAlaJc68AAnjqJjbHACNHCCMnO/h6zpZMv8R9+ajCXIEItmSi69
         0HiF2LjGAyWjYzZW5062pwPpt3xD7wA2FDa0Qmg4VwcRHZB5HVrsLy8fI9Y7i41bC3Vg
         0bfM+3RzgauAjspYps5ap+ytwJBfLpyEuThvXkv3pNVW7LSsQ5iszaigyU3DCLJj8YQZ
         i0wDG9YGZXWHGerLATukvJM06tq4Ot+t1cdrFfWsln5KzN/Ndy9MVVdDJzLHawJ8mAsG
         xWuw==
X-Gm-Message-State: APjAAAXIYDT62z0iNfbHe1jGu+ioY9gU6fWteqipBCCSb4UAqODDgUdJ
        omP/YB9MqYvzHRKRSk7gRoAajM0TKzTGcFmq+/xx2g==
X-Google-Smtp-Source: APXvYqzi1bDVMglVzYJ3r6pG7ZOvtXPshTexy1XVwW521fzCgZ2NPkJo4QgidQby6IKqJQqHcnd9GTpqmw8FcW/qIJY=
X-Received: by 2002:a5d:8543:: with SMTP id b3mr1386678ios.234.1554320448154;
 Wed, 03 Apr 2019 12:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190403183048.56750-1-egranata@chromium.org> <CABXOdTfvRryiMrFAe4wmvt5mm2k==b1BShbzHQ68vp5C3NFETA@mail.gmail.com>
In-Reply-To: <CABXOdTfvRryiMrFAe4wmvt5mm2k==b1BShbzHQ68vp5C3NFETA@mail.gmail.com>
From:   Enrico Granata <egranata@google.com>
Date:   Wed, 3 Apr 2019 12:40:37 -0700
Message-ID: <CAPR809u8L=_ykwShQ+E6of=S-0aGjandgzNgDDNgQ43UbMsWuA@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros_ec: check for NULL transfer function
To:     Guenter Roeck <groeck@google.com>
Cc:     Enrico Granata <egranata@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can certainly add a "did_print_error" flag or some such, but in
practice, if the transfer function is NULL, the initial handshake will
fail, and this will in turn cause EC registration to fail, and no
further communication should occur, so no further log entries will be
printed.

Thanks

Enrico Granata | egranata@google.com | ChromeOS | MTV1600


On Wed, Apr 3, 2019 at 11:51 AM Guenter Roeck <groeck@google.com> wrote:
>
> On Wed, Apr 3, 2019 at 11:31 AM <egranata@chromium.org> wrote:
> >
> > From: Enrico Granata <egranata@chromium.org>
> >
> > As new transfer mechanisms are added to the EC codebase, they may
> > not support v2 of the EC protocol.
> >
> > If the v3 initial handshake transfer fails, the kernel will try
> > and call cmd_xfer as a fallback. If v2 is not supported, cmd_xfer
> > will be NULL, and the code will end up causing a kernel panic.
> >
> > Add a check for NULL before calling the transfer function, along
> > with a helpful comment explaining how one might end up in this
> > situation.
> >
> > Signed-off-by: Enrico Granata <egranata@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_proto.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > index 97a068dff192d..953076ab401aa 100644
> > --- a/drivers/platform/chrome/cros_ec_proto.c
> > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > @@ -56,6 +56,16 @@ static int send_command(struct cros_ec_device *ec_dev,
> >         else
> >                 xfer_fxn = ec_dev->cmd_xfer;
> >
> > +       if (xfer_fxn == NULL) {
> > +               /* This error can happen if a communication error happened and
> > +                * the EC is trying to use protocol v2, on an underlying
> > +                * communication mechanism that does not support v2.
> > +                */
>
> I am not personally a friend of networking-style multi-line comments.
>
> > +               dev_err(ec_dev->dev,
> > +                       "missing EC transfer API, cannot send command\n");
>
> That message will be displayed each time a message is sent, ie in
> practice for each message. Is there any value in that, other than
> clogging the log ?
>
> Guenter
>
> > +               return -EIO;
> > +       }
> > +
> >         ret = (*xfer_fxn)(ec_dev, msg);
> >         if (msg->result == EC_RES_IN_PROGRESS) {
> >                 int i;
> > --
> > 2.21.0.392.gf8f6787159e-goog
> >
