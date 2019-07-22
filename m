Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD8DC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 00:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B005206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 00:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563755993;
	bh=4/CB9Ayev5JKrE0XJ4YE64N8BfVO1NLnfPU/tzmyKWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=znJ0sW/22TARMVq8Ca9/z83N6svfjGrDrhpDlw56htg3eTPU7fju61M+BGs9IMqZq
	 zMYC7NmvwHJ8JSqlWmd9mf1+MdmDx6DiE3LmF+rPLy2kF+/SJbXJk8YAna0cY+GzMJ
	 Fd5DHbyi5aHZmvWLrluCR/2v9bsyaC94mlwQzwdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfGVAjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 20:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfGVAjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 20:39:52 -0400
Received: from localhost (unknown [216.243.17.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 390EC206BF;
        Mon, 22 Jul 2019 00:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563755991;
        bh=4/CB9Ayev5JKrE0XJ4YE64N8BfVO1NLnfPU/tzmyKWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WScm1ORm+ix420nLZYK26vO4F4umJ40LKSDGPOakSl0fyTreIKkR7EPyUfNsCLg0u
         y0y8WaNpLrv3OLH8z1IvXwlD62ECXecZ7cyMmYFwKEW5ibuiZs+EzcdeAFM5Mbcmfs
         YVTrt0lwB62hI+ONtjKcxfodws8st6L+P9zp/7vg=
Date:   Sun, 21 Jul 2019 20:39:50 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.2 129/249] blk-iolatency: only account
 submitted bios
Message-ID: <20190722003950.GC1607@sasha-vm>
References: <20190715134655.4076-1-sashal@kernel.org>
 <20190715134655.4076-129-sashal@kernel.org>
 <20190715195806.GA77907@dennisz-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190715195806.GA77907@dennisz-mbp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 03:58:06PM -0400, Dennis Zhou wrote:
>On Mon, Jul 15, 2019 at 09:44:54AM -0400, Sasha Levin wrote:
>> From: Dennis Zhou <dennis@kernel.org>
>>
>> [ Upstream commit a3fb01ba5af066521f3f3421839e501bb2c71805 ]
>>
>> As is, iolatency recognizes done_bio and cleanup as ending paths. If a
>> request is marked REQ_NOWAIT and fails to get a request, the bio is
>> cleaned up via rq_qos_cleanup() and ended in bio_wouldblock_error().
>> This results in underflowing the inflight counter. Fix this by only
>> accounting bios that were actually submitted.
>>
>> Signed-off-by: Dennis Zhou <dennis@kernel.org>
>> Cc: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  block/blk-iolatency.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
>> index d22e61bced86..c91b84bb9d0a 100644
>> --- a/block/blk-iolatency.c
>> +++ b/block/blk-iolatency.c
>> @@ -600,6 +600,10 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
>>  	if (!blkg || !bio_flagged(bio, BIO_TRACKED))
>>  		return;
>>
>> +	/* We didn't actually submit this bio, don't account it. */
>> +	if (bio->bi_status == BLK_STS_AGAIN)
>> +		return;
>> +
>>  	iolat = blkg_to_lat(bio->bi_blkg);
>>  	if (!iolat)
>>  		return;
>> --
>> 2.20.1
>>
>
>Hi Sasha,
>
>If you're going to pick this up, c9b3007feca0 ("blk-iolatency: fix
>STS_AGAIN handling") fixes this patch, so please pick that up too.

I've picked it up, thanks!

--
Thanks,
Sasha
