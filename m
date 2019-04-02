Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C63C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F16207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="bm2/YaWr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d+rXowHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfDBXqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:46:09 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60329 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbfDBXqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:46:08 -0400
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Apr 2019 19:46:07 EDT
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 578EB21F2A;
        Tue,  2 Apr 2019 19:36:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 02 Apr 2019 19:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        dylNKNGwkziAkM4v8q4wkOXekFQ+UgIwjjuWTZeNBLc=; b=bm2/YaWrJCljpvtu
        zvGUKytPjXAsckeCFPsEBI5a87XEgUqTK9J/Yd4wAlwR+PnVr8igKYJT/htecJFf
        A1qIkJN0jLgD1c11MoZIfCh5C1Ro4hdEz6sjQzff/7stCLPIGIKo0jTe5dCr8u+v
        1bAKSY6hp7UC7wmlkAj35+8SjZ6/pjmmMFsXxZqrNL66Ra+Hq4suaKkWP88zWl8q
        UwUFqLK10lCxbXJU5J54HLME4I05+nUl265nvdME35ZUmZfHACp71aL4G7AuOCN4
        xvBh/ssX7UDx83IqlRTDaI1dD43cw4bvAQ/JE4yfDP5pfoXw2wFT1Bm/gdSJXwfU
        NqIc3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=dylNKNGwkziAkM4v8q4wkOXekFQ+UgIwjjuWTZeNB
        Lc=; b=d+rXowHJ5tlWF/XEVKAFtV0xjEkeNtaY1DGYqfUYCKS2FRxJBuBE3mF2q
        PEbOAeh/Wm3VCMeCGTiKgdFvIYTsCIymLkVMuDYrjMQQtIFJ+I/g87Ku0/1ZF3Hl
        y6qAeZ6OIubkivrTYDuUrf7YSi+VgDK8j2NsnXoy1djnbKPrA2AALt9Itf5VEmKk
        16fsK1daK/uXulopoEPjxqTq5F11DcAWPWZ55EN0pdveCn+5joOp6Vbdjv00uxXd
        7gMTB41jRmAsKh31FC2fIm236z1l8Dw2uRNjlhVb+nArxpBCmbZwKoxEilfarA2U
        IurncW6W0nynqEbxXpd05OnDFvy/Q==
X-ME-Sender: <xms:7_GjXOnnzRj9W_1eLbtFrpuID-2Ihoh47UvNPICJdNo1pFBDeGkwNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddugddvvdculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfoggfgsehtjeertdertdej
    necuhfhrohhmpefkrghnucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqne
    cukfhppeduudekrddvtdekrdeifedrvdefvdenucfrrghrrghmpehmrghilhhfrhhomhep
    rhgrvhgvnhesthhhvghmrgifrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:7_GjXB7F0WPxEHgFKBXuTDRJOGOlxONFdtDJSyQqcyKJcwOZwntNHQ>
    <xmx:7_GjXH_XgAzyBSAI_zhuRHsjyh8DjC0vR5RFmgH0q6ozk3IVd_V6pg>
    <xmx:7_GjXBg4-ONbiQ4huO1OUlSKX8meXPBpCLbjGoa7sVEhzLGJEYwgVA>
    <xmx:8_GjXCEcNWDM6g0Lz4Ghslp098l6do1tdhF2kNwVmnq5t8LXwQekHA>
Received: from pluto.themaw.net (unknown [118.208.63.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id 15F77E4805;
        Tue,  2 Apr 2019 19:36:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id 5F37C1C004A;
        Wed,  3 Apr 2019 07:36:11 +0800 (AWST)
Message-ID: <c4f09fa9b3fa4ead6df10db25eb62474f664dab2.camel@themaw.net>
Subject: Re: [PATCH v3 00/24] Convert vfs.txt to vfs.rst
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 03 Apr 2019 07:36:11 +0800
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

Never seen any reports of this but that doesn't mean it shouldn't
be fixed.

> 
> Alternatively, we could clear ->d_fsdata in autofs_d_release()
> under ->d_lock and have all potentially lockless users of
> autofs_dentry_ino() take ->d_lock around messing with that.
> I'd still prefer to do it as below, though.  Ian, do you have
> any objections against the following and, if you are OK with
> it, which tree would you prefer it to go through?

I can't think of any reason to add additional locking over
using an rcu free.

Please feel free to send this via your tree as your close
to what's being done and need to keep track of it.

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

