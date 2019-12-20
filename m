Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F94C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9D421655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lNAfVsG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfLTPEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:04:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfLTPEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mvyWFYK2DloxkwKiLTdIi4VUiymLqX0pzem4JYVIosA=; b=lNAfVsG/5sW3OZV6PrGhsAdJ2
        XoDul6sr7cKBpEd8OGujI05e3M0a7TU0EDbSd85owyCOc0c8QWnwghUoa6wqE20eR+8RxlHGXwTd+
        GPxLGEx/OSavzJz0MUdmVsECVDXYKyeozBX2D8tc6gH/EhLjgklXkIh9ZsR3VR0Uch6a2pjew9A0N
        oysxLzcDvpwyeUIRLy42uOKXIJIaSzGtpbRH+V4O3wNRoGwoGhJ6tx0NtSEYqSssu1Ix2Lj82gnXm
        2Igar2+9t4sAl0s6zfVfy52f1n4YJRZFBNhf0ulj53TLZWVwl4HXkHQcNXQBkapQMv5QWZsFCCCFH
        cdj4tNubg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iiJpE-0003Jf-0I; Fri, 20 Dec 2019 15:04:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 470053007F2;
        Fri, 20 Dec 2019 16:02:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B653201E8305; Fri, 20 Dec 2019 16:04:18 +0100 (CET)
Date:   Fri, 20 Dec 2019 16:04:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, patrick.bellasi@matbug.net,
        qperret@google.com, qais.yousef@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH v3 0/5] sched/fair: Task placement biasing using uclamp
Message-ID: <20191220150418.GK2844@hirez.programming.kicks-ass.net>
References: <20191211113851.24241-1-valentin.schneider@arm.com>
 <7c9caf20-de5b-3fa2-2663-e712ba3d7829@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c9caf20-de5b-3fa2-2663-e712ba3d7829@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 04:06:38PM +0100, Dietmar Eggemann wrote:
> On 11/12/2019 12:38, Valentin Schneider wrote:
> > Hi,
> > 
> > While uclamp restrictions currently only impact schedutil's frequency
> > selection, it would make sense to also let them impact CPU selection in
> > asymmetric topologies. This would let us steer specific tasks towards
> > certain CPU capacities regardless of their actual utilization - I give a
> > few examples in patch 4.
> > 
> > The first three patches are mainly cleanups, the meat of the thing is
> > in patches 4 and 5.
> > 
> > Note that this is in the same spirit as what Patrick had proposed for EAS
> > on Android [1]
> > 
> > [1]: https://android.googlesource.com/kernel/common/+/b61876ed122f816660fe49e0de1b7ee4891deaa2%5E%21
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Tested-By: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks!
