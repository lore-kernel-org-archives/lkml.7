Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3ACC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C7320679
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTzuu8Wg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfKYOg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:36:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34564 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbfKYOgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:36:55 -0500
Received: by mail-pl1-f196.google.com with SMTP id h13so6604860plr.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 06:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ysuSQwdoiGXVRPkAiaiJnsu2siAicLc8PmRbx8aQeCc=;
        b=XTzuu8Wgu30lZCM2ZeocPdBnl/r97cfM41I9es+Qqx5Lft/DxiSHuuori/v16kK+US
         DhVT2ilvxqvVbAKtT6RH5r4dcGb5D2nl9WPZ3Gsblik1WxPB9h6KvlbTmoEXVC0h1n0b
         D+XkP4sfNian+dJMkF+AJ8jbiu68v1zNiwwDZa9WjmI3Cf/384h8QOZIbdb87Zj2JQJQ
         7ICiYZ9cXVgb6rDY47PNDsEi3F3AzmeQH0rXF3tcjfX2cgLNYgQzi5UPZXpvV/X6YXOu
         UAiHb0AFdSYFuqyU3bqP1n0QZYQqnwXmWYSaqEb8JdfMMRK2HtDKKuN70DJgqG3ysVMr
         8xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ysuSQwdoiGXVRPkAiaiJnsu2siAicLc8PmRbx8aQeCc=;
        b=ptaSW/C33/laRheCXf+retF8l2ZpOq6uLM5HkmCaENrtTMCMTEo8SDpwI8SKSE4lUl
         Eq4fDVf7Nru/luWSnX8dxeVEm9+xpDxOL8TTXxdYCyANHYzEIk4HP66JGM/aP9tVIJZ6
         We6nAeH6+smI6DqxdzNlxcuxNhefGzB2OX/EFT3wwlyvVJi3MrWIFY/0ZEoYliTvL6YG
         xcWY3n3ox3npCNojFPh+5tzc6gJEuZFadUtKMf2fSrNK9Z0PsqAVPMs4GrnNarpiArMN
         xqg42OZ6f2wCeTQVqnMV1hCI11gSeEKMoop1vv0W0UrHcpiFO5eUrPi5uSrFMHoUtVKe
         9Edg==
X-Gm-Message-State: APjAAAWgmKlIqtWVsQX6dIgv6KBrHwDVj2XxGebeqBemGerpfSPzPRyt
        glDTO056X2bqPLWu6kr1hEM=
X-Google-Smtp-Source: APXvYqxrZv8TLSS2e9Tj+i3G4fjhJe1qimOZjbsMyXuNMmugiduyfQQaj15LsEmop0UcMsXZOQssLg==
X-Received: by 2002:a17:90a:1913:: with SMTP id 19mr40651035pjg.116.1574692614883;
        Mon, 25 Nov 2019 06:36:54 -0800 (PST)
Received: from mail.google.com ([139.180.133.10])
        by smtp.gmail.com with ESMTPSA id v19sm8821547pjr.14.2019.11.25.06.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:36:54 -0800 (PST)
Date:   Mon, 25 Nov 2019 22:36:46 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] perf: add support for logging debug messages to
 file
Message-ID: <20191125143644.5tkkazvlke5wcbcw@mail.google.com>
References: <20191018002757.4112-1-changbin.du@gmail.com>
 <20191123040910.dfi65lbev7ydtbdo@mail.google.com>
 <20191125092758.GA4675@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125092758.GA4675@krava>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 10:27:58AM +0100, Jiri Olsa wrote:
> On Sat, Nov 23, 2019 at 04:09:10AM +0000, Changbin Du wrote:
> > Hi Jiri, In case you missed this one in your mailbox. :)
> 
> sry I mised this and can't apply this anymore.. could you please
> rebase it to current Arnaldo's perf/core?
>
no problem, please check it later.

> thanks,
> jirka
> 
> > 
> > On Fri, Oct 18, 2019 at 08:27:55AM +0800, Changbin Du wrote:
> > > When in TUI mode, it is impossible to show all the debug messages to
> > > console. This make it hard to debug perf issues using debug messages.
> > > This patch adds support for logging debug messages to file to resolve
> > > this problem.
> > > 
> > > v5:
> > >   o doc default log path.
> > > v4:
> > >   o fix another segfault.
> > > v3:
> > >   o fix a segfault issue.
> > > v2:
> > >   o specific all debug options one time.
> > > 
> > > Changbin Du (2):
> > >   perf: support multiple debug options separated by ','
> > >   perf: add support for logging debug messages to file
> > > 
> > >  tools/perf/Documentation/perf.txt |  16 ++--
> > >  tools/perf/util/debug.c           | 124 ++++++++++++++++++++----------
> > >  2 files changed, 92 insertions(+), 48 deletions(-)
> > > 
> > > -- 
> > > 2.20.1
> > > 
> > 
> > -- 
> > Cheers,
> > Changbin Du
> > 
> 

-- 
Cheers,
Changbin Du
