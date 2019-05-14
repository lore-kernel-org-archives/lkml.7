Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A896C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285092147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwNYEApl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfENOB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:01:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43176 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENOB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:01:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id i26so1722085qtr.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 07:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A96YK3qa328OsFHhTU2DWRziq1ETs18hqgWFjRch1IY=;
        b=QwNYEApl0gyRquEbfTRP0H7a910BgQCEQTEw7R1BFKo5PUMXl3N8QfH3mjktpdVX0e
         x0WT/7vD9Bx8hNEqqXwyJwgGG1V1J5cJ8AMrYXsmJUIl7Z1CwU9ewx0bWmcpiQHMCaEz
         uBxrpWidi/3J5zBIFWs7Jr9oOaUd4VGo5z8NymHjaim7eb1Ozvg1rNktduJJrJJS+26E
         u9uwns7WOm9bTRnUiBYNTUQEjUOsdiwwjFQrqOn7PzPyA8M3i/6NrHTkxRGiZ+xdvF7j
         FtxMHJTjT3VugWwcgM7MiAGxMKygCs6WvANRnFUShrq9FQaethYefsP3GmOZGfZNIa9d
         PZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A96YK3qa328OsFHhTU2DWRziq1ETs18hqgWFjRch1IY=;
        b=t30g9aymB+qGz9T2Yj+yDapHHa0hOv1hrc6cU/OiWsWzVS29V8WrQUo9kX96NiqX9w
         nhyUGCUTbpRM8ulCcyqT0J6udQP8cQHOpra0oNI1+htNgNHUDGdY940uWCGDYP//5UMi
         nfACsEqBYZv/ePxHvMgYwTSbmoELEpSHJ776hxykc2WpZztpBVt8079P1BUECsW0jEzC
         47aSL2LsFYdXPrOtI4vT0Qbn0hN8xPI2b7ghHaeEugXdYzEWkIOmJ95x3HateRrTCKgM
         P2KLXJ6VVVVScbm6jJj3IdndG0pHXQfMcy1ujdZzhHc7a2W+LqY3Xt0ZncZbsXHkCODt
         gt5Q==
X-Gm-Message-State: APjAAAX+VsvRgu9ROFrGZIwKY7amxFKvj7Kk8czDTND1HFQgcEJES91o
        gD59CM5SiCuowlSvDlQDETU=
X-Google-Smtp-Source: APXvYqz8uDQXac6fk/PmRpgyo3Ntb4iaTqZ5WoPGeg6Flk9a0J8oHZteZ89ouuvuvriHRkQgpp30XA==
X-Received: by 2002:ac8:2516:: with SMTP id 22mr11270465qtm.55.1557842485662;
        Tue, 14 May 2019 07:01:25 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.209.210])
        by smtp.gmail.com with ESMTPSA id v3sm11691928qtc.97.2019.05.14.07.01.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 07:01:24 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 91C80403AD; Tue, 14 May 2019 11:01:13 -0300 (-03)
Date:   Tue, 14 May 2019 11:01:13 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: Re: [PATCH -tip v8 0/6] tracing/probes: uaccess: Add support
 user-space access
Message-ID: <20190514140113.GI3198@kernel.org>
References: <155741476971.28419.15837024173365724167.stgit@devnote2>
 <20190513183412.GD8003@kernel.org>
 <20190514140253.1edece79ff72ba47b9a8c72c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514140253.1edece79ff72ba47b9a8c72c@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 14, 2019 at 02:02:53PM +0900, Masami Hiramatsu escreveu:
> On Mon, 13 May 2019 15:38:24 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Fri, May 10, 2019 at 12:12:49AM +0900, Masami Hiramatsu escreveu:
> > > In this version, I fixed some typos/style issues and renamed fields
> > > according to Ingo's comment, and added Ack from Steve.
> > > 
> > > Also this version is rebased on the latest -tip/master tree.
> > 
> > Ingo, since this touches 'perf probe' and Steven already provided an
> > Acked-by, if you're ok with it I can process these, testing the 'perf
> > probe' changes and then ship it to you in my next pull req, ok?
> 
> Thanks Arnaldo! For the perf probe enhancement, it should work on
> the kernel which doesn't support 'u' prefix. :)

Sure, I'll test that case too, i.e. old kernel + new tool, old tool +
new kernel, new tool + new kernel, as usual.

- Arnaldo
