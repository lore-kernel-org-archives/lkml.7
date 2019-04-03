Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F7DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 23:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45232064A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 23:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="LyiATcFV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B9dIoUPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfDCX27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 19:28:59 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33549 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbfDCX26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 19:28:58 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 39B91222BA;
        Wed,  3 Apr 2019 19:28:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 03 Apr 2019 19:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        ++5CMhroEuAjazs1tO09H63zbBQ5nzJdJ5d+2RHIrNc=; b=LyiATcFVKqYDfMIb
        snYj1Mt7Ispou1aZOmkyr1bFymLsYr6VeyKcm49DUxj84YSe/rq7xG23WiuMF6gn
        C5bKEgLToCWroLCUG6qp78PYRzL0BGfqOwxYnLgQ712a1V4t2te9ZMXmVP5AH+IU
        QelN435IgpRL8w7tNGcpyD/Q5B5woa0J4aS5nP4v/a3+RB74zQfYagmFcajMEraA
        Bx0gjbGUkYZZsMB6foeTihXloPSIaZmpxGyfw0vKw2/LkZMG/+R/0Od0VSxTQTwP
        gyrsAKhNcCS1B0ix59rpuUyQ4ObJOwXyJpcMvAQ8GR0SVHoM4wyRY/UUXmU5EEp1
        DkVRCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=++5CMhroEuAjazs1tO09H63zbBQ5nzJdJ5d+2RHIr
        Nc=; b=B9dIoUPRAOVsLitQsTbmXna7UnkdDQvXapQk6TvX08Q99NQQAgMJK/alF
        bs9x0hNl0tkKHndC5VNaG+zLpn+1gyhco16EPCKeQ51EY+B3o2N9YtWBc3WvD+Io
        TSNUT09h9ZQoxP/0ZoPcbZYKylQ9tDBbZjRdXeIw4gmJxzT1RWZRHQS+sUcHkyRt
        d6ruTIsLvWyQq1mJ3rQqpc+cPmzTOzdgxFtMEcstRaZxC91yjs45r/3WcIWsP5/3
        IqdRx5ORAtQrWQ1Ovwa1g9ajNrhZ7UWUjt7mj9AGtk9qBAVQCmjFb7bdW15jR2qG
        Y9vdsPfdZt/ShS5U6/1+FoW3U1B9g==
X-ME-Sender: <xms:uEGlXDbzki7zwxvSd2jqXaCH9jSyQv0PiT_df9mSAX8Y4Wyejb_Rjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeggddvudculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfoggfgsehtjeertdertdej
    necuhfhrohhmpefkrghnucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqne
    cukfhppeduudekrddvtdekrdeifedrvdefvdenucfrrghrrghmpehmrghilhhfrhhomhep
    rhgrvhgvnhesthhhvghmrgifrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:uEGlXLUGjspAqIABHMI6S1Yg7-_yA7WYvkvLh_N6qu7ESIH73TRBFQ>
    <xmx:uEGlXOue12PNRolHcIYy_miuKNbE118XhUINEZRcl2ML09oPA65JUQ>
    <xmx:uEGlXMzmw7B3nRGQSvzfdzGDiSyPI9E1uz_BKYLvCXXc2nZ4K1Tr0A>
    <xmx:uUGlXOjdnp-vtUSfY9olDEQ00f71nSImOm56G34HJKNgwp-62QU8HA>
Received: from pluto.themaw.net (unknown [118.208.63.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id CD566E43A3;
        Wed,  3 Apr 2019 19:28:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id 61F711C0079;
        Thu,  4 Apr 2019 07:28:52 +0800 (AWST)
Message-ID: <894091e9742896e4bc810458a9f71f3f59a48860.camel@themaw.net>
Subject: Re: [PATCH v3 00/24] Convert vfs.txt to vfs.rst
From:   Ian Kent <raven@themaw.net>
To:     NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Apr 2019 07:28:52 +0800
In-Reply-To: <87ftqz29i2.fsf@notabene.neil.brown.name>
References: <20190327051717.23225-1-tobin@kernel.org>
         <20190402094934.5b242dc0@lwn.net>
         <20190402164824.GK2217@ZenIV.linux.org.uk>
         <20190402175401.GL2217@ZenIV.linux.org.uk>
         <20190402190811.GM2217@ZenIV.linux.org.uk>
         <5c5e02f8b8add4aa2fc24ba2a0880652529588af.camel@themaw.net>
         <87ftqz29i2.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-03 at 11:55 +1100, NeilBrown wrote:
> On Wed, Apr 03 2019, Ian Kent wrote:
> 
> > On Tue, 2019-04-02 at 20:08 +0100, Al Viro wrote:
> > > On Tue, Apr 02, 2019 at 06:54:01PM +0100, Al Viro wrote:
> > > > static void autofs_dentry_release(struct dentry *de)
> > > > {
> > > >         struct autofs_info *ino = autofs_dentry_ino(de);
> > > >         struct autofs_sb_info *sbi = autofs_sbi(de->d_sb);
> > > > 
> > > >         pr_debug("releasing %p\n", de);
> > > > 
> > > >         if (!ino)
> > > >                 return;
> > > > ...
> > > >         autofs_free_ino(ino);
> > > > }
> > > > with autofs_free_ino() being straight kfree().  Which means
> > > > that the lockless case of autofs_d_manage() can run into
> > > > autofs_dentry_ino(dentry) getting freed right under it.
> > > > 
> > > > And there we do have this reachable:
> > > > int autofs_expire_wait(const struct path *path, int rcu_walk)
> > > > {
> > > >         struct dentry *dentry = path->dentry;
> > > >         struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
> > > >         struct autofs_info *ino = autofs_dentry_ino(dentry);
> > > >         int status;
> > > >         int state;
> > > > 
> > > >         /* Block on any pending expire */
> > > >         if (!(ino->flags & AUTOFS_INF_WANT_EXPIRE))
> > 
> > Oh yes, this is saying the dentry hasn't been selected
> > for expire on the first pass, there's a second pass at
> > expire selection so there's a delay there and both flags
> > (this one and the expiring flag) are kept throughout the
> > expire operation if dentry is selected.
> > 
> > That might be partly why an oops has never been seen but
> > path walks can occur at any time so it's a bit puzzling.
> > 
> > LOL, and Neil probably can't remember the deeper detail
> > on what he did there now either.
> 
> It seems very likely that this was just a subtlety that I missed.
> I doesn't help that "ino" isn't actually and inode and isn't freed like
> an inode, but that is no excuse.

I've become accustom to the naming so that doesn't occur to
me, ;)

> 
> When we add the rcu_head linkage to 'struct autofs_info', we might as
> well remove the 'struct inode' from there - it doesn't seem to have been
> used for years.

That's a good point, I've thought about doing so several
times but haven't got around to it.

Ian

