Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C33C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C5320867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfJGMIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:08:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:6166 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfJGMIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:08:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 05:08:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,268,1566889200"; 
   d="scan'208";a="276771661"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by orsmga001.jf.intel.com with ESMTP; 07 Oct 2019 05:08:21 -0700
Subject: Re: [PATCH 5/5] perf record: Put a copy of kcore into the perf.data
 directory
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20191004083121.12182-1-adrian.hunter@intel.com>
 <20191004083121.12182-6-adrian.hunter@intel.com>
 <20191007112034.GE6919@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2298237b-f218-18d9-4fb5-33fc0d3a4664@intel.com>
Date:   Mon, 7 Oct 2019 15:06:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007112034.GE6919@krava>
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
>> +}
>> +
>>  static int record__mmap_evlist(struct record *rec,
>>  			       struct evlist *evlist)
>>  {
>> @@ -1383,6 +1417,12 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  	session->header.env.comp_type  = PERF_COMP_ZSTD;
>>  	session->header.env.comp_level = rec->opts.comp_level;
>>  
>> +	if (rec->opts.kcore &&
>> +	    !record__kcore_readable(&session->machines.host)) {
>> +		pr_err("ERROR: kcore is not readable.\n");
>> +		return -1;
>> +	}
>> +
> 
> is there any reason why this change is not merged with the change below?

It seemed better to do the validation before opening all the events.

> 
> 
>>  	record__init_features(rec);
>>  
>>  	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
>> @@ -1414,6 +1454,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  	}
>>  	session->header.env.comp_mmap_len = session->evlist->core.mmap_len;
>>  
>> +	if (rec->opts.kcore) {
>> +		err = record__kcore_copy(&session->machines.host, data);
>> +		if (err) {
>> +			pr_err("ERROR: Failed to copy kcore\n");
>> +			goto out_child;
>> +		}
>> +	}
>> +
> 
> thanks,
> jirka
> 

