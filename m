Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17517C00306
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D832082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567738903;
	bh=SzGojQzToRqxCpfmdL86DOZQu8Y6O9dT8W5aQVfbQtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RqexiHypdlmgwnJOMhoExWv45FQHT9zzFhkWU5paWVxc8L/Yhcfp2+RIXMJ1MytEA
	 rq6D5lt9ACLXwa6Y+pVhJMNhTuSFMJ7CC/N4NRUUt2M99WR8GPGFbtp3+YbijbOM+k
	 QZTilH4N3nYkhwzz6dNk8vDm4VCFYK63TLwA/Y8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392066AbfIFDBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 23:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389424AbfIFDBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 23:01:41 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29D0F206DE;
        Fri,  6 Sep 2019 03:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567738901;
        bh=SzGojQzToRqxCpfmdL86DOZQu8Y6O9dT8W5aQVfbQtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z1Be55gNDfWeThG1FWdE+yvMpl2tizqjHZX1hjRMeSA1xDz17abFKiO0cSKIBepey
         ho2Lettv6EyOoj87WTit0tPc+j4w4RxDIKigQxK+DMSO4p+w3fu0gUWceZllTsfIZc
         92lXiMjeXPSSqqyUrJSAwleXJCOJkKIDrL8wCyDU=
Date:   Thu, 5 Sep 2019 20:01:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot+5aca688dac0796c56129@syzkaller.appspotmail.com
Subject: Re: [PATCH vfs/for-next] vfs: fix vfs_get_single_reconf_super error
 handling
Message-ID: <20190906030139.GC803@sol.localdomain>
Mail-Followup-To: Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+5aca688dac0796c56129@syzkaller.appspotmail.com
References: <0000000000003675ae05915a9fd3@google.com>
 <20190831031024.26008-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831031024.26008-1-ebiggers@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 10:10:24PM -0500, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> syzbot reported an invalid free in debugfs_release_dentry().  The
> reproducer tries to mount debugfs with the 'dirsync' option, which is
> not allowed.  The bug is that if reconfigure_super() fails in
> vfs_get_super(), deactivate_locked_super() is called, but also
> fs_context::root is left non-NULL which causes deactivate_super() to be
> called again later.
> 
> Fix it by releasing fs_context::root in the error path.
> 
> Reported-by: syzbot+5aca688dac0796c56129@syzkaller.appspotmail.com
> Fixes: e478b48498a7 ("vfs: Add a single-or-reconfig keying to vfs_get_super()")
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/super.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 0f913376fc4c..99195e15be05 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1194,8 +1194,11 @@ int vfs_get_super(struct fs_context *fc,
>  		fc->root = dget(sb->s_root);
>  		if (keying == vfs_get_single_reconf_super) {
>  			err = reconfigure_super(fc);
> -			if (err < 0)
> +			if (err < 0) {
> +				dput(fc->root);
> +				fc->root = NULL;
>  				goto error;
> +			}
>  		}
>  	}
>  

Ping.  This is still broken in linux-next.

- Eric
