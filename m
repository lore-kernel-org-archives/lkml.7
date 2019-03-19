Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652AEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2067720811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cexcw/s1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfCSP3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:29:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42226 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCSP3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M3YgC4PQ3oC3wovMHbKlK0mpQFq3laS/+t0XN7D5y+g=; b=Cexcw/s1HW2/nYjJCLRTHRRZw
        IgPgO0b84ZDEskK7ObbqDYf29BYkHbcpIkn+m0ReMmlG9VpxGvjouKvhHJ2bkpjOHUo7sPRDw4BUu
        4fA3jYkcqPG9DM2qYjBJmm7fo1BLTDIFSXkUWyx1qBpfkAGYvaRIIhYamoi9ltcr2Jihef/uLbh6n
        IHLOZDNd+RvITBnR4LzgVr3YBsMSn0sPf6ERfbWTwh7U/8Gwqp2MCKb5Q/OD+hW3sD2+JwgDz7K9M
        J9d/W0BwGBbxeFoEb0X1AAd8UqpOsxp/xS/EnTKaUcbXGzyebRa8J2sqcX1G06fWH/ldFDZrzzgrA
        XQVFpW1fg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6Gfp-0001ig-S5; Tue, 19 Mar 2019 15:29:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A7FE28295A3F; Tue, 19 Mar 2019 16:29:03 +0100 (CET)
Date:   Tue, 19 Mar 2019 16:29:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 11/22] perf/core: Support a REMOVE transaction
Message-ID: <20190319152903.GJ5996@hirez.programming.kicks-ass.net>
References: <20190318214144.4639-1-kan.liang@linux.intel.com>
 <20190318214144.4639-12-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318214144.4639-12-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 02:41:33PM -0700, kan.liang@linux.intel.com wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> For TopDown metrics it is useful to have a remove transaction when
> the counter is unscheduled, so that the value can be saved correctly.
> Add a remove transaction to the perf core.

That needs more explaining.
