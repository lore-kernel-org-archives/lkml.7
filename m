Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E260EC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 04:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C1620700
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 04:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHQSXAf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKWEJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 23:09:13 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:32842 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfKWEJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 23:09:13 -0500
Received: by mail-pj1-f65.google.com with SMTP id o14so3986334pjr.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 20:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g8sgaQY/+XBwxHT7dgSuaVwAa2AexcXfsTE7aom3zK0=;
        b=bHQSXAf1edwcECyBp5dtz84e1e0dMEH2+HNZniaccn3zavCJE9U9DDNY2EsfnFKXJ6
         HJyqNJtS/hZUoXAcq1gqx/HkmcqUpdKGGMex94g4/V1nM3+RObfP0nvAWqWhgiJ9sYck
         Z4MNUnxLRWU0zTsrVcCVogBpS/O63r/yGBBqNINZNvQVvcvwLKfEntPzuXls8/aSnvEO
         Mb9YCbCTf/cfLLEp+2QIz8ibFb+nnKUKE3zhbn95NP/A7nlXkw8U7fIrlwReZq+RNgyP
         cvMbXrfThrLVT2NJJ9vBzORFVocZaMzueBm5iS6AJXu+l8hUrX20DETuVHKbYT0pUDFP
         ftTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g8sgaQY/+XBwxHT7dgSuaVwAa2AexcXfsTE7aom3zK0=;
        b=Knc4IVrNKdxzh160TSHPFnVN35vUmu9Orr5J8tD48BFRHpN5RS6p4mPLwsC+NN1Z2n
         I6PdZGWWrm+Fpn2msYDmgiobFXRJcwrMC9UXxNP2dyB7qaf8dXJjHb8hQnWNMnYxuL+N
         qpEvWb9v1VIjcGtzW7TqK9fWGZ9xRtdaTwh1wNh5/JFVmxeUdDZPHTkGzTJF5BM3rF1t
         HKdn2xapBAp/oRBiqVI0vxiyz+LL9e54LJf0hH/JliVc0hKlG6L6WDoOiKWmPDDPf/VB
         mNqzba1PXPjbF9cNuPyieSHHV7B9dWH9FK6zjF7ZYlaGtbXCMAGZIoXV+CNZU9QVewvG
         GQ7Q==
X-Gm-Message-State: APjAAAXWJ9lpZEge6lhOoSDQvS22HNJINqCu2JLZ6NUS/Sn4tHKwEP6e
        LwrzPStK5kjqPIMj4MsDubA=
X-Google-Smtp-Source: APXvYqwXX/S6KYurldfgKS7+knl6XFOJZLtow5XngPN23+xkR14NwNhd0QsLBY7gEQ67H5qpxG1yrA==
X-Received: by 2002:a17:902:bb8f:: with SMTP id m15mr17950296pls.121.1574482152599;
        Fri, 22 Nov 2019 20:09:12 -0800 (PST)
Received: from mail.google.com ([45.32.93.123])
        by smtp.gmail.com with ESMTPSA id x7sm120934pfa.107.2019.11.22.20.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Nov 2019 20:09:12 -0800 (PST)
Date:   Sat, 23 Nov 2019 04:09:10 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] perf: add support for logging debug messages to
 file
Message-ID: <20191123040910.dfi65lbev7ydtbdo@mail.google.com>
References: <20191018002757.4112-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018002757.4112-1-changbin.du@gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri, In case you missed this one in your mailbox. :)

On Fri, Oct 18, 2019 at 08:27:55AM +0800, Changbin Du wrote:
> When in TUI mode, it is impossible to show all the debug messages to
> console. This make it hard to debug perf issues using debug messages.
> This patch adds support for logging debug messages to file to resolve
> this problem.
> 
> v5:
>   o doc default log path.
> v4:
>   o fix another segfault.
> v3:
>   o fix a segfault issue.
> v2:
>   o specific all debug options one time.
> 
> Changbin Du (2):
>   perf: support multiple debug options separated by ','
>   perf: add support for logging debug messages to file
> 
>  tools/perf/Documentation/perf.txt |  16 ++--
>  tools/perf/util/debug.c           | 124 ++++++++++++++++++++----------
>  2 files changed, 92 insertions(+), 48 deletions(-)
> 
> -- 
> 2.20.1
> 

-- 
Cheers,
Changbin Du
