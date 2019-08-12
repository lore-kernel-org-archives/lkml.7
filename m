Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40CAC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7751E206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+ABqL6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfHLUBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:01:41 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41740 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfHLUBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:01:40 -0400
Received: by mail-qk1-f194.google.com with SMTP id g17so7239917qkk.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 13:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mzJd9LfyI6OyvkYy9nxABgF/o+uPg/L4uhRhKYYKXK8=;
        b=T+ABqL6cQJgPOi3/KuUg8dw9+u7TLkZl7ie+BEbOpts6p3A3W9mVODE3y46Nqai7kR
         X/Y8oXA6FHUXaU21ggo2fHUEnuLty4utTuLosncCtowhrw421B8HtDtcDNedK5VJw8WB
         CQoecsb0gLNIGPdcpTDScYJ8D/QGb34a380s3+/5r482y8yLTaGd81SuOLMnBErDd0lq
         w2RybkThge83juCWZ0bWRj7Wn3+CMhUQWzFGmDjj7kM0pA7ENhgnqUxs39oUbhqAYfXn
         coZLZzzxxGqqjw+5LEXeD+qn/tpmYXrP9UTfyDJjgRRPGvPNmfqmxkeUTvKVddz/vGNA
         uHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mzJd9LfyI6OyvkYy9nxABgF/o+uPg/L4uhRhKYYKXK8=;
        b=l6bPVhFUrxwFY6PlxOlcdO4/D1JdvFetETt1KD88HWUEIts/wkj3xWo94XAumtyoQS
         zf7OvNh9pVEB7YeQil8xwPpchuxwqWx1La3s6Ws6JCx4+aUFG7C9GmuOMCP6EQ2n3tAQ
         woWyBzTOggGVu5ehoqYC4Bj2dI8CWbk5t1SNM3RcUhBgCxC+7920vXmluc/5nOH/ViRW
         DYUujAYQdyEdvdPdBDiV1A7Id7g8TvOJz6LXZ6wxShNcS9QitvyVtXOAhnx2/P/c9/4s
         WRcoMYtlGfDv/NY4yQP/fFFEqYBA8qMOeCV+St0qZfXiEwR0f2JV6TQKt4DNf9V7gvwk
         jNSw==
X-Gm-Message-State: APjAAAX/WE3sEPxOxtQO3TF6WpkOoBePCezcthAM/Ce1nM4hVn4h97l+
        yRJXx1SA8iFz7YuOwmwI/aM=
X-Google-Smtp-Source: APXvYqy5EUKQpFOfiq5JMIN+wnSVRvYvH6S2RbGmJ5VoQBUBEx4uyhTG//pEJ9deZvUF58j6IEtE3w==
X-Received: by 2002:ae9:f801:: with SMTP id x1mr28277094qkh.242.1565640099542;
        Mon, 12 Aug 2019 13:01:39 -0700 (PDT)
Received: from quaco.ghostprotocols.net (187-26-98-68.3g.claro.net.br. [187.26.98.68])
        by smtp.gmail.com with ESMTPSA id f22sm5634753qkh.55.2019.08.12.13.01.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 13:01:38 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D585740340; Mon, 12 Aug 2019 17:01:34 -0300 (-03)
Date:   Mon, 12 Aug 2019 17:01:34 -0300
To:     Igor Lubashev <ilubashe@akamai.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH v3 2/4] perf: Use CAP_SYS_ADMIN with perf_event_paranoid
 checks
Message-ID: <20190812200134.GE9280@kernel.org>
References: <cover.1565188228.git.ilubashe@akamai.com>
 <ad56df5452eeafb99dda9fc3d30f0f487aace503.1565188228.git.ilubashe@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad56df5452eeafb99dda9fc3d30f0f487aace503.1565188228.git.ilubashe@akamai.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 07, 2019 at 10:44:15AM -0400, Igor Lubashev escreveu:
> +++ b/tools/perf/util/evsel.c
> @@ -279,7 +279,7 @@ struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
  
>  static bool perf_event_can_profile_kernel(void)
>  {
> -	return geteuid() == 0 || perf_event_paranoid() == -1;
> +	return perf_event_paranoid_check(-1);
>  }

While looking at your changes I think the pre-existing code is wrong,
i.e. the check in sys_perf_event_open(), in the kernel is:

        if (!attr.exclude_kernel) {
                if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
                        return -EACCES;
        }

And:

static inline bool perf_paranoid_kernel(void)
{
        return sysctl_perf_event_paranoid > 1;
}

So we have to change that perf_event_paranoit_check(-1) to pass 1
instead?

bool perf_event_paranoid_check(int max_level)
{
        return perf_cap__capable(CAP_SYS_ADMIN) ||
                        perf_event_paranoid() <= max_level;
}

Also you defined perf_cap__capable(anything) as:

#ifdef HAVE_LIBCAP_SUPPORT

#include <sys/capability.h>

bool perf_cap__capable(cap_value_t cap);
        
#else   

static inline bool perf_cap__capable(int cap __maybe_unused)
{               
        return false;
}       
                
#endif /* HAVE_LIBCAP_SUPPORT */


I think we should have:

#else

static inline bool perf_cap__capable(int cap __maybe_unused)
{
        return geteuid() == 0;
}

#endif /* HAVE_LIBCAP_SUPPORT */

Right?

So I am removing the introduction of perf_cap__capable() from the first
patch you sent, leaving it with _only_ the feature detection part, using
that feature detection to do anything is then moved to a separate patch,
after we finish this discussion about what we should fallback to when
libcap-devel isn't available, i.e. we should use the previous checks,
etc.

- Arnaldo
