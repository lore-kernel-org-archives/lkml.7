Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82003C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F09206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552495477;
	bh=1uAD5S5/4ALIgQMwLjMKCtIeaJ0Sa7kLCZ9RqhHt6kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xx8oB7meXTGC10V/4RNcZNCEhuATmVH+EarX0dGGkhdQPvYX7MhxMiloQWNg3Bvah
	 ltRZAAEHBRyvWIP+Ul2y7TukJ5qwPxB+Fls16nnj74YxUqEq0HxByFEHoAH99RJE/k
	 yfyUEQgEM0zQfuWxVI7eGi8qn6qx+rdDo7Bpdhu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfCMQog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfCMQof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:44:35 -0400
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net [107.3.167.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EEBE20651;
        Wed, 13 Mar 2019 16:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552495474;
        bh=1uAD5S5/4ALIgQMwLjMKCtIeaJ0Sa7kLCZ9RqhHt6kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/dpfvy6nlKO+lD3WgoWwf4vTrF5tQlR/biqB+yxtQ1ZoeEkASgbujG9pjySDx1Co
         2Ha8nPaBa/8lxZ1xKDtEi5k0dHiSBOwYB7H5a5K4rHh9XpbO/xV2zSEcNgeZdSYwsw
         0d44tKcgD5OiCjHFqOzzGxuRmQI4+54Fm55qTtU8=
Date:   Wed, 13 Mar 2019 09:44:33 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Theodore Ts'o <tytso@mit.edu>, Amir Goldstein <amir73il@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Subject: Re: overlayfs vs. fscrypt
Message-ID: <20190313164432.GE703@sol.localdomain>
References: <4603533.ZIfxmiEf7K@blindfold>
 <1854703.ve7plDhYWt@blindfold>
 <CAJfpegtgfuAkgv26QH6Ht25OeMiev-QvEf7ror4KAbud7FADgg@mail.gmail.com>
 <4066872.KGdO14EQMx@blindfold>
 <CAOQ4uxhqQKzriL0An4Tvzc1E_LffL-z9q1otOW_RdD1ZdKWP3Q@mail.gmail.com>
 <20190313151633.GA672@mit.edu>
 <20190313160616.GR2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313160616.GR2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 04:06:16PM +0000, Al Viro wrote:
> On Wed, Mar 13, 2019 at 11:16:33AM -0400, Theodore Ts'o wrote:
> > Actually, the original use was for ChromeOS, but the primary
> > assumption is that keying is per user (or profile), and that users are
> > mutually distrustful.  So when Alice logs out of the system, her keys
> > will be invalidated and removed from the kernel.  We can (and do) try
> > to flush cache entries via "echo 3 > /proc/sys/vm/drop_caches" on
> > logout.  However, this does not guarantee that all dcache entries will
> > be removed --- a dcache entry can be pinned due to an open file, a
> > process's current working directory, a bind mount, etc.
> > 
> > The other issue is negative dentries; if you try open a file in an
> > encrypted file, the file system won't even *know* whether or not a
> > file exists, since the directory entries are encrypted; hence, there
> > may be some negative dentries that need to be invalidated.
> > 
> > So a fundamental assumption with fscrypt is that keys will be added
> > and removed, and that when this happens, dentries will need to be
> > invalidated.  This is going to surprise overlayfs, so if overlayfs is
> > going to support fscrypt it *has* to be aware of the fact that this
> > can happen.  It's not even clear what the proper security semantics
> > should be; *especially* if the upper and lower directories aren't
> > similarly protected using the same fscrypt encryption key.  Suppose
> > the lower directory is encrypted, and the upper is not.  Now on a copy
> > up operation, the previously encrypted file, which might contain
> > credit card numbers, medical records, or other things that would cause
> > a GDPR regulator to have a freak out attack, would *poof* become
> > decrypted.
> 
> Just to make sure - you do realize that ban on multiple dentries refering
> to the same directory inode is *NOT* conditional upon those dentries being
> hashed, right?

Isn't this handled by d_splice_alias() already, by moving the old dentry to the
new name?

- Eric
