Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E644C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E4E214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504142AbfIXJNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 05:13:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:36571 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfIXJNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:13:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 02:13:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="182855741"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by orsmga008.jf.intel.com with ESMTP; 24 Sep 2019 02:13:41 -0700
Subject: Re: [PATCH RFC 1/2] perf tools: Support single perf.data file
 directory
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20190916085646.6199-1-adrian.hunter@intel.com>
 <20190916085646.6199-2-adrian.hunter@intel.com>
 <20190923213427.GB12521@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <766e6c36-c03f-0d9c-2983-565eb6a897bb@intel.com>
Date:   Tue, 24 Sep 2019 12:12:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923213427.GB12521@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/19 12:34 AM, Jiri Olsa wrote:
> On Mon, Sep 16, 2019 at 11:56:45AM +0300, Adrian Hunter wrote:
>> Support directory output that contains a regular perf.data file. This is
>> preparation for adding support for putting a copy of /proc/kcore in that
>> directory.
>>
>> Distinguish the multiple file case from the regular (single) perf.data file
>> case by adding data->is_multi_file.
> 
> SNIP
> 
>>  static int open_file_read(struct perf_data *data)
>>  {
>>  	struct stat st;
>> @@ -302,12 +312,17 @@ static int open_dir(struct perf_data *data)
>>  {
>>  	int ret;
>>  
>> -	/*
>> -	 * So far we open only the header, so we can read the data version and
>> -	 * layout.
>> -	 */
>> -	if (asprintf(&data->file.path, "%s/header", data->path) < 0)
>> -		return -1;
>> +	if (perf_data__is_multi_file(data)) {
>> +		/*
>> +		 * So far we open only the header, so we can read the data version and
>> +		 * layout.
>> +		 */
>> +		if (asprintf(&data->file.path, "%s/header", data->path) < 0)
>> +			return -1;
>> +	} else {
>> +		if (asprintf(&data->file.path, "%s/perf.data", data->path) < 0)
>> +			return -1;
>> +	}
> 

Thanks for replying :-)

> first, please note that there's support for perf.data directory code,
> but it's not been enabled yet, so we can do any changes there without
> breaking existing users
> 
> currently the logic is prepared to have perf.data DIR_FORMAT feature
> to define the layout of the directory
> 
> it'd be great to have just single point where we get directory layout,
> not checking on files names first and checking on DIR_FORMAT later

Ok, but what are you suggesting?  Naming the data file "header" seems a bit
counter-intuitive in this case.

> 
> also the kcore will be beneficial for other layouts,
> so would be great to make it somehow optional/switchable

In these patches it is, because it is not related to the DIR_FORMAT.

> one of the options could be to have DIR_FORMAT feature as the source
> of directory layout and it'd have bitmask of files/dirs (like kcore_dir)
> available in the directory

Is there an advantage to making optional files/dirs part of the format?
i.e. if they are there, use them otherwise don't.
