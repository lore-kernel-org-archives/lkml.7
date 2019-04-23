Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89472C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5792120843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bo0OHQoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfDWIra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:47:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46458 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWIr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dynh9I705ZiILXgmyOl+SyaOHisQmGgJs3EbSjjJDvE=; b=Bo0OHQoTLJzkglO2o5oz0h0Bbl
        x+cYSL2ncm4+gW92HkUi/vFcT8Ephg6JndFeHZ4jepBHL1I/i5XJzaHKyHRRWn74a4zMEY1JO1Xmg
        LygsMQDvpnE0rv9DJI0VZylMSzcLlLlMLL/KivEnDeY2tjAPbHSBGmMCyIltB/AL4PckF1ZIEC4iO
        LUPkxoyinn88R4YyIbdTmtRbcnnrGprnEWBMgq0jNfGn4UsWhyo1/ZeoR1w5TyzEx+qpdTZvknd44
        btwBiylEjC2zRgoOEzthn8/ITQy5MpT8ovFl+YZiigLRlg/fF/rxDc5BMrg8kFo2o+ZtAtkrYK/YF
        DMGv5OdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIr5H-0001FZ-M5; Tue, 23 Apr 2019 08:47:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7277729B47DC9; Tue, 23 Apr 2019 10:47:22 +0200 (CEST)
Date:   Tue, 23 Apr 2019 10:47:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/5] numa: introduce per-cgroup numa balancing
 locality, statistic
Message-ID: <20190423084722.GD11158@hirez.programming.kicks-ass.net>
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <c0ec8861-2387-e73b-e450-2d636557a3dd@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0ec8861-2387-e73b-e450-2d636557a3dd@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 10:11:24AM +0800, 王贇 wrote:
> +	p->numa_faults_locality[mem_node == numa_node_id() ? 4 : 3] += pages;

Possibly: 3 + !!(mem_node = numa_node_id()), generates better code.
