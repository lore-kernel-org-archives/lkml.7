Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D922BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4E421872
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfCNUyS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:54:18 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:44306 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfCNUyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:54:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E0CC860D4833;
        Thu, 14 Mar 2019 21:54:13 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oEITekKMhT3l; Thu, 14 Mar 2019 21:54:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7434060ED8B5;
        Thu, 14 Mar 2019 21:54:13 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uTYZWp7_Dz-m; Thu, 14 Mar 2019 21:54:13 +0100 (CET)
Received: from blindfold.localnet (089144193070.atnat0002.highway.a1.net [89.144.193.70])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id A22E760D4833;
        Thu, 14 Mar 2019 21:54:11 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mtd@lists.infradead.org, linux-fscrypt@vger.kernel.org,
        jaegeuk@kernel.org, tytso@mit.edu, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        paullawrence@google.com
Subject: Re: [PATCH 4/4] ubifs: Implement new mount option, fscrypt_key_required
Date:   Thu, 14 Mar 2019 21:54:10 +0100
Message-ID: <1957441.Hty6t2mpXG@blindfold>
In-Reply-To: <20190314174913.GA30026@gmail.com>
References: <CAJfpegvX4ANfso-Jn1zaB+m4Q_0eK9i-+MCJ+sTH5QzD3PZFMQ@mail.gmail.com> <20190314171559.27584-5-richard@nod.at> <20190314174913.GA30026@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

Am Donnerstag, 14. März 2019, 18:49:14 CET schrieb Eric Biggers:
> Hi Richard,
> 
> On Thu, Mar 14, 2019 at 06:15:59PM +0100, Richard Weinberger wrote:
> > Usually fscrypt allows limited access to encrypted files even
> > if no key is available.
> > Encrypted filenames are shown and based on this names users
> > can unlink and move files.
> 
> Actually, fscrypt doesn't allow moving files without the key.  It would only be
> possible for cross-renames, i.e. renames with the RENAME_EXCHANGE flag.  So for
> consistency with regular renames, fscrypt also forbids cross-renames if the key
> for either the source or destination directory is missing.
> 
> So the main use case for the ciphertext view is *deleting* files.  For example,
> deleting a user's home directory after that user has been removed from the
> system.  Or the system freeing up space by deleting cache files from a user who
> isn't currently logged in.

Right, I somehow thought beside of deleting you can do more.

> > 
> > This is not always what people expect. The fscrypt_key_required mount
> > option disables this feature.
> > If no key is present all access is denied with the -ENOKEY error code.
> 
> The problem with this mount option is that it allows users to create undeletable
> files.  So I'm not really convinced yet this is a good change.  And though the
> fscrypt_key_required semantics are easier to implement, we'd still have to
> support the existing semantics too, thus increasing the maintenance cost.

The undeletable-file argument is a good point. Thanks for bringing this up.
To get rid of such files root needs to mount without the new mount parameter. ;-\

> > 
> > The side benefit of this is that we don't need ->d_revalidate().
> > Not having ->d_revalidate() makes an encrypted ubifs usable
> > as overlayfs upper directory.
> > 
> 
> It would be preferable if we could get overlayfs to work without providing a
> special mount option.

Yes, but let's see what Al finds in his review.

> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > ---
> >  fs/ubifs/crypto.c |  2 +-
> >  fs/ubifs/dir.c    | 29 ++++++++++++++++++++++++++---
> >  fs/ubifs/super.c  | 15 +++++++++++++++
> >  fs/ubifs/ubifs.h  |  1 +
> >  4 files changed, 43 insertions(+), 4 deletions(-)
> > 
> 
> Shouldn't readlink() honor the mount option too?

Hmmm, yes. We need to honor it in ->get_link() too.

> > +		if (c->fscrypt_key_required && !dir->i_crypt_info)
> > +			return -ENOKEY;
> > +
> 
> How about returning -ENOKEY when trying to open the directory in the first
> place, rather than allowing getting to readdir()?  That would match the behavior
> of regular files.

I'm not sure what the best approach is.
We could also do it in ->permission().

Thanks,
//richard


