Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37756C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB6E20872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tjw9Ktoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442830AbfIYImF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 04:42:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406947AbfIYImE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 04:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=slIVu/DxGMu9zok1ECDFQwAeqP3IJaeIKjOiSYAzAEU=; b=Tjw9KtoiX/nGWJQfPJoOQAOQQ
        QV2QqtC45CeRbgBOSMP/S3GPI+/bONBvR+xM5bgJ+yhVUmfXjh+bLKSn3BQPRyPQK8/tTOlt5fWug
        82xmrFdH+2whhoQ7QEawWGSpblwp5BH3A1cQqje2JyYqFp2eFvgb7Nv6L5m+UnnFEy4Zd+AHiQzDq
        NrRv8h6g1TXB6G6AAfKtznqARZd8zLSvrqfbMu4NGEPF+MLAQa9Lddz9xN1pcEG501Xb5P9hXybLJ
        eYW1msD6Iimlez5Ob50WEiSRXa/1VYromx7qx4Bh7+9UaLzZODHx18E5UzsDG64DRNpJHG3rclN98
        RUz/1zVKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iD2rw-0008RH-GF; Wed, 25 Sep 2019 08:41:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E25A3012CF;
        Wed, 25 Sep 2019 10:41:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFE60203C2D9F; Wed, 25 Sep 2019 10:41:49 +0200 (CEST)
Date:   Wed, 25 Sep 2019 10:41:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@qperret.net>
Cc:     Pavan Kondeti <pkondeti@codeaurora.org>, mingo@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rjw@rjwysocki.net, morten.rasmussen@arm.com,
        valentin.schneider@arm.com, qais.yousef@arm.com, tkjos@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Speed-up energy-aware wake-ups
Message-ID: <20190925084149.GB4553@hirez.programming.kicks-ass.net>
References: <20190912094404.13802-1-qperret@qperret.net>
 <20190920030215.GA20250@codeaurora.org>
 <20190920094115.GA11503@qperret.net>
 <20190920103338.GB20250@codeaurora.org>
 <20190920112300.GA13151@qperret.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920112300.GA13151@qperret.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 01:23:00PM +0200, Quentin Perret wrote:
> On Friday 20 Sep 2019 at 16:03:38 (+0530), Pavan Kondeti wrote:
> > +1. Looks good to me.
> 
> Cool, thanks.
> 
> Peter/Ingo, is there anything else I should do ? Should I resend the
> patch 'properly' (that is, not inline) ?

Got it, thanks!
