Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4932CC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132C220665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k19exPmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbfFYHUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:20:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYHUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Nl6kl31Qo8qZhgEILObNglwHGknZSpNYtz2yQVPDso8=; b=k19exPmG+1SSX5O63A5s6imGq
        a2nhvKPBH3jPY0SPbRkpXLHZbslMlWANVtIPkNMxCpByWi6nsbxUO9nyulbKBlfXMd5a9wmSp2fUR
        iN60oF0r18d7TmglnQb9EhgTZ4EHezEDsqEV7F3W4JhmZzDdwkBC/ph4W4Z3Q3koMtBkdQcCXPzzV
        YMSctHr/RYkB/1FVBDYdldvivd/xAgr4m2ALpqSbfBUqLG+bEe+5oITtm3JvZeS4vjO3zq159o4b0
        /JTQF4gBCg7LeSjiKPM3JhXHxp6ijzouW01hOwMYgUZWoCZQ/w6+rvhleWdHDQGJS6yFN2+44lzXF
        ypyCnn1jA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hffkW-00020u-JM; Tue, 25 Jun 2019 07:20:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1DF1C209FFF54; Tue, 25 Jun 2019 09:20:15 +0200 (CEST)
Date:   Tue, 25 Jun 2019 09:20:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Shawn Landden <shawn@git.icu>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190625072015.GO3436@hirez.programming.kicks-ass.net>
References: <20190624161913.GA32270@embeddedor>
 <20190624193123.GI3436@hirez.programming.kicks-ass.net>
 <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net>
 <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <f3138138a67107d84ba014d363df6ca9deba50c5.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3138138a67107d84ba014d363df6ca9deba50c5.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 01:57:49PM -0700, Joe Perches wrote:

> > Once the C++17 `__attribute__((fallthrough))` is more widely handled by C compilers,

> I doubt waiting is better.
> If the latest compilers catch it, it's
> probably good enough.

Yeah, I don't see the point either; GCC does it, and that's all I really
care about.
