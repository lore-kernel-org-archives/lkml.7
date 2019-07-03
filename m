Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B518C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744BE2080C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY5Cz6Dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfGCSxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:53:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34581 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCSxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:53:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id m29so2883090qtu.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 11:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ag64teZVzLgzhFHw838DwskIKJMH8sytfjo0gih9s74=;
        b=lY5Cz6Dwq3tuK627jXknuGB72hyzdZLRX32qIaFinH3OPVJzGvtrjp4cMSmkZvLt1o
         b9BPXYPD1kpfRx7y35XrfWBXCNXZR5fPxtIA8Zqun6KvZAiD0yri84rdvhdkrPbLyANK
         oEMuPtdMuC9EdgUWlMi6X1OL1JrC+T9BEzUE1CF9KWi0MZtEcYtF1cNuzwGAqJjewnFm
         KwI69MEQ1gh3BPL73rOiqqyD6h6zzYWxNgfnevPYOEtMv7h0n7pKeXyyIO7Zw2VJtoyv
         s7wE4Ek1bd9rzbJCuMq8oECimJKx0sT5kzk/Yqd34qRi/Y+UZrfIdQMYnarZ4UAdnrd1
         3s5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ag64teZVzLgzhFHw838DwskIKJMH8sytfjo0gih9s74=;
        b=InPmHUCr515HsgJoN7otxtBqWZv0UXYW+/NIrz23WgCXmKRpfIQ0FCZu+TfTEQ1Tff
         rYyWXIwJB/IklNfgaPkhA0fmXdSGa2DHqwCv3rDLov0PdTemsd8TqtOCI4vXONxOvSxK
         o/s6xJ2eE9EZ4qGIhUdTzabaK/DwSujceXNrWOqCkepvajcguBN6E7iEkFj3TeIPJzhu
         NYrSvMDiHxMnUolrzZV+lZBeOquxd5MOw06iQXMogHvJR1teU9AvkSfcsIL6GgGfbMA3
         DgEL7VwfVM/KAmhK6N42611a4AuEalwAIzmU/dtRt4QdNA0V4fKZxYBxozY5iNaaG8tl
         awPQ==
X-Gm-Message-State: APjAAAU48etXD7VrgeIseyKnU4D/t7+AdNYZNhUW1ZNA7CZ/wceWZQGl
        24oNjd6NYRIS8LOL6dt2MweFUcaGbh8=
X-Google-Smtp-Source: APXvYqxjDVXPEEZJiTxktdMBN6QlLesr3wBNxSdPVRUUQsrXa7K2UFXmD+asUP6taPYUEpAWsk/2cA==
X-Received: by 2002:a0c:983b:: with SMTP id c56mr34311430qvd.131.1562180008940;
        Wed, 03 Jul 2019 11:53:28 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.209.182])
        by smtp.gmail.com with ESMTPSA id d123sm1309369qkb.94.2019.07.03.11.53.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 11:53:28 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7149D41153; Wed,  3 Jul 2019 15:43:46 -0300 (-03)
Date:   Wed, 3 Jul 2019 15:43:46 -0300
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 04/11] perf annotate: Smatch: Fix dereferencing freed
 memory
Message-ID: <20190703184346.GE10740@kernel.org>
References: <20190702103420.27540-1-leo.yan@linaro.org>
 <20190702103420.27540-5-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702103420.27540-5-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 02, 2019 at 06:34:13PM +0800, Leo Yan escreveu:
> Based on the following report from Smatch, fix the potential
> dereferencing freed memory check.
> 
>   tools/perf/util/annotate.c:1125
>   disasm_line__parse() error: dereferencing freed memory 'namep'
> 
> tools/perf/util/annotate.c
> 1100 static int disasm_line__parse(char *line, const char **namep, char **rawp)
> 1101 {
> 1102         char tmp, *name = ltrim(line);
> 
> [...]
> 
> 1114         *namep = strdup(name);
> 1115
> 1116         if (*namep == NULL)
> 1117                 goto out_free_name;
> 
> [...]
> 
> 1124 out_free_name:
> 1125         free((void *)namep);
>                           ^^^^^
> 1126         *namep = NULL;
>              ^^^^^^
> 1127         return -1;
> 1128 }
> 
> If strdup() fails to allocate memory space for *namep, we don't need to
> free memory with pointer 'namep', which is resident in data structure
> disasm_line::ins::name; and *namep is NULL pointer for this failure, so
> it's pointless to assign NULL to *namep again.

Applied, with this extra comment:


Committer note:

Freeing namep, which is the address of the first entry of the 'struct
ins' that is the first member of struct disasm_line would in fact free
that disasm_line instance, if it was allocated via malloc/calloc, which,
later, would a dereference of freed memory.
