Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3DCC31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941FF21855
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ztpYbwNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfFQG7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 02:59:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57596 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfFQG7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 02:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y7piXdmBDL/x4wKUpL4yfLcfRL1V1CU2X+sNEky1E+A=; b=ztpYbwNu1Ix6JsNAwF1thhxZp
        51JnJFP3opu9FapixnXOBLQISn3bIavs5VwpOYDraUSlDoeXdYRQ3ZKcOv6eh8IxSs/IQic82Tctj
        HqNh+CjbbpBr5h04zyqMq6Scc/stYKykNm/yKcqrOrbSgTtgat5tE4ylmM4f+oYSHndAa4iDAmUCh
        zNsP6y7VbP9c7NUBTt/yCMw0riLgsVHrGYhp0QMObC3JycTTOP35x3Gta+8QKau8fG+umGiptNgXQ
        XiXgqhQUPUJdkTf+sPcQZHasypJfYyXQ4UhnLrwqwAwGfleIQNJweY+FyQIgqKnQwhk3lzwkbice4
        tqolYkaDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hclbw-0005DX-5c; Mon, 17 Jun 2019 06:59:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 686772025A802; Mon, 17 Jun 2019 08:59:21 +0200 (CEST)
Date:   Mon, 17 Jun 2019 08:59:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Arun KS <arunks@codeaurora.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mm/hotplug: export try_online_node
Message-ID: <20190617065921.GV3436@hirez.programming.kicks-ass.net>
References: <20190617043635.13201-1-alastair@au1.ibm.com>
 <20190617043635.13201-6-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617043635.13201-6-alastair@au1.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 02:36:31PM +1000, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> If an external driver module supplies physical memory and needs to expose

Why would you ever want to allow a module to do such a thing?
