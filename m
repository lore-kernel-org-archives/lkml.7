Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0E5CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBB221479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAyFlSY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390006AbfJ1ORA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:17:00 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34705 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbfJ1OQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:16:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id c25so2366371qkk.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 07:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BE8qQYUg8CAj2cRYDCnsZpmtHA78HZgoB4j8skQt9o4=;
        b=WAyFlSY2JoRvlrv6/FabzENxE6+8ldE++UFF7nQ15zPq3sdmxDMqHGXJ/oacBdXzsX
         JyrUyXfNXpWh2X3JzXmg09ppxyzx13KbgKCXG9QItr89nOd6R+oB/wTZuRZ+YiBZmuld
         6iYsdkObjFILNjbwsHCp8FunggKHOGUpRuaVOnkV+2oGhFfeEh8/Dvcb9RjMjQYl66/m
         MWU7UKnD+/xFi7uDB7MBVt5hiSow4dBrWUVKzEaYhy6y4/z7u/DiokQzT4KXfNuz/9EE
         nLdrAjM5T/2l7jWpQ2ExUEAGrhvWlvoFDxbl9GmjCfn31/YsSf+oKKkB3WLl7bR9HhUk
         KlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BE8qQYUg8CAj2cRYDCnsZpmtHA78HZgoB4j8skQt9o4=;
        b=gYqjFyhrktMRxAloXMiAj1QBSUfR78R0724W3xBEIrn+/wRiFiMPVmBBvQD14K0CJr
         ZHQLRDPD2FwzV2831nX9ZKwUfSaL2MvFstPk/3JpmxxX42LTOqv+otUSUBlkz1fNOQGH
         uZsVs+RC9iKNVkCVQarOdzGqp3cK65CtJoK/pXbnBXPXk5fD4MhCx/K07E4hkrAuTJOt
         pRa6prw7fRCF6k47+yq+si/rJ0ddQv4Lr6iFvOQGytw8IJ/CVJw3tlVp4xYJ5D1vV+XC
         6egyZ8iCP1ke/eLeLh2batvCKszioXRbxIqC2if3iAjJMabm0ZtJRSQiEQouOKu42HYe
         rwEQ==
X-Gm-Message-State: APjAAAXKfhZC+rHE4YBJIE0jDbVZjS4sQ1tmUVQwOjv15IyoO69EWJTh
        +JGZbfRNaOmbl/OXFmzISYw=
X-Google-Smtp-Source: APXvYqy539/IYGmEFTHevv2ZwBuv3oz1itYb6YVrvbuijlb0sHVcJSAc50OwQGxYFHgyt4Fo1eHEhg==
X-Received: by 2002:a37:e50f:: with SMTP id e15mr16096423qkg.192.1572272218527;
        Mon, 28 Oct 2019 07:16:58 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id p59sm5244066qtd.2.2019.10.28.07.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 07:16:57 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3C85C41199; Mon, 28 Oct 2019 11:16:55 -0300 (-03)
Date:   Mon, 28 Oct 2019 11:16:55 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH V2 0/6] perf/probe: Additional fixes for range
 only functions
Message-ID: <20191028141655.GA4943@kernel.org>
References: <157208041894.16551.2733647209130045685.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157208041894.16551.2733647209130045685.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Oct 26, 2019 at 06:00:19PM +0900, Masami Hiramatsu escreveu:
> Hi Arnaldo,
> 
> I've updated examples in patch description in this v2.
> No changes in the code itself. I ran it on Ubuntu 19.04
> (linux-5.0.0-32-generic).
> 
> Please replace previous one with this.

Can you please take a look at my perf/core branch? I have these already
there:

5e72f4349eff perf probe: Fix to show ranges of variables in functions without entry_pc
50fc0fda5f2c perf probe: Fix to show inlined function callsite without entry_pc
d7bf48229b85 perf probe: Fix to list probe event with correct line number
39cee497850a perf probe: Fix to probe an inline function which has no entry pc
6150bad27ebd perf probe: Fix to probe a function which has no entry pc
fdaea9eea92d perf probe: Fix wrong address verification

And I added committer notes doing the tests.

- Arnaldo
 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (6):
>       perf/probe: Fix wrong address verification
>       perf/probe: Fix to probe a function which has no entry pc
>       perf/probe: Fix to probe an inline function which has no entry pc
>       perf/probe: Fix to list probe event with correct line number
>       perf/probe: Fix to show inlined function callsite without entry_pc
>       perf/probe: Fix to show ranges of variables in functions without entry_pc
> 
> 
>  tools/perf/util/dwarf-aux.c    |    6 +++---
>  tools/perf/util/probe-finder.c |   40 ++++++++++++++--------------------------
>  2 files changed, 17 insertions(+), 29 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

-- 

- Arnaldo
