Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4BEC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8504C21743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfEUGnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:43:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35039 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfEUGnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:43:42 -0400
Received: by mail-qt1-f193.google.com with SMTP id a39so19280684qtk.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 23:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gro6bYpyJjEyBjnoN8cxKbYz7QpgKEPbeHJeHV938fM=;
        b=o70lWBtNq+9lVO/+3WktlfA3Qcx5KEFT3di9wEW7mVBfZ/9MPxVh5FBvU/XhRYmKfT
         PMgfvDzZuIiyt5Mw7tLRPANDpOZhMIRPRbXkTJGNUWvH3W+piLE6+54p6JWM++F18pCi
         dPBuoQ+oV8JLzi9kE2idkuTmcrqWj3brLVUNFsF/y6AQpvU20GpeAdARz7Tp75rpK+PW
         r4+7LxbEUQ2mwADs+F/LNhQWFgY3h2lfZbBlQduNnEiq+0HJf/puBjyKvzHEP+YwKvR6
         TNDA9U13K2hDxBQeWHJtOSHKSazJl1EtNBtDQBiJnsa9CqmQwqvv74qsvcM5R4o914ok
         Za6A==
X-Gm-Message-State: APjAAAXllQ5rMgO0Ap09pr9yCBcsBd6qzWO4mj43Gz4mMqL2mavAkvdg
        3XP5kFC+c/zc5QhUGI+P9JORzZqi7d6EtB2uR7yo3A==
X-Google-Smtp-Source: APXvYqxXn1go1qbpDCG2yWak7kaOv1RYHlLtQD7wJZmZnmwbmMBNnw+06Lou9G3h+HjhnOOY/oD7Ff7vM7mbiHjnR+o=
X-Received: by 2002:ac8:875:: with SMTP id x50mr65243976qth.345.1558421021479;
 Mon, 20 May 2019 23:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190519072711.2592-1-aaron.ma@canonical.com> <20190521051053.GD183429@dtor-ws>
In-Reply-To: <20190521051053.GD183429@dtor-ws>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 21 May 2019 08:43:29 +0200
Message-ID: <CAO-hwJ+edn3SD8Z=yc1gOWRsA8_=uPTAHc18PkDhV2y7ackTPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Input: elantech - enable middle button support on 2 ThinkPads
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Cc:     Aaron Ma <aaron.ma@canonical.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 21, 2019 at 7:11 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Aaron,
>
> On Sun, May 19, 2019 at 03:27:10PM +0800, Aaron Ma wrote:
> > Adding 2 new touchpad PNPIDs to enable middle button support.
>
> Could you add their names in the comments please?
>
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> > ---
> >  drivers/input/mouse/elantech.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> > index a7f8b1614559..530142b5a115 100644
> > --- a/drivers/input/mouse/elantech.c
> > +++ b/drivers/input/mouse/elantech.c
> > @@ -1189,6 +1189,8 @@ static const char * const middle_button_pnp_ids[] = {
> >       "LEN2132", /* ThinkPad P52 */
> >       "LEN2133", /* ThinkPad P72 w/ NFC */
> >       "LEN2134", /* ThinkPad P72 */
> > +     "LEN0407",

AFAICT, this one is the Lenovo P53.
However, having a whitelist of new models is not going to scale IMO.

I was thinking at submitting a patch to enable middle button
unconditionally, but then I realized that libinput disables middle
click emulation on touchpads with an actual physical middle button.

And this morning I just realized that we might have a better chance at
this if we consider the new models to have the physical middle button.
I know LEN0407 attempts to bind over SMBus, so I would think we can
reduce the set of whitelist by just checking for
ETP_NEW_IC_SMBUS_HOST_NOTIFY (patch coming in).

Cheers,
Benjamin

> > +     "LEN0408",
>
> These should come first - I'd like to keep the list sorted
> alphabetically.
>
> >       NULL
> >  };
> >
> > --
> > 2.17.1
> >
>
> Thanks.
>
> --
> Dmitry
