Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14378C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08C520673
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570465049;
	bh=ozHM9vQqkRgP+5XD9rebNnIy1H6oVm5mvRZEz20pe/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Goj5XmJmD5YMyglqA5Yc9ZEj/T1CMvn+iJp08bcXU0IlMsAQFSSm7cJp6ogcjYIgy
	 xJ/0UX7p2w7O35wFA4va661gfl2mvuCIv/qTVyPQLCE6v4iVHwHrBY7nIzPs0oeju1
	 VVsxVS+7jYWjvP3uWvxuTzdOEW27ZGFHcsmPlHaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfJGQR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:17:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbfJGQR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:17:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D92120673;
        Mon,  7 Oct 2019 16:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570465047;
        bh=ozHM9vQqkRgP+5XD9rebNnIy1H6oVm5mvRZEz20pe/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F3od40EkornZpBn0Xe2Q6Q7UOfDLQH4dYQm+YkNjcCPDlA9yCwO0WVA+9uLX2sh8P
         PAYhOUyvfZdpOQA/hrUF4UpSD0ID2LinkIaYOKmqBmKibtTcf/EU6x03yJcD63XviX
         iWZ40LzOFsPQMro0dQk0blgWCzHnGt56r1BLzqKU=
Date:   Mon, 7 Oct 2019 18:17:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        linux-security-module@vger.kernel.org, stable@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH] ovl: filter of trusted xattr results in audit
Message-ID: <20191007161725.GB988623@kroah.com>
References: <20191007160918.29504-1-salyzyn@android.com>
 <20191007161616.GA988623@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007161616.GA988623@kroah.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 06:16:16PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 07, 2019 at 09:09:16AM -0700, Mark Salyzyn wrote:
> > When filtering xattr list for reading, presence of trusted xattr
> > results in a security audit log.  However, if there is other content
> > no errno will be set, and if there isn't, the errno will be -ENODATA
> > and not -EPERM as is usually associated with a lack of capability.
> > The check does not block the request to list the xattrs present.
> > 
> > Switch to has_capability_noaudit to reflect a more appropriate check.
> > 
> > Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> > Cc: linux-security-module@vger.kernel.org
> > Cc: kernel-team@android.com
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: stable@vger.kernel.org # v3.18
> > Fixes: upstream a082c6f680da ("ovl: filter trusted xattr for non-admin")
> > Fixes: 3.18 4bcc9b4b3a0a ("ovl: filter trusted xattr for non-admin")
> > ---
> > Replaced ns_capable_noaudit with 3.18.y tree specific
> > has_capability_noaudit present in original submission to kernel.org
> > commit 5c2e9f346b815841f9bed6029ebcb06415caf640
> > ("ovl: filter of trusted xattr results in audit")
> > 
> >  fs/overlayfs/inode.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> > index a01ec1836a72..1175efa5e956 100644
> > --- a/fs/overlayfs/inode.c
> > +++ b/fs/overlayfs/inode.c
> > @@ -265,7 +265,8 @@ static bool ovl_can_list(const char *s)
> >  		return true;
> >  
> >  	/* Never list trusted.overlay, list other trusted for superuser only */
> > -	return !ovl_is_private_xattr(s) && capable(CAP_SYS_ADMIN);
> > +	return !ovl_is_private_xattr(s) &&
> > +	       has_capability_noaudit(current, CAP_SYS_ADMIN);
> >  }
> >  
> >  ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
> > -- 
> > 2.23.0.581.g78d2f28ef7-goog
> > 
> 
> Thanks for the backport, this one worked!

I spoke too soon:

ERROR: "has_capability_noaudit" [fs/overlayfs/overlay.ko] undefined!

That function isn't exported for modules :(

greg k-h
