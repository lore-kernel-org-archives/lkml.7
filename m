Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F16C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5DB22CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWpQ8Nmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfGZTks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:40:48 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46065 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfGZTks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:40:48 -0400
Received: by mail-qt1-f193.google.com with SMTP id x22so48834293qtp.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=X2lDZIgoy2QitEtYC02cKSjZsrq3PsRON1whrdUGlu4=;
        b=sWpQ8NmjcX5CHs7dCM8npofYhw3/Kox1EhshiH13OGYgDMQfuYr5YrSiFWUVIIL7mM
         PBrP0DWUKgTUn4P2NlyBEFKS36f+LErW7yyuYSISU0yFC9AVu+zyMFs7TYr3dAdZqzJS
         SJfF3jMFXelcWWrUQojfcuI3vWHt5ET/GVDqdakIaDXBSRHV1k7jZ9Zw2IgHKmNhKVzH
         SWxcF6aq9OjRI6vxd6+/gX6bszFCLcYUMFGiTKDX7S999CIwzBe6HDjk4y2lCgVs/yUL
         rKUXtc+3f7jI2rX2+sGbtVSgESvTbhywHreBTgBz7B6wnw3ErkjSph+5Rs88WX4ezwgG
         +mVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=X2lDZIgoy2QitEtYC02cKSjZsrq3PsRON1whrdUGlu4=;
        b=qtXCiDBkGTLaa9Pyshp3wb39FbmqpJg+M0o2K960puntPn2k31ISXq4ElnP4x/AWkc
         7K59iUbrLG/1vBR25OLUyDfG863V/LZs8h7vBvlhUPMqidQqDqRt4aqr2Tp9eRCRl/Cj
         X8P89NZEneqJ9Sfm5UMsFrjOD4xFd1hgnR3JcW3lTMI6FAZH3XIxePJvwiriARECNnI4
         3TsybOfS70jmHnOVePz/1pl9e2K0BF6+515uQslxKyI6kq+gUXGS/nVIiizSmd7s+tjJ
         B27OUQLBTcsULB7CwmsN1G3s7rsk7WOEpt+Nw7xXvs2fYJDrJScDSM2/ojFaZI7U+vCD
         7gdA==
X-Gm-Message-State: APjAAAU1vaizDDG+Z4r41WWi9IijPWRuuA97AtFu8SkpV6GxkqJqE2uX
        jLMGJ1Cv5qWWaa8XRdMp3Sg=
X-Google-Smtp-Source: APXvYqwhMDuP3eoxkgEy1hq4UpuPY0c0r+qYjNEckpdm5lPRDZ8NZ+c3FH3Z0ZhxMgooH4GMnDCIGw==
X-Received: by 2002:ac8:7219:: with SMTP id a25mr67841044qtp.234.1564170047095;
        Fri, 26 Jul 2019 12:40:47 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id j66sm23242496qkf.86.2019.07.26.12.40.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 12:40:46 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5F14340340; Fri, 26 Jul 2019 16:40:44 -0300 (-03)
Date:   Fri, 26 Jul 2019 16:40:44 -0300
To:     Numfor Mbiziwo-Tiapo <nums@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com,
        linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com
Subject: Re: [PATCH 1/3] Fix backward-ring-buffer.c format-truncation error
Message-ID: <20190726194044.GC24867@kernel.org>
References: <20190724184512.162887-1-nums@google.com>
 <20190724184512.162887-2-nums@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190724184512.162887-2-nums@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 24, 2019 at 11:45:10AM -0700, Numfor Mbiziwo-Tiapo escreveu:
> Perf does not build with the ubsan (undefined behavior sanitizer)
> and there is an error that says:
> 
> tests/backward-ring-buffer.c:23:45: error: ‘%d’ directive output
> may be truncated writing between 1 and 10 bytes into a region of
> size 8 [-Werror=format-truncation=]
>    snprintf(proc_name, sizeof(proc_name), "p:%d\n", i);
> 
> This can be reproduced by running (from the tip directory):
> make -C tools/perf USE_CLANG=1 EXTRA_CFLAGS="-fsanitize=undefined"
> 
> Th error occurs because they are writing to the 10 byte buffer - the
> index 'i' of the for loop and the 2 byte hardcoded string. If somehow 'i'
> was greater than 8 bytes (10 - 2), then the snprintf function would
> truncate the string. Increasing the size of the buffer fixes the error.
> 
> Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> ---
>  tools/perf/tests/backward-ring-buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
> index 6d598cc071ae..1a9c3becf5ff 100644
> --- a/tools/perf/tests/backward-ring-buffer.c
> +++ b/tools/perf/tests/backward-ring-buffer.c
> @@ -18,7 +18,7 @@ static void testcase(void)
>  	int i;
>  
>  	for (i = 0; i < NR_ITERS; i++) {
> -		char proc_name[10];
> +		char proc_name[15];
>  
>  		snprintf(proc_name, sizeof(proc_name), "p:%d\n", i);
>  		prctl(PR_SET_NAME, proc_name);

This was fixed already by:

commit 11c1ea6f1a9bc97bf857fd12f72eacb6c69794e2
Author: Changbin Du <changbin.du@gmail.com>
Date:   Sat Mar 16 16:05:43 2019 +0800

    perf tools: Fix errors under optimization level '-Og'

    Optimization level '-Og' offers a reasonable level of optimization while
    maintaining fast compilation and a good debugging experience. This patch
    tries to make it work.

      $ make DEBUG=1 EXTRA_CFLAGS='-Og'
      bench/epoll-ctl.c: In function ‘do_threads’:
      bench/epoll-ctl.c:274:9: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
        return ret;
               ^~~
      ...

    Signed-off-by: Changbin Du <changbin.du@gmail.com>
    Reviewed-by: Jiri Olsa <jolsa@kernel.org>
