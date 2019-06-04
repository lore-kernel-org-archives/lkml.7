Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E656C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325F22199C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUvQrA/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfFDNUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:20:50 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42231 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfFDNUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:20:49 -0400
Received: by mail-qk1-f195.google.com with SMTP id b18so2757429qkc.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 06:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uqzhH7pqH9fWSLubAoSMZ9XsppGtow2rVqWRSJtHqZ8=;
        b=GUvQrA/tbu1BqAHG6b2qEaL+7AR/FaZ+bMvRDq/GZpWem6ylArBJX8D8kFGRNkxunX
         2iQCLGGv3kGhCILtA47/QpQ5VN/l6J9dYdXycOVt6CLApiKvZ2qb0XnB0CO9yZ4zihAf
         dJWd1LN1IuBF87IT47teHaDICPrVLq/VkNUNtk1/baTlc8rAxEvSTu9weHP4Y1QNkr6p
         PjyS+LFFr11obpUwiggJBE9GB0kXqUWnhePzbVFyQruAJg5fffVyCy7pdQAjfHeGeWPL
         SOXxKBaZSpq8WiRIN0vS5S5u+Q+h+fmsx5rWNIn8u6F9p2IRqbfKa77emCpJ/eWwkynE
         yhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uqzhH7pqH9fWSLubAoSMZ9XsppGtow2rVqWRSJtHqZ8=;
        b=PuRv4nTGI0Iw6HbHraJJIWxMSIEQN5LWlpuIakRpKgdvHpPHUBpuudHJ2+lsQkSnZG
         W6wTFul2yR6S8BnfnzVa6Sht+1VkcDik+te5z0u8GJ/cMWdXL/xuyGTVkumSNQkHfRoe
         SufRQ2leOwQgcayL2BbYh/HGS49fNQNY3zTgIWX+6tALdj3wKFBcpkITC2akY6NkyWqE
         L5GBNS/dAoo4gw88NaQUi6Rmvz0fw4UacqkUoMJibsFPemmLYKSkKkQ/E/jLXxKSn3uK
         nTSfrBiSbdEyCO+aU2omVCI6vsUpVfBLH7klIGiVLWPA5XhTdf7jfEJ+SUy3EBq3rwi/
         gcoA==
X-Gm-Message-State: APjAAAXgtDqMhFU5OlpRXU/GEeYRPu2SlBRL67T210vCcZQbrpHSDA4g
        xkWSA8ctEqvvYAoyFfLtI+sxOUvE
X-Google-Smtp-Source: APXvYqyRgLw39GiS1aSTkx+EwKCFx5pdbv7jQCxkY4iMVFGCbfPTTndfVLVVFWEf0ko6qV9Sj2bdPg==
X-Received: by 2002:a05:620a:13f9:: with SMTP id h25mr26437977qkl.283.1559654448215;
        Tue, 04 Jun 2019 06:20:48 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id f67sm10594421qtb.68.2019.06.04.06.20.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 06:20:47 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0007141149; Tue,  4 Jun 2019 10:20:44 -0300 (-03)
Date:   Tue, 4 Jun 2019 10:20:44 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/22] perf intel-pt: Fix itrace defaults for perf script
Message-ID: <20190604132044.GA24504@kernel.org>
References: <20190520113728.14389-1-adrian.hunter@intel.com>
 <20190520113728.14389-2-adrian.hunter@intel.com>
 <20190520144516.GL8945@kernel.org>
 <20190531164547.GC20408@kernel.org>
 <7f73ed6e-7935-b325-14af-0b9e43144ed4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f73ed6e-7935-b325-14af-0b9e43144ed4@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 04, 2019 at 02:32:15PM +0300, Adrian Hunter escreveu:
> On 31/05/19 7:45 PM, Arnaldo Carvalho de Melo wrote:
> > Em Mon, May 20, 2019 at 11:45:16AM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Mon, May 20, 2019 at 02:37:07PM +0300, Adrian Hunter escreveu:
> >>> Commit 4eb068157121 ("perf script: Make itrace script default to all
> >>> calls") does not work because 'use_browser' is being used to determine
> >>> whether to default to periodic sampling (i.e. better for perf report).
> >>> The result is that nothing but CBR events display for perf script
> >>> when no --itrace option is specified.

> >>> Fix by using 'default_no_sample' and 'inject' instead.

> >> Applied 1-3 for now, concentrating on fixes, will process 4-22 later.

> > Tested the ones that affect sqlite databases an the GUI, all look good,
> > added committer notes and text screenshots as committer notes, thanks!
 
> Thanks for applying!  Are patches 11-22 in your tree?

Yeah, delayed a bit push out as I was doing some automated tests, see
below what is there right now, if there is something missing, please let
me know, I also added commiter notes to most of them as I tested to see
if the comments matched the code and end GUI results.

- Arnaldo

ed1108bd8107 (HEAD -> perf/core, quaco/perf/core, acme/perf/core) perf augmented_raw_syscalls: Tell which args are filenames and how many bytes to copy
095b72ea8bc6 perf scripts python: exported-sql-viewer.py: Select find text when find bar is activated
08810ed07c90 perf scripts python: exported-sql-viewer.py: Add IPC information to Call Tree
96234e319dbe perf scripts python: exported-sql-viewer.py: Add IPC information to Call Graph Graph
18d0b3fa8f07 perf scripts python: exported-sql-viewer.py: Add CallGraphModelParams
a3f0fbba872e perf scripts python: exported-sql-viewer.py: Add IPC information to the Branch reports
44bd2140868f perf scripts python: export-to-postgresql.py: Export IPC information
ea76f3ba4a25 perf scripts python: export-to-sqlite.py: Export IPC information
75302e535b23 perf db-export: Export IPC information
a99d75fa022c perf db-export: Add brief documentation
0f9eea5e6974 perf thread-stack: Accumulate IPC information
1e80115f84a3 perf intel-pt: Document IPC usage
990917373744 perf intel-pt: Accumulate cycle count from TSC/TMA/MTC packets
17fa778da83e perf intel-pt: Re-factor TIP cases in intel_pt_walk_to_ip
dbb8dfd91a18 perf intel-pt: Record when decoding PSB+ packets
03386978a23b perf script: Add output of IPC ratio
f7c15a499e28 perf intel-pt: Add support for samples to contain IPC ratio
885ae6d43172 perf tools: Add IPC information to perf_sample
db3e60dd79a4 perf intel-pt: Accumulate cycle count from CYC packets
73a5a91c762d perf intel-pt: Factor out intel_pt_update_sample_time
3bbac0d75719 perf record: Allow mixing --user-regs with --call-graph=dwarf
7122f4bdb56d perf symbols: Remove unused variable 'err'
eea796aa2d6f perf data: Document directory format header: HEADER_DIR_FORMAT
cad909dc61fb perf data: Document clockid header: HEADER_CLOCKID
e1b3ce6a6898 perf data: Document memory topology header: HEADER_MEM_TOPOLOGY
8ab1ebfbb696 perf data: Add description of header HEADER_BPF_PROG_INFO and HEADER_BPF_BTF
b33fb3cf6f5e Merge tag 'perf-core-for-mingo-5.3-20190529' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core
14f1cfd4f7b4 (tag: perf-core-for-mingo-5.3-20190529) perf intel-pt: Rationalize intel_pt_sync_switch()'s use of next_tid
<SNIP>
