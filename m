Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0490C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05B7222B0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnSl3aKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfKSOdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:33:51 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:40782 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfKSOdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:33:51 -0500
Received: by mail-qv1-f66.google.com with SMTP id i3so8184065qvv.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 06:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c8+qR0rPmXMjqYgVr0UDNO0MT1NVFcgD4srYcXH9Uio=;
        b=tnSl3aKQS6L0TDWwu5Rd3pl/bkzXTKnJXt2KO6/YvG9mBAhb4/Oq/AUu5U+SfjifDD
         eIYwClFR8M3z/qTxj21I/eyReVx+EefwzFo12s64Tmbbxyt02N8DkuuqJ7TnW2m0BWWy
         qtqJYqafp/dg3IzhFyYlNiv87piHnybzMse2Z4poUKnHHGmiAKdaHje2rZvRKMaXnngB
         xOtObOfeLwwzeG0z4Sb/D9IbjmKlIjcUuZd7moZz3lnLFwQpzXBjT50SQHdTy8QvsK3l
         yzJp5ZydBgcAFoe+1bM+dS7PKB8mbknkLEgbrIIDBdAw/gr3pT0uEzbqm6fqcAE5ZHHY
         F42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c8+qR0rPmXMjqYgVr0UDNO0MT1NVFcgD4srYcXH9Uio=;
        b=ZEbCCoqlgnsuxzuucgK9loW8Vg1lrdCy3OHS/AQHFmFP4z0545HHBl8cs3Z4TvXLx1
         1VmvAWvPhwjB3XW2vPWtyzspPZF4EuH6PZXfT/PLo6pgA2qpoK/VQuSe3sbuQuGh0abo
         wlLPJ2x31GLyvh9Y3YClfg+VkjAc6QR80v7z3lavzWsWcVc6ImRjJwbX9SjSUWUZYR6r
         /IVaXoTHs+KnHxp3CH10PNI0OyJe4sN9Mr5vYgrcuVTAj8Knk7TwJT7s58iJvkwTTAbO
         uSqGavbUcYGgDBW9WRRpUl+Cz6OOawMzXCYHGxSVYlY4qdqdwoGe5CHvBS5MfTDyujyW
         hrCA==
X-Gm-Message-State: APjAAAWW8UyOj3CpBwFtw/7eS98VU4Q4sFES3qsQIofTr2kX73GCDI8t
        0UBC4zw337BLhhV03/qe+gnT2SIA/wo=
X-Google-Smtp-Source: APXvYqxxfW1Wb8sQNtRZijmvT/qCWkBDCrLIUEUBGL28NpubFsDL7XnTswCnDxsjLkGTaGFts2PIcw==
X-Received: by 2002:a0c:edb2:: with SMTP id h18mr1673262qvr.36.1574174029991;
        Tue, 19 Nov 2019 06:33:49 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id h12sm10113982qkh.123.2019.11.19.06.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 06:33:49 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 23F1540D3E; Tue, 19 Nov 2019 11:33:47 -0300 (-03)
Date:   Tue, 19 Nov 2019 11:33:47 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 0/7] perf/probe: Support multiprobe and immediates
 with fixes
Message-ID: <20191119143347.GB22731@kernel.org>
References: <157406469983.24476.13195800716161845227.stgit@devnote2>
 <20191118221104.GF20465@kernel.org>
 <20191119224604.1d3665b8e8dfdcfcc2a8f31e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119224604.1d3665b8e8dfdcfcc2a8f31e@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 19, 2019 at 10:46:04PM +0900, Masami Hiramatsu escreveu:
> On Mon, 18 Nov 2019 19:11:04 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Em Mon, Nov 18, 2019 at 05:11:40PM +0900, Masami Hiramatsu escreveu:
> > > Hi Arnaldo,
> > > 
> > > This is the 3rd version of the multiprobe support on perf probe
> > > including some fixes about "representive lines"
> > > 
> > > The previous thread is here:
> > > 
> > > https://lkml.kernel.org/r/157314406866.4063.16995747442215702109.stgit@devnote2
> > > 
> > > On the previous thread, we discussed some issues about incorrect line
> > > information shown by perf probe. I finally fixed those by introducing
> > > an idea of "representive line" -- a line which has a unique address
> > > (no other lines shares the same address) or a line which has the least
> > > line number among lines sharing same address. Now perf probe only shows
> > > such representive lines can be probed([1/7][3/7]), and if user tries to
> > > probe other non representive lines, it shows which line user should
> > > probe ([2/7]). The rest of patches in the series are same as v2 (except
> > > for [4/7], example output is updated)
> > > 
> > > This can be applied on top of perf/core.
> > 
> > Thanks, applied everything, only the two last patches I didn't test, the
> > kernel in this machine doesn't have the features it needs, we can fix
> > things if some problem lurks there.
> 
> Thank you Arnaldo! OK, if anything happens, I'll fix it soon.

np, Ingo already merged it, fast one, soon he'll push his tip/perf/core
branch out, thanks!

- Arnaldo
