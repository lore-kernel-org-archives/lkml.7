Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704A1C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3219A20656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gIdJrGJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfEHJSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 05:18:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46392 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfEHJSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3LSYsm/AoaNz9zk5fxrJoak93p76dPKvNnBLyYEkieU=; b=gIdJrGJVitjfUD1zPU/Q/t4iy
        gA3aL4teavogs3o153RVgKbmmSVYQVH68kYVVnYl3JOdfFmvfEoMXru9CQgk8x691aKXQOk63qgRy
        GwmN9ilOSZngcVYX/fZk2ZBMsCqZCYXd1N4h981HLPciBT1TaOzKzFqFeNqoSjTPBCIHZFT5iBLoj
        fvi96FantsgfVYBSABPupGuuHDpzpinDjZCGdBIGN9cbwO0NVZ3sIhGO5Pf+cBLukU44ADfqW9RH2
        KfxdIllbdkpZZdvSur8TSZrb3svM9SSNy2vve7wj8JcrDDE9ZFCieJjoK5XIOkbkoS0FoZrfXXCUt
        26L+It7BA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOIiE-0004qy-90; Wed, 08 May 2019 09:18:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 160262029F886; Wed,  8 May 2019 11:18:05 +0200 (CEST)
Date:   Wed, 8 May 2019 11:18:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com
Subject: Re: [PATCH 2/2] perf/x86/intel: Support PEBS output to PT
Message-ID: <20190508091805.GC2606@hirez.programming.kicks-ass.net>
References: <20190502105022.15534-1-alexander.shishkin@linux.intel.com>
 <20190502105022.15534-3-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502105022.15534-3-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 01:50:22PM +0300, Alexander Shishkin wrote:
> The output setting is per-CPU, so all PEBS events must be either writing
> to PT or to the DS area, so in order to not mess up the event scheduling,
> we fall back to the latter in case both types of events are scheduled in.

Urgh, that blows... I really don't like that.
