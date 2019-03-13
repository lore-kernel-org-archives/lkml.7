Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0756EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C627620854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="RQN7wUH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfCMW3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:29:49 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43780 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbfCMW3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:29:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B025C8EE20E;
        Wed, 13 Mar 2019 15:29:44 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 48Q_u705JBQe; Wed, 13 Mar 2019 15:29:44 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 051F18EE0D2;
        Wed, 13 Mar 2019 15:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1552516184;
        bh=r0qSgSWg4HhILQOi2XjlmRp+jCcS7oMGYg6ben2L3Is=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RQN7wUH8BcDHZNLfCFGRK4rCaJyJpSZlBTRdaCZzVul2OydBAOzVxN6BGg41deR/j
         5FZbUkGTM2ZlBcuH1Tn3GErbtjSx4gCW/4FIFdM5/YyrR5L0q+IwF4x4LgO3LmmXLK
         rw61OMYN1NjoWpqzA16jOmfEKREaTKzJeptO588g=
Message-ID: <1552516183.2808.14.camel@HansenPartnership.com>
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
Date:   Wed, 13 Mar 2019 15:29:43 -0700
In-Reply-To: <20190313221325.GE10169@gmail.com>
References: <20190313151633.GA672@mit.edu>
         <1552491394.3022.8.camel@HansenPartnership.com>
         <20190313164439.GF672@mit.edu>
         <1552499104.3022.44.camel@HansenPartnership.com>
         <20190313185826.GA4685@mit.edu>
         <1552504672.3022.59.camel@HansenPartnership.com>
         <20190313195713.GC10169@gmail.com>
         <1552507566.3022.65.camel@HansenPartnership.com>
         <20190313202519.GD10169@gmail.com>
         <1552511069.3022.77.camel@HansenPartnership.com>
         <20190313221325.GE10169@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-13 at 15:13 -0700, Eric Biggers wrote:
> On Wed, Mar 13, 2019 at 02:04:29PM -0700, James Bottomley wrote:
> > On Wed, 2019-03-13 at 13:25 -0700, Eric Biggers wrote:
> > > On Wed, Mar 13, 2019 at 01:06:06PM -0700, James Bottomley wrote:
> > > > On Wed, 2019-03-13 at 12:57 -0700, Eric Biggers wrote:
> > 
> > [...]
> > > > > fscrypt would allow the data to be stored encrypted on the
> > > > > local disk, so it's protected against offline compromise of
> > > > > the disk.
> > > > 
> > > > Container images are essentially tars of the overlays.  They
> > > > only become actual filesystems when instantiated at
> > > > runtime.  The current encrypted container image is an overlay
> > > > or set of overlays which is tarred then encrypted.  So to
> > > > instantiate it is decrypted then untarred.
> > > > 
> > > > The thing I was wondering about was whether instead of a tar
> > > > encrypt we could instead produce an encrypted image from a
> > > > fscrypt filesystem.
> > > > 
> > > 
> > > Why do you care whether the container image is encrypted on the
> > > local disk, when you're extracting it in plaintext onto the local
> > > disk anyway each time it runs? Even after the runtime files are
> > > "deleted", they may still be recoverable from the disk.  Are you
> > > using shred and BLKSECDISCARD, and a non-COW filesystem?
> > > 
> > > Now, if you wanted to avoid writing the plaintext to disk
> > > entirely (and thereby use encryption to actually achieve a useful
> > > security property that can't be achieved through file
> > > permissions), fscrypt is a good solution for that.
> > 
> > OK let's start with a cloud and container 101: A container is an
> > exactly transportable IaaS environment containing an
> > application.  The format for the exact transport is the "container
> > image" I've been describing (layered tar file set deployed with
> > overlays).  These images are usually stored in cloud based
> > registries which may or may not have useful access controls.  I
> > take it the reason for image encryption to protect confidentiality
> > within the registry is obvious.
> > 
> > Because of the exact transport, the deployment may be on my laptop,
> > on my test system or in some type of public or private cloud.  In
> > all cases bar the laptop, I won't actually own the physical system
> > which ends up deploying the container.  So in exchange for security
> > guarantees from the physical system owner, I agree to turn over my
> > decryption key and possibly a cash payment.  One of these
> > guarantees is usually that they shred the key after use and that
> > they deploy a useful key escrow system like vault or keyprotect to
> > guard it even while the decryption is being done.
> 
> 
> > Another is that all traces of the container be shredded after the
> > execution is finished.
> 
> Well, sounds like that's not the case currently even with an
> encrypted container image, because the actual runtime files are not
> encrypted on disk.

Shredding means destroying all trace including in the on-disk image. 
However, one problem with the current implementation is there's a
window between container run and container stop where the unencrypted
files are in memory and on local disk.  Access or cockup in that window
can leak confidential data.

>   Encrypting the runtime files using fscrypt with an ephemeral key
> would be useful here.  IOW, randomly generate an encryption key when
> the container starts, never store it anywhere, and wipe it when the
> container stops.
> 
> Note that this is separate from the container *image* encryption.

Actually, that was my original thought: it needn't be.  If fscrypt can
usefully add runtime security, then we could have the encrypted layer
be simply an fscrypt image ... I presume without the key we can create
a tar image of an fscrypt that is encrypted and would still be visible
on untar if we did have the key?  So the encrypted layer would be a tar
of the fscrypt filesystem without the key.

> > considering is could I be protected against either cloud provider
> > cockups that might leak the image (the misconfigured backup
> > scenario I suggested) or malicious actions of other tenants.
> 
> If the container image is encrypted with a key not on the system,
> then its confidentiality is protected from anything that may happen
> on that system.
> 
> But if the container image encryption key *is* on the system, your
> container image may be leaked either accidentally or maliciously.

Well, yes, but that's like saying if you don't want to pick up a virus
from your network unplug it.  We have to look at ways of deploying the
filesystem and the key such that it's hard to exfiltrate ... which
seems to be similar to your android fscrypt use case.

James

