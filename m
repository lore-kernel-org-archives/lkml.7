Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFBFCA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316CA2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfJ2JUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:20:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:22388 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfJ2JUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:20:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 02:20:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="374490804"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.197]) ([10.237.72.197])
  by orsmga005.jf.intel.com with ESMTP; 29 Oct 2019 02:20:13 -0700
Subject: Re: [PATCH RFC 2/6] perf dso: Refactor dso_cache__read()
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
 <20191025130000.13032-3-adrian.hunter@intel.com>
 <20191028153930.GA15449@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3c5652a7-57ef-bf5e-c0aa-2332c3febff9@intel.com>
Date:   Tue, 29 Oct 2019 11:19:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028153930.GA15449@krava>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/19 5:39 PM, Jiri Olsa wrote:
> On Fri, Oct 25, 2019 at 03:59:56PM +0300, Adrian Hunter wrote:
> 
> SNIP
> 
>> +}
>>  
>> -	return ret;
>> +static struct dso_cache *dso_cache__find(struct dso *dso,
>> +					 struct machine *machine,
>> +					 u64 offset,
>> +					 ssize_t *ret)
>> +{
>> +	struct dso_cache *cache = __dso_cache__find(dso, offset);
>> +
>> +	return cache ? cache : dso_cache__populate(dso, machine, offset, ret);
>>  }
>>  
>>  static ssize_t dso_cache_read(struct dso *dso, struct machine *machine,
>>  			      u64 offset, u8 *data, ssize_t size)
>>  {
>>  	struct dso_cache *cache;
>> +	ssize_t ret = 0;
>>  
>> -	cache = dso_cache__find(dso, offset);
>> -	if (cache)
>> -		return dso_cache__memcpy(cache, offset, data, size);
>> -	else
>> -		return dso_cache__read(dso, machine, offset, data, size);
>> +	cache = dso_cache__find(dso, machine, offset, &ret);
>> +	if (!cache)
>> +		return ret;
> 
> why not use the ERR_* macros to get error through the pointer
> instead of adding extra argument?
> 

OK, here's the diff for that:

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 460330d125b6..272545624fbe 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
+#include <linux/err.h>
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <sys/types.h>
@@ -865,30 +866,29 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
 
 static struct dso_cache *dso_cache__populate(struct dso *dso,
 					     struct machine *machine,
-					     u64 offset, ssize_t *ret)
+					     u64 offset)
 {
 	u64 cache_offset = offset & DSO__DATA_CACHE_MASK;
 	struct dso_cache *cache;
 	struct dso_cache *old;
+	ssize_t ret;
 
 	cache = zalloc(sizeof(*cache) + DSO__DATA_CACHE_SIZE);
-	if (!cache) {
-		*ret = -ENOMEM;
-		return NULL;
-	}
+	if (!cache)
+		return ERR_PTR(-ENOMEM);
 
 	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
-		*ret = bpf_read(dso, cache_offset, cache->data);
+		ret = bpf_read(dso, cache_offset, cache->data);
 	else
-		*ret = file_read(dso, machine, cache_offset, cache->data);
+		ret = file_read(dso, machine, cache_offset, cache->data);
 
-	if (*ret <= 0) {
+	if (ret <= 0) {
 		free(cache);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	cache->offset = cache_offset;
-	cache->size   = *ret;
+	cache->size   = ret;
 
 	old = dso_cache__insert(dso, cache);
 	if (old) {
@@ -902,23 +902,20 @@ static struct dso_cache *dso_cache__populate(struct dso *dso,
 
 static struct dso_cache *dso_cache__find(struct dso *dso,
 					 struct machine *machine,
-					 u64 offset,
-					 ssize_t *ret)
+					 u64 offset)
 {
 	struct dso_cache *cache = __dso_cache__find(dso, offset);
 
-	return cache ? cache : dso_cache__populate(dso, machine, offset, ret);
+	return cache ? cache : dso_cache__populate(dso, machine, offset);
 }
 
 static ssize_t dso_cache_read(struct dso *dso, struct machine *machine,
 			      u64 offset, u8 *data, ssize_t size)
 {
-	struct dso_cache *cache;
-	ssize_t ret = 0;
+	struct dso_cache *cache = dso_cache__find(dso, machine, offset);
 
-	cache = dso_cache__find(dso, machine, offset, &ret);
-	if (!cache)
-		return ret;
+	if (IS_ERR_OR_NULL(cache))
+		return PTR_ERR(cache);
 
 	return dso_cache__memcpy(cache, offset, data, size);
 }

