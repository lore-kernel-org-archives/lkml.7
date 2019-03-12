Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569CFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235652075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfCLOWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:22:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfCLOWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:22:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F16DF307E044;
        Tue, 12 Mar 2019 14:22:05 +0000 (UTC)
Received: from redhat.com (ovpn-122-134.rdu2.redhat.com [10.10.122.134])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CFB510018F9;
        Tue, 12 Mar 2019 14:22:04 +0000 (UTC)
Date:   Tue, 12 Mar 2019 09:22:02 -0500
From:   Bill O'Donnell <billodo@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 1/2] xfs: zero initialize highstale and lowstale in
 xfs_dir2_leaf_addname
Message-ID: <20190312142202.GA28037@redhat.com>
References: <20190311161948.GC4359@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311161948.GC4359@magnolia>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 12 Mar 2019 14:22:06 +0000 (UTC)
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

Reviewed-by: Bill O'Donnell <billodo@redhat.com>

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
