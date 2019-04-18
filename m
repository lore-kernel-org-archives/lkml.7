Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFD6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DC12054F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390058AbfDRTnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:43:55 -0400
Received: from mx2.yrkesakademin.fi ([85.134.45.195]:15470 "EHLO
        mx2.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389796AbfDRTnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:43:55 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Apr 2019 15:43:53 EDT
Subject: Re: [PATCH 5.0 05/93] perf data: Dont store auxtrace index for
 directory data file
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <stable@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Stephane Eranian" <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
References: <20190418160436.781762249@linuxfoundation.org>
 <20190418160437.573320142@linuxfoundation.org>
From:   Thomas Backlund <tmb@mageia.org>
Message-ID: <bda0be31-de84-50dc-e2f7-eed766bd542f@mageia.org>
Date:   Thu, 18 Apr 2019 22:28:47 +0300
MIME-Version: 1.0
In-Reply-To: <20190418160437.573320142@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-WatchGuard-Spam-ID: str=0001.0A0C0214.5CB8D37A.002E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-WatchGuard-Spam-Score: 0, clean; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.195
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den 18-04-2019 kl. 20:56, skrev Greg Kroah-Hartman:
> [ Upstream commit cd3dd8dd8ff62374d90cb3f2e54b8c94106c7810 ]
> 
> We can't store the auxtrace index when we store into multiple files,
> because we keep only offset for it, not the file.
> 
> The auxtrace data will be processed correctly in the 'pipe' mode.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Stephane Eranian <eranian@google.com>
> Link: http://lkml.kernel.org/r/20190308134745.5057-3-jolsa@kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   tools/perf/builtin-record.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 882285fb9f64..3fd154f1701b 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -386,7 +386,7 @@ static int record__process_auxtrace(struct perf_tool *tool,
>   	size_t padding;
>   	u8 pad[8] = {0};
>   
> -	if (!perf_data__is_pipe(data)) {
> +	if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
>   		off_t file_offset;
>   		int fd = perf_data__fd(data);
>   		int err;
> 


This breaks the build with:

builtin-record.c: In function 'record__process_auxtrace':
builtin-record.c:389:36: warning: implicit declaration of function 
'perf_data__is_dir'; did you mean 'perf_data__is_pipe'? 
[-Wimplicit-function-declaration]
   if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
                                     ^~~~~~~~~~~~~~~~~

Looks like it depends atleast on:

commit ec65def1045e4c7817b7f741a86dadae82877a93
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Fri Mar 8 14:47:35 2019 +0100

     perf data: Support having perf.data stored as a directory


Maybe better to drop it.

--
Thomas
