Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1C3C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3B82245C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg/9+xhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfLEMdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 07:33:07 -0500
Received: from mail-vs1-f53.google.com ([209.85.217.53]:34299 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbfLEMdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:33:07 -0500
Received: by mail-vs1-f53.google.com with SMTP id g15so2224073vsf.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 04:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WHqFzyKAvPkwY+9Y4I60hULDel9sSa/LgEW57iRWbpc=;
        b=gg/9+xhL0MpW2LXnuzsfg6y53YMto3XzzgVWw1lVOhrnhIjfonFgz+VpBIu/5KtKM4
         /qZWHZAwfcxA+RXxTXQjKpuNeLwwQ9ae5SgNGkTjQjaGgLMVXan6J15NWUqmYgTryuzA
         RG+mzmkGQ43o1wNqC0gHr90T1idocUc1ADH465h/F1fuFRMuhTyULfkl6hmbyvs2uK+1
         3Zcsc+1nt3kr2VpAXZW1lYYnbqn2uj4y1Y72i0SyQxE8B4IpyWuxMZHoI3jcsgx7jn1G
         dbqSKpmp1PhtjjeJU7QkKPpC/rJW+n6K9mokbOK7p/evkCOac75txYT88i8hbOT9CL3M
         Z1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WHqFzyKAvPkwY+9Y4I60hULDel9sSa/LgEW57iRWbpc=;
        b=ufNOIRxs9wcUeN67JG+vDow6BfGul5Q5tmwGqusnxMP7HFHhQ6BGWEi8+G3jtHgw73
         GLuSTJUWvJemn/6Ud8dSqpOWqcwy/AfpGRu3esDrOZf1nYwjFTqNNvp0E3c7ZplCWoDq
         pG2tHzX/N5rojVS7pg17Tr8wNJicMMBI7AKdodmQis7l9ZQlLiuLjrNFqIEj2D5TaxGk
         +MtcOK6CaUnqRKXDnvy05EFhiFilp/cSfd5fY3ZJaRZnQwDGJjnQFa+6s4HbhD+Gaw2f
         stJgFDvJ23O725sh/9myEs/dI7X0kTO2YRjSNiDSihHO1lQyZ6ZVFXWiyraSNsSFTJO9
         0XAg==
X-Gm-Message-State: APjAAAUz9y8T/1Bh056mRGeScN4weaxD7r0PYLF97wtm8KTjitZlsl76
        UNvvvaLy07ANhnvQHYBHuAQ=
X-Google-Smtp-Source: APXvYqwiy44bQJQ1CHWFs1fmXb6O+LcXJnVtByn/NZE4JkJ9N5XGRx0xWLNh1WafjXc2VM9vAhcGDQ==
X-Received: by 2002:a05:6102:243b:: with SMTP id l27mr5339810vsi.230.1575549185367;
        Thu, 05 Dec 2019 04:33:05 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id a6sm3326165vsr.9.2019.12.05.04.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 04:33:04 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 28367405E2; Thu,  5 Dec 2019 09:33:02 -0300 (-03)
Date:   Thu, 5 Dec 2019 09:33:02 -0300
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, sashal@kernel.org,
        Kenton Varda <kenton@cloudflare.com>
Subject: Re: perf not picking up symbols for namespaced processes
Message-ID: <20191205123302.GA25750@kernel.org>
References: <CABWYdi1ZKR=jmKnjoJTik08Q9uJBvyZ4W0C29iPiUJ5ef1obvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABWYdi1ZKR=jmKnjoJTik08Q9uJBvyZ4W0C29iPiUJ5ef1obvw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 04, 2019 at 07:46:10PM -0800, Ivan Babrou escreveu:
> We have a service that forks a child process in a namespace-based
> sandbox where the mount namespace is intentionally designed to reflect
> a totally empty filesystem. Our use case is very similar to Chrome's
> sandbox, for example, but on a server. Within the sandbox, not even
> the service's own binary is present in the mount namespace.
> 
> Process tree looks like this:
> 
> $ sudo pstree -psc 63989
> edgeworker(63989)─┬─edgeworker/sbox(255716)─┬─edgeworker/zygt(255718)
>                    │                         ├─{edgeworker/sbox}(255719)
>                    │                         ├─{edgeworker/sbox}(255720)
>                    │                         ├─{edgeworker/sbox}(255721)
>                    ├─edgeworker/stry(5803)
>                    ├─edgeworker/stry(63990)
>                    ├─edgeworker/stry(106218)
>                    ├─edgeworker/stry(191905)
>                    ├─edgeworker/stry(255695)
>                    ├─edgeworker/supr(255717)
> 
> Here sbox processes do actual work living in an empty mount namespaces
> and stry is a helper process for error reporting. All tasks come from
> the same binary that lives in the root mount namespace, launched by
> systemd.
> 
> During "perf script" run on a trace obtained from the system there are
> these possible outcomes:
> 
> 1. The first pid to be processed is a non-namespaced helper and
> symbols are present.
> 2. The first pid is not found and symbols are present.
> 3. The first pid is a sandboxed task and symbols are missing.
> 
> Symbols are missing, because "perf script" tries to jump into an empty
> sandbox and find a binary there, when in fact it lives outside:
> 
> getcwd("/state/home/ivan", 4096)        = 17
> open("/proc/self/ns/mnt", O_RDONLY)     = 5
> open("/proc/255719/ns/mnt", O_RDONLY)   = 6
> setns(6, CLONE_NEWNS)                   = 0
> stat("/usr/local/bin/edgeworker", 0x7ffedb9b3ca0) = -1 ENOENT (No such
> file or directory)
> 
> In the second outcome we don't have a PID to figure out the namespace
> to jump into, so this doesn't happen. It's a good fallback, but it was
> a bit confusing during debugging.
> 
> It's not entirely clear to me why sometimes a helper PID is picked,
> even though it's not the first sample in the recorded trace (at least
> not in the output). This happens deterministically, or at least
> appears so. In my process tree it's 255695.
> 
> I think perf should try to fallback to the default namespace to look
> up symbols if they are not found inside to cover our case. Relevant
> piece of logic is here:

That should work for your use case, as you're sure that looking up by
pathname only will find, outside the namespace, the binary you want.

Even with pathname based looukups being fragile, it works for your
usecase, so please consider providing a patch for such fallback,
together with a pr_debug() or even pr_warning() if this don't get too
noisy, to warn the user.

- Arnaldo
 
> * https://elixir.free-electrons.com/linux/v5.4.1/source/tools/perf/util/dso.c#L520

-- 

- Arnaldo
