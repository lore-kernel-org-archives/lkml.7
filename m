Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030B8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADC820854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="BC9/LJya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfCMUGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:06:10 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41202 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726263AbfCMUGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:06:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D55FA8EE20E;
        Wed, 13 Mar 2019 13:06:08 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TKSqYGIVD7Km; Wed, 13 Mar 2019 13:06:08 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EE2F28EE0D2;
        Wed, 13 Mar 2019 13:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1552507568;
        bh=SREgWgB3PyVIm4d3tabGZNSIILFTRIDn74XIrRjIxM0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BC9/LJyaER1SrRd5hbqJ1mSjtWpnyNQpCsIB2wXcSYH35U1Cc8s0OVHQEV1gJ48hP
         pn7XKYPpjw/nMn0j8dCh7jVBKyklYXN/M7S9TG7oOSVSjxxdm3Xa+peyuWElWUmgaN
         MVv9DbKm9gKv/kKn1IXqWDsWAnBfKEZXqgqqCepg=
Message-ID: <1552507566.3022.65.camel@HansenPartnership.com>
Subject: Re: overlayfs vs. fscrypt
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Amir Goldstein <amir73il@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Date:   Wed, 13 Mar 2019 13:06:06 -0700
In-Reply-To: <20190313195713.GC10169@gmail.com>
References: <1854703.ve7plDhYWt@blindfold>
         <CAJfpegtgfuAkgv26QH6Ht25OeMiev-QvEf7ror4KAbud7FADgg@mail.gmail.com>
         <4066872.KGdO14EQMx@blindfold>
         <CAOQ4uxhqQKzriL0An4Tvzc1E_LffL-z9q1otOW_RdD1ZdKWP3Q@mail.gmail.com>
         <20190313151633.GA672@mit.edu>
         <1552491394.3022.8.camel@HansenPartnership.com>
         <20190313164439.GF672@mit.edu>
         <1552499104.3022.44.camel@HansenPartnership.com>
         <20190313185826.GA4685@mit.edu>
         <1552504672.3022.59.camel@HansenPartnership.com>
         <20190313195713.GC10169@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-13 at 12:57 -0700, Eric Biggers wrote:
> On Wed, Mar 13, 2019 at 12:17:52PM -0700, James Bottomley wrote:
> > On Wed, 2019-03-13 at 14:58 -0400, Theodore Ts'o wrote:
> > > On Wed, Mar 13, 2019 at 10:45:04AM -0700, James Bottomley wrote:
> > > > >   If they can't break root, then the OS's user-id based
> > > > > access control checks (or SELinux checks if you are using
> > > > > SELinux) will still protect you.
> > > > 
> > > > Well, that's what one would think about the recent runc exploit
> > > > as well.  The thing I was looking to do was reduce the chances
> > > > that unencrypted data would be lying around to be
> > > > discovered.  I suppose the potentially biggest problem is
> > > > leaking the image after it's decrypted by admin means like a
> > > > badly configured backup, but unencryped data is potentially
> > > > discoverable by breakouts as well.
> > > 
> > > But while the container is running, the key is available and
> > > instantiated in the kernel, and the kernel is free to decrypt any
> > > encrypted file/block.
> > 
> > In the current encrypted tar file implementation, while the
> > container is running the decrypted tar file is extracted into the
> > container root and available for all to see.
> > 
> > The main security benefit of this implementation, as I said, is
> > security of at rest images and the runtime security is guaranteed
> > by other systems.
> 
> That's not security at rest, because you're decrypting the data and
> storing it onto the local disk.

I mean image at rest and image running.  The local disk untar only
happens for running image.

> fscrypt would allow the data to be stored encrypted on the local
> disk, so it's protected against offline compromise of the disk.

Container images are essentially tars of the overlays.  They only
become actual filesystems when instantiated at runtime.  The current
encrypted container image is an overlay or set of overlays which is
tarred then encrypted.  So to instantiate it is decrypted then
untarred.

The thing I was wondering about was whether instead of a tar encrypt we
could instead produce an encrypted image from a fscrypt filesystem.

James


> It would not prevent an attacker who has escalated to root or kernel
> privileges from reading the data while the container is running,
> because that would be impossible.
> 
> It would also not prevent non-root users from reading the data,
> because the kernel already has a huge variety of access control
> mechanisms that can do this and can be used alongside fscrypt.
> 
> > 
> > >   The reason why the kernel won't do this is because of its
> > > access control checks.
> > > 
> > > And we're talking about this within the context of the overlayfs.
> > > When in the container world will we have persistent data that
> > > lasts beyond the lifetime of the running container that will be
> > > using overlayfs?  I didn't think that existed; if you are using,
> > > say, a Docker storage volume, does overlayfs ever get into the
> > > act?  And if so, how, and what are the desired security
> > > properties?
> > 
> > Are you asking about persistent volumes?  I can answer, but that's
> > not the current use case.  The current use case is encrypted
> > images, which are overlays.  If you mean the misconfigured backup
> > comment then I was thinking a backup that wrongly sweeps container
> > root while the container is running.
> > 
> > Lets go back to basics: can fscrypt provide equivalent or better
> > protection than the current encrypted tarfile approach?  If the
> > answer is no because it's too tightly tied to the android use case
> > then perhaps there's not much point discussing it further.
> > 
> 
> It's not tied to the Android use case.  As I mentioned, fscrypt has
> many other users, and it wasn't even originally designed for Android.
> 
> - Eric
> 

