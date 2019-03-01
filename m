Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C4CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A9520842
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpNGokOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388283AbfCANxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:53:55 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45819 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387877AbfCANxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:53:52 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so27705313qtg.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 05:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=idsnNelqcVOnRQFtDc/OtIo26B1QWUQHEnBmAIVE7WY=;
        b=RpNGokOM1PqvOha/ja5QE/1So32jb2R2oX6/3ounLQje45HVcUJJbHNBqT8/B66REp
         UpWIYOI9LuW46wkZpVregjKvABHE1vu8M8ev3BNGBM9dyIrQlTTrmGV5JjqPhvjuyUGs
         0Pot/lzRKqDK3BawiEmAuNCPWvLJ8UBi12b9QDgH7mYjzuNw1u9s+snn86YyxI6HFCqL
         EuFbzduV0DrzeB8gkFS+KYpTcI3NYOLkCkJ9l3f5yzNbPWWkCgWBKWDgqlQSYDQaxvag
         nD4am0mZYhY64d23ZyJZQKUUsIZxWUOlp83NZHRc/jSTmHGIxFtl+N7pQdIPkeGEXQ3G
         1ECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=idsnNelqcVOnRQFtDc/OtIo26B1QWUQHEnBmAIVE7WY=;
        b=EN7vqB6CDswGJbBrZhj5I0eDIeiiSyPzvHMJ0zLCy3sx+2ZM5foem5r4LFJM3K+exc
         kTZIffK1hA9anQDm50hjm3BmX6SflWe7u7yRbxXfzsjK08mfIXRlkWkzTdTQ+sRpPgrg
         DcwUkwINqf9+31O0itywlZhMGwvJh6aiC7MelwJXrpwpE+Q7bV7eJES7K7g7BZyaUq7p
         yQXn7Va0TlV38GVPnFqDhLYXl9fe7pmtE6+GIMGngzeyVicisYcdq03c3HLnw+fz4nX7
         poAFbCtE68yNMMORmwX5ZLuS91s6YJH2i7LAEw4OyOOTQNLhAYlNuWPWlsMZKust+4Ta
         fKZQ==
X-Gm-Message-State: APjAAAVPmhDGhzx85gBRRv7DXl1IyO3xZ7VMi7TfjjlZ9xCqhepPUWwx
        jV2flylELl+H5d7VtSC1td9Hp46KQrGOsQ==
X-Google-Smtp-Source: APXvYqz4kYnWzTdnAqftUvBweyW3PHwHrZ/CoAFHBWWtmuUQdJEUU+crAvkx6lHIDb2Ai0FQy5Wsww==
X-Received: by 2002:ac8:2190:: with SMTP id 16mr4032874qty.365.1551448431339;
        Fri, 01 Mar 2019 05:53:51 -0800 (PST)
Received: from quaco.ghostprotocols.net (177-59-125-241.3g.claro.net.br. [177.59.125.241])
        by smtp.gmail.com with ESMTPSA id u187sm2696507qkf.59.2019.03.01.05.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 05:53:50 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 067CC4039C; Fri,  1 Mar 2019 10:53:45 -0300 (-03)
Date:   Fri, 1 Mar 2019 10:53:44 -0300
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] perf/core: Mark expected switch fall-through
Message-ID: <20190301135344.GG13100@kernel.org>
References: <20190212205430.GA8446@embeddedor>
 <2c4e0c7b-1166-387e-fe39-6b4ee5c32c7d@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c4e0c7b-1166-387e-fe39-6b4ee5c32c7d@embeddedor.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 28, 2019 at 03:31:31PM -0600, Gustavo A. R. Silva escreveu:
> Hi all,
> 
> Friendly ping:
> 
> Who can ack or review this, please?

I'm applying it, thanks.

- Arnaldo
 
> Thanks
> --
> Gustavo
> 
> On 2/12/19 2:54 PM, Gustavo A. R. Silva wrote:
> > In preparation to enabling -Wimplicit-fallthrough, mark switch
> > cases where we are expecting to fall through.
> > 
> > This patch fixes the following warning:
> > 
> > kernel/events/core.c: In function ‘perf_event_parse_addr_filter’:
> > kernel/events/core.c:9154:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >     kernel = 1;
> >     ~~~~~~~^~~
> > kernel/events/core.c:9156:3: note: here
> >    case IF_SRC_FILEADDR:
> >    ^~~~
> > 
> > Warning level 3 was used: -Wimplicit-fallthrough=3
> > 
> > This patch is part of the ongoing efforts to enable
> > -Wimplicit-fallthrough.
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >  kernel/events/core.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index ac194d3aae32..343ee21ab958 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -9152,6 +9152,7 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
> >  		case IF_SRC_KERNELADDR:
> >  		case IF_SRC_KERNEL:
> >  			kernel = 1;
> > +			/* fall through */
> >  
> >  		case IF_SRC_FILEADDR:
> >  		case IF_SRC_FILE:
> > 

-- 

- Arnaldo
