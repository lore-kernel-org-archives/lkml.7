Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4077C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDD121738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554481904;
	bh=MIlRvXJSnmUqGpJtw3hxqL1JereU8yIRzZ6lrvGbOLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bZ10JAnKGD7tB46/avlmkXzOytiunlFM/292arsypPcPIzCATmQHsM0Nipru3wP+d
	 Ufz4iv/QoyU/55T0ozQWGSvRCHU/u4Acn+9d4iJ0hLerRPRMidFYrTbGr8JzWkGwNq
	 tSJzGOgfDZSYqNF/J1957VlfJJknz3BRUEdzO2NM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbfDEQbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730870AbfDEQbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:31:39 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 412392146F;
        Fri,  5 Apr 2019 16:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554481898;
        bh=MIlRvXJSnmUqGpJtw3hxqL1JereU8yIRzZ6lrvGbOLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z1ZiGeFwImb0illlEzqo/aTzytGfLgWzw39XvYS+GM8WLF28J6n0Lq9j2UjSraeMP
         ndtWelwuGoOVI2tu2/IVUzXOKeXCvp/BPXBArklzj2WpVXMbS8/Q8rUDaqizdCV/1O
         CbaRUvJ0YKHl6c8QqlIhaOvxdCtTB/BAqfNkkM4o=
Date:   Fri, 5 Apr 2019 09:31:37 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 1/5] f2fs: clean up codes with op_is_write()
Message-ID: <20190405163137.GC51212@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190402105222.28374-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402105222.28374-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02, Chao Yu wrote:
> This patch uses generic function op_is_write() to instead private defined
> macro is_read_io() for cleanup.

I don't see huge reason to clean up this, but do expect huge backporting issue.

Thanks,

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/data.c | 25 +++++++++++++------------
>  fs/f2fs/f2fs.h |  3 +--
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d87dfa5aa112..22beda1a0c3c 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -287,7 +287,7 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
>  static inline void __submit_bio(struct f2fs_sb_info *sbi,
>  				struct bio *bio, enum page_type type)
>  {
> -	if (!is_read_io(bio_op(bio))) {
> +	if (op_is_write(bio_op(bio))) {
>  		unsigned int start;
>  
>  		if (type != DATA && type != NODE)
> @@ -324,10 +324,11 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
>  			set_sbi_flag(sbi, SBI_NEED_CP);
>  	}
>  submit_io:
> -	if (is_read_io(bio_op(bio)))
> -		trace_f2fs_submit_read_bio(sbi->sb, type, bio);
> -	else
> +	if (op_is_write(bio_op(bio)))
>  		trace_f2fs_submit_write_bio(sbi->sb, type, bio);
> +	else
> +		trace_f2fs_submit_read_bio(sbi->sb, type, bio);
> +
>  	submit_bio(bio);
>  }
>  
> @@ -340,10 +341,10 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
>  
>  	bio_set_op_attrs(io->bio, fio->op, fio->op_flags);
>  
> -	if (is_read_io(fio->op))
> -		trace_f2fs_prepare_read_bio(io->sbi->sb, fio->type, io->bio);
> -	else
> +	if (op_is_write(fio->op))
>  		trace_f2fs_prepare_write_bio(io->sbi->sb, fio->type, io->bio);
> +	else
> +		trace_f2fs_prepare_read_bio(io->sbi->sb, fio->type, io->bio);
>  
>  	__submit_bio(io->sbi, io->bio, fio->type);
>  	io->bio = NULL;
> @@ -464,20 +465,20 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>  
>  	/* Allocate a new bio */
>  	bio = __bio_alloc(fio->sbi, fio->new_blkaddr, fio->io_wbc,
> -				1, is_read_io(fio->op), fio->type, fio->temp);
> +				1, !op_is_write(fio->op), fio->type, fio->temp);
>  
>  	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
>  		bio_put(bio);
>  		return -EFAULT;
>  	}
>  
> -	if (fio->io_wbc && !is_read_io(fio->op))
> +	if (fio->io_wbc && op_is_write(fio->op))
>  		wbc_account_io(fio->io_wbc, page, PAGE_SIZE);
>  
>  	bio_set_op_attrs(bio, fio->op, fio->op_flags);
>  
> -	inc_page_count(fio->sbi, is_read_io(fio->op) ?
> -			__read_io_type(page): WB_DATA_TYPE(fio->page));
> +	inc_page_count(fio->sbi, op_is_write(fio->op) ?
> +			WB_DATA_TYPE(fio->page) : __read_io_type(page));
>  
>  	__submit_bio(fio->sbi, bio, fio->type);
>  	return 0;
> @@ -490,7 +491,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>  	struct f2fs_bio_info *io = sbi->write_io[btype] + fio->temp;
>  	struct page *bio_page;
>  
> -	f2fs_bug_on(sbi, is_read_io(fio->op));
> +	f2fs_bug_on(sbi, !op_is_write(fio->op));
>  
>  	down_write(&io->io_rwsem);
>  next:
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 5bc7b99fb9c1..24e7f0e6aab7 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1048,7 +1048,6 @@ struct f2fs_io_info {
>  	unsigned char version;		/* version of the node */
>  };
>  
> -#define is_read_io(rw) ((rw) == READ)
>  struct f2fs_bio_info {
>  	struct f2fs_sb_info *sbi;	/* f2fs superblock */
>  	struct bio *bio;		/* bios to merge */
> @@ -2813,7 +2812,7 @@ static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi,
>  #define __is_large_section(sbi)		((sbi)->segs_per_sec > 1)
>  
>  #define __is_meta_io(fio) (PAGE_TYPE_OF_BIO((fio)->type) == META &&	\
> -				(!is_read_io((fio)->op) || (fio)->is_meta))
> +				(op_is_write((fio)->op) || (fio)->is_meta))
>  
>  bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>  					block_t blkaddr, int type);
> -- 
> 2.18.0.rc1
