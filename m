Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DB4ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728E121655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfJGMHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:07:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:27590 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfJGMHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:07:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 05:07:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,268,1566889200"; 
   d="scan'208";a="276771556"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by orsmga001.jf.intel.com with ESMTP; 07 Oct 2019 05:07:52 -0700
Subject: Re: [PATCH 4/5] perf tools: Support single perf.data file directory
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20191004083121.12182-1-adrian.hunter@intel.com>
 <20191004083121.12182-5-adrian.hunter@intel.com>
 <20191007112027.GD6919@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2340d60c-e8a6-2333-06ce-77076c912a1c@intel.com>
Date:   Mon, 7 Oct 2019 15:06:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007112027.GD6919@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/19 2:20 PM, Jiri Olsa wrote:
> On Fri, Oct 04, 2019 at 11:31:20AM +0300, Adrian Hunter wrote:
> 
> SNIP
> 
>>  	u8 pad[8] = {0};
>>  
>> -	if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
>> +	if (!perf_data__is_pipe(data) && perf_data__is_single_file(data)) {
>>  		off_t file_offset;
>>  		int fd = perf_data__fd(data);
>>  		int err;
>> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
>> index df173f0bf654..964ea101dba6 100644
>> --- a/tools/perf/util/data.c
>> +++ b/tools/perf/util/data.c
>> @@ -76,6 +76,13 @@ int perf_data__open_dir(struct perf_data *data)
>>  	DIR *dir;
>>  	int nr = 0;
>>  
>> +	/*
>> +	 * Directory containing a single regular perf data file which is already
>> +	 * open, means there is nothing more to do here.
>> +	 */
>> +	if (perf_data__is_single_file(data))
>> +		return 0;
>> +
> 
> cool, I like this approach much more than the previous flag

Yes it is much nicer.  Thanks for your direction on that.

> 
> any change you (if there's repost) or Arnaldo
> could squeeze in indent change below?

Sent a patch, to be applied before these.

> 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index bfa80fe8d369..7f567a521cea 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -227,8 +227,8 @@ struct perf_session *perf_session__new(struct perf_data *data,
>  			/* Open the directory data. */
>  			if (data->is_dir) {
>  				ret = perf_data__open_dir(data);
> -			if (ret)
> -				goto out_delete;
> +				if (ret)
> +					goto out_delete;
>  			}
>  
>  			if (!symbol_conf.kallsyms_name &&
> 

