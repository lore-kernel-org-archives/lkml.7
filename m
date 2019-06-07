Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122B8C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA693214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aypwLzhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfFGTul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 15:50:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34453 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729944AbfFGTul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:50:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id m29so3719970qtu.1;
        Fri, 07 Jun 2019 12:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kmQwmNpL1gpgHz2Qe+F1FukdUbULsaf1PLYnXjQlTeE=;
        b=aypwLzhS4LnVTT0W6nOCZvCqNPDEooF/kqBQ2h6Zdg39BU2IycMnDWat9HZCG10hIr
         +Ph44dl719M1oiTMF4FhkvJetxBZRAdi01KAgMtDhGF2RNpXGl1cmm9ZrAQGFsGvsHjP
         wIWGMjMF1hAeX4Dd+UY3dRewGW7em0+ePS/St0r6UJR6GuTINRZ5p7YrVKaGogovl+I9
         4Fqdegc86Wp01G58MYWRmmxOxDarzgcjuPMuh73YmXU4fkWdTh+I6UcvLtI+vtox5mgr
         aw/axzRZCIA4fp52ZA3GZEfIeBPmaMUU02HKcqlIEsBG3HLhMMGVNK+FiXyrpizsfud0
         AdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kmQwmNpL1gpgHz2Qe+F1FukdUbULsaf1PLYnXjQlTeE=;
        b=pJWUjDAYAS5Wfg77TfNqdiiKHJ4F9p2nrmR+WnP5ucfyh6/R1lVqrtpXx+7LS0zOG3
         WjZJDAhopE9I9W9p/uIbUeOOIYE43Ul80L56gmezsgtMR0biFiJeXxpkClMXrfZ5WFOL
         lYJ3w/qfHk5R8ZnKZHRb3iKj7kbUtejmYBR5giqw6VPPMHCl174GgoRylAlMP/rZerBo
         tHBpY9ri2Nvw5Erk8nHv5iq4eVNwTQKWGOCAFzQj1PN8UA+ZlLVK0Tcxj0YQNw0qMpTK
         PFi6o/duHflMo/9n/iOrsAcM45vT0L0PWYVuVs0TW8xMZGKmeVbseTXe/I6+dur2Fk96
         2xRw==
X-Gm-Message-State: APjAAAWACUIx/bbf4FC8qmZoMSoqrm09QpUt2WO/kQaTqrQfmYI8b8Nx
        7H/DZzyKbW9yT2hBiIAh/IRf/K8X
X-Google-Smtp-Source: APXvYqyFBWpphZ5s0UNfRT0nUOz05IaPnhSTq0V5Xje+KFaqDssltFdmDfwcc2z3XiET9V/mhunkWw==
X-Received: by 2002:ac8:805:: with SMTP id u5mr49040556qth.186.1559937040396;
        Fri, 07 Jun 2019 12:50:40 -0700 (PDT)
Received: from quaco.ghostprotocols.net (187-26-97-17.3g.claro.net.br. [187.26.97.17])
        by smtp.gmail.com with ESMTPSA id y68sm1410800qkd.69.2019.06.07.12.50.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 12:50:39 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AA9AA41149; Fri,  7 Jun 2019 16:50:30 -0300 (-03)
Date:   Fri, 7 Jun 2019 16:50:30 -0300
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf test 6: Fix missing kvm module load for s390
Message-ID: <20190607195030.GQ21245@kernel.org>
References: <20190604053504.43073-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604053504.43073-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 04, 2019 at 07:35:04AM +0200, Thomas Richter escreveu:
> Command
> 
>    # perf test -Fv 6
> 
> fails with error
> 
>    running test 100 'kvm-s390:kvm_s390_create_vm' failed to parse
>     event 'kvm-s390:kvm_s390_create_vm', err -1, str 'unknown tracepoint'
>     event syntax error: 'kvm-s390:kvm_s390_create_vm'
>                          \___ unknown tracepoint

Thanks, applied,

- Arnaldo
 
> when the kvm module is not loaded or not built in.
> 
> Fix this by adding a valid function which tests if the module
> is loaded. Loaded modules (or builtin KVM support) have a
> directory named
>   /sys/kernel/debug/tracing/events/kvm-s390
> for this tracepoint.
> 
> Check for existence of this directory.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  tools/perf/tests/parse-events.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 4a69c07f4101..8f3c80e13584 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -18,6 +18,32 @@
>  #define PERF_TP_SAMPLE_TYPE (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME | \
>  			     PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD)
>  
> +#if defined(__s390x__)
> +/* Return true if kvm module is available and loaded. Test this
> + * and retun success when trace point kvm_s390_create_vm
> + * exists. Otherwise this test always fails.
> + */
> +static bool kvm_s390_create_vm_valid(void)
> +{
> +	char *eventfile;
> +	bool rc = false;
> +
> +	eventfile = get_events_file("kvm-s390");
> +
> +	if (eventfile) {
> +		DIR *mydir = opendir(eventfile);
> +
> +		if (mydir) {
> +			rc = true;
> +			closedir(mydir);
> +		}
> +		put_events_file(eventfile);
> +	}
> +
> +	return rc;
> +}
> +#endif
> +
>  static int test__checkevent_tracepoint(struct perf_evlist *evlist)
>  {
>  	struct perf_evsel *evsel = perf_evlist__first(evlist);
> @@ -1642,6 +1668,7 @@ static struct evlist_test test__events[] = {
>  	{
>  		.name  = "kvm-s390:kvm_s390_create_vm",
>  		.check = test__checkevent_tracepoint,
> +		.valid = kvm_s390_create_vm_valid,
>  		.id    = 100,
>  	},
>  #endif
> -- 
> 2.21.0

-- 

- Arnaldo
