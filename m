Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BC7C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604FA216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387850AbfG2O5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:57:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfG2O5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:57:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 866603007C58;
        Mon, 29 Jul 2019 14:57:43 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD32C60C5F;
        Mon, 29 Jul 2019 14:57:42 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     <viro@zeniv.linux.org.uk>, "zhangyi \(F\)" <yi.zhang@huawei.com>
Cc:     <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bcrl@kvack.org>,
        <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] aio: add timeout validity check for io_[p]getevents
References: <1564039289-7672-1-git-send-email-yi.zhang@huawei.com>
        <x49imrqb2e5.fsf@segfault.boston.devel.redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Mon, 29 Jul 2019 10:57:41 -0400
In-Reply-To: <x49imrqb2e5.fsf@segfault.boston.devel.redhat.com> (Jeff Moyer's
        message of "Thu, 25 Jul 2019 10:43:46 -0400")
Message-ID: <x49y30gnb16.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 29 Jul 2019 14:57:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al, can you take this through your tree?

Thanks,
Jeff

Jeff Moyer <jmoyer@redhat.com> writes:

> "zhangyi (F)" <yi.zhang@huawei.com> writes:
>
>> io_[p]getevents syscall should return -EINVAL if if timeout is out of
>> range, add this validity check.
>>
>> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
>> ---
>>  fs/aio.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/aio.c b/fs/aio.c
>> index 01e0fb9..dd967a0 100644
>> --- a/fs/aio.c
>> +++ b/fs/aio.c
>> @@ -2031,10 +2031,17 @@ static long do_io_getevents(aio_context_t ctx_id,
>>  		struct io_event __user *events,
>>  		struct timespec64 *ts)
>>  {
>> -	ktime_t until = ts ? timespec64_to_ktime(*ts) : KTIME_MAX;
>> -	struct kioctx *ioctx = lookup_ioctx(ctx_id);
>> +	ktime_t until = KTIME_MAX;
>> +	struct kioctx *ioctx = NULL;
>>  	long ret = -EINVAL;
>>  
>> +	if (ts) {
>> +		if (!timespec64_valid(ts))
>> +			return ret;
>> +		until = timespec64_to_ktime(*ts);
>> +	}
>> +
>> +	ioctx = lookup_ioctx(ctx_id);
>>  	if (likely(ioctx)) {
>>  		if (likely(min_nr <= nr && min_nr >= 0))
>>  			ret = read_events(ioctx, min_nr, nr, events, until);
>
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
>
> The previous suggestion[1] of fixing the helpers never materialized, so
> let's just get this fixed, already.
>
> -Jeff
>
> [1] https://marc.info/?l=linux-fsdevel&m=152209450618587&w=2
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
