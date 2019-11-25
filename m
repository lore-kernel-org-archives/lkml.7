Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0472C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CCB2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu7t3xuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfKYNqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:46:53 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33151 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfKYNqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:46:52 -0500
Received: by mail-qt1-f193.google.com with SMTP id y39so17211887qty.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 05:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5wVg8RtlgZ1wk3bQrbvKvpMIXk9Lyi6m0jGieGJX1yM=;
        b=Cu7t3xuzrGVP9upmw0aa/B8cGgmyqxYvNMJH32iqlxS0kRLts2UCEVjMHG7ak9pT3d
         M/UPiq8YmzHVOedbaCbSwfoxDOubUzXCB6xY9iFy86ZcQW63VdpvyieUXdaUkXG5Dtq3
         tOX9eeAD7bTV0A8BLA+fUCJlx2qJEA4NZDMm64PP6ZOlERqftac8GRc0nlPn0RaMoIIo
         jGRenkSpf0pH78a81X4ZPcQVepEZBdBWSHkyVMXk3QGVmVhJJVTRe554x1LG1k9tMaZK
         GhU6R6nQFsKCWSMUF6YHJU4pbgItyrzjyjbIHqXb//wpIbdkmMPt5VKaMDWswutpOtn5
         oFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5wVg8RtlgZ1wk3bQrbvKvpMIXk9Lyi6m0jGieGJX1yM=;
        b=KQ8WOQ32f51CjbWXakCWfJjmoieSjG8KpV7YcfRWckv6u9U784BusKywgLPF6pXUVl
         3JvD6rT/Wikj37u0a7xDHHV2xap03TTSv33cIe7SR936pBPoJlABHetGxJ/tB7f4aoUu
         fCxg915ijrJEc8zRaFj4yBAfcKPY/okn+jWbxJiAdnuPo5sY+Zwk3TnsZEL21TTh4mLT
         FvtLd72+pd7YT/ZzE5Uc08QqEjS2EvzinMQGUeIHQxVH7Ua6G4N214EyhpjPYA3SXi97
         tv0aZVMgMJqJvhwtEHlX1NePsWxeETSKAjLn8yGvDW/L18R0Y0ps3VpJcF3uJ7oISmfC
         ibzQ==
X-Gm-Message-State: APjAAAUA3mw1q5wb0AVnEtc6+1ZWXxdmBhNCqWWXn72nv6FeBAOnlliJ
        E6YAfp2TOxG7LGg67fzHZs8=
X-Google-Smtp-Source: APXvYqzxy0Bl6wMrwkYe/7h8DQHDnV7+RwZ7UNBZJkbYuJRJdqdVtIIRx1C1Z6mJ8B/6Dbuf0ZTd/g==
X-Received: by 2002:ac8:73ce:: with SMTP id v14mr28906855qtp.136.1574689611673;
        Mon, 25 Nov 2019 05:46:51 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id e13sm3896555qtr.80.2019.11.25.05.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 05:46:50 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2D06A40D3E; Mon, 25 Nov 2019 10:46:48 -0300 (-03)
Date:   Mon, 25 Nov 2019 10:46:48 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     x86@kernel.org, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 0/2] x86/insn: Add some more Intel instructions to the
 opcode map
Message-ID: <20191125134648.GA2168@kernel.org>
References: <20191125125044.31879-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125125044.31879-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 25, 2019 at 02:50:42PM +0200, Adrian Hunter escreveu:
> Hi
> 
> Here is a patch to update the x86 opcode map, and a patch to update the
> perf tools' "new instructions" test accordingly.
> 
> There are still CET instructions to add, which Yu-cheng is doing.

Thanks, applied.

- Arnaldo
 
> 
> Adrian Hunter (2):
>       x86/insn: perf tools: Add some more instructions to the new instructions test
>       x86/insn: Add some more Intel instructions to the opcode map
> 
>  arch/x86/lib/x86-opcode-map.txt              |  44 +-
>  tools/arch/x86/lib/x86-opcode-map.txt        |  44 +-
>  tools/perf/arch/x86/tests/insn-x86-dat-32.c  | 366 +++++++++++++++
>  tools/perf/arch/x86/tests/insn-x86-dat-64.c  | 484 ++++++++++++++++++++
>  tools/perf/arch/x86/tests/insn-x86-dat-src.c | 655 +++++++++++++++++++++++++++
>  5 files changed, 1569 insertions(+), 24 deletions(-)
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
