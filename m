Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB06C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 01:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BD42084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 01:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfKHBkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 20:40:09 -0500
Received: from mail5.windriver.com ([192.103.53.11]:50782 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfKHBkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 20:40:09 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id xA81dlFu025977
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 7 Nov 2019 17:39:47 -0800
Received: from [128.224.155.112] (128.224.155.112) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 7 Nov
 2019 17:39:46 -0800
Subject: Re: [PATCH v5] perf record: Add support for limit perf output file
 size
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>
References: <20191022080901.3841-1-jiwei.sun@windriver.com>
 <20191101081300.GA2172@krava> <20191107111356.GA23651@kernel.org>
CC:     <acme@redhat.com>, <linux-kernel@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <mpetlan@redhat.com>,
        <namhyung@kernel.org>, <a.p.zijlstra@chello.nl>,
        <adrian.hunter@intel.com>, <Richard.Danter@windriver.com>,
        <jiwei.sun.bj@qq.com>
From:   Jiwei Sun <Jiwei.Sun@windriver.com>
Message-ID: <3f4e70fd-d58c-3b43-3443-e37305dbc85d@windriver.com>
Date:   Fri, 8 Nov 2019 09:39:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20191107111356.GA23651@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.155.112]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 2019e9411f07f% 19:13, Arnaldo Carvalho de Melo wrote:
> Em Fri, Nov 01, 2019 at 09:13:00AM +0100, Jiri Olsa escreveu:
>> On Tue, Oct 22, 2019 at 04:09:01PM +0800, jsun4 wrote:
>>> The patch adds a new option to limit the output file size, then based
>>> on it, we can create a wrapper of the perf command that uses the option
>>> to avoid exhausting the disk space by the unconscious user.
>>>
>>> In order to make the perf.data parsable, we just limit the sample data
>>> size, since the perf.data consists of many headers and sample data and
>>> other data, the actual size of the recorded file will bigger than the
>>> setting value.
>>>
>>> Testing it:
>>>
>>>  # ./perf record -a -g --max-size=10M
>>>  Couldn't synthesize bpf events.
>>>  [ perf record: perf size limit reached (10249 KB), stopping session ]
>>>  [ perf record: Woken up 32 times to write data ]
>>>  [ perf record: Captured and wrote 10.133 MB perf.data (71964 samples) ]
>>>
>>>  # ls -lh perf.data
>>>  -rw------- 1 root root 11M Oct 22 14:32 perf.data
>>>
>>>  # ./perf record -a -g --max-size=10K
>>>  [ perf record: perf size limit reached (10 KB), stopping session ]
>>>  Couldn't synthesize bpf events.
>>>  [ perf record: Woken up 0 times to write data ]
>>>  [ perf record: Captured and wrote 1.546 MB perf.data (69 samples) ]
>>>
>>>  # ls -l perf.data
>>>  -rw------- 1 root root 1626952 Oct 22 14:36 perf.data
>>>
>>> Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
>>> ---
>>> v5 changes:
>>>   - Change the output format like [ perf record: perf size limit XX ]
>>>   - change the killing perf way from "raise(SIGTERM)" to set "done == 1"
>>
>> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> So, had to add this on top to fix the build on multiple building
> environments, rec->bytes_written is an u64, so we must use PRIu64 or
> else get errors like:
> 
>   builtin-record.c: In function 'record__write':
>   builtin-record.c:150:5: error: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'u64' [-Werror=format=]
>        rec->bytes_written >> 10);
>        ^
>     CC       /tmp/build/pe

Sorry for the flaw, and thanks for your suggestion and rectification. 
And I will pay attention to avoid such mistake next time.

Regards,
Jiwei

> 
> 
> - Arnaldo
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index b9ddfcda9611..b95c000c1ed9 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -145,7 +145,7 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>  	rec->bytes_written += size;
>  
>  	if (record__output_max_size_exceeded(rec) && !done) {
> -		fprintf(stderr, "[ perf record: perf size limit reached (%lu KB),"
> +		fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
>  				" stopping session ]\n",
>  				rec->bytes_written >> 10);
>  		done = 1;
> 
