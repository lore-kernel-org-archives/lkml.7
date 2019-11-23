Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EC2C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 04:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804F420700
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 04:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKqkTMCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKWEIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 23:08:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34928 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfKWEIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 23:08:00 -0500
Received: by mail-pg1-f196.google.com with SMTP id k32so4367341pgl.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 20:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MzKuDt8iI75H6p73nKRuPauZynxm9JSum9wi8JsQGQY=;
        b=VKqkTMCeaufkbkUuBIvZiV/TY7m9CAviwe+mI8WBnK4xZ9VJqYrThIlfL3VDeCsKq/
         XxxL1WKdzKloDCJoS4YXwM+cMfXSK8wmQ39a8rRwLUfegKQSd7jR76veblP17LorABJ3
         eXFghUFrH2KhDIDFfMtKgHK+J5nYUikSCvdtzWtJ4wqR5WGAZwJhsZ/4Z8gz7cIGONXX
         GSqdMVuoQYn5U1/nd6WRrqYBrnZynNA94egmEOsQo0bUWB5zFUy4fS7m0KoSoMrXhNn7
         FiLjfCY4JTZwe674dRDEmqQXvE2FEe8G+XuyzuNCJjGVRueobKZjZ0/vLMCBnHKOUQHW
         MwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MzKuDt8iI75H6p73nKRuPauZynxm9JSum9wi8JsQGQY=;
        b=Iwbpk4+/E4Z0EM0NHnmRQ8WLXgUY5+92na7MAOFolGWd65cOR+AXYXSMeScAPTwVNN
         PKSjScaKClagMJkhjLkij5IVMD5eLs9RsZDixVtIXusIG5mJlH5ks76IPV2MEhrMisZ+
         iJCbUF4bm3TROy8XrxLc5hVVaHGsZkfrHuvPGuO7gfOcNtJSkAcLky+qXdeB9rGDSBie
         Ovf4vTODmf1Ej/Ez7ibnQHs6aVf2DHp8l1XtSpzZVXt6/KpUwjgCtebbD8mUh2Nm+m5a
         8OF01AWRtuvaNsfhwq1TM5aXgtinLNzwgi8DV/n/k4vWx8mwuv0eDovcpPmZpCetdqFb
         j+Vw==
X-Gm-Message-State: APjAAAUPknfHE0BCimllL0SAaS42RhlJ7JqOj3byo5Zhmb+LarZoQh8I
        /GJlc/Md0w/CX48IXTxVBrc=
X-Google-Smtp-Source: APXvYqwn1PNYY2U4A89kmw9SLynHM+j7i/86/SpzNSE3zHOfQbPjAcLGGhsJwshUuoITfu3M0j1ezw==
X-Received: by 2002:a63:474a:: with SMTP id w10mr19065381pgk.331.1574482078320;
        Fri, 22 Nov 2019 20:07:58 -0800 (PST)
Received: from mail.google.com ([45.32.93.123])
        by smtp.gmail.com with ESMTPSA id o7sm136432pjo.7.2019.11.22.20.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Nov 2019 20:07:57 -0800 (PST)
Date:   Sat, 23 Nov 2019 04:07:54 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] perf: add support for logging debug messages to
 file
Message-ID: <20191123040753.nnbstznsabfltwi6@mail.google.com>
References: <20191018002757.4112-1-changbin.du@gmail.com>
 <CAM9d7cjzbfmKdRubMHyOGeN91EZGrF5dF7=xxewjftYo8m15fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjzbfmKdRubMHyOGeN91EZGrF5dF7=xxewjftYo8m15fw@mail.gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 12:35:01AM +0900, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Oct 18, 2019 at 9:28 AM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > When in TUI mode, it is impossible to show all the debug messages to
> > console. This make it hard to debug perf issues using debug messages.
> > This patch adds support for logging debug messages to file to resolve
> > this problem.
> 
> I thought I implemented a debug message view in TUI mode by saving
> all the messages in a linked list.  But it seems not sent to the list and I
> cannot find it now. :(
> 
Sounds bad :)

> Anyway I understand your concerns and the changes look ok to me, so
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
Thanks for your review.

