Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9243BC41514
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A29B22CB8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="X3hvdlGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfGZJgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:36:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41171 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZJgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:36:12 -0400
Received: by mail-lf1-f65.google.com with SMTP id 62so31755831lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 02:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cCNyX4EgHWf9DOLoNQ+h4Aw5GdNoi9VaZ75yal80M50=;
        b=X3hvdlGJC6xNYRLjQ1Sa8tEr/Ahcigk5o+UV3hCYNk5lCfwGNu/wPuAVlnJqXAxvxd
         hH6WHLD6i1nB+N2wO+xjpt0UI0XEzzBtl4tgSpXcNC9ex4T5oIN3qx/SzgJW7r5sg8Vr
         iT14ncdUJ8a7eb/cGraQgFwKdukyK6FYPRMLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cCNyX4EgHWf9DOLoNQ+h4Aw5GdNoi9VaZ75yal80M50=;
        b=kJlHFt+UNJz0pSzCpW2S62eqxW0TZwHgJt1V4675duhUJ4jljwX6iHxmF3AQpmEOx5
         kuxGrGNUpGs9LzK/yWJqPZ4jk6mKBG0aAfSia5TYrfpFQvwJ4TnkZKguSelWGCmYVNHN
         iG8QwUI7K5gHvSPxv5LHEGoo3K7+9MLpL3Snr7Bpi/ABFHdvxckHxySlkpsz+Zvy/YyH
         wfoMoJWfXW3Nm+3hPKuiSx9/8h9SRE+aKPdob2vmwz3AhfU9ojLJ9STls/qE7mJE7vlF
         YkbbQ+shRrZV1YXI44Khm1LjmyC0eJXaxa86Hs+5JgBzku7vEPwRGwHKmbAjvcgcUh/r
         9IDw==
X-Gm-Message-State: APjAAAWHalILUU/ipK3KR40HQOKQEXqw5M7WyYYxKTrd2djfN5tmw80r
        43Hwu9lqIeGPbDzKjvAhbjU=
X-Google-Smtp-Source: APXvYqwCo6Oe2SRXCiD3OqFxvFL5a4Y4zF/v0KyJ4Qkc7UkchhOvJ0pEiUiEr8ZRykwx46SVLNEesA==
X-Received: by 2002:a05:6512:48f:: with SMTP id v15mr791427lfq.37.1564133770570;
        Fri, 26 Jul 2019 02:36:10 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h129sm8193919lfd.74.2019.07.26.02.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 02:36:10 -0700 (PDT)
Subject: Re: [PATCH 02/10] mm/page_alloc: use unsigned int for "order" in
 __rmqueue_fallback()
To:     Pengfei Li <lpf.vector@gmail.com>, akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@suse.com, vbabka@suse.cz,
        cai@lca.pw, aryabinin@virtuozzo.com, osalvador@suse.de,
        rostedt@goodmis.org, mingo@redhat.com,
        pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20190725184253.21160-1-lpf.vector@gmail.com>
 <20190725184253.21160-3-lpf.vector@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <ac59714d-74d6-820c-37ea-5bf62cfc33a8@rasmusvillemoes.dk>
Date:   Fri, 26 Jul 2019 11:36:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725184253.21160-3-lpf.vector@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2019 20.42, Pengfei Li wrote:
> Because "order" will never be negative in __rmqueue_fallback(),
> so just make "order" unsigned int.
> And modify trace_mm_page_alloc_extfrag() accordingly.
> 

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 75c18f4fd66a..1432cbcd87cd 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2631,8 +2631,8 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
>   * condition simpler.
>   */
>  static __always_inline bool
> -__rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
> -						unsigned int alloc_flags)
> +__rmqueue_fallback(struct zone *zone, unsigned int order,
> +		int start_migratetype, unsigned int alloc_flags)
>  {

Please read the last paragraph of the comment above this function, run
git blame to figure out when that was introduced, and then read the full
commit description. Here be dragons. At the very least, this patch is
wrong in that it makes that comment inaccurate.

Rasmus
