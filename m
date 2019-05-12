Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD565C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 16:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7192146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 16:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="ClIgapr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfELQHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 12:07:21 -0400
Received: from mx01-fr.bfs.de ([193.174.231.67]:53288 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfELQHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 12:07:20 -0400
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id 3838F202F9;
        Sun, 12 May 2019 18:07:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1557677233; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e9lIIrxqzPfMJtNjxYdjjp0sTF1N/4LjdHyl2m7Zouc=;
        b=ClIgapr3lJTQBGuJFnVflN127lsjn3Of+XZPKOKnhtcXJjHSz6v/3u7nmK5F2kQJFoDDzD
        AhEkVYRem4iFHvEknK28FRcNhTHL7VafXvPSCEW14rfjvVlo9BNJpx7VDL8q9YiWFnfaWN
        G9SfyW4ajkzvwwkPOjRIOjlkAACamwauVg+QnUP/jqjJASo7CFdPyKNquVberDrNr6fn2w
        CXV6Zu15NoDVYJEUM2wOzxeuP3UsPnE8P4wmU7pCkpHqD+KTfFrnAYPZxMzW5sHlOKuPKA
        9+l+gx6HjWB02hi9Ut8VAuGZb70ONYMaQdvLeRcVxrQgsMXQfekU0Q3FiNidQQ==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id 80894BEEBD;
        Sun, 12 May 2019 18:07:12 +0200 (CEST)
Message-ID: <5CD844B0.5060206@bfs.de>
Date:   Sun, 12 May 2019 18:07:12 +0200
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     David Howells <dhowells@redhat.com>
CC:     colin.king@canonical.com, joe@perches.com, jaltman@auristor.com,
        linux-afs@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] afs: Fix afs_xattr_get_yfs() to not try freeing an
 error value
References: <155764714099.24080.1233326575922058381.stgit@warthog.procyon.org.uk> <155764714872.24080.15171754166782593095.stgit@warthog.procyon.org.uk>
In-Reply-To: <155764714872.24080.15171754166782593095.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-3.10 / 7.00];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         TO_DN_SOME(0.00)[];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 12.05.2019 09:45, schrieb David Howells:
> afs_xattr_get_yfs() tries to free yacl, which may hold an error value (say
> if yfs_fs_fetch_opaque_acl() failed and returned an error).
> 
> Fix this by allocating yacl up front (since it's a fixed-length struct,
> unlike afs_acl) and passing it in to the RPC function.  This also allows
> the flags to be placed in the object rather than passing them through to
> the RPC function.
> 
> Fixes: ae46578b963f ("afs: Get YFS ACLs and information through xattrs")
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/afs/internal.h  |    2 +
>  fs/afs/xattr.c     |   86 ++++++++++++++++++++++++++++------------------------
>  fs/afs/yfsclient.c |   29 ++++--------------
>  3 files changed, 53 insertions(+), 64 deletions(-)
> 
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index b3cd6e8ad59d..74ee0f8ef8dd 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -1382,7 +1382,7 @@ struct yfs_acl {
>  };
>  
>  extern void yfs_free_opaque_acl(struct yfs_acl *);
> -extern struct yfs_acl *yfs_fs_fetch_opaque_acl(struct afs_fs_cursor *, unsigned int);
> +extern struct yfs_acl *yfs_fs_fetch_opaque_acl(struct afs_fs_cursor *, struct yfs_acl *);
>  extern int yfs_fs_store_opaque_acl2(struct afs_fs_cursor *, const struct afs_acl *);
>  
>  /*
> diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
> index b6c44e75b361..d12bcda911e1 100644
> --- a/fs/afs/xattr.c
> +++ b/fs/afs/xattr.c
> @@ -148,9 +148,8 @@ static int afs_xattr_get_yfs(const struct xattr_handler *handler,
>  	struct afs_vnode *vnode = AFS_FS_I(inode);
>  	struct yfs_acl *yacl = NULL;
>  	struct key *key;
> -	unsigned int flags = 0;
>  	char buf[16], *data;
> -	int which = 0, dsize, ret;
> +	int which = 0, dsize, ret = -ENOMEM;
>  
>  	if (strcmp(name, "acl") == 0)
>  		which = 0;
> @@ -163,20 +162,26 @@ static int afs_xattr_get_yfs(const struct xattr_handler *handler,
>  	else
>  		return -EOPNOTSUPP;
>  
> +	yacl = kzalloc(sizeof(struct yfs_acl), GFP_KERNEL);
> +	if (!yacl)
> +		goto error;
> +
>  	if (which == 0)
> -		flags |= YFS_ACL_WANT_ACL;
> +		yacl->flags |= YFS_ACL_WANT_ACL;
>  	else if (which == 3)
> -		flags |= YFS_ACL_WANT_VOL_ACL;
> +		yacl->flags |= YFS_ACL_WANT_VOL_ACL;
>  
>  	key = afs_request_key(vnode->volume->cell);
> -	if (IS_ERR(key))
> -		return PTR_ERR(key);
> +	if (IS_ERR(key)) {
> +		ret = PTR_ERR(key);
> +		goto error_yacl;
> +	}
>  
>  	ret = -ERESTARTSYS;
>  	if (afs_begin_vnode_operation(&fc, vnode, key)) {
>  		while (afs_select_fileserver(&fc)) {
>  			fc.cb_break = afs_calc_vnode_cb_break(vnode);
> -			yacl = yfs_fs_fetch_opaque_acl(&fc, flags);
> +			yfs_fs_fetch_opaque_acl(&fc, yacl);
>  		}
>  
>  		afs_check_for_remote_deletion(&fc, fc.vnode);
> @@ -184,44 +189,45 @@ static int afs_xattr_get_yfs(const struct xattr_handler *handler,
>  		ret = afs_end_vnode_operation(&fc);
>  	}
>  
> -	if (ret == 0) {
> -		switch (which) {
> -		case 0:
> -			data = yacl->acl->data;
> -			dsize = yacl->acl->size;
> -			break;
> -		case 1:
> -			data = buf;
> -			dsize = snprintf(buf, sizeof(buf), "%u",
> -					 yacl->inherit_flag);
> -			break;
> -		case 2:
> -			data = buf;
> -			dsize = snprintf(buf, sizeof(buf), "%u",
> -					 yacl->num_cleaned);
> -			break;
> -		case 3:
> -			data = yacl->vol_acl->data;
> -			dsize = yacl->vol_acl->size;
> -			break;
> -		default:
> -			ret = -EOPNOTSUPP;
> -			goto out;
> -		}
> +	if (ret < 0)
> +		goto error_key;
> +
> +	switch (which) {
> +	case 0:
> +		data = yacl->acl->data;
> +		dsize = yacl->acl->size;
> +		break;
> +	case 1:
> +		data = buf;
> +		dsize = snprintf(buf, sizeof(buf), "%u", yacl->inherit_flag);
> +		break;
> +	case 2:
> +		data = buf;
> +		dsize = snprintf(buf, sizeof(buf), "%u", yacl->num_cleaned);
> +		break;
> +	case 3:
> +		data = yacl->vol_acl->data;
> +		dsize = yacl->vol_acl->size;
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		goto error_key;
> +	}
>  
> -		ret = dsize;
> -		if (size > 0) {
> -			if (dsize > size) {
> -				ret = -ERANGE;
> -				goto out;
> -			}
> -			memcpy(buffer, data, dsize);
> +	ret = dsize;
> +	if (size > 0) {
> +		if (dsize > size) {
> +			ret = -ERANGE;
> +			goto error_key;
>  		}
> +		memcpy(buffer, data, dsize);
>  	}
>  

i am confused: if size is <= 0 then the error is in dsize ?

re,
 wh

> -out:
> -	yfs_free_opaque_acl(yacl);
> +error_key:
>  	key_put(key);
> +error_yacl:
> +	yfs_free_opaque_acl(yacl);
> +error:
>  	return ret;
>  }
>  
> diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
> index 6cf7d161baa1..d3e9e3fe0b58 100644
> --- a/fs/afs/yfsclient.c
> +++ b/fs/afs/yfsclient.c
> @@ -2333,12 +2333,6 @@ void yfs_free_opaque_acl(struct yfs_acl *yacl)
>  	}
>  }
>  
> -static void yfs_destroy_fs_fetch_opaque_acl(struct afs_call *call)
> -{
> -	yfs_free_opaque_acl(call->reply[0]);
> -	afs_flat_call_destructor(call);
> -}
> -
>  /*
>   * YFS.FetchOpaqueACL operation type
>   */
> @@ -2346,18 +2340,17 @@ static const struct afs_call_type yfs_RXYFSFetchOpaqueACL = {
>  	.name		= "YFS.FetchOpaqueACL",
>  	.op		= yfs_FS_FetchOpaqueACL,
>  	.deliver	= yfs_deliver_fs_fetch_opaque_acl,
> -	.destructor	= yfs_destroy_fs_fetch_opaque_acl,
> +	.destructor	= afs_flat_call_destructor,
>  };
>  
>  /*
>   * Fetch the YFS advanced ACLs for a file.
>   */
>  struct yfs_acl *yfs_fs_fetch_opaque_acl(struct afs_fs_cursor *fc,
> -					unsigned int flags)
> +					struct yfs_acl *yacl)
>  {
>  	struct afs_vnode *vnode = fc->vnode;
>  	struct afs_call *call;
> -	struct yfs_acl *yacl;
>  	struct afs_net *net = afs_v2net(vnode);
>  	__be32 *bp;
>  
> @@ -2370,19 +2363,15 @@ struct yfs_acl *yfs_fs_fetch_opaque_acl(struct afs_fs_cursor *fc,
>  				   sizeof(__be32) * 2 +
>  				   sizeof(struct yfs_xdr_YFSFetchStatus) +
>  				   sizeof(struct yfs_xdr_YFSVolSync));
> -	if (!call)
> -		goto nomem;
> -
> -	yacl = kzalloc(sizeof(struct yfs_acl), GFP_KERNEL);
> -	if (!yacl)
> -		goto nomem_call;
> +	if (!call) {
> +		fc->ac.error = -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
> +	}
>  
> -	yacl->flags = flags;
>  	call->key = fc->key;
>  	call->reply[0] = yacl;
>  	call->reply[1] = vnode;
>  	call->reply[2] = NULL; /* volsync */
> -	call->ret_reply0 = true;
>  
>  	/* marshall the parameters */
>  	bp = call->request;
> @@ -2396,12 +2385,6 @@ struct yfs_acl *yfs_fs_fetch_opaque_acl(struct afs_fs_cursor *fc,
>  	trace_afs_make_fs_call(call, &vnode->fid);
>  	afs_make_call(&fc->ac, call, GFP_KERNEL);
>  	return (struct yfs_acl *)afs_wait_for_call_to_complete(call, &fc->ac);
> -
> -nomem_call:
> -	afs_put_call(call);
> -nomem:
> -	fc->ac.error = -ENOMEM;
> -	return ERR_PTR(-ENOMEM);
>  }
>  
>  /*
> 
> 
