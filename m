Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC164C388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 17:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E5821841
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 17:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fIyWSvup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfI0RG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 13:06:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34756 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0RG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 13:06:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id m19so2885516otp.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 10:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALyAWMAI/62LhKP4HzTSdIuPJ7a2yvozUW+yWtavY40=;
        b=fIyWSvupwowEAIsu3jKA3dQhU1zT+i2O8SwrnljrD9weISuLv+5yqA+VP9e1IZRy9P
         GQ1ton4ajwL62G0DS9LJbV3Bi2i/jeksqu/rwtkpSyeYVn4mD94lF5QOzULXMvrJWFGT
         knxuDU3ljt4ja9JuTP7WzLGYfgRvceH1SCKVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALyAWMAI/62LhKP4HzTSdIuPJ7a2yvozUW+yWtavY40=;
        b=TPaCWuEVkTVi2eJNQhmoyQfrI5vFYHanenFCQ6qqVO+ZRNrnt5RdKptOwhfSzEpCyY
         eYcCNligS1XhfBTYRLFpBoCqQ+bvpEe/xgFRFAkQzOuv68aR9uMBv8zIUWvdhtq+UZCM
         3TSRfjH5d61eMRNhaDpE4fExUburFyNZTPtUFfANOlS810Ezbs5IK217LDT5zy/Vi73y
         fcUIVw6Baxzcv/N2Uoz49kkCP6GahqmqSCXhpiDhQt0Jkij3ui2IKvTDm8e35qj8b2zw
         wMoqrh2i/jmPTumhBQa+jP8mEFMkUSfkiCJrvJij8r+K/Ez72jiWBPplXsEh8Y9PNvie
         lv7Q==
X-Gm-Message-State: APjAAAXwCDaJKw5VC44dyz11uO4eJBSeHz+u6n3VJSG2P5fJR2e6+PlL
        9N1+1RVKliTDPCC4Ffan1ItP4TVRsH8=
X-Google-Smtp-Source: APXvYqxM5rgFSE4hI2vvsMD3ur/Oq59oAZqNCfXcabPDhSebi8zsJeWFTuTA5YgGsaZIBSffLED4Vw==
X-Received: by 2002:a9d:6d82:: with SMTP id x2mr3892945otp.42.1569603985466;
        Fri, 27 Sep 2019 10:06:25 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id v132sm1864892oif.34.2019.09.27.10.06.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 10:06:24 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 41so2825337oti.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 10:06:24 -0700 (PDT)
X-Received: by 2002:a9d:621a:: with SMTP id g26mr3946061otj.236.1569603984106;
 Fri, 27 Sep 2019 10:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190621135907.112232-1-yuehaibing@huawei.com>
 <CAHX4x86qUKPTkRFWvWMgTMh1VY8ogJfr55khsSJTakS0emiyFA@mail.gmail.com> <CANLzEkvw-UGKh-OE91PiHUvOnjjdbTngnUNwFC4f54h8e3v+9A@mail.gmail.com>
In-Reply-To: <CANLzEkvw-UGKh-OE91PiHUvOnjjdbTngnUNwFC4f54h8e3v+9A@mail.gmail.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Fri, 27 Sep 2019 11:06:12 -0600
X-Gmail-Original-Message-ID: <CAHX4x85wF=q7FxAB9Fpzm4qYiu0_Ad2gQDNJqReY81rDTYrXsg@mail.gmail.com>
Message-ID: <CAHX4x85wF=q7FxAB9Fpzm4qYiu0_Ad2gQDNJqReY81rDTYrXsg@mail.gmail.com>
Subject: Re: [PATCH -next] platform/chrome: wilco_ec: Use kmemdup in enqueue_events()
To:     Benson Leung <bleung@chromium.org>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 4:43 PM Benson Leung <bleung@chromium.org> wrote:
>
> Hey Nick,
> On Fri, Jun 21, 2019 at 7:51 AM Nick Crews <ncrews@chromium.org> wrote:
> >
> > Thanks Yue, looks good to me.
> >
> > Nick
> >
> > On Fri, Jun 21, 2019 at 7:59 AM YueHaibing <yuehaibing@huawei.com> wrote:
> > >
> > > Use kmemdup rather than duplicating its implementation
> > >
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > > ---
> > >  drivers/platform/chrome/wilco_ec/event.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
> > > index c975b76e6255..70156e75047e 100644
> > > --- a/drivers/platform/chrome/wilco_ec/event.c
> > > +++ b/drivers/platform/chrome/wilco_ec/event.c
> > > @@ -248,10 +248,9 @@ static int enqueue_events(struct acpi_device *adev, const u8 *buf, u32 length)
> > >                 offset += event_size;
> > >
> > >                 /* Copy event into the queue */
> > > -               queue_event = kzalloc(event_size, GFP_KERNEL);
> > > +               queue_event = kmemdup(event, event_size, GFP_KERNEL);
> > >                 if (!queue_event)
> > >                         return -ENOMEM;
> > > -               memcpy(queue_event, event, event_size);
> > >                 event_queue_push(dev_data->events, queue_event);
> > >         }
> > >
> > >
> > >
>
> Looks like this was already incorporated into your commit,
> platform/chrome: wilco_ec: Use kmemdup in enqueue_events().

Thanks for the note Benson, but I think that must have
been a copy pasta error, it was actually included in
"platform/chrome: wilco_ec: Add circular buffer as event queue"
just so there isn't any confusion later :)

Nick

>
> Thanks!
> Benson
>
> --
> Benson Leung
> Staff Software Engineer
> Chrome OS Kernel
> Google Inc.
> bleung@google.com
> Chromium OS Project
> bleung@chromium.org
