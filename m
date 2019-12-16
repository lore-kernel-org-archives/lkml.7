Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE8BC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80600206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfLPL5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:57:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:36612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727241AbfLPL5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:57:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64477ACC9;
        Mon, 16 Dec 2019 11:57:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 064BF1E0B2E; Mon, 16 Dec 2019 12:57:42 +0100 (CET)
Date:   Mon, 16 Dec 2019 12:57:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     syzbot <syzbot+1c6756baf4b16b94d2a6@syzkaller.appspotmail.com>,
        deepa.kernel@gmail.com, jack@suse.cz, jeffm@suse.com,
        jlayton@kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] Re: memory leak in reiserfs_fill_super
Message-ID: <20191216115741.GE22157@quack2.suse.cz>
References: <000000000000ab22f20599779d25@google.com>
 <dbad2a8f-5a58-ecb5-eec7-1d6ef90abaed@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbad2a8f-5a58-ecb5-eec7-1d6ef90abaed@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 14-12-19 15:12:57, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> fill_super() conditionally allocates a jdev string if "jdev=x"
> is specified.  put_super() should free that memory.
> 
> Reported-by: syzbot+1c6756baf4b16b94d2a6@syzkaller.appspotmail.com
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks Randy but I've already sent a similar (and more complete) fix to this
bug as part of [1].

								Honza

[1] https://lore.kernel.org/linux-fsdevel/20191212105018.910-1-jack@suse.cz/

> ---
>  fs/reiserfs/super.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20191213.orig/fs/reiserfs/super.c
> +++ linux-next-20191213/fs/reiserfs/super.c
> @@ -629,6 +629,7 @@ static void reiserfs_put_super(struct su
>  	reiserfs_write_unlock(s);
>  	mutex_destroy(&REISERFS_SB(s)->lock);
>  	destroy_workqueue(REISERFS_SB(s)->commit_wq);
> +	kfree(REISERFS_SB(s)->s_jdev);
>  	kfree(s->s_fs_info);
>  	s->s_fs_info = NULL;
>  }
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
