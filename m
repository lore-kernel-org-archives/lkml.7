Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D39C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 06:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6D82465E
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 06:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576306710;
	bh=XBQHeoYqAMGOSLBvLrnshTLGXmqN0zjP5Hu0C573+lM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yhfjpmvaHmYtvgPoDeC4hlLRzrm6pGuAMXTRB8o6ZeZMFcuyc7s5xQzFJdEm4bI2C
	 BxUki4nkVLh8QA6eZ6UqkN07+cKbC1ERpQ9aUIsTVw2v1dKJoVyzGr1xHqW/hY4GJy
	 jM2NVuY3rTfxDd3nfveMJE6Y0w/Gv9+EthFrLGME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfLNG63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 01:58:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:35454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfLNG63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 01:58:29 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B09762465B;
        Sat, 14 Dec 2019 06:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576306709;
        bh=XBQHeoYqAMGOSLBvLrnshTLGXmqN0zjP5Hu0C573+lM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhQgp2kS87+CJb48lj/wVOuFkd8mNAzYyqgeTRMDZbaoJsm/NerK3HKr598V5Gmot
         qWG7GtwFnlrvP+94oVn9Z8ggeujjafrns1ZDKMkBzL0hCOoofdojqilKlIQW0IREwt
         PBOB/Y9G6JMTUP1YTcylx14GxVQe8xurL77tMOYU=
Date:   Fri, 13 Dec 2019 22:58:27 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     zhou xianrong <zhou_xianrong@yeah.net>
Cc:     dm-devel@redhat.com, weimin.mao@transsion.com,
        haizhou.song@transsion.com, snitzer@redhat.com,
        wanbin.wang@transsion.com, xianrong.zhou@transsion.com,
        linux-kernel@vger.kernel.org, yuanjiong.gao@transsion.com,
        ruxian.feng@transsion.com, agk@redhat.com
Subject: Re: [PATCH] dm-verity: unnecessary data blocks that need not read
 hash blocks
Message-ID: <20191214065827.GA727@sol.localdomain>
References: <20191211033240.169-1-zhou_xianrong@yeah.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211033240.169-1-zhou_xianrong@yeah.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:32:40AM +0800, zhou xianrong wrote:
> From: "xianrong.zhou" <xianrong.zhou@transsion.com>
> 
> If check_at_most_once enabled, just like verity work the prefetching work
> should check for data block bitmap firstly before reading hash block
> as well. Skip bit-set data blocks from both ends of data block range
> by testing the validated bitmap. This can reduce the amounts of data 
> blocks which need to read hash blocks.
> 
> Launching 91 apps every 15s and repeat 21 rounds on Android Q.
> In prefetching work we can let only 2602/360312 = 0.72% data blocks
> really need to read hash blocks.
> 
> But the reduced data blocks range would be enlarged again by
> dm_verity_prefetch_cluster later.
> 
> Signed-off-by: xianrong.zhou <xianrong.zhou@transsion.com>
> Signed-off-by: yuanjiong.gao <yuanjiong.gao@transsion.com>
> Tested-by: ruxian.feng <ruxian.feng@transsion.com>
> ---
>  drivers/md/dm-verity-target.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index 4fb33e7562c5..7b8eb754c0b6 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -581,6 +581,22 @@ static void verity_prefetch_io(struct work_struct *work)
>  	struct dm_verity *v = pw->v;
>  	int i;
>  
> +	if (v->validated_blocks) {
> +		while (pw->n_blocks) {
> +			if (unlikely(!test_bit(pw->block, v->validated_blocks)))
> +				break;
> +			pw->block++;
> +			pw->n_blocks--;
> +		}
> +		while (pw->n_blocks) {
> +			if (unlikely(!test_bit(pw->block + pw->n_blocks - 1,
> +				v->validated_blocks)))
> +				break;
> +			pw->n_blocks--;
> +		}
> +		if (!pw->n_blocks)
> +			return;
> +	}

This is a good idea, but shouldn't this logic go in verity_submit_prefetch()
prior to the struct dm_verity_prefetch_work being allocated?  Then if no
prefeching is needed, allocating and scheduling the work object can be skipped.

Also note that you're currently leaking the work object with the early return.

- Eric
