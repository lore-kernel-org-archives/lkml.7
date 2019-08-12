Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CECC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7888320679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9t3qgma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfHLUQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:16:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39308 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfHLUQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:16:05 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9so104097493qtu.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5g7jjLU4VGzMwlr574F/Nchx2Tl+Lxpx7Ov3R6T4BKE=;
        b=i9t3qgmaJCsaeHHeK2nlpOJj47Gwd9m1UtLytdg5UDY0zjcoorUwSZzu/yRhxvQo5M
         iHJDjnl6Uunpv2ZEKwV3gFZqlqE2XptWcCehbcGKTyF1AHaunbVt/tFROPDUB5H4MgLQ
         EO8BP/vurIIEXahX3IsBfoUUNK5Ce3IuHIaRUIZAzBAalIMY3BBRQFvX3fF+LEjCo69f
         yeJcwAFMS/17W09iUh2XNBJdTXCsUJAeIeeSOMBbQ6yMM8p9IGzmTQTHk3HmlcT4RfMJ
         2yNc5iEA73WZ8wQm/eLmQ3CyVFFFM2ZGMR2wUf29PfENq14xR38xrnntu93VRYxyZC+W
         0fUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5g7jjLU4VGzMwlr574F/Nchx2Tl+Lxpx7Ov3R6T4BKE=;
        b=kLSmaZUOt8m6rQzEY2C43hy5UjO7K/6AfC9XBHTps3JP922d+UelDA1DQWWSJ74VDd
         Un8M+OyA2UwhDAlitTYRZy6NqCo0bBJz6vqTr5xH9c3iraTYzDpl/3lXsppWFYgkjrXu
         WO67b/w4nfol01YYnpDNLRIi4QoX1vJB6WDIB5M69R4L3Q2smd7p2C0cAWn4lpW5KXEO
         It09Tz2k7GeZOX910zu5hUVWtRor9JligRsHKxUvjNYZhoDY3ZwPCkGXqw/mnY2tGcLG
         9WgSY7MFyUE/gYKNxl9F5W1RcWGDbw5vnE+dNzTZsdv7ITHTh5mJmz+8lWTOGdC32B4+
         65tQ==
X-Gm-Message-State: APjAAAWvrFmbA2GMPp17CdKPONG2IeNhl8vmqjqaqcq92MHzhef1H3IN
        cN4j7c4e6T2N+uU/Frw0Eyo=
X-Google-Smtp-Source: APXvYqxnYsfb4ZaAjNL+kcKuGEEEzX+ONF6YLS/dutUUvdL+dbcjtQNbcaKJzeXf7sJ8XoW/zFLdBw==
X-Received: by 2002:ac8:296c:: with SMTP id z41mr5813520qtz.307.1565640963984;
        Mon, 12 Aug 2019 13:16:03 -0700 (PDT)
Received: from quaco.ghostprotocols.net (187-26-98-68.3g.claro.net.br. [187.26.98.68])
        by smtp.gmail.com with ESMTPSA id d123sm49214177qkb.94.2019.08.12.13.16.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 13:16:01 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7243E40340; Mon, 12 Aug 2019 17:15:57 -0300 (-03)
Date:   Mon, 12 Aug 2019 17:15:57 -0300
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
Message-ID: <20190812201557.GF9280@kernel.org>
References: <cover.1565188228.git.ilubashe@akamai.com>
 <ad56df5452eeafb99dda9fc3d30f0f487aace503.1565188228.git.ilubashe@akamai.com>
 <20190812200134.GE9280@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812200134.GE9280@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 12, 2019 at 05:01:34PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Aug 07, 2019 at 10:44:15AM -0400, Igor Lubashev escreveu:
> > +++ b/tools/perf/util/evsel.c
> > @@ -279,7 +279,7 @@ struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
>   
> >  static bool perf_event_can_profile_kernel(void)
> >  {
> > -	return geteuid() == 0 || perf_event_paranoid() == -1;
> > +	return perf_event_paranoid_check(-1);
> >  }
> 
> While looking at your changes I think the pre-existing code is wrong,
> i.e. the check in sys_perf_event_open(), in the kernel is:
> 
>         if (!attr.exclude_kernel) {
>                 if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
>                         return -EACCES;
>         }
> 
> And:
> 
> static inline bool perf_paranoid_kernel(void)
> {
>         return sysctl_perf_event_paranoid > 1;
> }
> 
> So we have to change that perf_event_paranoit_check(-1) to pass 1
> instead?
> 
> bool perf_event_paranoid_check(int max_level)
> {
>         return perf_cap__capable(CAP_SYS_ADMIN) ||
>                         perf_event_paranoid() <= max_level;
> }
> 
> Also you defined perf_cap__capable(anything) as:
> 
> #ifdef HAVE_LIBCAP_SUPPORT
> 
> #include <sys/capability.h>
> 
> bool perf_cap__capable(cap_value_t cap);
>         
> #else   
> 
> static inline bool perf_cap__capable(int cap __maybe_unused)
> {               
>         return false;
> }       
>                 
> #endif /* HAVE_LIBCAP_SUPPORT */
> 
> 
> I think we should have:
> 
> #else
> 
> static inline bool perf_cap__capable(int cap __maybe_unused)
> {
>         return geteuid() == 0;
> }
> 
> #endif /* HAVE_LIBCAP_SUPPORT */
> 
> Right?
> 
> So I am removing the introduction of perf_cap__capable() from the first
> patch you sent, leaving it with _only_ the feature detection part, using
> that feature detection to do anything is then moved to a separate patch,
> after we finish this discussion about what we should fallback to when
> libcap-devel isn't available, i.e. we should use the previous checks,
> etc.

So, please take a look at the tmp.perf/cap branch in my git repo:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/cap

I split the patch and made perf_cap__capable() fallback to 'return
geteuid() == 0;' when libcap-devel isn't available, i.e. keep the
checks made prior to your patchset.

Jiri, can I keep your Acked-by?

- Arnaldo
