Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027F3C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85D52080C
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoEjDa5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbfHZNzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:55:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37296 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfHZNzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:55:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id y26so17940277qto.4;
        Mon, 26 Aug 2019 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=662h+2yvuOf+WXhpcki588zNBbSoWr3HEqfisS3L1FM=;
        b=WoEjDa5TJI91R5TOym0Prxy5m/wNjeiz1a0iUpX28asnzjZw7Ebl/41avQrXvBk4oB
         vFZc5yHKTHMYs2RUZ1UnbHuqlTQj/bBf67D+xrMw7vTpLcOwpEmYMCcVFSlKCw6BwXEF
         g/EQs1psuOeXUCsLG1/Ds9OLmfIrST78t8OZAsYaLgfiZdWYDDR3A59g6N5ZD0lmq2eJ
         /is1GzSmsAw4kJccmUbdxpOGV0zpfJadl3uUJceyfQLxHBUtcYakEg93EIn6frQKCIzU
         3Fou2b5pwKP05PS8qD4bJXSrEip+q42TJc0Mpjisb6xb5zyALsGBjS2iUgHrUl0re1Ed
         5vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=662h+2yvuOf+WXhpcki588zNBbSoWr3HEqfisS3L1FM=;
        b=SxOFUZR6eJhtmBg4YzGYRIDogHDTpPwIxMir4PDDX9rcuhKu7udVMlyJaFWo1sCX1Y
         jUtkHihUq/3uwoOC6/084PEHnRQnX7M8BClZ/z9KPevNgRsob5HA/AKNt0q6sG4MCzQ6
         dMD0c2Q/RVQ6hbDXby5INpWr2w/iJlb4Am75Y1DY2lZY/Byz5hlEew2L/zqo7H6HKMAX
         EU9CTtuPg+X9ztryAIFXd7eMc31KgshpQU7dKvnXijvgRyTVCLIwdTyhH9X9rAOkiyN7
         XrztDFvSMohX8L2yhnlBDW/wV9yBc6cyqpzcGo95eRG1HQBNOxkwTgn4SpFT+fwquY/U
         TVRA==
X-Gm-Message-State: APjAAAVoM4ntj7MaEUtrProwMK71WZe8s6+rhO+lkOlXfq+ZPYDlQ9aP
        X8Eazbf9/VDo6kU9aUIQ9ks=
X-Google-Smtp-Source: APXvYqwKA28pWdGTL/rd6C1Y0xdI1IxhCq4nupXsTMtKUvWBDQSklDz1F20OVCekAqRIMMyaLsyTFw==
X-Received: by 2002:ac8:748a:: with SMTP id v10mr17466700qtq.386.1566827739201;
        Mon, 26 Aug 2019 06:55:39 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id r189sm6642167qkc.60.2019.08.26.06.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 06:55:38 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3850A40916; Mon, 26 Aug 2019 10:55:36 -0300 (-03)
Date:   Mon, 26 Aug 2019 10:55:36 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        "Jin, Yao" <yao.jin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Jonatan Corbet <corbet@lwn.net>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: BoF on LPC 2019 : Linux Perf advancements for compute intensive
 and server systems
Message-ID: <20190826135536.GA24801@kernel.org>
References: <43216530-4410-6cc4-aa4a-51fa7e7c1b0c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43216530-4410-6cc4-aa4a-51fa7e7c1b0c@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 26, 2019 at 02:36:48PM +0300, Alexey Budankov escreveu:
> 
> Hi,
> 
> There is a BoF session scheduled on Linux Plumbers Conference 2019 event.
> If you plan attend the event feel free to join and discuss about the BoF 
> topic and beyond:
> 
> Linux Perf advancements for compute intensive and server systems:
> 
> "Modern server and compute intensive systems are naturally built around 
>  several top performance CPUs with large amount of cores and equipped 
>  by shared memory that spans a number of NUMA domains. Compute intensive 
>  workloads usually implement highly parallel CPU bound cyclic codes 
>  performing mathematics calculations that reference data located in 
>  the shared memory. Performance observability and profiling of these 
>  workloads on such systems have unique characteristics and impose specific 
>  requirements on software performance tools. The requirements include 
>  tools CPU scalability, coping with high rate and volume of collected 
>  performance data as well as NUMA awareness. In order to fulfill that 
>  requirements a number of extensions have been implemented in Linux Perf 
>  tool that are currently a part of the Linux kernel source tree 
>  [1], [2], [3], [4]"

All those are already merged, after long reviewing phases and lots of
testing, right?

I think the next step for people working in this area, in preparation
for this BoF, is to list what are their current efforts, like Ian et all
did in:

  https://linuxplumbersconf.org/event/4/contributions/291/

- Arnaldo
 
> Best regards,
> Alexey
> 
> [1] https://marc.info/?l=linux-kernel&m=154149439404555&w=2
> [2] https://marc.info/?l=linux-kernel&m=154817912621465&w=2
> [3] https://marc.info/?l=linux-kernel&m=155293062518459&w=2
> [4] https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html

-- 

- Arnaldo
