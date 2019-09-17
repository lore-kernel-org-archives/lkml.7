Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290A3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20BA21670
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfIQJwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 05:52:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:51574 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbfIQJwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:52:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44616AC63;
        Tue, 17 Sep 2019 09:52:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C7E45DA889; Tue, 17 Sep 2019 11:52:41 +0200 (CEST)
Date:   Tue, 17 Sep 2019 11:52:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     David Sterba <dsterba@suse.com>, emamd001@umn.edu, kjlu@umn.edu,
        smccaman@umn.edu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/affs: release memory if affs_init_bitmap fails
Message-ID: <20190917095241.GP2850@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        David Sterba <dsterba@suse.com>, emamd001@umn.edu, kjlu@umn.edu,
        smccaman@umn.edu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190917041346.4802-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917041346.4802-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 11:13:42PM -0500, Navid Emamdoost wrote:
> In affs_init_bitmap, on error handling path we may release the allocated
> memory.

Yes the memory should be released but not all paths that lead to the
label 'out' are actually errors:

288                 if (affs_checksum_block(sb, bh)) {
289                         pr_warn("Bitmap %u invalid - mounting %s read only.\n",
290                                 bm->bm_key, sb->s_id);
291                         *flags |= SB_RDONLY;
292                         goto out;
293                 }

ie. the return value 'res' is still 0, and the filesystem is mounted
read-only.

> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  fs/affs/bitmap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/affs/bitmap.c b/fs/affs/bitmap.c
> index 5ba9ef2742f6..745ed2cc4b51 100644
> --- a/fs/affs/bitmap.c
> +++ b/fs/affs/bitmap.c
> @@ -347,6 +347,7 @@ int affs_init_bitmap(struct super_block *sb, int *flags)
>  out:
>  	affs_brelse(bh);
>  	affs_brelse(bmap_bh);
> +	kfree(sbi->s_bitmap);

The sbi->s_bitmap would be freed but at umount time it will
be freed again.

>  	return res;
>  }
>  
> -- 
> 2.17.1
> 
> 
