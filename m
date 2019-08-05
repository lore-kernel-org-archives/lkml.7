Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB80C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C0B20880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbfHERzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:55:01 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59882 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfHERzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:55:01 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A05B51540A46F;
        Mon,  5 Aug 2019 10:55:00 -0700 (PDT)
Date:   Mon, 05 Aug 2019 10:55:00 -0700 (PDT)
Message-Id: <20190805.105500.1555481916904502971.davem@davemloft.net>
To:     hslester96@gmail.com
Cc:     vishal@chelsio.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cxgb4: smt: Use refcount_t for refcount
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190802083547.12657-1-hslester96@gmail.com>
References: <20190802083547.12657-1-hslester96@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 05 Aug 2019 10:55:00 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>
Date: Fri,  2 Aug 2019 16:35:47 +0800

> refcount_t is better for reference counters since its
> implementation can prevent overflows.
> So convert atomic_t ref counters to refcount_t.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v2:
>   - Convert refcount from 0-base to 1-base.

The existing code is buggy and should be fixed before you start making
conversions to it.

> @@ -111,7 +111,7 @@ static void t4_smte_free(struct smt_entry *e)
>   */
>  void cxgb4_smt_release(struct smt_entry *e)
>  {
> -	if (atomic_dec_and_test(&e->refcnt))
> +	if (refcount_dec_and_test(&e->refcnt))
>  		t4_smte_free(e);

This runs without any locking and therefore:

>  	if (e) {
>  		spin_lock(&e->lock);
> -		if (!atomic_read(&e->refcnt)) {
> -			atomic_set(&e->refcnt, 1);
> +		if (refcount_read(&e->refcnt) == 1) {
> +			refcount_set(&e->refcnt, 2);

This test is not safe, since the reference count can asynchronously decrement
to zero above outside of any locks.

Then you'll need to add locking, and as a result the need to an atomic
counter goes away and just a normal int can be used.
