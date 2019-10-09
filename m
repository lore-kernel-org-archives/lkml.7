Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C936ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B5E20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBFu8F8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbfJIPBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:01:01 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41304 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfJIPBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:01:00 -0400
Received: by mail-io1-f65.google.com with SMTP id n26so5623428ioj.8;
        Wed, 09 Oct 2019 08:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qg77rKEV8sqoLJ5jhRaIbmkXA6q29h9mmik7MN3d40o=;
        b=DBFu8F8pitsJc/XeCuYmIOmz/XeDfO8iPVA5qBl0Hng0UDpOL5c85YOX10xJ/DBJDM
         H4f78gzVwHqM1KZF97D5vu6jvUtumy0W9niJ+VX6xMTuS+VpULdhVQPqrznKVSo9KcC1
         1awuWTNRBljBx9Fu6ns5Ju2PoxcE8kRnb05yz7IsI7cIXgsdG734iOjuBbHL/M43bKu7
         8mlnOVhYASOcJQgv4QlT8A6V4TsHwLn/lScfytU5PtpwJ7Y0owJeL9CXwpoHaTu7tZsZ
         yyxK+lN12zN6fKmqYRlDgDh4/rTMBfM0BvMpDXvtRAtBuncjeG7yXEHH+4X67COdXw0a
         wn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qg77rKEV8sqoLJ5jhRaIbmkXA6q29h9mmik7MN3d40o=;
        b=s0VD+56FWGTjTAiWdfn+2JlCgDwffpNhG92JQFAINqVNjV5pvCL4xBfkQS+hNAwoGw
         0r9ayFq0BK3qro5bapuP3a+Ubcq0QAMtNAG0tNAqcS/klWzXqnlW59ygUEvyCZmZpck5
         EmxJGgFA3Thesw3UNn9bvtcMBh5LT+ROJU8pZtIaTYBUeboLV4Lb3IqzlLUbfBcp2zs1
         awJxo7gmtym6OSxx03C3r/Y/Xswqgmy9uvLl0Ae2uaGtzQ1L03X3KrwVe7+iVCcdPtgu
         7QBVG1ObLGJl0iLOjyy53ZNoqcSqF+DTlI8oB1PJYtg2t3Ivrb8W4GykAs3gU3GwMu64
         4aTA==
X-Gm-Message-State: APjAAAWmlDplDyXHz5wOH5VSJz7oXDENIUku4ZlCmEPsAkz6AQzPw3sj
        Q1pYibyGILuL9pIzRyJqrH/wrz7mnZVjEMHlTFI=
X-Google-Smtp-Source: APXvYqw93Pdi9hgF7K3HQPP09GXqR3W0N7qXz2FnTwPB5ntxxhR0Ilu7PEHpEagAUY05ysSuXX5kkMLZK+pHevvrnW8=
X-Received: by 2002:a5e:8711:: with SMTP id y17mr3922522ioj.227.1570633259375;
 Wed, 09 Oct 2019 08:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190913235505.9164-1-navid.emamdoost@gmail.com> <6de2396d-eaa4-5cb4-9a1d-f253503bcf48@xs4all.nl>
In-Reply-To: <6de2396d-eaa4-5cb4-9a1d-f253503bcf48@xs4all.nl>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Wed, 9 Oct 2019 10:00:48 -0500
Message-ID: <CAEkB2ESWm2woq6LLxOUGaLVwszg4uRNMmVEatnPXsyu1XDvSvA@mail.gmail.com>
Subject: Re: [PATCH] media: usb: fix memory leak in af9005_identify_state
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Wed, Oct 9, 2019 at 7:42 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 9/14/19 1:55 AM, Navid Emamdoost wrote:
> > In af9005_identify_state when returning -EIO the allocated buffer should
> > be released.
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >  drivers/media/usb/dvb-usb/af9005.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/usb/dvb-usb/af9005.c b/drivers/media/usb/dvb-usb/af9005.c
> > index 02697d86e8c1..aee500beaab6 100644
> > --- a/drivers/media/usb/dvb-usb/af9005.c
> > +++ b/drivers/media/usb/dvb-usb/af9005.c
> > @@ -975,8 +975,10 @@ static int af9005_identify_state(struct usb_device *udev,
> >               *cold = 1;
> >       else if (reply == 0x02)
> >               *cold = 0;
> > -     else
> > +     else {
> > +             kfree(buf);
> >               return -EIO;
> > +     }
>
> Why not just set ret = -EIO; here?
>
This makes sense. I will send a v2.

> You only need to add a
>
>         if (!ret)
> >       deb_info("Identify state cold = %d\n", *cold);
>
> before this line.
>
> So this becomes:
>
>         else
>                 ret = -EIO;
>         if (!ret)
>                 deb_info("Identify state cold = %d\n", *cold);
>
> Regards,
>
>         Hans
>
> >
> >  err:
> >
>


-- 
Navid.
