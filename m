Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DACC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD21720693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfCRKIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:08:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbfCRKIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:08:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBFB43086207;
        Mon, 18 Mar 2019 10:08:00 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73AAD177AE;
        Mon, 18 Mar 2019 10:07:58 +0000 (UTC)
Date:   Mon, 18 Mar 2019 11:07:58 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 01/16] perf: add doc for how to build perf with Asan and
 UBSan
Message-ID: <20190318100758.GA28556@krava>
References: <20190316080556.3075-1-changbin.du@gmail.com>
 <20190316080556.3075-2-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190316080556.3075-2-changbin.du@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 18 Mar 2019 10:08:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 04:05:41PM +0800, Changbin Du wrote:
> AddressSanitizer (or ASan) and UndefinedBehaviorSanitizer (or UBSan) are
> very useful tools to detect program bugs.
>  o AddressSanitizer (or ASan) is a GCC feature that detects memory
>    corruption bugs such as buffer overflows or memory leaks.
>  o UndefinedBehaviorSanitizer (or UBSan) is a fast undefined behavior
>    detector supprted by GCC. UBSan detect undefined behavior of programs
>    at runtime.
> 
> This patch adds doc for how to use them on perf. Later patches will fix
> some of the issues disclosed by them.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/Documentation/Build.txt | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tools/perf/Documentation/Build.txt b/tools/perf/Documentation/Build.txt
> index f6fc6507ba55..cae6e1d9b901 100644
> --- a/tools/perf/Documentation/Build.txt
> +++ b/tools/perf/Documentation/Build.txt
> @@ -47,3 +47,23 @@ Those objects are then used in final linking:
>  
>  NOTE this description is omitting other libraries involved, only
>       focusing on build framework outcomes

thanks for adding doc, one nit:

> +
> +3) buld and install perf

there's already:
 2) perf build
 =============

please use something like 

 3) perf build for ASan/UBSan
 ============================

> +  $ cd tools/perf
> +  $ make DESTDIR=/usr
> +  $ make DESTDIR=/usr install
> +
> +4) build with ASan or UBSan

no need for this label

> +AddressSanitizer (or ASan) is a GCC feature that detects memory corruption bugs
> +such as buffer overflows or memory leaks.
> +  $ cd tools/perf
> +  $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address'
> +  $ ASAN_OPTIONS=log_path=asan.log ./perf record -a
> +ASan outputs all detected issues into log file 'asan.log.<pid>'.
> +
> +UndefinedBehaviorSanitizer (or UBSan) is a fast undefined behavior detector
> +supprted by GCC. UBSan detect undefined behavior of programs at runtime.
> +  $ cd tools/perf
> +  $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=undefined'
> +  $ UBSAN_OPTIONS=print_stacktrace=1 ./perf record -a
> +If UBSan detects any problem at runtime, it outputs a “runtime error:” message.
> \ No newline at end of file
> -- 
> 2.19.1
> 
