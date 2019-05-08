Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D44C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4395720656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sS3hGp/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfEHKja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:39:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfEHKja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2lXTAKWtrORg2nwktLeR6LNdRNDmowmpIkUNcTNHbi0=; b=sS3hGp/nZQdKRUQnssNMlT8Vy
        k+9HqNgfH9kLIVd9SCvTL1xF7E6l0vB6CPuBzLKuk29HEvEOVnymQDawZlVBjXLqPfXsGxVDeNmCw
        vQKPKyjhHww8c2EMAedjVfKMqBHeOAPOePFbXLkumia5ncBUUGVevqxJj4Zd2OdkPpJyil9cU8P3R
        Yc4P7AVGU26PaexyTMuQD8j14zEKw7oQpEvwaU8RZKmvTrFBLR0qSj1qGAYGY8t4eIDhraoM3YeFF
        8dwaUdjlh1BeL4k+FsgRXVqgD5kia8pgaTc3U9y9Z3Fg7XTLKER2pH7E4EeP7tXVPlXsPiUHN4q0G
        QlBbj07Cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOJyx-0002bO-CF; Wed, 08 May 2019 10:39:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 997672029F87E; Wed,  8 May 2019 12:39:24 +0200 (CEST)
Date:   Wed, 8 May 2019 12:39:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com
Subject: Re: [PATCH 0/2] perf, intel: Add support for PEBS output to Intel PT
Message-ID: <20190508103924.GF2606@hirez.programming.kicks-ass.net>
References: <20190502105022.15534-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502105022.15534-1-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 01:50:20PM +0300, Alexander Shishkin wrote:
> Hi Peter,
> 
> New PEBS feature: output to Intel PT stream instead of the DS area. It's
> theoretically useful in virtualized environments, where DS area can't be
> used. It's also good for those who are interested in instruction trace for
> context of the PEBS events. As PEBS goes, it can provide LBR context with
> all the branch-related information that PT doesn't provide at the moment.
> 
> PEBS records are packetized in the PT stream, so instead of extracting
> them in the PMI, we leave it to the perf tool, because real time PT
> decoding is not practical. Tooling patches are not included, but can be
> found here [1].
> 
> Added is an attribute bit 'aux_source' to mean that an event is a source of
> AUX data. This bit enables PEBS output to PT.

There is a distinct lack of permission checks in this. When creating
this construct we should verify the creator has access to PT. And we
should verify we're not (accidentally or otherwise) writing into someone
else's PT buffers.
