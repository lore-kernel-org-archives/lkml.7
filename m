Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D842DC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48C321743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfEUGtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:49:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38016 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfEUGtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:49:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id l3so8475166qtj.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 23:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EX+RbZ2QuclOpIncZJaA9lb0b+yqy0TQx8yZ2oQxaGo=;
        b=pKhnnwBbtqAcjqr+fcNhFu04tOUo1mgrX2WhegDG3jYXfeTBvxVrVpqryNYzEAL7eu
         UclUT55JLAP6O5PogEhYgXacbIIZbea6rS0i0MYtsM/tQaZ/vBE4RNUnhyP+9T8LIhht
         10KlKJ7aJ4Paav0Bt3kYhslIPiL0sX64K0x7zQguZ2b0wUexM8oTcjOzKH32Ig0GQVFT
         L+zmqCwckAkVAP2G9wcavwZHzvPeDh5fUeGmcuTEIilLo8P4j/rclLs96rwpUCq5HmtG
         vWz+K2nrzyi4lw/xu5vPunuk1dHqQfAq4UgkTC/v6FPg/DYekYTYjbsp9hKZNKDie4RM
         t2mQ==
X-Gm-Message-State: APjAAAUqL6INFbNRleHqOOvZlFpP16eCG6O9rFp81DiVSBj97/nfe2WZ
        WXghMX97WGsxoirN1qdj1wZD5eY3hhRajonDu8fO0qUEAU8=
X-Google-Smtp-Source: APXvYqyD1l2cT5B/5llVtcVwpmWYQWV+ifAU8LYZS74s9QsQIt96L5e8QfeClbxaEnEp5eYzrP3zcOzgimj1lhpL+9o=
X-Received: by 2002:ac8:1a59:: with SMTP id q25mr67748115qtk.154.1558421359749;
 Mon, 20 May 2019 23:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190519072711.2592-1-aaron.ma@canonical.com> <20190519072711.2592-2-aaron.ma@canonical.com>
 <20190521050850.GC183429@dtor-ws>
In-Reply-To: <20190521050850.GC183429@dtor-ws>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 21 May 2019 08:49:08 +0200
Message-ID: <CAO-hwJLXB8Qec9Yhz0y6WgvEpE6KHk_53g4VtPGj9mfvMzk4dg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Input: synaptics - remove X240 from the topbuttonpad list
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Aaron Ma <aaron.ma@canonical.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Christopher Heiny <Cheiny@synaptics.com>,
        Andrew Duggan <aduggan@synaptics.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 7:09 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Aaron,
>
> On Sun, May 19, 2019 at 03:27:11PM +0800, Aaron Ma wrote:
> > Lenovo ThinkPad X240 does not have the top software button.
> > When this wrong ID in top button list, smbus mode will fail to probe,
> > so keep it working at PS2 mode.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> > ---
> >  drivers/input/mouse/synaptics.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> > index b6da0c1267e3..6ae7bc92476b 100644
> > --- a/drivers/input/mouse/synaptics.c
> > +++ b/drivers/input/mouse/synaptics.c
> > @@ -140,7 +140,6 @@ static const char * const topbuttonpad_pnp_ids[] = {
> >       "LEN002E",
> >       "LEN0033", /* Helix */
> >       "LEN0034", /* T431s, L440, L540, T540, W540, X1 Carbon 2nd */
> > -     "LEN0035", /* X240 */
>
> According to the history this came from Synaptics through Hans, so I'd
> like to make sure there are no several X240 versions floating around...

A quick google image search showed that the X240 had 2 versions: one
with the top software buttons, one without.

And this definitively rings a bell. I am sure we asked Lenovo and
Synaptics to change the PnPID when they would do such a change, but
they "forgot" during the *40 series refresh.
We have code in place to fix the reported ranges of the coordinates,
and we had to check against the board id (see min_max_pnpid_table[] in
synaptics.c).
Unfortunately, X240 (LEN0035) is not part of this table, so I don't
know which refresh of the board ID has implemented the non top
software buttons.

Cheers,
Benjamin


>
> >       "LEN0036", /* T440 */
> >       "LEN0037", /* X1 Carbon 2nd */
> >       "LEN0038",
> > --
> > 2.17.1
> >
>
> Thanks.
>
> --
> Dmitry
