Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94497C742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5FC2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="FeDvb65j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FqbO97DB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfGLIiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:38:24 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38837 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbfGLIiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:38:23 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B749D2230E;
        Fri, 12 Jul 2019 04:38:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 12 Jul 2019 04:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=/UVl1SfI1iLqkTsHe3vvfHE6leW
        BQBCgm2DrQ+AZhuk=; b=FeDvb65jzKh9ghvM1HCsSOXtn9CnPAhANSHh0STjxKD
        LbVqaYAd0KVoB5qZZdIwkrYK5cVDnAdF530XhX5ilO0wLC5pFmk52uYD+SvqMJKV
        ZZH4nZvyDhCT1qjICj/a5Or0rQZ0C4a0IutgIgLZnYd5Bc7B3PwMskEmsXVLak22
        7hO8ITIpH9OAhYveSIU90xbIya6AU7l7o0NvPKCghF7DCVhBILG19UL3n6mi9Zp5
        UH4UE+I2m5YmckXxlpHiYGMq6uggaOCxik9XWvewRl65z8KPpkOHLS1vJ8H/QNfY
        g8rSAjVBgWO9A5Ub6CYHJvZUA0l+6S5MEi5mV/8CPbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/UVl1S
        fI1iLqkTsHe3vvfHE6leWBQBCgm2DrQ+AZhuk=; b=FqbO97DBs5/ZTmPDcD3Glf
        PjagPJr1GioWza5EKp4nmjemeHczqP6PwpZl1nJHbgnrK4O58rCZf1LBB+6sB/Tt
        O1wHgnLiMtn3ZoEdGQmbVFT7A9sFWb9sJETPzA88ISCsgVllmWma67BQPF7Iggc0
        wNxVX1JVFefj5sMs7u8QHBI0GjuRDbp/jit8Th3kDcw+AlJJXKYkjDNBg+GzlctN
        UpCPaBE6VIWA7iqW0tCAVSmmLl7d8SLYb0467AEAlJtjzjOXCVVH28lhHprteyHt
        tY9S6cWAHmE+z5q/vfNLNgnkhyzxkHCLdX5gJPBPqC8ztL8/p2caPhWsH3bwf6rA
        ==
X-ME-Sender: <xms:_UYoXQOguVlUqK9-SN_uHhS74SotEOGASz3FDsfw2VH2IQl14bHgrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrhedtgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:_UYoXf1E8-HxayeYP4JppO4Fch5OtgdS7fUCYwM2yUA2DQGZM6ay3Q>
    <xmx:_UYoXWNeGIB9dO34uvdzCfjag_yrN0R1yq5MrikjNymKVtDZima6Aw>
    <xmx:_UYoXSzWxYDvkc7nxMVp8KXBYR8xCHhZycLfpK4ZwUESSpVCuqUcVA>
    <xmx:_kYoXUm_cxfpVqtNQEmLoQHqY7nywqV1nNhZHftTD3PZOgbSIPUVng>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5F2E480061;
        Fri, 12 Jul 2019 04:38:21 -0400 (EDT)
Date:   Fri, 12 Jul 2019 09:59:20 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: linux-next: build failure after merge of the char-misc tree
Message-ID: <20190712075920.GA18592@kroah.com>
References: <20190708192345.53fce4cf@canb.auug.org.au>
 <20190712104430.739f1b61@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712104430.739f1b61@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 10:44:30AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 8 Jul 2019 19:23:45 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > After merging the char-misc tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> > 
> > drivers/misc/vmw_balloon.c: In function 'vmballoon_mount':
> > drivers/misc/vmw_balloon.c:1736:14: error: 'simple_dname' undeclared (first use in this function); did you mean 'simple_rename'?
> >    .d_dname = simple_dname,
> >               ^~~~~~~~~~~~
> >               simple_rename
> > drivers/misc/vmw_balloon.c:1736:14: note: each undeclared identifier is reported only once for each function it appears in
> > drivers/misc/vmw_balloon.c:1739:9: error: implicit declaration of function 'mount_pseudo'; did you mean 'mount_bdev'? [-Werror=implicit-function-declaration]
> >   return mount_pseudo(fs_type, "balloon-vmware:", NULL, &ops,
> >          ^~~~~~~~~~~~
> >          mount_bdev
> > drivers/misc/vmw_balloon.c:1739:9: warning: returning 'int' from a function with return type 'struct dentry *' makes pointer from integer without a cast [-Wint-conversion]
> >   return mount_pseudo(fs_type, "balloon-vmware:", NULL, &ops,
> >          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >         BALLOON_VMW_MAGIC);
> >         ~~~~~~~~~~~~~~~~~~
> > 
> > Caused by commit
> > 
> >   83a8afa72e9c ("vmw_balloon: Compaction support")
> > 
> > interacting with commits
> > 
> >   7e5f7bb08b8c ("unexport simple_dname()")
> >   8d9e46d80777 ("fold mount_pseudo_xattr() into pseudo_fs_get_tree()")
> > 
> > from the vfs tree.
> > 
> > I applied the following merge fix patch:
> > 
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Mon, 8 Jul 2019 19:17:56 +1000
> > Subject: [PATCH] convert vmwballoon to use the new mount API
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/misc/vmw_balloon.c | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> > index 91fa43051535..e8c0f7525f13 100644
> > --- a/drivers/misc/vmw_balloon.c
> > +++ b/drivers/misc/vmw_balloon.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/mount.h>
> > +#include <linux/pseudo_fs.h>
> >  #include <linux/balloon_compaction.h>
> >  #include <linux/vmw_vmci_defs.h>
> >  #include <linux/vmw_vmci_api.h>
> > @@ -1728,21 +1729,14 @@ static inline void vmballoon_debugfs_exit(struct vmballoon *b)
> >  
> >  #ifdef CONFIG_BALLOON_COMPACTION
> >  
> > -static struct dentry *vmballoon_mount(struct file_system_type *fs_type,
> > -				      int flags, const char *dev_name,
> > -				      void *data)
> > +static int vmballoon_init_fs_context(struct fs_context *fc)
> >  {
> > -	static const struct dentry_operations ops = {
> > -		.d_dname = simple_dname,
> > -	};
> > -
> > -	return mount_pseudo(fs_type, "balloon-vmware:", NULL, &ops,
> > -			    BALLOON_VMW_MAGIC);
> > +	return init_pseudo(fc, BALLOON_VMW_MAGIC) ? 0 : -ENOMEM;
> >  }
> >  
> >  static struct file_system_type vmballoon_fs = {
> >  	.name           = "balloon-vmware",
> > -	.mount          = vmballoon_mount,
> > +	.init_fs_context          = vmballoon_init_fs_context,
> >  	.kill_sb        = kill_anon_super,
> >  };
> >  
> 
> This is now a conflict between the vfs tree and Linus' tree.

Looks good to me, I'll watch out for this when Al's tree is merged.

thanks,

greg k-h
