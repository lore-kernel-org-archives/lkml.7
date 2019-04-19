Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4454EC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A2D20449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698824;
	bh=xZgh1ReIbFGFEypDhfXYdHpKWvBUB3k4elfLfpTDzvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DTYKzL3wC+3NrKIDOW9wYkTFWyotYVAZI/Dr3I57zCxUXyRVJFsVvCpWQVnLWjOux
	 iRPkdnB7fZrjnkIqenSIdpimiEgd+1vCzn/N4/d2KQCLIy49PYAOs/lG2Nr8p96P92
	 4oecCO7HijUagGNSb2ZlOpVJDmieLIFioZP6v7mQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfDSSdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727564AbfDSS3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:16 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C1A4222A6;
        Fri, 19 Apr 2019 13:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555680328;
        bh=xZgh1ReIbFGFEypDhfXYdHpKWvBUB3k4elfLfpTDzvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mypMHku+atSmaPvSYmO0j/bFyPL8kfqDTUQdV6VFm1iMY0+TM7f9LacmzKuh0E1O9
         dtNS41gHECsJA5MPd3j9q9URuqNGnbD5OD1yhVTLIsaevWx8X8PH6XZLmTobTIxaBs
         Y4lXfyHjnfzsbGn0BdVbo4TqUskIrzb26T6PfMSc=
Date:   Fri, 19 Apr 2019 09:25:27 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Thomas Backlund <tmb@mageia.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 5.0 05/93] perf data: Dont store auxtrace index for
 directory data file
Message-ID: <20190419132527.GB17719@sasha-vm>
References: <20190418160436.781762249@linuxfoundation.org>
 <20190418160437.573320142@linuxfoundation.org>
 <bda0be31-de84-50dc-e2f7-eed766bd542f@mageia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bda0be31-de84-50dc-e2f7-eed766bd542f@mageia.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 10:28:47PM +0300, Thomas Backlund wrote:
>Den 18-04-2019 kl. 20:56, skrev Greg Kroah-Hartman:
>>[ Upstream commit cd3dd8dd8ff62374d90cb3f2e54b8c94106c7810 ]
>>
>>We can't store the auxtrace index when we store into multiple files,
>>because we keep only offset for it, not the file.
>>
>>The auxtrace data will be processed correctly in the 'pipe' mode.
>>
>>Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>Cc: Adrian Hunter <adrian.hunter@intel.com>
>>Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
>>Cc: Andi Kleen <ak@linux.intel.com>
>>Cc: Namhyung Kim <namhyung@kernel.org>
>>Cc: Peter Zijlstra <peterz@infradead.org>
>>Cc: Stephane Eranian <eranian@google.com>
>>Link: http://lkml.kernel.org/r/20190308134745.5057-3-jolsa@kernel.org
>>Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>Signed-off-by: Sasha Levin <sashal@kernel.org>
>>---
>>  tools/perf/builtin-record.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>index 882285fb9f64..3fd154f1701b 100644
>>--- a/tools/perf/builtin-record.c
>>+++ b/tools/perf/builtin-record.c
>>@@ -386,7 +386,7 @@ static int record__process_auxtrace(struct perf_tool *tool,
>>  	size_t padding;
>>  	u8 pad[8] = {0};
>>-	if (!perf_data__is_pipe(data)) {
>>+	if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
>>  		off_t file_offset;
>>  		int fd = perf_data__fd(data);
>>  		int err;
>>
>
>
>This breaks the build with:
>
>builtin-record.c: In function 'record__process_auxtrace':
>builtin-record.c:389:36: warning: implicit declaration of function 
>'perf_data__is_dir'; did you mean 'perf_data__is_pipe'? 
>[-Wimplicit-function-declaration]
>  if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
>                                    ^~~~~~~~~~~~~~~~~
>
>Looks like it depends atleast on:
>
>commit ec65def1045e4c7817b7f741a86dadae82877a93
>Author: Jiri Olsa <jolsa@kernel.org>
>Date:   Fri Mar 8 14:47:35 2019 +0100
>
>    perf data: Support having perf.data stored as a directory
>
>
>Maybe better to drop it.

I've dropped it, thanks!

--
Thanks,
Sasha
