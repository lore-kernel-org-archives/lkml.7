Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6BEC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98F0206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfHMN6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:58:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33175 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfHMN6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:58:18 -0400
Received: by mail-qt1-f193.google.com with SMTP id v38so14010887qtb.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UPqVMYRKgPny4jLiI9xhCyK5fHo3cjEgQkb61xfTW14=;
        b=Ht/wlkQ3/o7iL/GMhB7+8huXacIDzH6/udFZQ/tuB6daV1LqAt6+UyB5aEPHl1M1fy
         zYE3Xf3qfo4kK6n/Ml3RsncFshlE9HIg+Kaju6MKxcFK8y+gRmh3oJ4045zz6jhLpl7e
         vs1Gzi6+CtMRhsa6R5cNCaoKmksiFG83CMT8A1Q6GKZBsbzfbgGR8hGCt1INOiVwICLH
         54+UhFkbDzCED8W+APXwN5IEsM+LT00YT45h9ZjnOrAQvcCz0UmJqTrxHiRiGEeIPyXF
         +IXkNw7nnuhLLT5TeB8Elqnw2zxhDlTF8Mc0Vmab+g20sjhaRsRW23SLekhm4vigRJvC
         /qIA==
X-Gm-Message-State: APjAAAVoTyv/Es6fIFAYghTb51fsv3Z05nZXwLpjMOjS+dUbyP3A5baI
        oklH69ENBFwj5mlUeBdCprFxMnfE4obZtOOtokVnIA==
X-Google-Smtp-Source: APXvYqxy/SPlI+Cs61J60nUWTgxDhSCy4ll/DIFc9AjaGYIslLEaCx/268hAHASOAYIHZAC4N3artjmCpjkrdYYGjIA=
X-Received: by 2002:ac8:33c7:: with SMTP id d7mr20342902qtb.294.1565704696825;
 Tue, 13 Aug 2019 06:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190812162105.13428-1-benjamin.tissoires@redhat.com> <CADyDSO4x49GWdRVkW=cytvMc7rM3NJkJ4-Sj-FjM9Gday7C-iw@mail.gmail.com>
In-Reply-To: <CADyDSO4x49GWdRVkW=cytvMc7rM3NJkJ4-Sj-FjM9Gday7C-iw@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 13 Aug 2019 15:58:05 +0200
Message-ID: <CAO-hwJ+z0szwuQrUxpQhii2z_jwxMX91df0ynK5QbZpMhg79-g@mail.gmail.com>
Subject: Re: [PATCH] HID: uhid: actually use the err number from userspace
To:     David Rheinsberg <david.rheinsberg@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 12:50 PM David Rheinsberg
<david.rheinsberg@gmail.com> wrote:
>
> Hey
>
> On Mon, Aug 12, 2019 at 6:21 PM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > This can help debugging the situation
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >
> > Hi,
> >
> > not entirely sure if we can use this in a such simple way.
> >
> > However, this is useful to mimic device behaviour from userspace.
> >
> > Cheers,
> > Benjamin
> >
> >  drivers/hid/uhid.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> > index fa0cc0899827..2fa32e7fc733 100644
> > --- a/drivers/hid/uhid.c
> > +++ b/drivers/hid/uhid.c
> > @@ -284,7 +284,7 @@ static int uhid_hid_set_report(struct hid_device *hid, unsigned char rnum,
> >                 goto unlock;
> >
> >         if (uhid->report_buf.u.set_report_reply.err)
> > -               ret = -EIO;
> > +               ret = -uhid->report_buf.u.set_report_reply.err;
>
> I am generally in favor of this. But:
>
> 1) can you do this for both set_report *and* get_report?

right :)

>
> 2) I think you have to filter some of the error codes. For instance,
> if you return one of the -ERESTARTSYS codes, this might cause the
> syscall to restart (if auto-restart is enabled on this context). At
> the same time, this is not *that* bad. It might even be useful for the
> userspace driver to trigger an EINTR. At least we should be aware of
> this. So maybe filters are not necessary.. Mhhh. Comments?

I haven't thought at all of the side effects of letting the user
return a random error code.
I have the impression that anything below EHWPOISON (133) is
relatively safe. So maybe we should just make sure the error code is
below 134?

The ERESTARTSYS has a few warnings in the include file, so I guess the
side effects might be too much for what we want to deal with.

Cheers,
Benjamin

>
> Thanks
> David
>
> >         else
> >                 ret = count;
> >
> > --
> > 2.19.2
> >
