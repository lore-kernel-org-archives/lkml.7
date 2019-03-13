Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D89C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48862146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfCMQGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:06:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60698 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbfCMQG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:06:29 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h46OW-0000OV-TI; Wed, 13 Mar 2019 16:06:17 +0000
Date:   Wed, 13 Mar 2019 16:06:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Theodore Ts'o <tytso@mit.edu>, Amir Goldstein <amir73il@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Subject: Re: overlayfs vs. fscrypt
Message-ID: <20190313160616.GR2217@ZenIV.linux.org.uk>
References: <4603533.ZIfxmiEf7K@blindfold>
 <1854703.ve7plDhYWt@blindfold>
 <CAJfpegtgfuAkgv26QH6Ht25OeMiev-QvEf7ror4KAbud7FADgg@mail.gmail.com>
 <4066872.KGdO14EQMx@blindfold>
 <CAOQ4uxhqQKzriL0An4Tvzc1E_LffL-z9q1otOW_RdD1ZdKWP3Q@mail.gmail.com>
 <20190313151633.GA672@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313151633.GA672@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 11:16:33AM -0400, Theodore Ts'o wrote:
> Actually, the original use was for ChromeOS, but the primary
> assumption is that keying is per user (or profile), and that users are
> mutually distrustful.  So when Alice logs out of the system, her keys
> will be invalidated and removed from the kernel.  We can (and do) try
> to flush cache entries via "echo 3 > /proc/sys/vm/drop_caches" on
> logout.  However, this does not guarantee that all dcache entries will
> be removed --- a dcache entry can be pinned due to an open file, a
> process's current working directory, a bind mount, etc.
> 
> The other issue is negative dentries; if you try open a file in an
> encrypted file, the file system won't even *know* whether or not a
> file exists, since the directory entries are encrypted; hence, there
> may be some negative dentries that need to be invalidated.
> 
> So a fundamental assumption with fscrypt is that keys will be added
> and removed, and that when this happens, dentries will need to be
> invalidated.  This is going to surprise overlayfs, so if overlayfs is
> going to support fscrypt it *has* to be aware of the fact that this
> can happen.  It's not even clear what the proper security semantics
> should be; *especially* if the upper and lower directories aren't
> similarly protected using the same fscrypt encryption key.  Suppose
> the lower directory is encrypted, and the upper is not.  Now on a copy
> up operation, the previously encrypted file, which might contain
> credit card numbers, medical records, or other things that would cause
> a GDPR regulator to have a freak out attack, would *poof* become
> decrypted.

Just to make sure - you do realize that ban on multiple dentries refering
to the same directory inode is *NOT* conditional upon those dentries being
hashed, right?
