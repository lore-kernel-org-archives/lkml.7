Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEC2ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCE02190F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfJGMQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:16:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:44448 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbfJGMQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:16:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 05:16:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,268,1566889200"; 
   d="scan'208";a="276775403"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by orsmga001.jf.intel.com with ESMTP; 07 Oct 2019 05:16:16 -0700
Subject: Re: [PATCH 5/5] perf record: Put a copy of kcore into the perf.data
 directory
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20191004083121.12182-1-adrian.hunter@intel.com>
 <20191004083121.12182-6-adrian.hunter@intel.com>
 <20191007112039.GF6919@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ea42a459-1b73-b236-d9e3-50e4bec81de9@intel.com>
Date:   Mon, 7 Oct 2019 15:14:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007112039.GF6919@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/19 2:20 PM, Jiri Olsa wrote:
> On Fri, Oct 04, 2019 at 11:31:21AM +0300, Adrian Hunter wrote:
> 
> SNIP
> 
>>  	bool	      strict_freq;
>>  	bool	      sample_id;
>>  	bool	      no_bpf_event;
>> +	bool	      kcore;
>>  	unsigned int  freq;
>>  	unsigned int  mmap_pages;
>>  	unsigned int  auxtrace_mmap_pages;
>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>> index 061bb4d6a3f5..bfa80fe8d369 100644
>> --- a/tools/perf/util/session.c
>> +++ b/tools/perf/util/session.c
>> @@ -230,6 +230,10 @@ struct perf_session *perf_session__new(struct perf_data *data,
>>  			if (ret)
>>  				goto out_delete;
>>  			}
>> +
>> +			if (!symbol_conf.kallsyms_name &&
>> +			    !symbol_conf.vmlinux_name)
>> +				symbol_conf.kallsyms_name = perf_data__kallsyms_name(data);
> 
> hum, should this also depend on rec->opts.kcore ?

This is the bit that makes 'perf script' work.  It has the same affect as
though the --kallsyms option was used. i.e. it makes 'perf script' behave
the same as:
	
	perf script --kallsyms perf.data/kcore_dir/kallsyms

Which works because perf looks for kcore in the same directory as kallsyms.
