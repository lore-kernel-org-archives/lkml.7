Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F79EFA3731
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D00420820
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408295AbfJQId3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:33:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:48192 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408283AbfJQId2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:33:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0B05B742;
        Thu, 17 Oct 2019 08:33:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9A1231E485F; Thu, 17 Oct 2019 10:33:26 +0200 (CEST)
Date:   Thu, 17 Oct 2019 10:33:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsnotify/fdinfo: exportfs_encode_inode_fh() takes
 pointer as 4th argument
Message-ID: <20191017083326.GC20260@quack2.suse.cz>
References: <20191016095955.3347-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016095955.3347-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-10-19 10:59:55, Ben Dooks (Codethink) wrote:
> The call to exportfs_encode_inode_fh() takes an pointer
> as the 4th argument, so replace the integer 0 with the
> NULL pointer.
> 
> This fixes the following sparse warning:
> 
> fs/notify/fdinfo.c:53:87: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Thanks for the cleanup! Applied.

								Honza

> ---
> Cc: Jan Kara <jack@suse.cz>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/notify/fdinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> index 1e2bfd26b352..ef83f4020554 100644
> --- a/fs/notify/fdinfo.c
> +++ b/fs/notify/fdinfo.c
> @@ -50,7 +50,7 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
>  	f.handle.handle_bytes = sizeof(f.pad);
>  	size = f.handle.handle_bytes >> 2;
>  
> -	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, 0);
> +	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, NULL);
>  	if ((ret == FILEID_INVALID) || (ret < 0)) {
>  		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
>  		return;
> -- 
> 2.23.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
