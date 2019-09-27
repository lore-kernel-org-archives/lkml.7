Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99356C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E373208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Buf3XKlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfI0DCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 23:02:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38486 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbfI0DCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 23:02:41 -0400
Received: by mail-io1-f65.google.com with SMTP id u8so12429259iom.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 20:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DqS8CKCqfS3uYwo6fxsB/vgYneWRSmUgNFHzOxBj8mM=;
        b=Buf3XKlV1Z0TVnpHyRzpBbKhxwUyFCGd4dJdxoIzFfC2g50ozH8DfZVOTvGKUc2BJr
         LQiir9PETDZL8OPe1Rbxr/2J9mWpe9awhNpXnHzlmuoj2COyTngzOyVXy5fQ7gbOOz1o
         OaOvdSwPfrc6Fv30W2ZEWZ1ac+kRysl6AZuJP/tHgnuXnn0AFY9yKN5XvA7f7T9IdtA2
         3lRh5HsR8Y+JbfNpKyMxO52OOrDVnKfs1RiuQBIlwMdrc5dZkCNW61UyZPmHLGwBjQge
         Ahe5YJhhnwf2utnAPXwHtTtWIL88B8sVvamDl5I2oFjji1CK0SswqM+RI+Y0CCAope1m
         +r4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DqS8CKCqfS3uYwo6fxsB/vgYneWRSmUgNFHzOxBj8mM=;
        b=XcwtuG2urSn/mn5woKSvzbU3BDu93cM9/YeWvd53HMNT1LZxMHQ2ha6AXOlKzQKxXB
         uvrd+vsz4jY/GSPdOoug1LZW2XJkydRCov6MSsJ0LjNk2B3URCIbRR7D6jH2WGcEkF/C
         H03lqq5E0bofJjPMeddeY3eUXpkZPc/NbycpsEWdoSIDe27o8k6WtBIkOy+ayuriod9e
         wbC0UBNRQHBkP3pSUqrCugXsDJz0ikqlZOiu8Xz/T0y6YvQ9AnUdYGDe1s2/OinGxPy8
         fD6AMFdDe5Ahf8qE8UKzeFiNqKO+seyYEGXiv6lhrwTpqxLBMw5mmTDS2rIhQQBEUTg3
         jbGw==
X-Gm-Message-State: APjAAAWSaakfsLyz1mh/7tg1FP1xHfbR1K16WmfrGDycfAQiDgkJw5EW
        nYIsA2fSce025A/0qXohzVw=
X-Google-Smtp-Source: APXvYqx1L9qjRJEsHT9X9uAKY7IMnjTAX1C2jDv6tKBrvtWeToTP7J9LfCDR/j0zbh+AloLmUdyxeQ==
X-Received: by 2002:a92:af52:: with SMTP id n79mr2529870ili.4.1569553359998;
        Thu, 26 Sep 2019 20:02:39 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.gmail.com with ESMTPSA id y7sm1775136ior.45.2019.09.26.20.02.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Sep 2019 20:02:39 -0700 (PDT)
Date:   Thu, 26 Sep 2019 22:02:37 -0500
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: prevent memory leak in udf_new_inode
Message-ID: <20190927030237.GE22969@cs-dulles.cs.umn.edu>
References: <20190925213904.12128-1-navid.emamdoost@gmail.com>
 <20190925222408.GN26530@ZenIV.linux.org.uk>
 <20190926080031.GB12013@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926080031.GB12013@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 10:00:31AM +0200, Jan Kara wrote:
> On Wed 25-09-19 23:24:08, Al Viro wrote:
> > On Wed, Sep 25, 2019 at 04:39:03PM -0500, Navid Emamdoost wrote:
> > > In udf_new_inode if either udf_new_block or insert_inode_locked fials
> > > the allocated memory for iinfo->i_ext.i_data should be released.
> > 
> > "... because of such-and-such reasons" part appears to be missing.
> > Why should it be released there?
> > 
> > > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > > ---
> > >  fs/udf/ialloc.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
> > > index 0adb40718a5d..b8ab3acab6b6 100644
> > > --- a/fs/udf/ialloc.c
> > > +++ b/fs/udf/ialloc.c
> > > @@ -86,6 +86,7 @@ struct inode *udf_new_inode(struct inode *dir, umode_t mode)
> > >  			      dinfo->i_location.partitionReferenceNum,
> > >  			      start, &err);
> > >  	if (err) {
> > > +		kfree(iinfo->i_ext.i_data);
> > >  		iput(inode);
> > >  		return ERR_PTR(err);
> > >  	}
> > 
> > Have you tested that?  Because it has all earmarks of double-free;
> > normal eviction pathway ought to free the damn thing.  <greps around
> > a bit>
> > 
> > Mind explaining what's to stop ->evict_inode (== udf_evict_inode) from
> > hitting
> >         kfree(iinfo->i_ext.i_data);
> > considering that this call of kfree() appears to be unconditional there?
> 
> Exactly. udf_evict_inode() is responsible for freeing iinfo->i_ext.i_data
> so the patch would result in double free.
> 
> 								Honza
Thanks for clarification.
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
