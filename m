Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8C3CA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4304C2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BPlFogKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfJ3R56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 13:57:58 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34617 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfJ3R55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:57:57 -0400
Received: by mail-yw1-f68.google.com with SMTP id d192so1161316ywa.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZAJAbO6qwXhLEfUbw+AhujMFfUXjrUZjKzqtdegXcpE=;
        b=BPlFogKNwpXdEhzfBA3vrd5InmBVlOAbu5jJZ69b6mMYO56ZV/S6tJfSnU5azKMjfk
         nTrUrFAtkDIw7vI63ZDJuuN6W1CvRnbjCYF8r3+YhE5mv0JoypVBxb2+StYO2fqB7x5Q
         j4JbvB5ILE2TW4sNBxA+9XI+Id64EYF4rjq+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZAJAbO6qwXhLEfUbw+AhujMFfUXjrUZjKzqtdegXcpE=;
        b=sqrOdIUguvzZ8CSdgWALgBKVdSsXzowLEbSlw1mmu3KsqJZqq42wLEvbC/nBxaA9Hl
         CaSSMp90z4VIiIcjjRgeInNn0dP245PwVLg91pcOX48qSi5Mw/FtfAvHRYtd3XZmQoT0
         ncImLZulkKw4TzhVPimu2t/fwlpMyB/QcbUh8F7oGRGdLt2Y/RUdyzYzRbsv4u4R8kw4
         GkAPOXCIw7oq5DJ87wIxnFLJv3ZjWPjmOnypru3oOf4cQUg+JsdesOtViVt5VeOZDUsT
         any82HLros+bG2p0Ih5yZy4JNhsdPxouo44uKhBJPm6QpdglzcaW718aXIxOHpjgbPGq
         CxCg==
X-Gm-Message-State: APjAAAW6z0AOKtPsqMise5c3YrPX+JKOw1SeDmjOfNVEOeXKYSXEVBb8
        CnVcBRhTj7HKnrE4w+CtIN7UzBsW/hY=
X-Google-Smtp-Source: APXvYqwVX8vZcKpyD7JBUABzq+PyOeOb4r3hKhdLDgdqDlgaUSTD1WffwCAzc3Z6Q2bOVUiJ19u2mQ==
X-Received: by 2002:a81:84c6:: with SMTP id u189mr676310ywf.351.1572458276780;
        Wed, 30 Oct 2019 10:57:56 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id s18sm417754ywk.33.2019.10.30.10.57.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 10:57:56 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id q1so3606740ion.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 10:57:56 -0700 (PDT)
X-Received: by 2002:a5d:9059:: with SMTP id v25mr996377ioq.58.1572457892344;
 Wed, 30 Oct 2019 10:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191030100618.1.Ibf7a996e4a58e84f11eec910938cfc3f9159c5de@changeid>
 <20191030173758.GC693@sol.localdomain>
In-Reply-To: <20191030173758.GC693@sol.localdomain>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Oct 2019 10:51:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uzma+eSGG1S1Aq6s3QdMNh4J-c=g-5uhB=0XBtkAawcA@mail.gmail.com>
Message-ID: <CAD=FV=Uzma+eSGG1S1Aq6s3QdMNh4J-c=g-5uhB=0XBtkAawcA@mail.gmail.com>
Subject: Re: [PATCH] Revert "ext4 crypto: fix to check feature status before
 get policy"
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>, Chao Yu <chao@kernel.org>,
        Ryo Hashimoto <hashimoto@chromium.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        Guenter Roeck <groeck@chromium.org>, apronin@chromium.org,
        linux-doc@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 30, 2019 at 10:38 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Hi Douglas,
>
> On Wed, Oct 30, 2019 at 10:06:25AM -0700, Douglas Anderson wrote:
> > This reverts commit 0642ea2409f3 ("ext4 crypto: fix to check feature
> > status before get policy").
> >
> > The commit made a clear and documented ABI change that is not backward
> > compatible.  There exists userspace code [1] that relied on the old
> > behavior and is now broken.
> >
> > While we could entertain the idea of updating the userspace code to
> > handle the ABI change, it's my understanding that in general ABI
> > changes that break userspace are frowned upon (to put it nicely).
> >
> > NOTE: if we for some reason do decide to entertain the idea of
> > allowing the ABI change and updating userspace, I'd appreciate any
> > help on how we should make the change.  Specifically the old code
> > relied on the different return values to differentiate between
> > "KeyState::NO_KEY" and "KeyState::NOT_SUPPORTED".  I'm no expert on
> > the ext4 encryption APIs (I just ended up here tracking down the
> > regression [2]) so I'd need a bit of handholding from someone.
> >
> > [1] https://chromium.googlesource.com/chromiumos/platform2/+/refs/heads/master/cryptohome/dircrypto_util.cc#73
> > [2] https://crbug.com/1018265
> >
> > Fixes: 0642ea2409f3 ("ext4 crypto: fix to check feature status before get policy")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  Documentation/filesystems/fscrypt.rst | 3 +--
> >  fs/ext4/ioctl.c                       | 2 --
> >  2 files changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
> > index 8a0700af9596..4289c29d7c5a 100644
> > --- a/Documentation/filesystems/fscrypt.rst
> > +++ b/Documentation/filesystems/fscrypt.rst
> > @@ -562,8 +562,7 @@ FS_IOC_GET_ENCRYPTION_POLICY_EX can fail with the following errors:
> >    or this kernel is too old to support FS_IOC_GET_ENCRYPTION_POLICY_EX
> >    (try FS_IOC_GET_ENCRYPTION_POLICY instead)
> >  - ``EOPNOTSUPP``: the kernel was not configured with encryption
> > -  support for this filesystem, or the filesystem superblock has not
> > -  had encryption enabled on it
> > +  support for this filesystem
> >  - ``EOVERFLOW``: the file is encrypted and uses a recognized
> >    encryption policy version, but the policy struct does not fit into
> >    the provided buffer
> > diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> > index 0b7f316fd30f..13d97fb797b4 100644
> > --- a/fs/ext4/ioctl.c
> > +++ b/fs/ext4/ioctl.c
> > @@ -1181,8 +1181,6 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >  #endif
> >       }
> >       case EXT4_IOC_GET_ENCRYPTION_POLICY:
> > -             if (!ext4_has_feature_encrypt(sb))
> > -                     return -EOPNOTSUPP;
> >               return fscrypt_ioctl_get_policy(filp, (void __user *)arg);
> >
>
> Thanks for reporting this.  Can you elaborate on exactly why returning
> EOPNOTSUPP breaks things in the Chrome OS code?  Since encryption is indeed not
> supported, why isn't "KeyState::NOT_SUPPORTED" correct?

I guess all I know is from the cryptohome source code I sent a link
to, which I'm not a super expert in.  Did you get a chance to take a
look at that?  As far as I can tell the code is doing something like
this:

1. If I see EOPNOTSUPP then this must be a kernel without ext4 crypto.
Fallback to using the old-style ecryptfs.

2. If I see ENODATA then this is a kernel with ext4 crypto but there's
no key yet.  We should set a key and (if necessarily) enable crypto on
the filesystem.

3. If I see no error then we're already good.


> Note that the state after this revert will be:
>
> - FS_IOC_GET_ENCRYPTION_POLICY on ext4 => ENODATA
> - FS_IOC_GET_ENCRYPTION_POLICY on f2fs => EOPNOTSUPP
> - FS_IOC_GET_ENCRYPTION_POLICY_EX on ext4 => EOPNOTSUPP
> - FS_IOC_GET_ENCRYPTION_POLICY_EX on f2fs => EOPNOTSUPP
>
> So if this code change is made, the documentation would need to be updated to
> explain that the error code from FS_IOC_GET_ENCRYPTION_POLICY is
> filesystem-specific (which we'd really like to avoid...), and that
> FS_IOC_GET_ENCRYPTION_POLICY_EX handles this case differently.  Or else the
> other three would need to be changed to ENODATA -- which for
> FS_IOC_GET_ENCRYPTION_POLICY on f2fs would be an ABI break in its own right,
> though it's possible that no one would notice.
>
> Is your proposal to keep the error filesystem-specific for now?

I guess I'd have to leave it up to the people who know this better.
Mostly I just saw this as an ABI change breaking userspace which to me
means revert.  I have very little background here to make good
decisions about the right way to move forward.


> BTW, the crbug.com link is not publicly viewable, so should not be included in
> the commit message.

My apologies.  It's public now.  Annoyingly they've been experimenting
with making bugs on crbug.com private by default (argh) and I didn't
notice.

-Doug
