Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33C6C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D0D20873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfJOIF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:05:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:59644 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728350AbfJOIF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:05:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3465B564;
        Tue, 15 Oct 2019 08:05:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4A3DF1E4A8A; Tue, 15 Oct 2019 10:05:57 +0200 (CEST)
Date:   Tue, 15 Oct 2019 10:05:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: include internal.h for missing declarations
Message-ID: <20191015080557.GC21550@quack2.suse.cz>
References: <20191011170039.16100-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011170039.16100-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11-10-19 18:00:39, Ben Dooks wrote:
> The declarations of __block_write_begin_int and guard_bio_eod
> are needed from internal.h so include it to fix the following
> sparse warnings:
> 
> fs/buffer.c:1930:5: warning: symbol '__block_write_begin_int' was not declared. Should it be static?
> fs/buffer.c:2994:6: warning: symbol 'guard_bio_eod' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

OK, makes sense to keep declarations in sync with real functions. Thanks
for the patch a feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/buffer.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 86a38b979323..792f22a88e67 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -48,6 +48,8 @@
>  #include <linux/sched/mm.h>
>  #include <trace/events/block.h>
>  
> +#include "internal.h"
> +
>  static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
>  static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
>  			 enum rw_hint hint, struct writeback_control *wbc);
> -- 
> 2.23.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
