Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBCBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BDB2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552508725;
	bh=EXe+Ez5eFEmIkT8jEZDz6Y2InduzsahFDoJq2DbHfuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=diPGrVLZ++WZ/8iAvWyInU9ISu7/VRo836t8avbe+aN1FvE1z7EXGVCxL4nXGWZBa
	 l1dT0pwVru/+C06CKN3tlMdAZK1w98ayXwWMD/GEHETMnJ0wklol8NXXxPFtGqitsW
	 INJmofGT8nNONp8Lup0xoW2luD7uG2F55ERYSx5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfCMUZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfCMUZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:25:23 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03F7A206DF;
        Wed, 13 Mar 2019 20:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552508722;
        bh=EXe+Ez5eFEmIkT8jEZDz6Y2InduzsahFDoJq2DbHfuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mc2cEbLxEwfuk8GuRGfe6pBnrtYt1cyIjOu4ojK/xG20SsPAorOSVXaBW1+8vKeMF
         NZXdXHZ0PtWDRk/VSj8lG+NxnPfL6NtIoYdaEeq4hFe42gT7Nh4Qp5hFu6u0eHNKBb
         C37Cbd7CO/GuSb2/FDNr5EB4xl9z525UIDu2L2H4=
Date:   Wed, 13 Mar 2019 13:25:20 -0700
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
Message-ID: <20190313202519.GD10169@gmail.com>
References: <4066872.KGdO14EQMx@blindfold>
 <CAOQ4uxhqQKzriL0An4Tvzc1E_LffL-z9q1otOW_RdD1ZdKWP3Q@mail.gmail.com>
 <20190313151633.GA672@mit.edu>
 <1552491394.3022.8.camel@HansenPartnership.com>
 <20190313164439.GF672@mit.edu>
 <1552499104.3022.44.camel@HansenPartnership.com>
 <20190313185826.GA4685@mit.edu>
 <1552504672.3022.59.camel@HansenPartnership.com>
 <20190313195713.GC10169@gmail.com>
 <1552507566.3022.65.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552507566.3022.65.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 01:06:06PM -0700, James Bottomley wrote:
> On Wed, 2019-03-13 at 12:57 -0700, Eric Biggers wrote:
> > On Wed, Mar 13, 2019 at 12:17:52PM -0700, James Bottomley wrote:
> > > On Wed, 2019-03-13 at 14:58 -0400, Theodore Ts'o wrote:
> > > > On Wed, Mar 13, 2019 at 10:45:04AM -0700, James Bottomley wrote:
> > > > > >   If they can't break root, then the OS's user-id based
> > > > > > access control checks (or SELinux checks if you are using
> > > > > > SELinux) will still protect you.
> > > > > 
> > > > > Well, that's what one would think about the recent runc exploit
> > > > > as well.  The thing I was looking to do was reduce the chances
> > > > > that unencrypted data would be lying around to be
> > > > > discovered.  I suppose the potentially biggest problem is
> > > > > leaking the image after it's decrypted by admin means like a
> > > > > badly configured backup, but unencryped data is potentially
> > > > > discoverable by breakouts as well.
> > > > 
> > > > But while the container is running, the key is available and
> > > > instantiated in the kernel, and the kernel is free to decrypt any
> > > > encrypted file/block.
> > > 
> > > In the current encrypted tar file implementation, while the
> > > container is running the decrypted tar file is extracted into the
> > > container root and available for all to see.
> > > 
> > > The main security benefit of this implementation, as I said, is
> > > security of at rest images and the runtime security is guaranteed
> > > by other systems.
> > 
> > That's not security at rest, because you're decrypting the data and
> > storing it onto the local disk.
> 
> I mean image at rest and image running.  The local disk untar only
> happens for running image.
> 
> > fscrypt would allow the data to be stored encrypted on the local
> > disk, so it's protected against offline compromise of the disk.
> 
> Container images are essentially tars of the overlays.  They only
> become actual filesystems when instantiated at runtime.  The current
> encrypted container image is an overlay or set of overlays which is
> tarred then encrypted.  So to instantiate it is decrypted then
> untarred.
> 
> The thing I was wondering about was whether instead of a tar encrypt we
> could instead produce an encrypted image from a fscrypt filesystem.
> 

Why do you care whether the container image is encrypted on the local disk, when
you're extracting it in plaintext onto the local disk anyway each time it runs?
Even after the runtime files are "deleted", they may still be recoverable from
the disk.  Are you using shred and BLKSECDISCARD, and a non-COW filesystem?

Now, if you wanted to avoid writing the plaintext to disk entirely (and thereby
use encryption to actually achieve a useful security property that can't be
achieved through file permissions), fscrypt is a good solution for that.

- Eric
