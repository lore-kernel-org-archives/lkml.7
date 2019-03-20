Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6011CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF702183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lBlhaYbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfCTP6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:58:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52486 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfCTP6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5g9pViXNY7nvZ81dpyxLzpfjmEIOF3XIHU7e+zT5Mv0=; b=lBlhaYbX6cripVhlxSqE0OMQf
        xNuBhITN2Rh7W2zm25DQNm1rpCZqazCq7lO/LSnpk4WNWlCjP7m4csMBAkHG4E4Cca5D9tp7E7fCZ
        AUdb2dS9P9S5atYiR0A4si4bezKwOv6eVEpKPz+vSoIFlAQ19S8v2ubE509vVdfGnLBeNOydPR905
        9OuMzFg+hYx0YOvnwjRGxyjzcrEQtvweIVBkYEeAu/Jx4iXDOLY2S56AQOhimqlhS21bzNYavZdfA
        R4xKLSDoz/EL5guuPGIqZtC2Hwf6QBYEFuQv7LHbglcD45xMPV/GBjKB3LAD1TLJadyY7gC3grZ1n
        AbuDHTyiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6dbc-0004In-Fo; Wed, 20 Mar 2019 15:58:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 41E7D2391A9A2; Wed, 20 Mar 2019 16:58:15 +0100 (CET)
Date:   Wed, 20 Mar 2019 16:58:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 03/22] perf/x86/intel: Support adaptive PEBSv4
Message-ID: <20190320155815.GI6058@hirez.programming.kicks-ass.net>
References: <20190318214144.4639-1-kan.liang@linux.intel.com>
 <20190318214144.4639-4-kan.liang@linux.intel.com>
 <20190319144748.GH5996@hirez.programming.kicks-ass.net>
 <20190319213824.GY24002@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319213824.GY24002@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 02:38:24PM -0700, Andi Kleen wrote:
> > How much work would intel_pmu_drain_pebs_icl() be?
> > 
> > I'm thinking that might not be terrible.
> 
> I had it in an early version of the code, but it ended up with a lot 
> of code duplication.

I'm thinking that if you remove all the <v3 nonsense, it shouldn't be
_that_ much. A quick hack here makes it ~60 lines.

And it avoids sprinkling a whole bunch of conditionals around and
introducing that new x86_pmu method.

