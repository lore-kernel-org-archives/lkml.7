Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA665C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AD02071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfKVQBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:01:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:7773 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbfKVQBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:01:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 08:01:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; 
   d="scan'208";a="408930168"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 22 Nov 2019 08:01:45 -0800
Received: from [10.251.82.176] (abudanko-mobl.ccr.corp.intel.com [10.251.82.176])
        by linux.intel.com (Postfix) with ESMTP id 0C86C58049B;
        Fri, 22 Nov 2019 08:01:42 -0800 (PST)
Subject: Re: [PATCH v1 2/3] perf mmap: declare type for cpu mask of arbitrary
 length
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <26d1512a-9dea-bf7e-d18e-705846a870c4@linux.intel.com>
 <0c716b33-a91e-2972-637f-e7c3a187fa77@linux.intel.com>
 <20191122131513.GE17308@krava>
 <53af9c5c-a33d-4fc4-88e9-851b1caad3f1@linux.intel.com>
Organization: Intel Corp.
Message-ID: <61ce5a52-9c34-f936-b09b-f8f59cedcb66@linux.intel.com>
Date:   Fri, 22 Nov 2019 19:01:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <53af9c5c-a33d-4fc4-88e9-851b1caad3f1@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.2019 16:58, Alexey Budankov wrote:
> On 22.11.2019 16:20, Jiri Olsa wrote:
>> On Wed, Nov 20, 2019 at 12:37:48PM +0300, Alexey Budankov wrote:
>>>

<SNIP>

>>> +#define mmap_cpu_mask_bytes(m) \
>>
>> we try to have all macros upper case
> 
> In v2.
> 
>>
>>> +	(BITS_TO_LONGS(((struct mmap_cpu_mask *)m)->nbits) * sizeof(unsigned long))
>>
>> we have BITS_TO_BYTES
> 
> In v2.

Avoided BITS_TO_BYTES() in this particular case because 
the storage is allocated in unsigned long chunks, thus
the possibly unused tail bytes at the last chunk would 
be accounted in the returned size, and for compatibility 
with cpu_set_t which is also allocated in unsigned longs.

~Alexey
