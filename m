Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CDAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C902133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nf0Xs9I1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbfB1SqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:46:17 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:43235 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfB1SqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:46:16 -0500
Received: by mail-qt1-f177.google.com with SMTP id y4so24712414qtc.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 10:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=of3SXHJJzWjSl6foRbHSA/ECnXoedJ/59IqCdBMijGo=;
        b=nf0Xs9I1rqR5ZTZzT2jZftbURSJSBsUQXLiQ8VMAf8/n9IiTeSX/I0QmQXNpyYchis
         jYYJ1ZGY24yntBb2PVTIAvlXIgH9NVEOUfUUcS3gX+3xLrr4nivJEFkNzT+P45qLbRSU
         UMmt1ySSUZL0qr4sE6PT2+JIu11vUJHxLlTEVIoMIlONJTcWU0TCpSf3RxNJ8/V513Dk
         trStYIn9y/dzP/TD+x6lpZGjgxHq6rulnT+sdJdr+OdRGPPIFZjcvnpUXhi13l2rshwI
         gqS7jmzVIQsdM5X8NcrcABSR9AWUI1K85MzOdhzqQ+NloCybclfzAransqUErkQTsBtt
         bidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=of3SXHJJzWjSl6foRbHSA/ECnXoedJ/59IqCdBMijGo=;
        b=jnfWkQnP4Ej2fWTvLq902hKFVUIBjHbUcJxGP7cfAYo4UZi5pUYa3UlwhwuszlxFsl
         OktRSeRadUn36KXDvw/BI8qWW1YtUKc2LHuDO0D1nX3DH5Ke5fsbs8523h47rwaH8IvD
         pndeXFABwEjEPYa8Xj8H4NVuSnBWRhqWAsudDIKLjWKUoqnHlWMmgqpZclCablc/XQ6D
         s1nKH1YPoJKnzAIBYYQDoAwuYI7ap3fg78w3rb2H6Ef0uuxBy7iTWNS4hO9tVDVX46wi
         IAMojqzSPM3vZ82Cg/vI5E7rgYCxmSejPLnyJCRgZozwkwOotKqoVAC71B3OWiGtmt7O
         zy3Q==
X-Gm-Message-State: APjAAAUgUwXTGz6wJMu9bExpkd+KTaw/TxeW/+rW6lgr3O8/O1ELSmO8
        rG6fcE7Y8tJS2J96MbBH1vI=
X-Google-Smtp-Source: APXvYqzisChRwovfndB4zBhkC4/Vz9/RsXeExsAQrtA9qEhXsPsxqOH0jv74tK3yRzv5GUIeKZQDxw==
X-Received: by 2002:ac8:2ca1:: with SMTP id 30mr602326qtw.245.1551379575279;
        Thu, 28 Feb 2019 10:46:15 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id f58sm13401556qtc.14.2019.02.28.10.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 10:46:14 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6A1984039C; Thu, 28 Feb 2019 15:46:12 -0300 (-03)
Date:   Thu, 28 Feb 2019 15:46:12 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 01/10] feature: implement libzstd check, LIBZSTD_DIR
 and NO_LIBZSTD defines
Message-ID: <20190228184612.GF9508@kernel.org>
References: <bb018a36-5249-ca6a-8e16-6afac442bae5@linux.intel.com>
 <e729df84-1b0e-d402-c03e-c1729d4ec43d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e729df84-1b0e-d402-c03e-c1729d4ec43d@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 28, 2019 at 11:59:01AM +0300, Alexey Budankov escreveu:
> +++ b/tools/build/Makefile.feature
> @@ -66,7 +66,8 @@ FEATURE_TESTS_BASIC :=                  \
>          sched_getcpu			\
>          sdt				\
>          setns				\
> -        libaio
> +        libaio				\
> +        libzstd

Since you added this as a basic feature to test, add this when you
resubmit, so that 'perf -vv' tells us that this basic feature is indeed
present.


diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 50df168be326..d41197fc8cef 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -78,6 +78,7 @@ static void library_status(void)
 	STATUS(HAVE_LZMA_SUPPORT, lzma);
 	STATUS(HAVE_AUXTRACE_SUPPORT, get_cpuid);
 	STATUS(HAVE_LIBBPF_SUPPORT, bpf);
+	STATUS(HAVE_ZSTD_SUPPORT, bpf);
 }
 
 int cmd_version(int argc, const char **argv)
