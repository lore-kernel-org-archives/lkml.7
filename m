Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1A9C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD28720643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R52MJref"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfCKQqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:46:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39983 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfCKQqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:46:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id r23so2109914edm.7;
        Mon, 11 Mar 2019 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kkf/Ijrme+opCg1UsdMKL4AypLjy9oSWPmvyVp+1AaY=;
        b=R52MJrefkdEzuQ8cmYOEzgF9J9lGWW4f5VqG57Wrc4LcJQv0SGqVbvmlga76A1SSZg
         5VE0y09Dp6+wgYsNyhPtorn7MC0MPuAu31MeQHQ9tYE7wk4xeDkj6WCoaLBS6jOpUTNo
         CCTEMTLFcpJDwb1XplMB+bA6cSww65n9CSQsYWq83NbZ3yoEzLL2kfld4IBYjCdzmv9I
         FbOKk8JpUm1wnIiYDW9XTd1oipr1N6GKRyW+kNo+6RI9RiCC+H11+hHH082tsrG3WNJH
         6g2b5pXDePYVUDEiNJCY8Tb+hy0kDnkteQ0B2z0ihvv0iWqqbGuCOdJE3ndJF8gndGU6
         gqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kkf/Ijrme+opCg1UsdMKL4AypLjy9oSWPmvyVp+1AaY=;
        b=eGlABLOX4SlgqLwErFkvVClbVwAW0kkFlv2/5oFf0qdPXyLS4CYvZWLVahlarMHduh
         0CmaMpmFlqKyaodCZCZjy9Uo1dT1aXmpnAzgwwj9jjKdPvXZ/BwmsKPLHr7EQYJvecVx
         PeciRJdXa0wtbrQTj9+Ij5t+ie7eBmQ0SZNOvA17KcSdsld2R+lW8sx+xCt9bl1Ygsne
         TutainXtfpXlxfWqoPHeKeXBLfjPULKZixXbojCZgnl6NvvMb3kpcdi8cRHoTpaOPc8B
         h1TkHiOGwSfW2fXGa3ZsUy5Wb811O/4busMecHCcyHhPUtsU4C5qDDK86FdO0d0vwo3N
         SuFw==
X-Gm-Message-State: APjAAAV6/RnSfnlKx8haLN+SS2m8Cuj5uvRrfM+tJrpODe0TDKlqXpII
        L72O7EZMd0LIbxTKsTFx1iQ=
X-Google-Smtp-Source: APXvYqyQpW22nD/RG7vPyLS19R0fh65LzgqxQS4c7YM9aEOpRV0ZNtbAJzKYgAHuv6XQz0cllEHZRg==
X-Received: by 2002:a05:6402:1352:: with SMTP id y18mr44341968edw.76.1552322779118;
        Mon, 11 Mar 2019 09:46:19 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id k14sm4781836edb.51.2019.03.11.09.46.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Mar 2019 09:46:18 -0700 (PDT)
Date:   Mon, 11 Mar 2019 09:46:16 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 1/2] xfs: zero initialize highstale and lowstale in
 xfs_dir2_leaf_addname
Message-ID: <20190311164616.GA14469@archlinux-ryzen>
References: <20190311161948.GC4359@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311161948.GC4359@magnolia>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 09:19:48AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Smatch complains about the following:
> 
> fs/xfs/libxfs/xfs_dir2_leaf.c:848 xfs_dir2_leaf_addname() error:
> uninitialized symbol 'lowstale'.
> 
> fs/xfs/libxfs/xfs_dir2_leaf.c:849 xfs_dir2_leaf_addname() error:
> uninitialized symbol 'highstale'.
> 
> I don't think there's any incorrect behavior associated with the
> uninitialized variable, but as the author of the previous zero-init
> patch points out, it's best not to be passing around pointers to
> uninitialized stack areas.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for this!

> ---
>  fs/xfs/libxfs/xfs_dir2_leaf.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_dir2_leaf.c b/fs/xfs/libxfs/xfs_dir2_leaf.c
> index 9a3767818c50..2abf945e5844 100644
> --- a/fs/xfs/libxfs/xfs_dir2_leaf.c
> +++ b/fs/xfs/libxfs/xfs_dir2_leaf.c
> @@ -574,7 +574,7 @@ xfs_dir2_leaf_addname(
>  	xfs_dir2_data_unused_t	*dup;		/* data unused entry */
>  	int			error;		/* error return value */
>  	int			grown;		/* allocated new data block */
> -	int			highstale;	/* index of next stale leaf */
> +	int			highstale = 0;	/* index of next stale leaf */
>  	int			i;		/* temporary, index */
>  	int			index;		/* leaf table position */
>  	struct xfs_buf		*lbp;		/* leaf's buffer */
> @@ -583,7 +583,7 @@ xfs_dir2_leaf_addname(
>  	xfs_dir2_leaf_entry_t	*lep;		/* leaf entry table pointer */
>  	int			lfloglow;	/* low leaf logging index */
>  	int			lfloghigh;	/* high leaf logging index */
> -	int			lowstale;	/* index of prev stale leaf */
> +	int			lowstale = 0;	/* index of prev stale leaf */
>  	xfs_dir2_leaf_tail_t	*ltp;		/* leaf tail pointer */
>  	int			needbytes;	/* leaf block bytes needed */
>  	int			needlog;	/* need to log data header */
