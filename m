Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3455AC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF94822CED
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzHDlGF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfHZWK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 18:10:26 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:38442 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfHZWKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 18:10:25 -0400
Received: by mail-qk1-f178.google.com with SMTP id u190so15445454qkh.5;
        Mon, 26 Aug 2019 15:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OqFP4429NaCXrdK6a75re0BTQB3Dv9LNc9qPdlLe7dY=;
        b=jzHDlGF+NW83sFETNqGnuINCU8OxrNQQs8nx7qRveFYrfG+6AlhBXe9FK5sWKfjDwz
         yuP1eIBlqR7SJzBQ3KcBCJuE2XSJ07zmw9DwmcIC8o7KKbxJ2CWYKNQ/cHVYCLwDjy8p
         086DNGaikoTA+t2B7tQA19iJY0oZMeWLgLAfqC7+nutnwxoY8HZIniQev4G1x3zvuc4L
         8Z877nzINUi8TTnePVPZ7ZhsDs9Zg1brZMMn13C1vNybzS7+zE5TkcDUUc9Ah8Dina6H
         j5y69fqy9f6cLf/T7zwLM3yxzhb79yGwL1l0O2vGH//3vUWZnBK30t2hPfjJgNUjfR9n
         mYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OqFP4429NaCXrdK6a75re0BTQB3Dv9LNc9qPdlLe7dY=;
        b=g8m8OMkGExdGG8tpYMPqyo0xYfJuVnD3j/vmFCD0RTnW0o+rCcekGkcX6M1P/y/sSR
         ICj0zpEyet8RaBm7kpMy3NMt+Ddqr8vDf0aUq00a2sf7Yzs3SJFP1RdSgsK/X2vG8TjV
         N2DaeuOQ5ZMKfBs6I3wqXmTvTzUwzNoFubSy3Ygn5z8Zb9aoMh38fY6f3bcWCe4rLWqd
         mR72gqldwyQk7e0pyaXXT2SSHvO4JrVc/aSxoYe9DEdbpXnNA7dqR4xcNt7WDDq1KOYF
         turjKf3B6Jjjuvu9Kn1NLWSeeHK2LFUeVoQGGBker27UupAZZWfGYr92io5ID1t9bZ+a
         C2Dg==
X-Gm-Message-State: APjAAAUM3lDuWfHPe1IkPrdTjL++DuZF1JiglWFdWVnaV0ik/m1txrP9
        H2v4mDe+yZccnWjlW13skmM=
X-Google-Smtp-Source: APXvYqzZv8ZA0QWR1unXdqHNGBEbmxOTvJsw8UAJi6vHRBGULw4c8TeHzm4E/fhPstdJPGQ71hBoxg==
X-Received: by 2002:a37:94c1:: with SMTP id w184mr835218qkd.172.1566857424700;
        Mon, 26 Aug 2019 15:10:24 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id i5sm9151056qti.0.2019.08.26.15.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 15:10:23 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF3E240916; Mon, 26 Aug 2019 19:10:21 -0300 (-03)
Date:   Mon, 26 Aug 2019 19:10:21 -0300
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20190826221021.GB21761@kernel.org>
References: <43216530-4410-6cc4-aa4a-51fa7e7c1b0c@linux.intel.com>
 <20190826135536.GA24801@kernel.org>
 <da687997-6280-2613-a389-f7b94c600c2b@linux.intel.com>
 <20190826175758.GH5447@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826175758.GH5447@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 26, 2019 at 10:57:58AM -0700, Andi Kleen escreveu:
> > 
> > > 
> > > All those are already merged, after long reviewing phases and lots of
> > > testing, right?
> > 
> > Right. These changes now constitute parts of the Linux kernel source tree.
> 
> Might be better to focus on future areas that haven't been merged yet.

Agreed, we can have a initial, short report on what has been done to
address these issues, and I think Alexey could take care of that, but
then we should try and list here what else in addition to what Ian et
all listed on their talk.

And perhaps even things that ammeliorate the problems they list there,
i.e. Ian, Stephane, the things that Alexey listed were already
tested/considered by you guys?

- Arnaldo
