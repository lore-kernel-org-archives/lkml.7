Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20242C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BAD21E6A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="GVi7fMSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfHGMfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 08:35:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46800 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfHGMfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 08:35:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so91209662wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 05:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kzfiKrOfhO3DLsT1TlErtHyd7ui9YJUBIjOmwytOTlI=;
        b=GVi7fMSAjlMO9idivA3+c6CjKv4HWaNruHvJBIQSMbDCDgCMLDr7pl9xz5LQzuFgrt
         /wkrhUnI4jRlhCJ1oajcqv2Wd8f3itiCuT2ZZQultAoxeEKSm5vQ0Q9ZSeA0g9YoHFk/
         NyG7WP0Q5BUNG02hgQmPYaBHNW7vV80/NE09Cz1IQ+NBy8/u2hU4eDDpXOAjC465i9zM
         mlHUUMWRBSwsxTE7bzGEjg5eTHCk6pxVnWpV/1POYLXj7BjFg17ECg1irV8VfPpTJEI4
         HBJdcWcFtjR2FqWrbXOc5uEC/tDYLerIbUy0830FyGZ1NTIwSVnAWFLgd2BtkhDxdN8/
         umVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kzfiKrOfhO3DLsT1TlErtHyd7ui9YJUBIjOmwytOTlI=;
        b=MwdeXS+ehf9/2u3z24+vm4XX/x/RWG4Bb/veO+Z/r70lECAMBb72ubyIaxcudCXZtX
         1Z0LH/45nWjUpMVxJ8H2pMxglBDILRA+k668OdW+3f/K7pSXjyLT2OQ7hQrclIaUGHk6
         qTFRpeCtwSxo55d0QNPpCMWSfKl2j2cRXBR+EW0GJ0Y5gaj42piiZf6lCy76AEqojxrw
         eFJ8LSgkjqiyxOjKKnicw1BMJ0dahbKpQrfGhpNvZTqm78qrWfHniIZMvw++IEmuH9PP
         +TEZDTO9IZSmlRkUsj4GFSBib16EoCoDX6FxWDfIIqErvVf8fniPsarnQypLKqyZRgbp
         Xoeg==
X-Gm-Message-State: APjAAAXVUi0uo8JC1/UugrvN3jUOzGBR5u2RQGuW++DZSsY1aG6DOnaV
        CFvsr3fin2Hexm7DTnh4eYI8NtZu+wic3BT4gMD6lQ==
X-Google-Smtp-Source: APXvYqwdbQmIHPnEVap4ssVFw6r+F1SKoVRLrwBJRqCX8DzyReJycSvWfGErwOXUDFFaO+UUv1taWQ6Ma8eIk9nIuWs=
X-Received: by 2002:adf:f204:: with SMTP id p4mr11158616wro.317.1565181331907;
 Wed, 07 Aug 2019 05:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffEkotpvVz8FA78vNFh0qZv3kEMNrXXfVPEUC=MhH0pMCZA@mail.gmail.com>
 <0a83fde3-1a74-684c-0d70-fb44b9021f96@molgen.mpg.de> <CAMGffE=_kPoBmSwbxvrqdqbhpR5Cu2Vbe4ArGqm9ns9+iVEH_g@mail.gmail.com>
 <CAMGffEkcXcQC+kjwdH0iVSrFDk-o+dp+b3Q1qz4z=R=6D+QqLQ@mail.gmail.com>
 <87h86vjhv0.fsf@notabene.neil.brown.name> <CAMGffEnKXQJBbDS8Yi0S5ZKEMHVJ2_SKVPHeb9Rcd6oT_8eTuw@mail.gmail.com>
 <CAMGffEkfs0KsuWX8vGY==1dym78d6wsao_otSjzBAPzwGtoQcw@mail.gmail.com>
 <87blx1kglx.fsf@notabene.neil.brown.name> <CAMGffE=cpxumr0QqJsiGGKpmZr+4a0BiCx3n0_twa5KPs=yX1g@mail.gmail.com>
In-Reply-To: <CAMGffE=cpxumr0QqJsiGGKpmZr+4a0BiCx3n0_twa5KPs=yX1g@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 7 Aug 2019 14:35:20 +0200
Message-ID: <CAMGffEm41+-DvUu_MhfbVURL_LOY8KP1QkTWDcFf7nyGLK7Y3A@mail.gmail.com>
Subject: Re: Bisected: Kernel 4.14 + has 3 times higher write IO latency than
 Kernel 4.4 with raid1
To:     NeilBrown <neilb@suse.com>
Cc:     Neil F Brown <nfbrown@suse.com>,
        Alexandr Iarygin <alexandr.iarygin@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-kernel@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 8:36 AM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
>
> On Wed, Aug 7, 2019 at 1:40 AM NeilBrown <neilb@suse.com> wrote:
> >
> > On Tue, Aug 06 2019, Jinpu Wang wrote:
> >
> > > On Tue, Aug 6, 2019 at 9:54 AM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
> > >>
> > >> On Tue, Aug 6, 2019 at 1:46 AM NeilBrown <neilb@suse.com> wrote:
> > >> >
> > >> > On Mon, Aug 05 2019, Jinpu Wang wrote:
> > >> >
> > >> > > Hi Neil,
> > >> > >
> > >> > > For the md higher write IO latency problem, I bisected it to these commits:
> > >> > >
> > >> > > 4ad23a97 MD: use per-cpu counter for writes_pending
> > >> > > 210f7cd percpu-refcount: support synchronous switch to atomic mode.
> > >> > >
> > >> > > Do you maybe have an idea? How can we fix it?
> > >> >
> > >> > Hmmm.... not sure.
> > >> Hi Neil,
> > >>
> > >> Thanks for reply, detailed result in line.
> >
> > Thanks for the extra testing.
> > ...
> > > [  105.133299] md md0 in_sync is 0, sb_flags 2, recovery 3, external
> > > 0, safemode 0, recovery_cp 524288
> > ...
> >
> > ahh - the resync was still happening.  That explains why set_in_sync()
> > is being called so often.  If you wait for sync to complete (or create
> > the array with --assume-clean) you should see more normal behaviour.
> I've updated my tests accordingly, thanks for the hint.
> >
> > This patch should fix it.  I think we can do better but it would be more
> > complex so no suitable for backports to -stable.
> >
> > Once you confirm it works, I'll send it upstream with a
> > Reported-and-Tested-by from you.
> >
> > Thanks,
> > NeilBrown
>
> Thanks a lot, Neil, my quick test show, yes, it fixed the problem for me.
>
> I will run more tests to be sure, will report back the test result.
Hi Neil,

I've run our regression tests with your patch, everything works fine
as expected.

So Reported-and-Tested-by: Jack Wang <jinpu.wang@cloud.ionos.com>

Thank you for your quick fix.

The patch should go to stable 4.12+

Regards,
Jack Wang

>
> Regards,
> Jack Wang
>
> >
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index 24638ccedce4..624cf1ac43dc 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -8900,6 +8900,7 @@ void md_check_recovery(struct mddev *mddev)
> >
> >         if (mddev_trylock(mddev)) {
> >                 int spares = 0;
> > +               bool try_set_sync = mddev->safemode != 0;
> >
> >                 if (!mddev->external && mddev->safemode == 1)
> >                         mddev->safemode = 0;
> > @@ -8945,7 +8946,7 @@ void md_check_recovery(struct mddev *mddev)
> >                         }
> >                 }
> >
> > -               if (!mddev->external && !mddev->in_sync) {
> > +               if (try_set_sync && !mddev->external && !mddev->in_sync) {
> >                         spin_lock(&mddev->lock);
> >                         set_in_sync(mddev);
> >                         spin_unlock(&mddev->lock);
