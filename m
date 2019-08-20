Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4227AC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BDE20673
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vc/J2w7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfHTJjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:39:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34862 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbfHTJjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C87H0XKexdsL+UWE1aJ+2v1FBCvDZI+oD03Bgb6sB1g=; b=vc/J2w7/Zao+JUHDIHCUlQgWC
        /MUBJQsP63C2BIxsbEOyobu5zs8bSjJu7u1PSLlYC4CpD5bKc2kvUhGqAWawVtv1QCp92gmCNGNnT
        5ZBAkBeYAH1l7ctbmjHe90+AHIthekpURhPv2odHoLl67X19ZLHOrLWQJs12E3684UzTZOB0skukk
        J0YvA9wuducCpGzBW2ubBX3LiRIU17hJNetnuDILBGbBGzoUOLaQbyssp9z3iqOAz67v2acf6pjkN
        yr0IhYbXZsF/vHjRGdbuFaWOvTDuA6yxShpHjMNzJcbh3oYP2Ia2jySEcIOtvzMlx9BBRCOxT3OBf
        CJbWUN3FQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i00bd-0005x7-OE; Tue, 20 Aug 2019 09:39:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC07330768C;
        Tue, 20 Aug 2019 11:38:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED96420CE7743; Tue, 20 Aug 2019 11:39:07 +0200 (CEST)
Date:   Tue, 20 Aug 2019 11:39:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     longli@linuxonhyperv.com
Cc:     Ingo Molnar <mingo@redhat.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>
Subject: Re: [PATCH 1/3] sched: define a function to report the number of
 context switches on a CPU
Message-ID: <20190820093907.GG2332@hirez.programming.kicks-ass.net>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
 <1566281669-48212-2-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566281669-48212-2-git-send-email-longli@linuxonhyperv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 11:14:27PM -0700, longli@linuxonhyperv.com wrote:

> +u64 get_cpu_rq_switches(int cpu)
> +{
> +	return cpu_rq(cpu)->nr_switches;
> +}
> +EXPORT_SYMBOL_GPL(get_cpu_rq_switches);

Also, that is broken on 32bit.
