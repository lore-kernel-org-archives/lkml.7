Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA90C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2DC20843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VhCDJgQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfDWJqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:46:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47108 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfDWJqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZDorSYmy5pifOTHN5/R3ArDCdlVxn3mnwyoVkmNtAtk=; b=VhCDJgQBiA236vNR4anmbsAMXL
        iKoz13puLU3Kc/59ZTI7P9DnUr9OHwD93GcjQh9E7uYv8wbd0wqaokjsOKy3vOOuUWmExvfTYAbT4
        6vxpv6oPbmJ21DxtsSrcmPKLRZ+y7jBBaEhdJPeNSTbWD7z3aGOkwcyI8YRXdoapScIPbHdU/XXEk
        1BPrb0+kAYTfnvJKEgbWV7hV6BLNeWCzHqaMdOcf7P761H3Csf+VD39hheTQ8GDXFNYbmlUOSPHsN
        9Yx2NlSnYMVNsvSH6uieX/wAQBElNwObTUe5sQtnAyblmtpOfYK9NmQrAXyf3V9d89q84UF0RfFou
        9hsFg8pQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIs07-0001ze-Rv; Tue, 23 Apr 2019 09:46:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 75A5A29BB5057; Tue, 23 Apr 2019 11:46:06 +0200 (CEST)
Date:   Tue, 23 Apr 2019 11:46:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/5] numa: introduce per-cgroup numa balancing
 locality, statistic
Message-ID: <20190423094606.GK11158@hirez.programming.kicks-ass.net>
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <c0ec8861-2387-e73b-e450-2d636557a3dd@linux.alibaba.com>
 <20190423084722.GD11158@hirez.programming.kicks-ass.net>
 <b1a3aebf-e699-23ce-b7b8-06b6155f3dbe@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1a3aebf-e699-23ce-b7b8-06b6155f3dbe@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 05:33:25PM +0800, 王贇 wrote:
> 
> 
> On 2019/4/23 下午4:47, Peter Zijlstra wrote:
> > On Mon, Apr 22, 2019 at 10:11:24AM +0800, 王贇 wrote:
> >> +	p->numa_faults_locality[mem_node == numa_node_id() ? 4 : 3] += pages;
> > 
> > Possibly: 3 + !!(mem_node = numa_node_id()), generates better code.
> 
> Sounds good~ will apply in next version.

Well, check code gen first, of course.
