Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE451C0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 03:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8CB2083B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 03:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="K+lwpCzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfGGDoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 23:44:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42321 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfGGDoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 23:44:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so5943004pff.9
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 20:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OGUlAsCzUJoVYKt86uXjpY15AX803LKAiJ+hKkbXiTw=;
        b=K+lwpCzMTYmA/zgfuwuOhNyywUhdndxBklkJQFtamOnGFQgBymUzxtd+ZnZnC34BQn
         HpGdYR+MaSj86LwaPTsUFPSAqNaYztJBf828LhLgpXVLKiKUUuWQamnohQ954phD5PBU
         sTku+RMuT/x6xZEO3yziQLmLGyS4esSqrZF7Oiga0E/SOHjHTJ5ukilmpeOrzMgx9tSs
         t50CZw+BoHCupXPQ5Q5gBEgs5P8+Ya7RGFEwR/XFZhXVV1N85vGgWLnCs5RwRQ/J8BKs
         x7wJ3LT+Y2Qq+UcFDRg2fuFRWWoe1SYidyJtsN483bKk9DR7iwIEGdlu8E/eXhf7gWlM
         qipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OGUlAsCzUJoVYKt86uXjpY15AX803LKAiJ+hKkbXiTw=;
        b=GOyPsLUKfso8UTLKg4YYYP1c6MCPOOjBljVFaCfsvHv/ODCG4LLAjK0XxO4DO5KBdL
         AoFvAjfOOxVhBxj93EgqrbZpuGKsZy9jTDi3B+Q3IoMnMGEC3C/QLCETgQ2nybkDB1uH
         1EE4Y5V+ltBLPgLuldcEofQnZKFKDfrtJQPMt/RmiJZypKO0CxrDUVL8GjxzhCCLZdHS
         3sLsj614OMu93hPvjEc6u1jmD/CMhAJzQe7+5NKM/n0PL7f5QNKPQUsbV5NaiM/BNbW0
         CGF9gRPT5xr0HPk2LRI4bUeK3fzRObxsdBPhfBS92HrntdholvB/LqB+ptT2cRpwlZa5
         akZQ==
X-Gm-Message-State: APjAAAVwwrrt4DKcTi8ZF5lyv4jr9FqIFU+pvc8d1l/GQXegWrF4HttP
        EfbCvRkd8plV18HmoxnEEFAVGA==
X-Google-Smtp-Source: APXvYqzq+ioM2N+GO2roeqRon6lxBnQ4VB+VqtWQKeXqt+nD10mJMFHAJ+8LwRaXfr1N0wJlMa+3AA==
X-Received: by 2002:a65:4347:: with SMTP id k7mr14240023pgq.253.1562471047834;
        Sat, 06 Jul 2019 20:44:07 -0700 (PDT)
Received: from Etsukata.local (p2517222-ipngn21701marunouchi.tokyo.ocn.ne.jp. [118.7.246.222])
        by smtp.gmail.com with ESMTPSA id r15sm13506677pfh.121.2019.07.06.20.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jul 2019 20:44:07 -0700 (PDT)
Subject: Re: [PATCH v2 5/7] x86/mm, tracing: Fix CR2 corruption
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>
References: <20190704195555.580363209@infradead.org>
 <20190704200050.534802824@infradead.org>
 <CAHk-=wiJ4no+TW-8KTfpO-Q5+aaTGVoBJzrnFTvj_zGpVbrGfA@mail.gmail.com>
 <20190705134916.GU3402@hirez.programming.kicks-ass.net>
 <CAHk-=whsgA+8XtqJY91gqHhh9xLYQLM3kLLFTby=uf2eoZyK7Q@mail.gmail.com>
 <20190706182728.435a89ed@gandalf.local.home>
From:   Eiichi Tsukata <devel@etsukata.com>
Openpgp: preference=signencrypt
Autocrypt: addr=devel@etsukata.com; keydata=
 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
Message-ID: <128b96b9-b6c8-5c15-3ca5-c2b38a404ea9@etsukata.com>
Date:   Sun, 7 Jul 2019 12:44:02 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190706182728.435a89ed@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/07/07 7:27, Steven Rostedt wrote:

> 
> We also have to deal with reading vmalloc'd data as that can fault too.
> The perf ring buffer IIUC is vmalloc, so if perf records in one of
> these locations, then the reading of the vmalloc area has a potential
> to fault corrupting the CR2 register as well. Or have we changed
> vmalloc to no longer fault?
> 
> -- Steve
> 

It seems that perf ring buffer does not normally use vmalloc.
It depends on CONFIG_PERF_USE_VMALLOC introduced by the following commit:

commit 906010b2134e14a2e377decbadd357b3d0ab9c6a
Author: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date:   Mon Sep 21 16:08:49 2009 +0200

    perf_event: Provide vmalloc() based mmap() backing
    
    Some architectures such as Sparc, ARM and MIPS (basically
    everything with flush_dcache_page()) need to deal with dcache
    aliases by carefully placing pages in both kernel and user maps.
    
    These architectures typically have to use vmalloc_user() for this.
    
    However, on other architectures, vmalloc() is not needed and has
    the downsides of being more restricted and slower than regular
    allocations.
    
    Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
    Acked-by: David Miller <davem@davemloft.net>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Jens Axboe <jens.axboe@oracle.com>
    Cc: Paul Mackerras <paulus@samba.org>
    LKML-Reference: <1254830228.21044.272.camel@laptop>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

