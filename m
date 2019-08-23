Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B5AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 03:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EC123407
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 03:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404050AbfHWDCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 23:02:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49972 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726283AbfHWDCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 23:02:47 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E9570F33A7B7D70DA2DC;
        Fri, 23 Aug 2019 11:02:44 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 23 Aug
 2019 11:02:42 +0800
Subject: Re: [PATCH 1/2] f2fs: introduce {page,io}_is_mergeable() for
 readability
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20190712085542.4068-1-yuchao0@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <28424a84-67aa-c8e9-99c3-475be89206ac@huawei.com>
Date:   Fri, 23 Aug 2019 11:02:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190712085542.4068-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/12 16:55, Chao Yu wrote:
> Wrap merge condition into function for readability, no logic change.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2: remove bio validation check in page_is_mergeable().
>  fs/f2fs/data.c | 40 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 6a8db4abdf5f..f1e401f9fc13 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -482,6 +482,33 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>  	return 0;
>  }
>  
> +static bool page_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
> +				block_t last_blkaddr, block_t cur_blkaddr)
> +{
> +	if (last_blkaddr != cur_blkaddr)

if (last_blkaddr + 1 != cur_blkaddr)

Merge condition is wrong here.

> +		return false;
> +	return __same_bdev(sbi, cur_blkaddr, bio);
> +}
> +
> +static bool io_type_is_mergeable(struct f2fs_bio_info *io,
> +						struct f2fs_io_info *fio)
> +{
> +	if (io->fio.op != fio->op)
> +		return false;
> +	return io->fio.op_flags == fio->op_flags;
> +}
> +
> +static bool io_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
> +					struct f2fs_bio_info *io,
> +					struct f2fs_io_info *fio,
> +					block_t last_blkaddr,
> +					block_t cur_blkaddr)
> +{
> +	if (!page_is_mergeable(sbi, bio, last_blkaddr, cur_blkaddr))
> +		return false;
> +	return io_type_is_mergeable(io, fio);
> +}
> +
>  int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>  {
>  	struct bio *bio = *fio->bio;
> @@ -495,8 +522,8 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>  	trace_f2fs_submit_page_bio(page, fio);
>  	f2fs_trace_ios(fio, 0);
>  
> -	if (bio && (*fio->last_block + 1 != fio->new_blkaddr ||
> -			!__same_bdev(fio->sbi, fio->new_blkaddr, bio))) {
> +	if (bio && !page_is_mergeable(fio->sbi, bio, *fio->last_block,
> +						fio->new_blkaddr)) {
>  		__submit_bio(fio->sbi, bio, fio->type);
>  		bio = NULL;
>  	}
> @@ -569,9 +596,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>  
>  	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
>  
> -	if (io->bio && (io->last_block_in_bio != fio->new_blkaddr - 1 ||
> -	    (io->fio.op != fio->op || io->fio.op_flags != fio->op_flags) ||
> -			!__same_bdev(sbi, fio->new_blkaddr, io->bio)))
> +	if (io->bio && !io_is_mergeable(sbi, io->bio, io, fio,
> +			io->last_block_in_bio, fio->new_blkaddr))
>  		__submit_merged_bio(io);
>  alloc_new:
>  	if (io->bio == NULL) {
> @@ -1643,8 +1669,8 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
>  	 * This page will go to BIO.  Do we need to send this
>  	 * BIO off first?
>  	 */
> -	if (bio && (*last_block_in_bio != block_nr - 1 ||
> -		!__same_bdev(F2FS_I_SB(inode), block_nr, bio))) {
> +	if (bio && !page_is_mergeable(F2FS_I_SB(inode), bio,
> +				*last_block_in_bio, block_nr - 1)) {

*last_block_in_bio, block_nr)

Sorry, anyway, let me send v2.

>  submit_and_realloc:
>  		__submit_bio(F2FS_I_SB(inode), bio, DATA);
>  		bio = NULL;
> 
