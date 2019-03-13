Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7219C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B922146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552515211;
	bh=nbNmEu5Quhv0lQswbwaJX/eeMbO9RTCsG55kylmzjzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hoUChffgpyWfwzxAFctQNUMmpGpGvFrr6Ws9z8vVAMTaQhBqbH0Jet4BooZGZE2DN
	 Ker4WbcIjylqOItLJEivuOI8KrCFOaBJiERUhgBAEtDQa2W2z7TLi4mcnb6wGBeZR2
	 9yQnmtmWYvgqjfusKhYra/I3VSSYKj91nPba1Gno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfCMWNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfCMWN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:13:29 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB29A21019;
        Wed, 13 Mar 2019 22:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552515208;
        bh=nbNmEu5Quhv0lQswbwaJX/eeMbO9RTCsG55kylmzjzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Us8zrarG9Qg2lUnCPvVA2xh/lrgbdVGn9WUjOC0nAbSIUNu/lbPHlTHb+wg7cgITU
         VhqR8PBDKRsHVkIh34RtPjxRNfUZxrJ7x3bnGBUYJlx3iGK9JLkX9JSVWDSUIBaReI
         Zg6TpRNLpR8zo8PZW9371nB00fK4sjv3dlIXORUI=
Date:   Wed, 13 Mar 2019 15:13:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Amir Goldstein <amir73il@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Subject: Re: overlayfs vs. fscrypt
Message-ID: <20190313221325.GE10169@gmail.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552511069.3022.77.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 02:04:29PM -0700, James Bottomley wrote:
> On Wed, 2019-03-13 at 13:25 -0700, Eric Biggers wrote:
> > On Wed, Mar 13, 2019 at 01:06:06PM -0700, James Bottomley wrote:
> > > On Wed, 2019-03-13 at 12:57 -0700, Eric Biggers wrote:
> [...]
> > > > fscrypt would allow the data to be stored encrypted on the local
> > > > disk, so it's protected against offline compromise of the disk.
> > > 
> > > Container images are essentially tars of the overlays.  They only
> > > become actual filesystems when instantiated at runtime.  The
> > > current encrypted container image is an overlay or set of overlays
> > > which is tarred then encrypted.  So to instantiate it is decrypted
> > > then untarred.
> > > 
> > > The thing I was wondering about was whether instead of a tar
> > > encrypt we could instead produce an encrypted image from a fscrypt
> > > filesystem.
> > > 
> > 
> > Why do you care whether the container image is encrypted on the local
> > disk, when you're extracting it in plaintext onto the local disk
> > anyway each time it runs? Even after the runtime files are "deleted",
> > they may still be recoverable from the disk.  Are you using shred and
> > BLKSECDISCARD, and a non-COW filesystem?
> > 
> > Now, if you wanted to avoid writing the plaintext to disk entirely
> > (and thereby use encryption to actually achieve a useful security
> > property that can't be achieved through file permissions), fscrypt is
> > a good solution for that.
> 
> OK let's start with a cloud and container 101: A container is an
> exactly transportable IaaS environment containing an application.  The
> format for the exact transport is the "container image" I've been
> describing (layered tar file set deployed with overlays).  These images
> are usually stored in cloud based registries which may or may not have
> useful access controls.  I take it the reason for image encryption to
> protect confidentiality within the registry is obvious.
> 
> Because of the exact transport, the deployment may be on my laptop, on
> my test system or in some type of public or private cloud.  In all
> cases bar the laptop, I won't actually own the physical system which
> ends up deploying the container.  So in exchange for security
> guarantees from the physical system owner, I agree to turn over my
> decryption key and possibly a cash payment.  One of these guarantees is
> usually that they shred the key after use and that they deploy a useful
> key escrow system like vault or keyprotect to guard it even while the
> decryption is being done.


> Another is that all traces of the container be shredded after the execution is
> finished.

Well, sounds like that's not the case currently even with an encrypted container
image, because the actual runtime files are not encrypted on disk.  Encrypting
the runtime files using fscrypt with an ephemeral key would be useful here.
IOW, randomly generate an encryption key when the container starts, never store
it anywhere, and wipe it when the container stops.

Note that this is separate from the container *image* encryption.

> considering is could I be protected against either cloud provider
> cockups that might leak the image (the misconfigured backup scenario I
> suggested) or malicious actions of other tenants.

If the container image is encrypted with a key not on the system, then its
confidentiality is protected from anything that may happen on that system.

But if the container image encryption key *is* on the system, your container
image may be leaked either accidentally or maliciously.

- Eric
