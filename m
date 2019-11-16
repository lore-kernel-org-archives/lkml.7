Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E32C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 07:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3EE20723
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 07:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qWPCg5Bu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfKPHwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 02:52:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51354 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfKPHwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 02:52:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id q70so11844138wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 23:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2MJkGFAo2CploiZjzVMIvSSTxLbNNOQ2kJ94c7MrbvQ=;
        b=qWPCg5BumT1Hbc7j6nLO10sM8hrkENDcXbA2pqixSQKBLNV+oRCDyBt8yH3YtcFsPf
         aEl6G+Ww2FAcPv4dEhzPDUO0qR4V5LT3JnTpEtwQQHiwlkQGq/aXf8/eCL3LaaW11p+v
         WRxJxZY1qMEMgIsqZ9QWdA9RZjp+wQsZ594CcA7/Zb45ZdfdQ/9SZB9DFYitsEyqH4T+
         UDMgnkmqQuHZATfGnhxdNVXuItAzBtjOeM/Tfu8aDB/1ddOvWNe3KRwWSkEMUvST3DlC
         NoltePsWcmb9AvW4p2bTfnhAKCFUvqU8EBZDqUdThqP7nVWyU30K7qv1Bg6ZpaEnttMg
         YrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2MJkGFAo2CploiZjzVMIvSSTxLbNNOQ2kJ94c7MrbvQ=;
        b=gmzZsjcoGGafjWiRe9iE2EGCpABFTz+M34RXL7kJLNzU2oPX81P03f13YHvCrq7Q6+
         ZYDH6PILhLOr83DcfGYpnl3jEYVQQszqPuN9CU8NR4UbUKX9sOj4VzsAao8bA/QWiDhA
         iBO9XDf+cNUq91Jl8kQPJv36Vyl1UcuFMZSqYlAHPoI/aToYogkH8sjed/j2IWQ9lOoi
         ZNkH0hWGb4vApRMrRCll+lVvN7m4H8RxmQVXftY7P+1aigK01YNBxrAABDsPzjgjEHVa
         Z1eJqbIgaP43/Qa9dePHysj4S47Fxnq8ENlto/rOWXQEwB17W4vybb0uJBclgFIu9+z5
         ckCA==
X-Gm-Message-State: APjAAAVYrBsJtCrTlbvfWapiZ5U0XEbvm4boCAoFC97vbVo8i7A65AdV
        nsZ5dIZi+P/22738AomvOcEDbYypSeGWVZA4boJvrg==
X-Google-Smtp-Source: APXvYqzQIyjsfoLiraXOh4QeOG0tTjmTBM2OXTT8L+tVLBM9jZONnR13Ut11tGfISahFI0HlkMN7XNcVR5mVKhG2vv0=
X-Received: by 2002:a1c:6641:: with SMTP id a62mr18481618wmc.54.1573890754483;
 Fri, 15 Nov 2019 23:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20191107222315.GA7261@kernel.org> <20191108181533.222053-1-irogers@google.com>
 <20191111120230.GD9791@krava>
In-Reply-To: <20191111120230.GD9791@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 15 Nov 2019 23:52:23 -0800
Message-ID: <CAP-5=fVA6y-osb6EHAU50FybpOeFC6x0e7QLk2XmyMfQPnAWDQ@mail.gmail.com>
Subject: Re: [PATCH] perf tools: report initial event parsing error
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 4:02 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Nov 08, 2019 at 10:15:33AM -0800, Ian Rogers wrote:
> > Record the first event parsing error and report. Implementing feedback
> > from Jiri Olsa:
> > https://lkml.org/lkml/2019/10/28/680
> >
> > An example error is:
> >
> > $ tools/perf/perf stat -e c/c/
> > WARNING: multiple event parsing errors
> > event syntax error: 'c/c/'
> >                        \___ unknown term
> >
> > valid terms: event,filter_rem,filter_opc0,edge,filter_isoc,filter_tid,filter_loc,filter_nc,inv,umask,filter_opc1,tid_en,thresh,filter_all_op,filter_not_nm,filter_state,filter_nm,config,config1,config2,name,period,percore
> >
> > Initial error:
> > event syntax error: 'c/c/'
> >                     \___ Cannot find PMU `c'. Missing kernel support?
>
> not sure where this got lost or if it was there before,
> but the index should point to zero to have the 'arrow' aligned

This happened in:
448d732cefb3 perf parse: Add parse events handle error
When the code wasn't clear on the value of idx it was set to -1.
Fixed in v2 but perhaps there are other instances from 448d732cefb3
that should be addressed.

Thanks,
Ian

> jirka
>
>
> ---
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index a369bbc289b2..6bae9d6edc12 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1366,7 +1366,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>                 if (asprintf(&err_str,
>                                 "Cannot find PMU `%s'. Missing kernel support?",
>                                 name) >= 0)
> -                       parse_events__handle_error(err, -1, err_str, NULL);
> +                       parse_events__handle_error(err, 0, err_str, NULL);
>                 return -EINVAL;
>         }
>
>
