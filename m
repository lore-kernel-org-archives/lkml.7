Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF85C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1668206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfCMPze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:55:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:24148 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfCMPze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:55:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 08:55:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,474,1544515200"; 
   d="scan'208";a="140462137"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Mar 2019 08:55:33 -0700
Received: from [10.252.18.45] (abudanko-mobl.ccr.corp.intel.com [10.252.18.45])
        by linux.intel.com (Postfix) with ESMTP id 22CCE58046D;
        Wed, 13 Mar 2019 08:55:30 -0700 (PDT)
Subject: Re: [PATCH v7 10/12] perf report: implement record trace
 decompression
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5f3a8326-58a0-816e-ad61-31c111232c7a@linux.intel.com>
 <54b3c3c8-2b7e-e7ba-d55e-d15cc5983ced@linux.intel.com>
 <20190313143719.GF6676@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <fee1ca34-eaa4-75c4-60bb-72a7b18fdd1a@linux.intel.com>
Date:   Wed, 13 Mar 2019 18:55:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190313143719.GF6676@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13.03.2019 17:37, Jiri Olsa wrote:
> On Tue, Mar 12, 2019 at 08:36:18AM +0300, Alexey Budankov wrote:
> 
> SBIP
> 
>> +#ifdef HAVE_ZSTD_SUPPORT
>> +static int perf_session__process_compressed_event(struct perf_session *session,
>> +					union perf_event *event, u64 file_offset)
>> +{
>> +	void *src;
>> +	size_t decomp_size, src_size;
>> +	u64 decomp_last_rem = 0;
>> +	size_t decomp_len = session->header.env.comp_mmap_len;
>> +	struct decomp *decomp, *decomp_last = session->decomp_last;
>> +
>> +	decomp = mmap(NULL, sizeof(struct decomp) + decomp_len, PROT_READ|PROT_WRITE,
>> +		      MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
>> +	if (decomp == MAP_FAILED) {
>> +		pr_err("Couldn't allocate memory for decompression\n");
>> +		return -1;
>> +	}
> 
> ok, I see the need to keep this decomp around, we need the event
> to be there the whole time, like the mmap for the standard events
> 
> we know the total uncompressed size when record is done, right?
> could we save it in the COMPRESSED feature and alloc all the
> needed uncompressed data in single mmap?

It can be not that good idea. The required contiguous memory 
region can be really huge to be allocated. Plain malloc()'s are 
also not good. I was observing OOM in perf report process when 
loading traces of several GiBs. So smaller, page size granularity,
linked memory regions performed the best in my experiments.

~Alexey

> 
> jirka
> 
