Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED6FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90004206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbfDJSCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:02:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40800 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbfDJSCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:02:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hEHXp-0008Fj-1d; Wed, 10 Apr 2019 18:01:57 +0000
Date:   Wed, 10 Apr 2019 19:01:57 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     James Morris <jmorris@namei.org>
Cc:     Kangjie Lu <kjlu@umn.edu>, pakki001@umn.edu,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: inode: fix a missing check for
 securityfs_create_file
Message-ID: <20190410180156.GZ2217@ZenIV.linux.org.uk>
References: <alpine.LRH.2.21.1903160608080.2905@namei.org>
 <20190315210025.17832-1-kjlu@umn.edu>
 <alpine.LRH.2.21.1904110334380.25754@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1904110334380.25754@namei.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 03:34:43AM +1000, James Morris wrote:
> On Fri, 15 Mar 2019, Kangjie Lu wrote:
> 
> > securityfs_create_file  may fail. The fix checks its status and
> > returns the error code upstream if it fails.
> > 
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > 
> 
> Applied to
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
> 
> > ---
> > Return the exact error code upstream.
> > ---
> >  security/inode.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/security/inode.c b/security/inode.c
> > index b7772a9b315e..667f8b15027d 100644
> > --- a/security/inode.c
> > +++ b/security/inode.c
> > @@ -339,6 +339,11 @@ static int __init securityfs_init(void)
> >  #ifdef CONFIG_SECURITY
> >  	lsm_dentry = securityfs_create_file("lsm", 0444, NULL, NULL,
> >  						&lsm_ops);
> > +	if (IS_ERR(lsm_dentry)) {
> > +		unregister_filesystem(&fs_type);
> > +		sysfs_remove_mount_point(kernel_kobj, "security");
> > +		return PTR_ERR(lsm_dentry);
> > +	}

Rather bad way to do it - generally, register_filesystem() should be
the last thing done by initialization.  Any modular code that
does unregister_filesystem() on failure exit is flat-out broken;
here it's not instantly FUBAR, but it's a bloody bad example.

What's more, why not let simple_fill_super() do it?  Just
static int fill_super(struct super_block *sb, void *data, int silent)
{
        static const struct tree_descr files[] = {
#ifdef CONFIG_SECURITY
		{"lsm", &lsm_ops, 0444},
#endif
		{""}
	};

and to hell with that call of securityfs_create_file() and all its
failure handling...
