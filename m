Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF85C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A56F20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1ZsnDtrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfGATEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:04:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38220 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGATEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 15:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1/S0WpGJCxat3z+CwRXAzrSmek6LiacnT0SSFTakjnw=; b=1ZsnDtrcIjgzNNB8Vg5eZHVMS
        TcVdCD383SWt8QP/Evs70n8IO8UahZ6ChOg+0j1l2ZWkZiPTBGp3nYrjzeGHft4uSD+Zkyv8dia6o
        UEjyPhBI3zG5OPMDMpkOkVqvTc4DNgiGTHf2Sxbo/HBE1od8+9nw4niJvxV9haEftJPevQlblpUzD
        8MccKZgxrBCtveg/mRQmT39I2B/2/M9zgnEet/KxJ0h0eauEvqYwyeBibWoKZaigQT2JChfscR5eh
        0EkRYaoYhBTRdngM1T8M67nGzPkOmFWiRVBIYyqXVbBaP5zz4Iv3J7A2Hw+ekBMZKH7RCNcij6fG0
        Xn4kS6ofQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hi1aq-0001od-MU; Mon, 01 Jul 2019 19:04:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3CE192013A21B; Mon,  1 Jul 2019 21:03:58 +0200 (CEST)
Date:   Mon, 1 Jul 2019 21:03:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH v2] sched/fair: fix imbalance due to CPU affinity
Message-ID: <20190701190358.GW3419@hirez.programming.kicks-ass.net>
References: <1561996022-28829-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561996022-28829-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 05:47:02PM +0200, Vincent Guittot wrote:
> The load_balance() has a dedicated mecanism to detect when an imbalance
> is due to CPU affinity and must be handled at parent level. In this case,
> the imbalance field of the parent's sched_group is set.
> 
> The description of sg_imbalanced() gives a typical example of two groups
> of 4 CPUs each and 4 tasks each with a cpumask covering 1 CPU of the first
> group and 3 CPUs of the second group. Something like:
> 
> 	{ 0 1 2 3 } { 4 5 6 7 }
> 	        *     * * *
> 
> But the load_balance fails to fix this UC on my octo cores system
> made of 2 clusters of quad cores.
> 
> Whereas the load_balance is able to detect that the imbalanced is due to
> CPU affinity, it fails to fix it because the imbalance field is cleared
> before letting parent level a chance to run. In fact, when the imbalance is
> detected, the load_balance reruns without the CPU with pinned tasks. But
> there is no other running tasks in the situation described above and
> everything looks balanced this time so the imbalance field is immediately
> cleared.
> 
> The imbalance field should not be cleared if there is no other task to move
> when the imbalance is detected.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks!
