Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA0AC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866032186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jTOIGU81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDSWyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:54:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfDSWyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8GHfViN1qI7tP5bjrRTuauCJlfPJIop88X8YcwvDN6s=; b=jTOIGU81UGM+SZeugfFRNRueG
        l6N+dMe5L8tE+LsbrB8ff0RI23zdhq6sMGzaJL9CqIcSoEsKeE+4mKtV6w04nWSC7qRYvmWsX4qVv
        Em6ez34lCyAWPmoo4haiEBl4pAP0PH4JLNkC+J77nltznW7JRNaHYaUvM5IoJDhTTIt9fWrjgAVWX
        Is1aHcSYYpXbYDLQcz5qHAlAfHu6Ej/IcDznFo6/qIoVShfVOmTYM2vgrmAG/mFYR9pCVl8JRV8eu
        HeKPmAjiFhTEbg9PgKdqcVA72Lz8X+M7ZlBEd2a/rQHpy56woJi6su9wdmYLTprp8Drt48ag2WAIl
        /o7GbTcpA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHU8n-0006OX-Cm; Fri, 19 Apr 2019 14:05:21 +0000
Date:   Fri, 19 Apr 2019 07:05:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Subject: DISCONTIGMEM is deprecated
Message-ID: <20190419140521.GI7751@bombadil.infradead.org>
References: <20190419094335.GJ18914@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419094335.GJ18914@techsingularity.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 10:43:35AM +0100, Mel Gorman wrote:
> DISCONTIG is essentially deprecated and even parisc plans to move to
> SPARSEMEM so there is no need to be fancy, this patch simply disables
> watermark boosting by default on DISCONTIGMEM.

I don't think parisc is the only arch which uses DISCONTIGMEM for !NUMA
scenarios.  Grepping the arch/ directories shows:

alpha (does support NUMA, but also non-NUMA DISCONTIGMEM)
arc (for supporting more than 1GB of memory)
ia64 (looks complicated ...)
m68k (for multiple chunks of memory)
mips (does support NUMA but also non-NUMA)
parisc (both NUMA and non-NUMA)

I'm not sure that these architecture maintainers even know that DISCONTIGMEM
is deprecated.  Adding linux-arch to the cc.
