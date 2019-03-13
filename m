Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA903C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947B820651
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfCMPdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:33:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:47143 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfCMPdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:33:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 08:33:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,474,1544515200"; 
   d="scan'208";a="141703542"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 13 Mar 2019 08:33:38 -0700
Received: from [10.252.18.45] (unknown [10.252.18.45])
        by linux.intel.com (Postfix) with ESMTP id CC5FD58046D;
        Wed, 13 Mar 2019 08:33:36 -0700 (PDT)
Subject: Re: [PATCH v7 08/12] perf record: implement compression for AIO trace
 streaming
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5f3a8326-58a0-816e-ad61-31c111232c7a@linux.intel.com>
 <618f7b8b-015b-d67e-9ef4-dc7aa0d2cd62@linux.intel.com>
 <20190313143651.GA6676@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <16580fcc-23ae-dfa1-60ae-963fb4ae3207@linux.intel.com>
Date:   Wed, 13 Mar 2019 18:33:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190313143651.GA6676@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13.03.2019 17:36, Jiri Olsa wrote:
> On Tue, Mar 12, 2019 at 08:30:13AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> -
>> -	md->prev = head;
>> -	perf_mmap__consume(md);
>> -
>> -	rc = push(to, &md->aio.cblocks[idx], md->aio.data[idx], size0 + size, *off);
>> -	if (!rc) {
>> -		*off += size0 + size;
>> -	} else {
>> -		/*
>> -		 * Decrement md->refcount back if aio write
>> -		 * operation failed to start.
>> -		 */
>> -		perf_mmap__put(md);
>> -	}
>> -
>> -	return rc;
>> -}
>>  #else /* !HAVE_AIO_SUPPORT */
>>  static int perf_mmap__aio_enabled(struct perf_mmap *map __maybe_unused)
>>  {
>> @@ -566,7 +492,7 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
>>  
>>  	rc = perf_mmap__read_init(md);
>>  	if (rc < 0)
>> -		return (rc == -EAGAIN) ? 0 : -1;
>> +		return (rc == -EAGAIN) ? 1 : -1;
> 
> hum, should this be in part of this one?
> 
>   perf record: implement -f,--mmap-flush=<threshold> option

It affects the both serial and AIO but currently is only used 
in AIO flow. That is why it is placed here.

~Alexey

> 
> 
> jirka
> 
