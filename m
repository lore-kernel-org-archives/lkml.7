Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58655C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA5A206D3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImgincHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfLTQes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:34:48 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37439 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfLTQep (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:34:45 -0500
Received: by mail-pj1-f68.google.com with SMTP id m13so4356180pjb.2
        for <Linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 08:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YdN5HZFY70+uN8OhT128vV6ppNaPFOpHNUcrRmBAfdM=;
        b=ImgincHbtVHsiMUvL/gwzJVxz7JNZwkBVvg9Xw1t5sMsZTL88QNSL+HwcOhHAuFT7d
         N+0v/0X6sXGp8mXBj4W1VhZOP+Y9/HcMEKByTZXoOQvy5we6pqedczEPPiFtO63twlbT
         ytfKhvCeQUlkBWJBIyFHNLB4ZasPN2mpPmiR0GKxYx60mGScf+TayB0QPuiocc0PdwWG
         TxL4lr9R3s5oTdmghYs53GaTepfpn1KJus3IdVd1+i2gMIDT59aggptsEGbR/qptuHfI
         hgqmRMqqYIBxJvcf4F5dPTPW31Dw0ebFU3jz/i45Gy+BCCd1h8K2hrEMuVl2rJ9bvyq1
         inEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YdN5HZFY70+uN8OhT128vV6ppNaPFOpHNUcrRmBAfdM=;
        b=MAgwkA73e7PJYTOrocY7sprk19I3221S+apMt2pgT+EpelNieTPeFbllq8h5gy9Sem
         1tj2BWT8PMLroszkZqOGVk45hp9Xz1SwY0y6l6xNZpbILYFmU9pKMsP76LDmz2EtyQyS
         rTG7BdUZ4+HMGurSrvDHQ+skpq8CLLdbCOnhYMoZ3n1TMFPsPeChRJwWzIjkWzIg737B
         7f/3a2XaT0vBn9/0H92pVZVptAIqORVNIr7toxVHNT0kk+U5qQYKcsQ1JnitJPTxX1Ql
         K4s6JjaBKFBp02wdUU+ffwfPETvjJK6qPB7slbKOMyKYkFWvvpAGRPQiJKUfWZYX8O8D
         2Dkw==
X-Gm-Message-State: APjAAAXWox2Q9C9XTHkk/vqS4Emq4USz5w2HEFgedV/HzbXBaldDFaK+
        Nu31mzGrmM/4v5buBVfmd00=
X-Google-Smtp-Source: APXvYqyU7hOvR2wAXXHTJVnps8LibhARD/qehK2mHp+CTZVffVD9SFcHg5rKOJ88MvaMqzBuUhHt/w==
X-Received: by 2002:a17:90b:4391:: with SMTP id in17mr17138531pjb.33.1576859684952;
        Fri, 20 Dec 2019 08:34:44 -0800 (PST)
Received: from quaco.ghostprotocols.net (179-240-128-100.3g.claro.net.br. [179.240.128.100])
        by smtp.gmail.com with ESMTPSA id d4sm11052968pjz.12.2019.12.20.08.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 08:34:44 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7C00B40CB9; Fri, 20 Dec 2019 13:34:38 -0300 (-03)
Date:   Fri, 20 Dec 2019 13:34:38 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 1/4] perf report: Fix incorrectly added dimensions as
 switch perf data file
Message-ID: <20191220163438.GA18798@kernel.org>
References: <20191220013722.20592-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220013722.20592-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 20, 2019 at 09:37:19AM +0800, Jin Yao escreveu:
> We observed an issue that was some extra columns displayed after switching
> perf data file in browser. The steps to reproduce:
> 
> 1. perf record -a -e cycles,instructions -- sleep 3
> 2. perf report --group
> 3. In browser, we use hotkey 's' to switch to another perf.data
> 4. Now in browser, the extra columns 'Self' and 'Children' are displayed.
> 
> The issue is setup_sorting() executed again after repeat path, so dimensions
> are added again.
> 
> This patch checks the last key returned from __cmd_report(). If it's
> K_SWITCH_INPUT_DATA, skips the setup_sorting().

you forgot to add this right?

Cc: Feng Tang <feng.tang@intel.com>
Fixes: ad0de0971b7f ("perf report: Enable the runtime switching of perf data file")
 
>  v6:
>  ---
>  No change.
> 
>  v5:
>  ---
>  New patch in v5.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-report.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 387311c67264..de988589d99b 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1076,6 +1076,7 @@ int cmd_report(int argc, const char **argv)
>  	struct stat st;
>  	bool has_br_stack = false;
>  	int branch_mode = -1;
> +	int last_key = 0;
>  	bool branch_call_mode = false;
>  #define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
>  	static const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
> @@ -1450,7 +1451,8 @@ int cmd_report(int argc, const char **argv)
>  		sort_order = sort_tmp;
>  	}
>  
> -	if (setup_sorting(session->evlist) < 0) {
> +	if ((last_key != K_SWITCH_INPUT_DATA) &&
> +	    (setup_sorting(session->evlist) < 0)) {
>  		if (sort_order)
>  			parse_options_usage(report_usage, options, "s", 1);
>  		if (field_order)
> @@ -1530,6 +1532,7 @@ int cmd_report(int argc, const char **argv)
>  	ret = __cmd_report(&report);
>  	if (ret == K_SWITCH_INPUT_DATA) {
>  		perf_session__delete(session);
> +		last_key = K_SWITCH_INPUT_DATA;
>  		goto repeat;
>  	} else
>  		ret = 0;
> -- 
> 2.17.1

-- 

- Arnaldo
