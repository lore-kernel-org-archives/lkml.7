Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B03C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6376B2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bj2NYJPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfFMUZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:25:56 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43833 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfFMUZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:25:55 -0400
Received: by mail-io1-f68.google.com with SMTP id k20so749291ios.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 13:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxJBMcBvwVkpAf1cgG4dPli24Ww6q68XEHKC5A8aObk=;
        b=bj2NYJPmryyGgICLn1E4HRmF1agezEr1mo/1DGIrMGTjMFw2iRKv0i5eOhE8Zta66r
         U6KFwJt4gOWZi92tahMKfmQ8UY8j/pm+wRNG67dGzNobX9JOaEDJGZJVbFDwUGqEwzg2
         cnnWpEBl0bH0iH50UGlUHlLISbl3cSfjL8rEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxJBMcBvwVkpAf1cgG4dPli24Ww6q68XEHKC5A8aObk=;
        b=qE1VbD5jFJyJj6gsN4hJNlLf9wTX0FJzdbo+ugjU9qusWCERsjIxIhQ4trqrM0elG7
         FMuyxGsxL0+t2kmuBsDIzYRIFJzKnzrw4/tenpIvqj0QQeGpEDCkh0h2LHdbMAN5XKsr
         3Tc+jDS+IAW64G731joEILfc0FydP/nOA7GiY8vl8MsZB9kmFfE6uVryrRSZu5NqcbIo
         WT0Z47aR6XJ/umgie6bvlJoFEYCxtjwfnWbij6B/VUqpotln5hlQ7AD+pn+lVye5/5kW
         w0izl8voHgbguU1azviLa6biLqXRIXVcYqUw52FQRs+Aff3PdqbYQYib8oNRnuN2f3Go
         fz0w==
X-Gm-Message-State: APjAAAVeGEYht1/6/7G1ePnvUf27PBtqk3+eeAqSCMHE5YEo2cKywbTx
        D0svKdehBZHCZRdYj5/U13/EKA5Jcmb0xVVD1mHHmA==
X-Google-Smtp-Source: APXvYqz+u/akT0s3tkUOtvxwHIrlqT8vSdlw0YMYd4SB0cK2+55b9TPncxxRXStL5TgLhYKlUMfXiQLo1cX/FwEAB+w=
X-Received: by 2002:a6b:7e41:: with SMTP id k1mr14643948ioq.285.1560457555275;
 Thu, 13 Jun 2019 13:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190612225431.p753mzqynxpsazb7@brauner.io> <CAHk-=wh2Khe1Lj-Pdu3o2cXxumL1hegg_1JZGJXki6cchg_Q2Q@mail.gmail.com>
 <20190613132250.u65yawzvf4voifea@brauner.io> <871rzxwcz7.fsf@xmission.com>
In-Reply-To: <871rzxwcz7.fsf@xmission.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 13 Jun 2019 22:25:44 +0200
Message-ID: <CAJfpegvZwDY+zoWjDTrPpMCS01rzQgeE-_z-QtGfvcRnoamzgg@mail.gmail.com>
Subject: Re: Regression for MS_MOVE on kernel v5.1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 8:35 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Christian Brauner <christian@brauner.io> writes:
>
> > On Wed, Jun 12, 2019 at 06:00:39PM -1000, Linus Torvalds wrote:
> >> On Wed, Jun 12, 2019 at 12:54 PM Christian Brauner <christian@brauner.io> wrote:
> >> >
> >> > The commit changes the internal logic to lock mounts when propagating
> >> > mounts (user+)mount namespaces and - I believe - causes do_mount_move()
> >> > to fail at:
> >>
> >> You mean 'do_move_mount()'.
> >>
> >> > if (old->mnt.mnt_flags & MNT_LOCKED)
> >> >         goto out;
> >> >
> >> > If that's indeed the case we should either revert this commit (reverts
> >> > cleanly, just tested it) or find a fix.
> >>
> >> Hmm.. I'm not entirely sure of the logic here, and just looking at
> >> that commit 3bd045cc9c4b ("separate copying and locking mount tree on
> >> cross-userns copies") doesn't make me go "Ahh" either.
> >>
> >> Al? My gut feel is that we need to just revert, since this was in 5.1
> >> and it's getting reasonably late in 5.2 too. But maybe you go "guys,
> >> don't be silly, this is easily fixed with this one-liner".
> >
> > David and I have been staring at that code today for a while together.
> > I think I made some sense of it.
> > One thing we weren't absolutely sure is if the old MS_MOVE behavior was
> > intentional or a bug. If it is a bug we have a problem since we quite
> > heavily rely on this...
>
> It was intentional.
>
> The only mounts that are locked in propagation are the mounts that
> propagate together.  If you see the mounts come in as individuals you
> can always see/manipulate/work with the underlying mount.
>
> I can think of only a few ways for MNT_LOCKED to become set:
> a) unshare(CLONE_NEWNS)
> b) mount --rclone /path/to/mnt/tree /path/to/propagation/point
> c) mount --move /path/to/mnt/tree /path/to/propgation/point
>
> Nothing in the target namespace should be locked on the propgation point
> but all of the new mounts that came across as a unit should be locked
> together.

Locked together means the root of the new mount tree doesn't have
MNT_LOCKED set, but all mounts below do have MNT_LOCKED, right?

Isn't the bug here that the root mount gets MNT_LOCKED as well?

>
> Then it breaking is definitely a regression that needs to be fixed.
>
> I believe the problematic change as made because the new mount
> api allows attaching floating mounts.  Or that was the plan last I
> looked.   Those floating mounts don't have a mnt_ns so will result
> in a NULL pointer dereference when they are attached.

Well, it's called anonymous namespace.  So there *is* an mnt_ns, and
its lifetime is bound to the file returned by fsmount().

Thanks,
Miklos
