Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F405DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF94A22CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392229AbfHWGAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 02:00:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:48704 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390268AbfHWGAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 02:00:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 23:00:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,420,1559545200"; 
   d="scan'208";a="180602948"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 22 Aug 2019 23:00:15 -0700
Received: from [10.251.80.230] (abudanko-mobl.ccr.corp.intel.com [10.251.80.230])
        by linux.intel.com (Postfix) with ESMTP id 33B20580258;
        Thu, 22 Aug 2019 23:00:11 -0700 (PDT)
Subject: Re: [PATCH] Fixes hang in zstd compression test by changing the
 source of random data.
To:     James Clark <James.Clark@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>
References: <3d8cc701-df4e-f949-1715-5118b530e990@arm.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <76459555-eab2-b55d-e5cc-1db3e956ec7f@linux.intel.com>
Date:   Fri, 23 Aug 2019 09:00:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3d8cc701-df4e-f949-1715-5118b530e990@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22.08.2019 16:55, James Clark wrote:
> Running 'perf test' with zstd compression linked will hang at the test
> 'Zstd perf.data compression/decompression' because /dev/random blocks
> reads until there is enough entropy. This means that the test will
> appear to never complete unless the mouse is continually moved while
> running it.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/tests/shell/record+zstd_comp_decomp.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> index 899604d1..63a91ec 100755
> --- a/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> +++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> @@ -13,7 +13,7 @@ skip_if_no_z_record() {
>  collect_z_record() {
>  	echo "Collecting compressed record file:"
>  	$perf_tool record -o $trace_file -g -z -F 5000 -- \
> -		dd count=500 if=/dev/random of=/dev/null
> +		dd count=500 if=/dev/urandom of=/dev/null

Acked-by: Alexey Budankov <alexey.budankov@linux.intel.com>

~Alexey

>  }
>  
>  check_compressed_stats() {
> 
