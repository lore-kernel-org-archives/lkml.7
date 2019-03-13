Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB3EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF9B2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfCMWmY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:42:24 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:51436 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfCMWmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:42:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 71E246089E22;
        Wed, 13 Mar 2019 23:42:20 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sC0lP2ewmzQk; Wed, 13 Mar 2019 23:42:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EE29660D4827;
        Wed, 13 Mar 2019 23:42:19 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HwA4ubAvkyor; Wed, 13 Mar 2019 23:42:19 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 7B6516089E22;
        Wed, 13 Mar 2019 23:42:19 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Subject: Re: overlayfs vs. fscrypt
Date:   Wed, 13 Mar 2019 23:42:18 +0100
Message-ID: <4098793.CtYQtWW4dM@blindfold>
In-Reply-To: <20190313222610.GF10169@gmail.com>
References: <4603533.ZIfxmiEf7K@blindfold> <15244624.W7e5yEypHC@blindfold> <20190313222610.GF10169@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 13. März 2019, 23:26:11 CET schrieb Eric Biggers:
> On Wed, Mar 13, 2019 at 09:33:10PM +0100, Richard Weinberger wrote:
> > Am Mittwoch, 13. März 2019, 15:26:54 CET schrieb Amir Goldstein:
> > > IMO, the best thing for UBIFS to do would be to modify fscrypt to support
> > > opting out of the revalidate behavior, IWO, sanitize your hack to an API.
> > 
> > Given the WTF/s rate this thread has, this might me a good option.
> > Actually people already asked me how to disable this feature because
> > they saw no use of it.
> > Being able to delete encrypted files looks good on the feature list but in
> > reality it has very few users but causes confusion, IMHO.
> > 
> > I propose a new fscrypt_operations flag, FS_CFLG_NO_CRYPT_FNAMES.
> > If this flag is set, a) fscrypt_setup_filename() will return -EPERM if
> > no key is found.
> > And b) __fscrypt_prepare_lookup() will not attach fscrypt_d_ops to the dentry.
> > 
> > Eric, what do you think?
> > 
> > Thanks,
> > //richard
> > 
> 
> What specifically is wrong with supporting the ciphertext "view" of encrypted
> directories, and why do you want to opt UBIFS out of it specifically but not
> ext4 and f2fs?  (The fscrypt_operations are per-filesystem type, not
> per-filesystem instance, so I assume that's what you had in mind.)  Note that we
> can't unconditionally remove it because people need it to delete files without
> the key.  We could add a mount option to disable it, but why exactly?

You are right, fscrypt_operations is the wrong structure.
My plan was having it per filesystem instance. So a mount-option seems like
a good option. Of course for all filesystems that support fscrypt, not just UBIFS.

Over the last year I've converted many emebdded systems to fscrypt and it happened
more than once that users, and more importantly, applications got confused that
you can mount and walk the filesystem even if you don't have the key loaded yet.
For them it felt more natural that you cannot even readdir if you don't have the key.

In my opinion having such a mount option is useful to match these expectations.
And it is also useful because you can enable only the features you actually need.
On embedded systems that I have in mind you never delete files without having the key
and since fscrypt is used for the whole filesystem you can just recreate it if you
really lost the key.

Thanks,
//richard


