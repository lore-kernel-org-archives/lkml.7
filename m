Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC8ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AAF222CE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H47/Ecos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395383AbfJYOsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:48:43 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41737 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394081AbfJYOsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:48:43 -0400
Received: by mail-qk1-f194.google.com with SMTP id p10so1986260qkg.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B+8577nBMSQJR/EYe2buoxSL4ZeEmNmmcsCqbW3W0c8=;
        b=H47/EcosMvPU0lLjlcX+muD7XU/o3Jr3FXaLBMH9IIFDm6eJjQ9o8aNaPjcVnxs5Cz
         EMTUfeRSxGjqKYOzhl9tnHnmHl36xVt5OQV/1+lHp70gQSsfNwDJWr4e3dQ7K/pZJCB1
         3hD1tu4rfT/RXm07HX2TWgnpu1MRkhbD0Q6LUO/yLkcn1m0VUcGZtpO3jjCghaN8t3qQ
         4CcJ4vLoO71ShxaAfIcguWsANAYT8OwGq08Whhxsc7FUt/8vKLlfrc+f02vkBlBPMH9Z
         0GE7MWMRtkRL3rfkv7/ObgZl/LtbvY2XahzbFU7X/XQ56QTl+88r/A80RjqmyABjyP18
         O0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B+8577nBMSQJR/EYe2buoxSL4ZeEmNmmcsCqbW3W0c8=;
        b=i4V31HCfdMJjGnk0cjjZHhJbr8ssauGg4OqGDKxXRQ3MTc3hYwpj8i0WAoDFG+WBuz
         Qq1/cxtlcgtSodJmcJdk9QBemhpne9ivMxBlMOa70J2b94rdAXnLJX0dIMyCFR7Uf8zU
         ZskBynZ4M9liGAjDXeOJI9lDi1hsxjjqm/xMwIfrb5mUz1UPJ+qePMmVqSIDYeIO5jUf
         Jdbn9eS4RO0KnyTeRtSIV9scCPLf18M3I1vWPP023nuFddbupsp8IjgwrbLC+YCZLz8t
         z2qtXxEOaTcBsmmwtTc7+uNyH5+8hCYYMhG2MpeVDw8LA3O24MkI3gqHRv3duvZ6K28X
         dreA==
X-Gm-Message-State: APjAAAU+DBqY8pd8rI+UhhzB/js0GjGRxD9pXraoNsieAm8NpmoqTNk4
        ML2GFyfgNyNmsPwTJvDMWZc=
X-Google-Smtp-Source: APXvYqy+M3qHU/6190GEqoBi4zu8vVbRlUpcu0C4PlNJG85lqixUEXAw06UWmn/Xts+FJ7wmeNHMHg==
X-Received: by 2002:a05:620a:200f:: with SMTP id c15mr2919044qka.263.1572014922423;
        Fri, 25 Oct 2019 07:48:42 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id w131sm1210207qka.85.2019.10.25.07.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 07:48:41 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8577A41199; Fri, 25 Oct 2019 11:48:39 -0300 (-03)
Date:   Fri, 25 Oct 2019 11:48:39 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 5/6] perf auxtrace: Add auxtrace_cache__remove()
Message-ID: <20191025144839.GA24735@kernel.org>
References: <20191025130000.13032-1-adrian.hunter@intel.com>
 <20191025130000.13032-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025130000.13032-6-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 25, 2019 at 03:59:59PM +0300, Adrian Hunter escreveu:
> Add auxtrace_cache__remove(). Intel PT uses an auxtrace_cache to store the
> results of code-walking, so that the same block of instructions does not
> have to be decoded repeatedly. However, when there are text poke events,
> the associated cache entries need to be removed.

Applied this one as it is just leg work for the rest, that I'll wait a
bit for comments.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/auxtrace.c | 28 ++++++++++++++++++++++++++++
>  tools/perf/util/auxtrace.h |  1 +
>  2 files changed, 29 insertions(+)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 8470dfe9fe97..c555c3ccd79d 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -1457,6 +1457,34 @@ int auxtrace_cache__add(struct auxtrace_cache *c, u32 key,
>  	return 0;
>  }
>  
> +static struct auxtrace_cache_entry *auxtrace_cache__rm(struct auxtrace_cache *c,
> +						       u32 key)
> +{
> +	struct auxtrace_cache_entry *entry;
> +	struct hlist_head *hlist;
> +	struct hlist_node *n;
> +
> +	if (!c)
> +		return NULL;
> +
> +	hlist = &c->hashtable[hash_32(key, c->bits)];
> +	hlist_for_each_entry_safe(entry, n, hlist, hash) {
> +		if (entry->key == key) {
> +			hlist_del(&entry->hash);
> +			return entry;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +void auxtrace_cache__remove(struct auxtrace_cache *c, u32 key)
> +{
> +	struct auxtrace_cache_entry *entry = auxtrace_cache__rm(c, key);
> +
> +	auxtrace_cache__free_entry(c, entry);
> +}
> +
>  void *auxtrace_cache__lookup(struct auxtrace_cache *c, u32 key)
>  {
>  	struct auxtrace_cache_entry *entry;
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index f201f36bc35f..3f4aa5427d76 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -489,6 +489,7 @@ void *auxtrace_cache__alloc_entry(struct auxtrace_cache *c);
>  void auxtrace_cache__free_entry(struct auxtrace_cache *c, void *entry);
>  int auxtrace_cache__add(struct auxtrace_cache *c, u32 key,
>  			struct auxtrace_cache_entry *entry);
> +void auxtrace_cache__remove(struct auxtrace_cache *c, u32 key);
>  void *auxtrace_cache__lookup(struct auxtrace_cache *c, u32 key);
>  
>  struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
> -- 
> 2.17.1

-- 

- Arnaldo
