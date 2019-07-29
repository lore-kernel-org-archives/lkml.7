Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97E9C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7879206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfG2SQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 14:16:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:2183 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfG2SQ7 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 14:16:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 11:16:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,323,1559545200"; 
   d="scan'208";a="199833604"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jul 2019 11:16:58 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 5BA6F301BBA; Mon, 29 Jul 2019 11:16:58 -0700 (PDT)
Date:   Mon, 29 Jul 2019 11:16:58 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH] perf pmu-events: Fix the missing "cpu_clk_unhalted.core"
Message-ID: <20190729181658.GH25319@tassilo.jf.intel.com>
References: <20190729072755.2166-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729072755.2166-1-yao.jin@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 1a91a197cafb..d413761621b0 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -453,6 +453,7 @@ static struct fixed {
>  	{ "inst_retired.any_p", "event=0xc0" },
>  	{ "cpu_clk_unhalted.ref", "event=0x0,umask=0x03" },
>  	{ "cpu_clk_unhalted.thread", "event=0x3c" },
> +	{ "cpu_clk_unhalted.core", "event=0x3c" },

Not sure this is correct for non Atom.

On Atom thread==core, but that is not true with SMT/HyperThreading.

The big cores currently don't have this event, so it would
match incorrectly.

This has to be handled on the event list level, perhaps with
some enhancements.

-Andi
