Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32522C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E1D21D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JeuTI/rY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733277AbfKGIoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:44:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfKGIoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rr5VVptu6KKK3kXl5x5Pd3BbgAvahZHolhBbi/HcDXE=; b=JeuTI/rY4No7kiJ/81lvxDV9p
        YSX3mqVRxL/j9g+S3f1K3OQ//hzfiLv7UZjIUvLVITFFBZ67fXcpF1QWfBNAqb53UkdYIJyJ37Bfv
        S6AwGu8oiN8Xe5471gsruxH7xKYBOXhU0xIxrXPWWB9VNW0B1jFEaLkkSKt0zk8oe9Vanu1Hr+8Kq
        tvu3AcDPu1vH7b/7D2/6ojk/zhhV1UBOIswrZOSm2Ju5u7Hfk8WT+RMKMBTCLbtmw5ktokv4Q1n/+
        vRUQB2Ng2BfmL5rk6v4ukMhE9bXlTOQCL54D6wIpfhZ8pEKKplioi28m2NKpzd9rvOFL7O+3a6s6p
        Vhd730FHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSdOh-0000T0-Mo; Thu, 07 Nov 2019 08:44:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 89C06300692;
        Thu,  7 Nov 2019 09:43:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E6DFD2025EDB2; Thu,  7 Nov 2019 09:44:04 +0100 (CET)
Date:   Thu, 7 Nov 2019 09:44:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: fix missing static inline on
 perf_cgroup_switch
Message-ID: <20191107084404.GY4131@hirez.programming.kicks-ass.net>
References: <20191106132527.19977-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106132527.19977-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 01:25:27PM +0000, Ben Dooks (Codethink) wrote:
> It looks like a "static inline" has been missed in front
> of the empty definition of perf_cgroup_switch under
> certain configurations. Fixes the following sparse warning:
> 
> kernel/events/core.c:1035:1: warning: symbol 'perf_cgroup_switch' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>

Thanks!
