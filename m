Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F594C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC97206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgsjGJpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfHMVfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:35:13 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36392 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfHMVfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:35:12 -0400
Received: by mail-qk1-f194.google.com with SMTP id d23so6131794qko.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 14:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qSZMaG3xbRG8FNk4uoR8OBjr9+aEDabN2v5+j/YqxS4=;
        b=bgsjGJpXccNAr7l7+QXWZ8M8CMdF81R5jy0iolNFm5bDoBh6F5ZH1tFORPU5VQDX29
         i3FQ5dYKqvWGmagJL87x6QqnJT7unzyVJNlpAoW7qa+P1yI04j89StWiHaFSJ/yo3DRq
         YUeBptjevmqQ1vFkbB8d3mHbuvzRMWZXpkjYltCWPDLZyVE7P6C/42RlCow6R8WqLr17
         jV9SJMX5uDgmdSJALD+1Ti8pHa54ywLpvTIs09X6ShS63V+nnaCS8PxCvLYDm4RLMHRV
         JZiF5jvTvZKyeD60ukIIgEunxVgAWesWeSv4XxJUJH+zC1c0ifzwnQHAsMpBHcqBrjBC
         4QRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qSZMaG3xbRG8FNk4uoR8OBjr9+aEDabN2v5+j/YqxS4=;
        b=ZTGnx1KXj1+YT4HJbJ7h5t6XiVsWh48L2CUKFDWdjyMKO8JROL5zsVvfsA84n4G1Qt
         by1/8lOSd0OWb4xpIpQYG3Ny8MlaLD71qvTBG+zQ2vukHNVt8XYeQBjmaGB2PdzgcfcV
         RECpAyZEQTDp5y7r12jEFI5Wr4WW6Uo6KfL1ORDVDt8vm83OWBFjndAaK3OSgmJBkQcM
         W6kbkNWGo9f4p7TFeYMB9urFkATlNXUQrd7dQa/ZOwzN0+XTFbe3P164UsPa6aHKexEz
         wc03poXNJlOUe9xGfiHgdCoe2RkdGP6x3GJTB+hZP01bvH6GMYEuWE+CG+d8LyonUsql
         3uTg==
X-Gm-Message-State: APjAAAUZ2J6ELu7Pl1GRkG8JLcuzAA9Ek4ecxs9OqPw9cB1kdjeJR3Qi
        NRWPc05EpIhAMxOtTL+KJ7c=
X-Google-Smtp-Source: APXvYqw3mvAsMm6k7IgQvdbGGYNuLQo9P5sQmDZ3gjH41gjN3fW3SEOf1FLcscJQq/DrErUTfmATnw==
X-Received: by 2002:a05:620a:1513:: with SMTP id i19mr7941055qkk.284.1565732111540;
        Tue, 13 Aug 2019 14:35:11 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.159.8.214])
        by smtp.gmail.com with ESMTPSA id f11sm1096693qto.62.2019.08.13.14.35.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 14:35:10 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 12CA644639; Tue, 13 Aug 2019 18:35:08 -0300 (-03)
Date:   Tue, 13 Aug 2019 18:35:08 -0300
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Wang Nan <wangnan0@huawei.com>, He Kuang <hekuang@huawei.com>,
        Michal Marek <mmarek@suse.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Stephane Eranian <eranian@google.com>,
        Paul Turner <pjt@google.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: Re: [PATCH] tools lib traceevent: Fix "robust" test of
 do_generate_dynamic_list_file
Message-ID: <20190813213508.GL9280@kernel.org>
References: <20190805130150.25acfeb1@gandalf.local.home>
 <20190813172112.34fadd4e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813172112.34fadd4e@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 13, 2019 at 05:21:12PM -0400, Steven Rostedt escreveu:
> On Mon, 5 Aug 2019 13:01:50 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > [
> >   Not sure why I wasn't Cc'd on the original patch (or the one before that)
> >   but I guess I need to add tools/lib/traceevent under MAINTAINERs for
> >   perhaps tracing?
> > ]
> > 
> 
> Ping?

Will apply later today, thanks,

- Arnaldo
 
> -- Steve
> 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > The tools/lib/traceevent/Makefile had a test added to it to detect a failure
> > of the "nm" when making the dynamic list file (whatever that is). The
> > problem is that the test sorts the values "U W w" and some versions of sort
> > will place "w" ahead of "W" (even though it has a higher ASCII value, and
> > break the test.
> > 
> > Add 'tr "w" "W"' to merge the two and not worry about the ordering.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 6467753d61399 ("tools lib traceevent: Robustify do_generate_dynamic_list_file")
> > Reported-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  tools/lib/traceevent/Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
> > index 3292c290654f..8352d53dcb5a 100644
> > --- a/tools/lib/traceevent/Makefile
> > +++ b/tools/lib/traceevent/Makefile
> > @@ -266,8 +266,8 @@ endef
> >  
> >  define do_generate_dynamic_list_file
> >  	symbol_type=`$(NM) -u -D $1 | awk 'NF>1 {print $$1}' | \
> > -	xargs echo "U W w" | tr ' ' '\n' | sort -u | xargs echo`;\
> > -	if [ "$$symbol_type" = "U W w" ];then				\
> > +	xargs echo "U w W" | tr 'w ' 'W\n' | sort -u | xargs echo`;\
> > +	if [ "$$symbol_type" = "U W" ];then				\
> >  		(echo '{';						\
> >  		$(NM) -u -D $1 | awk 'NF>1 {print "\t"$$2";"}' | sort -u;\
> >  		echo '};';						\

-- 

- Arnaldo
