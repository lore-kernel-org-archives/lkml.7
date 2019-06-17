Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701A0C31E53
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E1121BA1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ciyWTDMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfFQHPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 03:15:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40564 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfFQHPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 03:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gpRMsfGNXtpOHyXo1HHqlE0dlVAyPKBRJRDhBOKV9jk=; b=ciyWTDMrwSY3eNjL+rF5wFxvY
        Hk0lkKZBcBzvIMyNlZFE0NW6MIWRBlxlwnMDVqs7KohK9iSwbzBy5AnCQbGRDRPTaWJDWsBEHbf6S
        x2vJX1VhVXZiH6spDpYQwXl6RqXuKAeRagnraCMYavKvp+Sc/fsLkO/AHgrZtGSgDWkuGS781Vuej
        UCWQr0KsCKYjfN/XoK5gwW2s3OqBX2wib/0PrlfQSff+SB3cwgBxTivqhBuUUuo0TcpdenkP5mOgs
        nBHx8IXK+RndchBTpjqETN8U02sGo2U3SxhTEnnzA9GKAfbuiopJf2aHzCHL+/P6NlBB+1co33y6L
        VDNnrnyjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hclrT-0005ke-Jx; Mon, 17 Jun 2019 07:15:27 +0000
Date:   Mon, 17 Jun 2019 00:15:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alastair D'Silva <alastair@d-silva.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 5/5] mm/hotplug: export try_online_node
Message-ID: <20190617071527.GA14003@infradead.org>
References: <20190617043635.13201-1-alastair@au1.ibm.com>
 <20190617043635.13201-6-alastair@au1.ibm.com>
 <20190617065921.GV3436@hirez.programming.kicks-ass.net>
 <f1bad6f784efdd26508b858db46f0192a349c7a1.camel@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1bad6f784efdd26508b858db46f0192a349c7a1.camel@d-silva.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 05:05:30PM +1000, Alastair D'Silva wrote:
> On Mon, 2019-06-17 at 08:59 +0200, Peter Zijlstra wrote:
> > On Mon, Jun 17, 2019 at 02:36:31PM +1000, Alastair D'Silva wrote:
> > > From: Alastair D'Silva <alastair@d-silva.org>
> > > 
> > > If an external driver module supplies physical memory and needs to
> > > expose
> > 
> > Why would you ever want to allow a module to do such a thing?
> > 
> 
> I'm working on a driver for Storage Class Memory, connected via an
> OpenCAPI link.
> 
> The memory is only usable once the card says it's OK to access it.

And all that should go through our pmem APIs, not not directly
poke into mm internals.  And if you still need core patches send them
along with the actual driver.
