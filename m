Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F8FC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E6B217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOk1sKkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfI0P04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 11:26:56 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36813 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfI0P0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 11:26:55 -0400
Received: by mail-qt1-f195.google.com with SMTP id o12so7787763qtf.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 08:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UN4/+144gXmJj1EL57+hN+Kizv/0pk1NLQEdyQbeimE=;
        b=AOk1sKkc3Ro5x70fvu24eXjr+nWazif7DfQQkeK6lpYDawZSfdbSSmwDUYusjvAynv
         N2F3ILvOJuISpbe5j4CB+OKmLva6dGC6C8eXAWXckvaMGUQizLu9kRx3TSqMJphxr0Xy
         US5sNnV0o+CGj5c3cUED1pvYW8IuLXiQ6LmcYbWy90dqbMFXYxc/W3oNiLVYf858kEco
         4Zamhb1PQHKidOzuGRJ/Hfmri0B9KmLKMzSWznBFZkJtPHhO/3lsYfrrkn5BTeqILqLT
         K2LY9tAHtkXBsxqEO+UOZH483Kl1thWs07RNdv8n7rktCINcytPLWk5/PFeJdqramfXm
         mHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UN4/+144gXmJj1EL57+hN+Kizv/0pk1NLQEdyQbeimE=;
        b=cWf34cYFbzfvTub5m5CMORXrpZC9cCOeoKswXe99m7YLNpH/GT1LMwN+E8FL5F4FXe
         JS7Uo1ovT5Xn/JBHWh/f7Z5PUeaCzcOyuoRfJJBXzeMQ9/kjgaBbPoq97CysuppnijQ7
         TKtru3FKrry2qvVGJi86pS0fSeeZxoPXMBHgXePJ3K6ia/m+kmcrcEySXFHRQ+F4DtO9
         AJsc4Kghu+yLzvQMCueq+zeBIrC+GL+0CfyUnmewC4sZ99wQEvx/kW1YI9v0UhHNFx/n
         EyUGIVoNH4Y/sbbkDfUko3kXWi2NLCaXA4bzerfLkkN9yFaXMs7R+evT2ap6wnY+/ly+
         TugQ==
X-Gm-Message-State: APjAAAU1K8sUnRy0Iw6c/FigQfudi9tFmI0nsv686xR5Htxe7FKBkVy7
        jq1wVz7T2gIncpwntsnD/+E=
X-Google-Smtp-Source: APXvYqw6I07YGEpdwzjs2ovVzsOS2QYxYnset9HYEVJqLGBO6KcGB/e6p5xEU8zpHQP3CSGG/eh8IQ==
X-Received: by 2002:ac8:1492:: with SMTP id l18mr10292157qtj.307.1569598014643;
        Fri, 27 Sep 2019 08:26:54 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id h68sm1252943qkf.2.2019.09.27.08.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 08:26:53 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9404440396; Fri, 27 Sep 2019 12:26:51 -0300 (-03)
Date:   Fri, 27 Sep 2019 12:26:51 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH] perf llvm: don't access out-of-scope array
Message-ID: <20190927152651.GA20644@kernel.org>
References: <20190926220018.25402-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926220018.25402-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 26, 2019 at 03:00:18PM -0700, Ian Rogers escreveu:
> test_dir is assigned to the release array which is out-of-scope 3 lines
> later. Extend the scope of the release array so that an out-of-scope
> array isn't accessed.
> Bug detected by clang's address sanitizer.

This one is really ironic, code to support using clang/llvm in perf is
caught with a bug detected by clang's utilities ;-)

Please next time try to use 'git blame' so as to add this:

[root@quaco perf]# git tag --contains 07bc5c699a3d | grep ^v[[:digit:]] | sort --version-sort | head -1
v4.4
[root@quaco perf]#

Cc: Wang Nan <wangnan0@huawei.com>
Cc: stable@vger.kernel.org # v4.4+
Fixes: 07bc5c699a3d ("perf tools: Make fetch_kernel_version() publicly available")

And help get noticed by the various backport bots out there.

Thanks a lot, applied!

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/llvm-utils.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
> index 8d04e3d070b1..8b14e4a7f1dc 100644
> --- a/tools/perf/util/llvm-utils.c
> +++ b/tools/perf/util/llvm-utils.c
> @@ -233,14 +233,14 @@ static int detect_kbuild_dir(char **kbuild_dir)
>  	const char *prefix_dir = "";
>  	const char *suffix_dir = "";
>  
> +	/* _UTSNAME_LENGTH is 65 */
> +	char release[128];
> +
>  	char *autoconf_path;
>  
>  	int err;
>  
>  	if (!test_dir) {
> -		/* _UTSNAME_LENGTH is 65 */
> -		char release[128];
> -
>  		err = fetch_kernel_version(NULL, release,
>  					   sizeof(release));
>  		if (err)
> -- 
> 2.23.0.444.g18eeb5a265-goog

-- 

- Arnaldo
