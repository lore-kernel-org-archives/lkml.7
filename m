Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDAAC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB6E20675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qhVho7h1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392152AbfDRSPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:15:30 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52892 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391988AbfDRSP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:15:29 -0400
Received: by mail-it1-f194.google.com with SMTP id x132so4744425itf.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 11:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CW+A47pueiQZp5g7zyLeBZOwBHny5iEZaX7aLyF2mKw=;
        b=qhVho7h1nXq6a75CQaR+bbJ5jZQFSagxoBnDBKnwJrqIxHDe6U2GRF0sGsSDkyNZ3i
         Ixd8WPIrVGxNpOaLpP89fgJpsT7qp/emyPdDty5II+p04/ueQEvAgc4VWQWvn3syWxQE
         kYlSxO4/0OFqyXKpDYBgGShk2YCLpzJ0AvhK8kF0HvjUkKUUDUuhUWo6XadARibEkJ0d
         7aumIrc08m3svTf7F9vPnUTvi5E//al1r+MqNs8RlCSEH9FZntrW9VVd2OgEmXQBaTo8
         CGIbBsA4kDZPV5mlK1iIoJcPxy9qpx8g4w4J173i+vSOgjJVVdJZEP1ERuBPvMvEwoP2
         L8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CW+A47pueiQZp5g7zyLeBZOwBHny5iEZaX7aLyF2mKw=;
        b=mbjP/g9CG6FCtV3CpEP03MgNGYUVbUgCICMJuS/Y7j/8V0QexzYDXzauRwnScI/V0E
         Q37RicRtDz3mC5zv5O842ewtu/rW/crakcASfIdVqlzQBUgoykQPSWnvdNdmZOeiZ+09
         04GhLvvYK5Mv2v/IkGa4YPi0KdeY/kJDXb7jSVWpU90xEMDE++ZUqotSeQ8Pe5N+KquI
         jJpRCzT+jt45yZsPGdhmywGJlIs2fj7+332c174DB2EkBBy54IKLL3mRsCA08YEJfTF5
         8VWJoNwsdRrdwWc4guReQIzPeHb6emeDInFalKMmUvCeRNb6+xfYbFyFgnKk1my41Kb7
         LvRg==
X-Gm-Message-State: APjAAAXQ16uKDZB0wUvuqIlkFlFvp5AEK7a5apvTEiWM7QKaBJD5hX5u
        5hjgPbf+Izf4S2P56u1hC7QNlA==
X-Google-Smtp-Source: APXvYqyYis2v1s1FkOXE5xng5MTlhKcFZZlyK3nLkmvh78psaSWKh4UR3G27YNu35qhR8TnsmBYIMw==
X-Received: by 2002:a24:43cf:: with SMTP id s198mr4459980itb.113.1555611328068;
        Thu, 18 Apr 2019 11:15:28 -0700 (PDT)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id m81sm1311933itm.33.2019.04.18.11.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 11:15:27 -0700 (PDT)
Date:   Thu, 18 Apr 2019 13:15:26 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 005/110] perf data: Dont store auxtrace index for
 directory data file
Message-ID: <20190418181526.dopckmdnxxnrnkgj@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
References: <20190418160437.484158340@linuxfoundation.org>
 <20190418160437.973692718@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190418160437.973692718@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 07:55:54PM +0200, Greg Kroah-Hartman wrote:
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
>  tools/perf/builtin-record.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 22ebeb92ac51..f5b438486a64 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -178,7 +178,7 @@ static int record__process_auxtrace(struct perf_tool *tool,
>  	size_t padding;
>  	u8 pad[8] = {0};
>  
> -	if (!perf_data__is_pipe(data)) {
> +	if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {

This one causes a build failure when building perf:

    builtin-record.c: In function ‘record__process_auxtrace’:
    builtin-record.c:181:36: error: implicit declaration of function ‘perf_data__is_dir’; did you mean ‘perf_data__is_pipe’? [-Werror=implicit-function-declaration]
      if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
                                        ^~~~~~~~~~~~~~~~~
                                        perf_data__is_pipe
    builtin-record.c:181:36: error: nested extern declaration of ‘perf_data__is_dir’ [-Werror=nested-externs]

It seems to require 258031c017c3 ("perf header: Add DIR_FORMAT feature
to describe directory data"), which doesn't backport cleanly. Dropping
f54f24d0f19a ("perf data: Don't store auxtrace index for directory data
file") does seem to fix the issue.

>  		off_t file_offset;
>  		int fd = perf_data__fd(data);
>  		int err;
> -- 
> 2.19.1
> 
> 
> 

-- 
Linaro - Kernel Validation
