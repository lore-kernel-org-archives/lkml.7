Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669DDCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AA120873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfJUMnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:43:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:14835 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbfJUMno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:43:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 05:43:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="200419281"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.55]) ([10.237.72.55])
  by orsmga003.jf.intel.com with ESMTP; 21 Oct 2019 05:43:41 -0700
Subject: Re: [PATCH 4/5] perf tools: Support single perf.data file directory
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20191004083121.12182-1-adrian.hunter@intel.com>
 <20191004083121.12182-5-adrian.hunter@intel.com>
 <20191007112027.GD6919@krava>
 <2340d60c-e8a6-2333-06ce-77076c912a1c@intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a2853fa8-a2e8-8e17-132c-0d47b8129eff@intel.com>
Date:   Mon, 21 Oct 2019 15:42:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2340d60c-e8a6-2333-06ce-77076c912a1c@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/19 3:06 PM, Adrian Hunter wrote:
> On 7/10/19 2:20 PM, Jiri Olsa wrote:
>> On Fri, Oct 04, 2019 at 11:31:20AM +0300, Adrian Hunter wrote:
>>
>> SNIP
>>
>>>  	u8 pad[8] = {0};
>>>  
>>> -	if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
>>> +	if (!perf_data__is_pipe(data) && perf_data__is_single_file(data)) {
>>>  		off_t file_offset;
>>>  		int fd = perf_data__fd(data);
>>>  		int err;
>>> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
>>> index df173f0bf654..964ea101dba6 100644
>>> --- a/tools/perf/util/data.c
>>> +++ b/tools/perf/util/data.c
>>> @@ -76,6 +76,13 @@ int perf_data__open_dir(struct perf_data *data)
>>>  	DIR *dir;
>>>  	int nr = 0;
>>>  
>>> +	/*
>>> +	 * Directory containing a single regular perf data file which is already
>>> +	 * open, means there is nothing more to do here.
>>> +	 */
>>> +	if (perf_data__is_single_file(data))
>>> +		return 0;
>>> +
>>
>> cool, I like this approach much more than the previous flag
> 
> Yes it is much nicer.  Thanks for your direction on that.
> 
>>
>> any change you (if there's repost) or Arnaldo
>> could squeeze in indent change below?
> 
> Sent a patch, to be applied before these.
> 

That is:

"[PATCH] perf session: Fix indent in perf_session__new()"

Any comments on this patch set Arnaldo?
