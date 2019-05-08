Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A34C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1401B205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfEHGCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 02:02:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbfEHGCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:02:44 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3276EBA782003272E7F9;
        Wed,  8 May 2019 14:02:42 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 8 May 2019
 14:02:37 +0800
Subject: Re: linux-next: manual merge of the staging tree with the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Jens Axboe <axboe@kernel.dk>, Greg KH <greg@kroah.com>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20190501170528.2d86d133@canb.auug.org.au>
 <20190508134413.26a13d00@canb.auug.org.au>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <b864d776-d671-b95e-e8bc-85c00bfb669f@huawei.com>
Date:   Wed, 8 May 2019 14:02:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190508134413.26a13d00@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 2019/5/8 11:44, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 1 May 2019 17:05:28 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Today's linux-next merge of the staging tree got conflicts in:
>>
>>   drivers/staging/erofs/data.c
>>   drivers/staging/erofs/unzip_vle.c
>>
>> between commit:
>>
>>   2b070cfe582b ("block: remove the i argument to bio_for_each_segment_all")
>>
>> from the block tree and commit:
>>
>>   14a56ec65bab ("staging: erofs: support IO read error injection")
>>
>> from the staging tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>
>> -- 
>> Cheers,
>> Stephen Rothwell
>>
>> diff --cc drivers/staging/erofs/data.c
>> index 9f04d7466c55,c64ec76643d4..000000000000
>> --- a/drivers/staging/erofs/data.c
>> +++ b/drivers/staging/erofs/data.c
>> @@@ -17,11 -17,18 +17,17 @@@
>>   
>>   static inline void read_endio(struct bio *bio)
>>   {
>> + 	struct super_block *const sb = bio->bi_private;
>>  -	int i;
>>   	struct bio_vec *bvec;
>> - 	const blk_status_t err = bio->bi_status;
>> + 	blk_status_t err = bio->bi_status;
>>   	struct bvec_iter_all iter_all;
>>   
>> + 	if (time_to_inject(EROFS_SB(sb), FAULT_READ_IO)) {
>> + 		erofs_show_injection_info(FAULT_READ_IO);
>> + 		err = BLK_STS_IOERR;
>> + 	}
>> + 
>>  -	bio_for_each_segment_all(bvec, bio, i, iter_all) {
>>  +	bio_for_each_segment_all(bvec, bio, iter_all) {
>>   		struct page *page = bvec->bv_page;
>>   
>>   		/* page is already locked */
>> diff --cc drivers/staging/erofs/unzip_vle.c
>> index 59b9f37d5c00,a2e03c932102..000000000000
>> --- a/drivers/staging/erofs/unzip_vle.c
>> +++ b/drivers/staging/erofs/unzip_vle.c
>> @@@ -843,14 -844,13 +844,12 @@@ static void z_erofs_vle_unzip_kickoff(v
>>   
>>   static inline void z_erofs_vle_read_endio(struct bio *bio)
>>   {
>> - 	const blk_status_t err = bio->bi_status;
>> + 	struct erofs_sb_info *sbi = NULL;
>> + 	blk_status_t err = bio->bi_status;
>>  -	unsigned int i;
>>   	struct bio_vec *bvec;
>> - #ifdef EROFS_FS_HAS_MANAGED_CACHE
>> - 	struct address_space *mc = NULL;
>> - #endif
>>   	struct bvec_iter_all iter_all;
>>   
>>  -	bio_for_each_segment_all(bvec, bio, i, iter_all) {
>>  +	bio_for_each_segment_all(bvec, bio, iter_all) {
>>   		struct page *page = bvec->bv_page;
>>   		bool cachemngd = false;
>>   
> 
> This conflict is now between the block tree and Linus' tree.

It seems that the conflict has been resolved in linus' tree:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2b070cfe582b8e99fec6ada57d2e59e194aae202

Thanks,
Gao Xiang


> 
