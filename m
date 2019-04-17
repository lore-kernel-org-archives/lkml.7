Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3994EC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3FB217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555473137;
	bh=2AoyQVgWA7GMSi2oLzWJrSu9d9Ru8xbZpsJd1envo64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sfymdCuVj9SoZEKV7CbwoMgpA23C/DRRVB++4zTlUj2IxSvZ3mL6nEY3yYVli1amT
	 2+1xPp7Qot37+tIsTt9FQy+Q75VOYRMWh0wcHxgRJafHAUkK7k/0j5ns0R17aZ6nxy
	 HJ4Q4Ll3X5Fj2chgoaL2yfKld4gc4Vl7Lu204qA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfDQDwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:52:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35598 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfDQDwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 23:52:15 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 93DCADA6;
        Wed, 17 Apr 2019 03:52:13 +0000 (UTC)
Date:   Tue, 16 Apr 2019 20:52:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Tejun Heo <tj@kernel.org>, Qian Cai <cai@lca.pw>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/1] mm: Remove the SLAB allocator
Message-Id: <20190416205212.5cb286fbeec801f50269b2b5@linux-foundation.org>
In-Reply-To: <20190412112816.GD18914@techsingularity.net>
References: <20190410024714.26607-1-tobin@kernel.org>
        <f06aaeae-28c0-9ea4-d795-418ec3362d17@suse.cz>
        <alpine.DEB.2.21.1904101452340.100430@chino.kir.corp.google.com>
        <20190412112816.GD18914@techsingularity.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019 12:28:16 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:

> On Wed, Apr 10, 2019 at 02:53:34PM -0700, David Rientjes wrote:
> > > FWIW, our enterprise kernel use it (latest is 4.12 based), and openSUSE
> > > kernels as well (with openSUSE Tumbleweed that includes latest
> > > kernel.org stables). AFAIK we don't enable SLAB_DEBUG even in general
> > > debug kernel flavours as it's just too slow.
> > > 
> > > IIRC last time Mel evaluated switching to SLUB, it wasn't a clear
> > > winner, but I'll just CC him for details :)
> > > 
> > 
> > We also use CONFIG_SLAB and disable CONFIG_SLAB_DEBUG for the same reason.
> 
> Would it be possible to re-evaluate using mainline kernel 5.0?

I have vague memories that slab outperforms slub for some networking
loads.  Could the net folks please comment?

