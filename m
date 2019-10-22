Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ACDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BAA21906
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NqegDXF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbfJVJZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:25:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37280 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731451AbfJVJZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XyP+8Dg8ZNZ3dCXyUwyBIbUVvdYD1ZbF4jpFQJVpZcE=; b=NqegDXF2NbIceOJjVkT0F4QvJ
        1rbJpUoL+448gsZsXMGWGtYKGPAh8vQ9ukI+Opyqvyr1gzADuIZ5UHveE8T0EcTPJFFOUsD/cRiZV
        a1AG52NCGS/VtGbf6HZrzWipPIZ9xdBjt/D+YEN92TpJXqwA+Z1QTAlGOxRz49krHYeyvg8nE5vTE
        WtZ6euqSkAOrFvGcd2vqgL/4rGFta11mFKQxYB4bfabdAND5+1w3Dit18LHdpqPzSniruvrnmDr4S
        4Wp5XPKN4mm0q71MDOMZEeEDedkcfyMmfiWDtAGE2HVtySoDEFhg6pOBEfCc2DLzrmy0Zg/TKabX+
        Bl6lFzTqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMqPg-00029B-Jc; Tue, 22 Oct 2019 09:25:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9432130127E;
        Tue, 22 Oct 2019 11:24:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 153D620420897; Tue, 22 Oct 2019 11:25:09 +0200 (CEST)
Message-Id: <20191022092017.740591163@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 22 Oct 2019 11:20:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, andi@firstfloor.org, kan.liang@linux.intel.com
Subject: [PATCH 0/3] Various optimizations for event creation
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There here patches are the result of Andi looking at perf event creation
bottlenecks. And while he's solved much of it with his recent perf-stat patch
set that moves event creation to CPU affine threads, these patches do still
help and can also cover other workloads.

Please consider.


