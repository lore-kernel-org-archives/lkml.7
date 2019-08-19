Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F93EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351DA206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uclkTQf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfHSOjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:39:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45603 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHSOjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:39:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id k13so2098013qtm.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 07:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xLLJjoesEJEd2PYE/+HF/TxYCpyFxN7zx0ODjGCcy18=;
        b=uclkTQf1xIbL/YqubPN8iva5x5aaymMT90zdYu5pZt2ovvePCdJ+eD+lnE3hJhVinr
         V4NUkX94HN7mfv0Q0PV0wMyJNEtAFEjrbLKfyEzagDlDlZWg2l15lJNLHngks0zoSvph
         GbXuSl4soXVAf31WpOqv2ePg4jSWHZWpQ3G+IJsftBE55slxkML8r3mFajexgpnSQA6m
         68ONYZPr7qbdx9VCXeEfrYCpKXDHtUhrH5vSw3EaI25PKsuy8I74XU45xRIscIjbNpsI
         8RJfJ7jowvk+86RcXQz2rmpXhpsepAkO8gYrwcxpIWLkMGfnHyiDIORMUl+QH3rOJuxF
         HVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xLLJjoesEJEd2PYE/+HF/TxYCpyFxN7zx0ODjGCcy18=;
        b=toe0w4Sai8ekJFiTZgazxZPwkGh6TLTX3D7ldlSUWjIxYL+Gj8hUu86tnglgEOB8RG
         55vz4JEfwxUU5oli4HUiFEodzoz4wbyl2uZjksV+aYQXx5w0Ixsu+lG6r+IPjfGAwxYW
         AnQ8ahImPnSlOBvv2TRyC1z8AZA3CweY4e043+f9SXALxxBat6EfgC0oIZfO6+llMFfj
         HTP7UDessYFsN0TVx9l0Dq4X3/kYkqx2t23iSy/Zs5Uz9Lo76XPrO8hX/9UkwH4CWMsm
         9B2bO6UsOdNsCFgYIiDcMtz8RwGE2V2FCgW2qsRFhOUNq2P2H0K0rXaDD4YiN8HNy5Rx
         mPoQ==
X-Gm-Message-State: APjAAAWkyzERSMYE/flHQQ68cMCAFCfRkYfwjCnqGC7Zh/lGZfEMyNXY
        4eIPBp1VyfyJ1m6ohQpUZ80=
X-Google-Smtp-Source: APXvYqyjb3GdPZqfTAPv+HnG/T8EtsGmVB9DSKuvq+lT9XScVwwp2Q3bO/ivyqMPlKyF9A58Znb6ug==
X-Received: by 2002:a0c:e907:: with SMTP id a7mr10459919qvo.35.1566225593232;
        Mon, 19 Aug 2019 07:39:53 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id 6sm8229587qtu.15.2019.08.19.07.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 07:39:52 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3978E40340; Mon, 19 Aug 2019 11:39:50 -0300 (-03)
Date:   Mon, 19 Aug 2019 11:39:50 -0300
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Wang Nan <wangnan0@huawei.com>, He Kuang <hekuang@huawei.com>,
        Michal Marek <mmarek@suse.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Stephane Eranian <eranian@google.com>,
        Paul Turner <pjt@google.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: Re: [PATCH] tools lib traceevent: Fix "robust" test of
 do_generate_dynamic_list_file
Message-ID: <20190819143950.GD29674@kernel.org>
References: <20190805130150.25acfeb1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805130150.25acfeb1@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 05, 2019 at 01:01:50PM -0400, Steven Rostedt escreveu:
> [
>   Not sure why I wasn't Cc'd on the original patch (or the one before that)
>   but I guess I need to add tools/lib/traceevent under MAINTAINERs for
>   perhaps tracing?
> ]
> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The tools/lib/traceevent/Makefile had a test added to it to detect a failure
> of the "nm" when making the dynamic list file (whatever that is). The
> problem is that the test sorts the values "U W w" and some versions of sort
> will place "w" ahead of "W" (even though it has a higher ASCII value, and
> break the test.
> 
> Add 'tr "w" "W"' to merge the two and not worry about the ordering.

Thanks, applied.

- Arnaldo
 
> Cc: stable@vger.kernel.org
> Fixes: 6467753d61399 ("tools lib traceevent: Robustify do_generate_dynamic_list_file")
> Reported-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  tools/lib/traceevent/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
> index 3292c290654f..8352d53dcb5a 100644
> --- a/tools/lib/traceevent/Makefile
> +++ b/tools/lib/traceevent/Makefile
> @@ -266,8 +266,8 @@ endef
>  
>  define do_generate_dynamic_list_file
>  	symbol_type=`$(NM) -u -D $1 | awk 'NF>1 {print $$1}' | \
> -	xargs echo "U W w" | tr ' ' '\n' | sort -u | xargs echo`;\
> -	if [ "$$symbol_type" = "U W w" ];then				\
> +	xargs echo "U w W" | tr 'w ' 'W\n' | sort -u | xargs echo`;\
> +	if [ "$$symbol_type" = "U W" ];then				\
>  		(echo '{';						\
>  		$(NM) -u -D $1 | awk 'NF>1 {print "\t"$$2";"}' | sort -u;\
>  		echo '};';						\
> -- 
> 2.20.1

-- 

- Arnaldo
