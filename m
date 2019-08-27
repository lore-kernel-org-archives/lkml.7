Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044ACC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB65F206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfH0Vpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:45:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:33535 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfH0Vpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:45:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 14:45:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,438,1559545200"; 
   d="scan'208";a="209903706"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2019 14:45:45 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C2D09301872; Tue, 27 Aug 2019 14:45:45 -0700 (PDT)
Date:   Tue, 27 Aug 2019 14:45:45 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: perf/core] perf script: Fix memory leaks in list_scripts()
Message-ID: <20190827214545.GM5447@tassilo.jf.intel.com>
References: <20190408162748.GA21008@embeddedor>
 <156689437793.24518.1210962260082729908.tip-bot2@tip-bot2>
 <b660a320-6b32-cc24-d829-1527dfc16e5d@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b660a320-6b32-cc24-d829-1527dfc16e5d@embeddedor.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> This should be tagged for stable:
> 
> Cc: stable@vger.kernel.org

It's a theoretical problem (which are explicitely ruled out by stable rules)
because if you ever see user space malloc() returning NULL the system is likely
already randomly killing your processes in OOM, including eventually perf.

I can see the value of shutting up coverity though, but that's not something
that needs to be in stable.

-Andi
