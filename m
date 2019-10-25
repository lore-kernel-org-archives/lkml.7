Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1513ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB9C21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uvZX1h3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439062AbfJYJqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:46:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392769AbfJYJqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VfhLh7CdOQIbuKjo2/tRw2WTzt9oCdpQFUdcTg7xZKA=; b=uvZX1h3urIxm7JJ6+H/GoLIOP
        U7zOXP5bvuO/Zf8IyCh3vHxXcQ5dhQLrkL4vaeM6nJ7zvnmoLON+wSnVnkLN+M0AbEBmXFdurqxMY
        +xBoycXBY04ovYASWwDnlGmmvrqoDcfe/2hdRsSs2WCLgabCyar1Kuyod5dUKfYlvxnHtni6vt5WN
        TyYKGzgALzZgpCUaZ8kNyC1e1foSEid4rjciUsh89zehEIV+sYW44OyuTlB8om1BmSPCDXHLCbMgk
        i4iwGb/Oble1vgz+oultUwPBjbzAa2lPe265L4JPgvXH2y/JKTCdoS9Br79DHuD31OIq5FX33MZ40
        gmoCYNNjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNwAx-0002B5-MV; Fri, 25 Oct 2019 09:46:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3DB79300F3F;
        Fri, 25 Oct 2019 11:45:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1AEE52100B876; Fri, 25 Oct 2019 11:46:30 +0200 (CEST)
Date:   Fri, 25 Oct 2019 11:46:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] perf/core: fix restoring of Intel LBR call stack
 on a context switch
Message-ID: <20191025094630.GI4131@hirez.programming.kicks-ass.net>
References: <6fa20503-b5ad-16c7-260e-5243509176bc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fa20503-b5ad-16c7-260e-5243509176bc@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:35:46AM +0300, Alexey Budankov wrote:

Is this the exact same version again? ISTR already having seen (and
picked up for testing) a v5.
