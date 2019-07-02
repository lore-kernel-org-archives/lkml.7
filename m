Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3A2C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE8A206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfGBN7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:59:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:48450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726963AbfGBN7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:59:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 057A4AFC3;
        Tue,  2 Jul 2019 13:58:59 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Ilya Dryomov" <idryomov@gmail.com>, "Sage Weil" <sage@redhat.com>,
        "Zheng Yan" <zyan@redhat.com>, "zhengbin" <zhengbin13@huawei.com>,
        <ceph-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ceph: fix end offset in truncate_inode_pages_range call
References: <20190701171634.20290-1-lhenriques@suse.com>
        <85689b9674e96c15602f6a1829142273868250df.camel@kernel.org>
Date:   Tue, 02 Jul 2019 14:58:57 +0100
In-Reply-To: <85689b9674e96c15602f6a1829142273868250df.camel@kernel.org> (Jeff
        Layton's message of "Tue, 02 Jul 2019 09:48:16 -0400")
Message-ID: <87y31g7d26.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff Layton" <jlayton@kernel.org> writes:

> On Mon, 2019-07-01 at 18:16 +0100, Luis Henriques wrote:
>> Commit e450f4d1a5d6 ("ceph: pass inclusive lend parameter to
>> filemap_write_and_wait_range()") fixed the end offset parameter used to
>> call filemap_write_and_wait_range and invalidate_inode_pages2_range.
>> Unfortunately it missed truncate_inode_pages_range, introducing a
>> regression that is easily detected by xfstest generic/130.
>> 
>> The problem is that when doing direct IO it is possible that an extra page
>> is truncated from the page cache when the end offset is page aligned.
>> This can cause data loss if that page hasn't been sync'ed to the OSDs.
>> 
>> While there, change code to use PAGE_ALIGN macro instead.
>> 
>> Fixes: e450f4d1a5d6 ("ceph: pass inclusive lend parameter to filemap_write_and_wait_range()")
>> Signed-off-by: Luis Henriques <lhenriques@suse.com>
>> ---
>>  fs/ceph/file.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> index 183c37c0a8fc..7a57db8e2fa9 100644
>> --- a/fs/ceph/file.c
>> +++ b/fs/ceph/file.c
>> @@ -1007,7 +1007,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
>>  			 * may block.
>>  			 */
>>  			truncate_inode_pages_range(inode->i_mapping, pos,
>> -					(pos+len) | (PAGE_SIZE - 1));
>> +						   PAGE_ALIGN(pos + len) - 1);
>>  
>>  			req->r_mtime = mtime;
>>  		}
>
> Luis, should this be sent to stable? It seems like a data corruption
> problem...

Yes, I believe so.  But I believe all the active stable kernels that
include commit e450f4d1a5d6 (or a backport of it) will pick it anyway
due to the 'Fixes:' tag.  AFAIK only 5.1 and 5.2 are affected.

Cheers,
-- 
Luis
