Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A66C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359BF2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QBJ+a+oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfHEPvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:51:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51716 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfHEPvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J86VQUOlgDcHLUjKAqG9vpLO0JAk0UrPFVfhyhBABUk=; b=QBJ+a+oj8g01YOkFtYKgs7DSC
        EUUTLfh97fkqizXMvtQy54xyETp+PHpwh0/vIZTlao4dcMoMcfkgDPJLC70aj+GoAG7SQcayjAe+u
        Drn6vyMK0jZ4HVTGW50GfoqExW1x7kj5Ydo8Q2PK7Xavi4bxB2inUTSIFLZvZhj2P4JJ9rTW4Q2UZ
        VYLUz/hhwGzD3Xmmm9m59ldxtKhQWpWnnCnmSrs7toYjUTd0UyW1NNi+ShwRdOsHpaGaYZp2goryQ
        vL8sMZeJsK8WwFWQ12E56hiAYJI+crOvvq5pWOoLQmmhMSIIvDc0Edq0lZqYpf5bqWw9dDMZaBpEj
        RRmUkGmrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hufFi-00021U-Q1; Mon, 05 Aug 2019 15:50:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 13394201E9F1C; Mon,  5 Aug 2019 17:50:24 +0200 (CEST)
Date:   Mon, 5 Aug 2019 17:50:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC tip/core/rcu 14/14] rcu/nohz: Make multi_cpu_stop()
 enable tick on all online CPUs
Message-ID: <20190805155024.GK2332@hirez.programming.kicks-ass.net>
References: <20190802151435.GA1081@linux.ibm.com>
 <20190802151501.13069-14-paulmck@linux.ibm.com>
 <20190804144317.GF2349@hirez.programming.kicks-ass.net>
 <20190804144835.GB2386@hirez.programming.kicks-ass.net>
 <20190804184159.GC28441@linux.ibm.com>
 <20190805080531.GH2349@hirez.programming.kicks-ass.net>
 <20190805145448.GI28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805145448.GI28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 07:54:48AM -0700, Paul E. McKenney wrote:

> > Right; so clearly we're not understanding what's happening. That seems
> > like a requirement for actually doing a patch.
> 
> Almost but not quite.  It is a requirement for a patch *that* *is*
> *supposed* *to* *be* *a* *fix*.  If you are trying to prohibit me from
> writing experimental patches, please feel free to take a long walk on
> a short pier.
> 
> Understood???

Ah, my bad, I thought you were actually proposing this as an actual
patch. I now see that is my bad, I'd overlooked the RFC part.
