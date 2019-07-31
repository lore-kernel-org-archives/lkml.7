Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61245C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3155D2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfGaJs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:48:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:51478 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbfGaJsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:48:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2310EAD93;
        Wed, 31 Jul 2019 09:48:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D22641E43D6; Wed, 31 Jul 2019 11:48:19 +0200 (CEST)
Date:   Wed, 31 Jul 2019 11:48:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     jack@suse.cz, akpm@linux-foundation.org, arnd@arndb.de,
        hariprasad.kelam@gmail.com, linux.bhar@gmail.com,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: reiserfs: Remove unnecessary check of bh in
 remove_from_transaction()
Message-ID: <20190731094819.GB15806@quack2.suse.cz>
References: <20190727084019.11307-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727084019.11307-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 27-07-19 16:40:19, Jia-Ju Bai wrote:
> On lines 3430-3434, bh has been assured to be non-null:
>     cn = get_journal_hash_dev(sb, journal->j_hash_table, blocknr);
>     if (!cn || !cn->bh) {
>         return ret;
>     }
>     bh = cn->bh;
> 
> Thus, the check of bh on line 3447 is unnecessary and can be removed.
> Thank Andrew Morton for good advice.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/reiserfs/journal.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
> index 4517a1394c6f..11155b8513db 100644
> --- a/fs/reiserfs/journal.c
> +++ b/fs/reiserfs/journal.c
> @@ -3444,9 +3444,8 @@ static int remove_from_transaction(struct super_block *sb,
>  	if (cn == journal->j_last) {
>  		journal->j_last = cn->prev;
>  	}
> -	if (bh)
> -		remove_journal_hash(sb, journal->j_hash_table, NULL,
> -				    bh->b_blocknr, 0);
> +	remove_journal_hash(sb, journal->j_hash_table, NULL,
> +			    bh->b_blocknr, 0);
>  	clear_buffer_journaled(bh);	/* don't log this one */
>  
>  	if (!already_cleaned) {
> -- 
> 2.17.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
