Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E98CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0A620830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbfJ2JVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:21:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:29137 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbfJ2JVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:21:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 02:21:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="374491117"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.197]) ([10.237.72.197])
  by orsmga005.jf.intel.com with ESMTP; 29 Oct 2019 02:21:47 -0700
Subject: Re: [PATCH RFC 3/6] perf dso: Add dso__data_write_cache_addr()
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20191025130000.13032-1-adrian.hunter@intel.com>
 <20191025130000.13032-4-adrian.hunter@intel.com>
 <20191028154503.GB15449@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <531e096d-2dbf-28e0-1fdc-3a121e18241a@intel.com>
Date:   Tue, 29 Oct 2019 11:20:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028154503.GB15449@krava>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/19 5:45 PM, Jiri Olsa wrote:
> On Fri, Oct 25, 2019 at 03:59:57PM +0300, Adrian Hunter wrote:
> SNIP
> 
>>  
>> -static ssize_t data_read_offset(struct dso *dso, struct machine *machine,
>> -				u64 offset, u8 *data, ssize_t size)
>> +static ssize_t data_read_write_offset(struct dso *dso, struct machine *machine,
>> +				      u64 offset, u8 *data, ssize_t size,
>> +				      bool out)
>>  {
>>  	if (dso__data_file_size(dso, machine))
>>  		return -1;
>> @@ -1034,7 +1037,7 @@ static ssize_t data_read_offset(struct dso *dso, struct machine *machine,
>>  	if (offset + size < offset)
>>  		return -1;
>>  
>> -	return cached_read(dso, machine, offset, data, size);
>> +	return cached_io(dso, machine, offset, data, size, out);
> 
> you renamed the function as _read_write_ so the bool choosing
> the opration should be named either read or write.. I had to
> go all the way down to find out what 'out' means ;-)
> 

Arnaldo already applied it, so here is the diff:

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 12ab26baba44..505ba78eda3c 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -829,12 +829,12 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
 }
 
 static ssize_t dso_cache__memcpy(struct dso_cache *cache, u64 offset, u8 *data,
-				 u64 size, bool out)
+				 u64 size, bool read)
 {
 	u64 cache_offset = offset - cache->offset;
 	u64 cache_size   = min(cache->size - cache_offset, size);
 
-	if (out)
+	if (read)
 		memcpy(data, cache->data + cache_offset, cache_size);
 	else
 		memcpy(cache->data + cache_offset, data, cache_size);
@@ -912,14 +912,14 @@ static struct dso_cache *dso_cache__find(struct dso *dso,
 }
 
 static ssize_t dso_cache_io(struct dso *dso, struct machine *machine,
-			    u64 offset, u8 *data, ssize_t size, bool out)
+			    u64 offset, u8 *data, ssize_t size, bool read)
 {
 	struct dso_cache *cache = dso_cache__find(dso, machine, offset);
 
 	if (IS_ERR_OR_NULL(cache))
 		return PTR_ERR(cache);
 
-	return dso_cache__memcpy(cache, offset, data, size, out);
+	return dso_cache__memcpy(cache, offset, data, size, read);
 }
 
 /*
@@ -928,7 +928,7 @@ static ssize_t dso_cache_io(struct dso *dso, struct machine *machine,
  * by cached data. Writes update the cache only, not the backing file.
  */
 static ssize_t cached_io(struct dso *dso, struct machine *machine,
-			 u64 offset, u8 *data, ssize_t size, bool out)
+			 u64 offset, u8 *data, ssize_t size, bool read)
 {
 	ssize_t r = 0;
 	u8 *p = data;
@@ -936,7 +936,7 @@ static ssize_t cached_io(struct dso *dso, struct machine *machine,
 	do {
 		ssize_t ret;
 
-		ret = dso_cache_io(dso, machine, offset, p, size, out);
+		ret = dso_cache_io(dso, machine, offset, p, size, read);
 		if (ret < 0)
 			return ret;
 
@@ -1022,7 +1022,7 @@ off_t dso__data_size(struct dso *dso, struct machine *machine)
 
 static ssize_t data_read_write_offset(struct dso *dso, struct machine *machine,
 				      u64 offset, u8 *data, ssize_t size,
-				      bool out)
+				      bool read)
 {
 	if (dso__data_file_size(dso, machine))
 		return -1;
@@ -1034,7 +1034,7 @@ static ssize_t data_read_write_offset(struct dso *dso, struct machine *machine,
 	if (offset + size < offset)
 		return -1;
 
-	return cached_io(dso, machine, offset, data, size, out);
+	return cached_io(dso, machine, offset, data, size, read);
 }
 
 /**


