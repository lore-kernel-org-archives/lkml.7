Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC30C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFCB2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="bZjJwk3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbfDQN1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:27:44 -0400
Received: from a9-46.smtp-out.amazonses.com ([54.240.9.46]:39622 "EHLO
        a9-46.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727034AbfDQN1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1555507663;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=9pePXe16Pm2sxz5+PY34bI9W90zEIcb20PpoSEOxJTI=;
        b=bZjJwk3bVTXsr1+Ka6SqEQZ7tpn+LdSlTg8zXZXM2NSPN/ix4m4ImO+nk8wNWLgb
        f/EueiAV+rbhBF2JrWPmqKMZlIqnt44dbCE+dTsKw0nBaY9UbpaRrDCN/LPrmaRXtsb
        GaUIudJugC+DttqYbbZvPaU9Vj1fQfjqcOT/JJY0=
Date:   Wed, 17 Apr 2019 13:27:43 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Jesper Dangaard Brouer <netdev@brouer.com>
cc:     Pekka Enberg <penberg@iki.fi>, Michal Hocko <mhocko@kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>, Vlastimil Babka <vbabka@suse.cz>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Tejun Heo <tj@kernel.org>, Qian Cai <cai@lca.pw>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH 0/1] mm: Remove the SLAB allocator
In-Reply-To: <20190417105018.78604ad8@carbon>
Message-ID: <0100016a2b7b515b-2a0a4fab-6c9d-4eeb-a0c8-d3fffbf64e55-000000@email.amazonses.com>
References: <20190410024714.26607-1-tobin@kernel.org> <f06aaeae-28c0-9ea4-d795-418ec3362d17@suse.cz> <20190410081618.GA25494@eros.localdomain> <20190411075556.GO10383@dhcp22.suse.cz> <262df687-c934-b3e2-1d5f-548e8a8acb74@iki.fi>
 <20190417105018.78604ad8@carbon>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.04.17-54.240.9.46
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019, Jesper Dangaard Brouer wrote:

> I do think SLUB have a number of pathological cases where SLAB is
> faster.  If was significantly more difficult to get good bulk-free
> performance for SLUB.  SLUB is only fast as long as objects belong to
> the same page.  To get good bulk-free performance if objects are
> "mixed", I coded this[1] way-too-complex fast-path code to counter
> act this (joined work with Alex Duyck).

Right. SLUB usually compensates for that with superior allocation
performance.

> > It's, of course, worth thinking about other pathological cases too.
> > Workloads that cause large allocations is one. Workloads that cause lots
> > of slab cache shrinking is another.
>
> I also worry about long uptimes when SLUB objects/pages gets too
> fragmented... as I said SLUB is only efficient when objects are
> returned to the same page, while SLAB is not.

??? Why would SLUB pages get more fragmented? SLUB has fragmentation
prevention methods that SLAB does not have.
