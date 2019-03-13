Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0958C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB98E213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552506198;
	bh=xBwVO4J7+eKGefYtgEY/HJuhWOaBPz4oCLZzazWEaIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=joaSge0MjU5MrwSBS/iGI53IamrUxMI60aqxe9IHKADf6XJDGXlsx/cBWmwzkZ5vh
	 CPOhexQIyAmQJ1DVJAUgdwZrwKGxoSFdp4bXC3ql83pNTG5415vTi++gJ6K+oD5oaY
	 T54XvH0Hg/v3l3COvQtRww7mMKHeDRWmvitUZdVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfCMTnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:43:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbfCMTnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:43:16 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C09612077B;
        Wed, 13 Mar 2019 19:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552506196;
        bh=xBwVO4J7+eKGefYtgEY/HJuhWOaBPz4oCLZzazWEaIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lfao3a2yNDBGTn48W4IJg/exfnGDI0vjAZOTO7Xg9OJFsTg3p+1pvgDJlbEziB8Qy
         IfrAQoOPFLsr0Z4s4pQ2l6Npw4PQWaCp+BgSQ66U959WHVAKxLpM8a/D9cNpRziHCo
         F0qenrDxIXY5wYMtX4INBTFWG1AyF5URvxr2lQ0s=
Date:   Wed, 13 Mar 2019 12:43:14 -0700
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
Message-ID: <20190313194313.GB10169@gmail.com>
References: <4603533.ZIfxmiEf7K@blindfold>
 <1854703.ve7plDhYWt@blindfold>
 <CAJfpegtgfuAkgv26QH6Ht25OeMiev-QvEf7ror4KAbud7FADgg@mail.gmail.com>
 <4066872.KGdO14EQMx@blindfold>
 <CAOQ4uxhqQKzriL0An4Tvzc1E_LffL-z9q1otOW_RdD1ZdKWP3Q@mail.gmail.com>
 <20190313151633.GA672@mit.edu>
 <20190313160616.GR2217@ZenIV.linux.org.uk>
 <20190313164432.GE703@sol.localdomain>
 <20190313191945.GT2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313191945.GT2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 07:19:46PM +0000, Al Viro wrote:
> On Wed, Mar 13, 2019 at 09:44:33AM -0700, Eric Biggers wrote:
> 
> > > Just to make sure - you do realize that ban on multiple dentries refering
> > > to the same directory inode is *NOT* conditional upon those dentries being
> > > hashed, right?
> > 
> > Isn't this handled by d_splice_alias() already, by moving the old dentry to the
> > new name?
> 
> ... which means that if somebody without the key chdirs into subdirectory
> they only see by encrypted name and waits for proper owner to look it up,
> they suddenly see it by _un_encrypted name.  Or does O_PATH open, for
> that matter, so exec permissions on that thing are not required.

Is there a real problem here?  After the key is added, the filenames are
supposed to be shown in plaintext, not ciphertext.  This is intrinsic to the
fact that we don't support both "views" at the same time.  Either the directory
has the key or it does not.

If someone is using ciphertext view (e.g. doing a directory traversal)
concurrently with the key being added, that can certainly break things.  But the
ciphertext view only allows a very restricted set of actions such as deleting
files.  And if such actions are necessary, the system userspace is meant to be
designed in such a way that adding the key can't race with it.

- Eric
