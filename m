Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A269C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38262084A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="mxHyatdq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jIGceqLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfDBX4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:56:22 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39109 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbfDBX4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:56:22 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E8DDB21B96;
        Tue,  2 Apr 2019 19:56:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 02 Apr 2019 19:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        8nWEWM5KhPgaRHWbfxIAzGL7FZB8gmuv88IYZ0HO6Dk=; b=mxHyatdq6sVsOfdf
        TL92GXSXwbGqPXXn1weFRroTnbYpMVrXQsBb8ZiyMQ50Cev2SKx5tBxWTM14AH6E
        RnSnAjqMUl1hmBJXl1TWeYz6Kpg8HUCwqZlAugpwXfWam6mRlCNLTSSF4RVrZOZ7
        s/oxEz8v3xl4ph+5tlWPva1xfUDt+gv3q9qqtCRp7hnXVBJ44osC1tI9vfxUO6P5
        qlUqbBBIVkHWxXxK28sm4voOD9egj70GQY4ClnGl8z85hw0M5ju4Dq5ct9VyJVPU
        3SSVNS15vZWFFQU6GqCKis3lCZvOWtgTLPEEObmLhw1FTmNENcVkZxOl76MbzkMX
        IEvEDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=8nWEWM5KhPgaRHWbfxIAzGL7FZB8gmuv88IYZ0HO6
        Dk=; b=jIGceqLHwz7gO/ZR9Yec4gbm4XGAGQNIGhU7/2HH5/wfNtZwT52slj6OT
        wDtVuW/CbK5j/UxUzg8Orkuet509vKSPqHmPsnZzuJVw/07hXgxgq1L0kPpFROt9
        E+O/WO4I6uGUskFkOMfM388dCs7BvyabxBUuyNx7bO1jNmq8y3CNFalAcQQ7hhlM
        FcWcvaI2pwmhkpzXy0gpxVK1Vvtoh4PJ2EOh/yDGLXEytK5EKXHfYqFU4k23WLEQ
        Ebr1pPZVNGbvNW4zuL5LpQ44HNfDX22mLtTaQyY8LRrBYIZA5NmYnXHLUu8MD984
        9i0fdMDlpWoO9HCgXTUZlRXsBKEcQ==
X-ME-Sender: <xms:pPajXKtquiZinWxym0P7uaqdHTZM_6mjn0rvJ7km6B9xrT5U1QcjCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddugddvieculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfoggfgsehtjeertdertdej
    necuhfhrohhmpefkrghnucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqne
    cukfhppeduudekrddvtdekrdeifedrvdefvdenucfrrghrrghmpehmrghilhhfrhhomhep
    rhgrvhgvnhesthhhvghmrgifrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:pPajXNvEwKIOv3IQlB8h9mSB-j7LpJlun6x9vqBoDl5fVh08Y5laBA>
    <xmx:pPajXC4UZMRIfE4-zWEJEvt4eM0RhzhghAWr7aiJLkiu3QY5gf7IKg>
    <xmx:pPajXIA2BBJtOL8p8BT3NN4MvCK7jxqNjoIRtQDuahUna5R2VyYzMA>
    <xmx:pPajXJ4KvB9diB4rYB13g5cZ68jGoMuQBllnZoR1GAQrjQaS1cuHdA>
Received: from pluto.themaw.net (unknown [118.208.63.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id D3E791030F;
        Tue,  2 Apr 2019 19:56:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id 6B3441C013D;
        Wed,  3 Apr 2019 07:56:16 +0800 (AWST)
Message-ID: <5c5e02f8b8add4aa2fc24ba2a0880652529588af.camel@themaw.net>
Subject: Re: [PATCH v3 00/24] Convert vfs.txt to vfs.rst
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 03 Apr 2019 07:56:16 +0800
In-Reply-To: <20190402190811.GM2217@ZenIV.linux.org.uk>
References: <20190327051717.23225-1-tobin@kernel.org>
         <20190402094934.5b242dc0@lwn.net>
         <20190402164824.GK2217@ZenIV.linux.org.uk>
         <20190402175401.GL2217@ZenIV.linux.org.uk>
         <20190402190811.GM2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-02 at 20:08 +0100, Al Viro wrote:
> On Tue, Apr 02, 2019 at 06:54:01PM +0100, Al Viro wrote:
> > static void autofs_dentry_release(struct dentry *de)
> > {
> >         struct autofs_info *ino = autofs_dentry_ino(de);
> >         struct autofs_sb_info *sbi = autofs_sbi(de->d_sb);
> > 
> >         pr_debug("releasing %p\n", de);
> > 
> >         if (!ino)
> >                 return;
> > ...
> >         autofs_free_ino(ino);
> > }
> > with autofs_free_ino() being straight kfree().  Which means
> > that the lockless case of autofs_d_manage() can run into
> > autofs_dentry_ino(dentry) getting freed right under it.
> > 
> > And there we do have this reachable:
> > int autofs_expire_wait(const struct path *path, int rcu_walk)
> > {
> >         struct dentry *dentry = path->dentry;
> >         struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
> >         struct autofs_info *ino = autofs_dentry_ino(dentry);
> >         int status;
> >         int state;
> > 
> >         /* Block on any pending expire */
> >         if (!(ino->flags & AUTOFS_INF_WANT_EXPIRE))

Oh yes, this is saying the dentry hasn't been selected
for expire on the first pass, there's a second pass at
expire selection so there's a delay there and both flags
(this one and the expiring flag) are kept throughout the
expire operation if dentry is selected.

That might be partly why an oops has never been seen but
path walks can occur at any time so it's a bit puzzling.

LOL, and Neil probably can't remember the deeper detail
on what he did there now either.

> >                 return 0;
> >         if (rcu_walk)
> >                 return -ECHILD;
> > 
> > the second check buggers off in lockless mode; the first one
> > can be done in lockless mode just fine, so AFAICS we do have
> > a problem there.  Smells like we ought to make that kfree
> > in autofs_free_ino() RCU-delayed...  Ian, have you, by any
> > chance, run into reports like that?  Use-after-free or
> > oopsen in autofs_expire_wait() and friends, that is...
> 
> Alternatively, we could clear ->d_fsdata in autofs_d_release()
> under ->d_lock and have all potentially lockless users of
> autofs_dentry_ino() take ->d_lock around messing with that.
> I'd still prefer to do it as below, though.  Ian, do you have
> any objections against the following and, if you are OK with
> it, which tree would you prefer it to go through?
> 
> autofs: fix use-after-free in lockless ->d_manage()
> 
> autofs_d_release() can overlap with lockless ->d_manage(),
> ending up with autofs_dentry_ino() freed under the latter.
> Make freeing autofs_info instances RCU-delayed...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
> index 70c132acdab1..e1091312abe1 100644
> --- a/fs/autofs/autofs_i.h
> +++ b/fs/autofs/autofs_i.h
> @@ -71,6 +71,7 @@ struct autofs_info {
>  
>  	kuid_t uid;
>  	kgid_t gid;
> +	struct rcu_head rcu;
>  };
>  
>  #define AUTOFS_INF_EXPIRING	(1<<0) /* dentry in the process of expiring */
> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index 80597b88718b..fb0225f21c12 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -36,7 +36,7 @@ void autofs_clean_ino(struct autofs_info *ino)
>  
>  void autofs_free_ino(struct autofs_info *ino)
>  {
> -	kfree(ino);
> +	kfree_rcu(ino, rcu);
>  }
>  
>  void autofs_kill_sb(struct super_block *sb)

