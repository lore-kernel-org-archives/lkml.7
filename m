Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA39CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5045B21721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nwd5dW6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390993AbfJ1Q2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:28:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbfJ1Q2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qpI9foyHi8EnUmSAWcgk6rHa+5Eal+BjDZ/Pl2bVIIc=; b=Nwd5dW6yCmLSCfl7ftG+wlTMw
        URomm2PGdukSStTQ54+XtiHut6wKi2ncfiK69zO81Xof5ny82xUzuS3tYj9Q5AN1qUzrPmdG6ooUp
        Zdc0b4OqJehmFTlea+aONl1PyB7DySwEZHn6BROLBuisxjrV5+9AHGpP7R6uJVlTOMk037omZXBtT
        HqxKn3CqYKbJ0Uby5ND850oKSReg48vXpfqiBgaqV/PtPXbjkZuvB+7G4e3WMx8bzk67404TVAcQq
        vD0tRo05x2Eyg2ueKrog4llQkLrM2rUeMGUIEbJrUBBC5kq8WAvBM30sDQHIR7BhJOde/+iWaGsk4
        Gid14cmOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP7so-0004wS-WD; Mon, 28 Oct 2019 16:28:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9DB5C300E4D;
        Mon, 28 Oct 2019 17:27:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 020CA2B400AB5; Mon, 28 Oct 2019 17:28:40 +0100 (CET)
Date:   Mon, 28 Oct 2019 17:28:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com
Subject: Re: [PATCH v3 1/3] perf: Allow using AUX data in perf samples
Message-ID: <20191028162840.GD5671@hirez.programming.kicks-ass.net>
References: <20191025140835.53665-1-alexander.shishkin@linux.intel.com>
 <20191025140835.53665-2-alexander.shishkin@linux.intel.com>
 <20191028162712.GH4097@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028162712.GH4097@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 05:27:12PM +0100, Peter Zijlstra wrote:
> And while I get why we need recursion protection for pmu::snapshot_aux,
> I'm a little puzzled on why it is over the padding, that is, why isn't
> the whole of aux_in_sampling inside (the newly minted)
> perf_pmu_snapshot_aux() ?

That is, given the previous delta, the below.

---
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6292,9 +6292,17 @@ long perf_pmu_snapshot_aux(struct perf_e
 	 * IRQs need to be disabled to prevent IPIs from racing with us.
 	 */
 	local_irq_save(flags);
+	/*
+	 * Guard against NMI hits inside the critical section;
+	 * see also perf_prepare_sample_aux().
+	 */
+	WRITE_ONCE(rb->aux_in_sampling, 1);
+	barrier();
 
 	ret = event->pmu->snapshot_aux(event, handle, size);
 
+	barrier();
+	WRITE_ONCE(rb->aux_in_sampling, 0);
 	local_irq_restore(flags);
 
 	return ret;
@@ -6316,13 +6324,6 @@ static void perf_aux_sample_output(struc
 	if (!rb)
 		return;
 
-	/*
-	 * Guard against NMI hits inside the critical section;
-	 * see also perf_prepare_sample_aux().
-	 */
-	WRITE_ONCE(rb->aux_in_sampling, 1);
-	barrier();
-
 	size = perf_pmu_snapshot_aux(sampler, handle, data->aux_size);
 
 	/*
@@ -6348,9 +6349,6 @@ static void perf_aux_sample_output(struc
 	}
 
 out_clear:
-	barrier();
-	WRITE_ONCE(rb->aux_in_sampling, 0);
-
 	ring_buffer_put(rb);
 }
 
