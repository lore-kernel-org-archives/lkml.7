Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B046DC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 18:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835FD20672
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 18:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7Rhnu3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfK2S7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 13:59:20 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34679 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfK2S7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 13:59:20 -0500
Received: by mail-qt1-f195.google.com with SMTP id i17so33415578qtq.1;
        Fri, 29 Nov 2019 10:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SIfzHeBggeKvyRBg8l0Zl5fuaymT1ijt6/Qzfa/epTE=;
        b=W7Rhnu3mrLLQvFsGTyFM9qV6uhEG4ZyZSFoFOo87LQzuPxSBz13zGPGdK2D+T3E997
         BtcRbVXF5IrPgIaeP6edXnjmPWrK9pBK3ZvfId4jnW6YycDZnJjWkL9bjsIh980ipEBu
         g8RKZ0iZEJQDS8iY0L/lVadOXsC6zKowkSdYx67fb4sT7ozxLP2Jkyd8pGTrGN88Ti0R
         RCq5hZ46YowQJHKQrebaXk+CYYpXI0JMk/dC1HrQNtu7ANY4gh4N2L97kptQzLa70p4M
         Vky7OG9iSd1qQLxUirQcp3ZZQNI0XJPkWyq6XVKgqkWta3F8TAzQp5BPZtqRoJ2uvvaQ
         NfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SIfzHeBggeKvyRBg8l0Zl5fuaymT1ijt6/Qzfa/epTE=;
        b=RePb4ONmm27fw0loUzyn6sBn9Kuu+aDfh7x82jJC899uXtqI9+j/DpK4NfIh4RbY2/
         QDaUjgmgUs0QOx1Nn/Uw+wN5dPEyL7quF/aHz7QPpPEt4M4sTO19Q32/hk6ys17Ky5z7
         OU08zJrLrIU+OOv3CmcTOjiw1LSqoUeIBQ7Jf/6yI6FO6yGnrduQeBLsHA0TB2eneqxX
         3d7DzzDJH9dThdL+Ux1BzqSPYt5QqVsmPcLLV5MzANu8knNOnK7MVh4LR78/55LTlxPf
         5ZtSGO6vIWktiWLfpyvNWXl5YpTezn8IdafA6FPyMj9WAHAkvJz68sEVYIigCxnF4PIK
         4SQw==
X-Gm-Message-State: APjAAAX+EEC5lt5f9gk808mf4eeMsM1bIATmurM1eEO07gmS7fCvkJLv
        PHhggraB5GGaK+I5gMPBI/0=
X-Google-Smtp-Source: APXvYqwwzO2+FSEOu8GC6WX1wjpdA6mkF0S2Ntoyk/OIApYeESykFh6CED3VWzm+rd+/YNzqL+R0wQ==
X-Received: by 2002:ac8:1afc:: with SMTP id h57mr42295281qtk.250.1575053958977;
        Fri, 29 Nov 2019 10:59:18 -0800 (PST)
Received: from quaco.ghostprotocols.net (179-240-153-127.3g.claro.net.br. [179.240.153.127])
        by smtp.gmail.com with ESMTPSA id v189sm10662727qkc.37.2019.11.29.10.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 10:59:18 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 32D59405B6; Fri, 29 Nov 2019 15:59:14 -0300 (-03)
Date:   Fri, 29 Nov 2019 15:59:14 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 04/15] perf tools: Add map_groups to 'struct
 addr_location'
Message-ID: <20191129185914.GE4063@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
 <20191112183757.28660-5-acme@kernel.org>
 <20191129134056.GE14169@krava>
 <20191129151733.GC26963@kernel.org>
 <20191129160631.GD26963@kernel.org>
 <20191129180354.GB26903@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129180354.GB26903@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 29, 2019 at 07:03:54PM +0100, Jiri Olsa escreveu:
> On Fri, Nov 29, 2019 at 01:06:31PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Nov 29, 2019 at 12:17:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, Nov 29, 2019 at 02:40:56PM +0100, Jiri Olsa escreveu:
> > > > > +++ b/tools/perf/util/callchain.c
> > > > > @@ -1119,8 +1119,8 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
> > > > >  			goto out;
> > > > >  	}
> > > > >  
> > > > > -	if (al->map->groups == &al->machine->kmaps) {
> > > > > -		if (machine__is_host(al->machine)) {
> > > > > +	if (al->mg == &al->mg->machine->kmaps) {
> > 
> > > > heya, I'm getting segfault because of this change
> > 
> > > > perf record --call-graph dwarf ./ex
> > 
> > > > 	(gdb) r report --stdio
> > > > 	Program received signal SIGSEGV, Segmentation fault.
> > > > 	fill_callchain_info (al=0x7fffffffa1b0, node=0xcd2bd0, hide_unresolved=false) at util/callchain.c:1122
> > > > 	1122            if (al->maps == &al->maps->machine->kmaps) {
> > > > 	(gdb) p al->maps
> > > > 	$1 = (struct maps *) 0x0

> > > > I wish all those map changes would go through some review,
> > > > I have no idea how the code works now ;-)

> > > ouch, I did tons of tests, obviously some more, and reviewing, would
> > > catch these, my bad, will try and fix this...

> > > And yeah, I reproduced the problem, working on a fix.

> > Can you try with this one-liner?

> yep, it fixes the issue for me

Thanks, I'm taking that as a Tested-by: you, in addition to the
Reported-by,

- Arnaldo
