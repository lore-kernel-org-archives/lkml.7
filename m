Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41CCC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC98206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doTmgIkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfDZOUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:20:35 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40303 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDZOUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:20:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id y49so1403083qta.7;
        Fri, 26 Apr 2019 07:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7zyqaEXDAFgaDLRc1tG3yLWvPTQmX1XNRx4pI6zsCi8=;
        b=doTmgIkI277Epc1dS3ZiFxR7Jrk6AbWzefK0soNZZhEM8byDTrv2n8Ctb6WbR969HT
         KyX3OqNktFJx5ERng4HtHqCYnF/ZC2GLgq7A+PDG9SKlTScPC5JLUHE9QPpKcwrmtX+o
         rIrh0pirOduH+pXIh0OyXS5tQlG4kmXFJoCANBbs5G/3OJnEnmphwFghtzGvFeqnIjO1
         Vn+V7TtEp9cwC6WA6uD3kqjuypel/Ft0EAV8jwfbuaAklqqxO4ZGCrVQI72Eyr1PEgWf
         QL9aUYXLbNTBEzjhXF8owRH3z8S5XoPTHQ7r2lk4WqbxeyWa6N9HwKWYyxBBy/rZz5Ok
         ZjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7zyqaEXDAFgaDLRc1tG3yLWvPTQmX1XNRx4pI6zsCi8=;
        b=ZQneFtE9DFlU7bCX3PkiVpe8pyuyLJe1/tLLmi3FjTv8WnmrIjfnAmzFATcflcSM/w
         bB+a8obM9IFL0Wzxb9IIJGeS7c6EvlCMknFloxCZFVMMLARFbMzmS1mbvhHpO07qym8o
         ce3k/XTd+ZfEwCoeVSu9IId4MWDe69lZUzbL34OKDze92tzmexzJ77m82tjsstWT0Ddg
         jsZXVx0tGsUaL/0wsXMaQRb2JyYod4FIYLsdh7Bst8DVQTfdVwo00XoStSgKyAhMWgGW
         HO7cwJvXDCdFvokB9oGUbySbGzlpo8fuaRZZQcGCUlpaQWlSa6ILPTbzCdyTStNvqEwk
         X+jg==
X-Gm-Message-State: APjAAAW4nQOG/6JROEKP6uQ+vxDYcVoIWNMnd3lIN+jnI6KBQZgZ4FY7
        ztTIOqFj6xxIiJoBfPw0LNOVugM+
X-Google-Smtp-Source: APXvYqzoO/kthcxFbcW8PI2Yo2KWwI8EXcs1p0ApRv9c4fKfdhKOr0j9DH0BL2npGkOb/IEzAJSUJA==
X-Received: by 2002:ac8:7647:: with SMTP id i7mr35621606qtr.38.1556288434052;
        Fri, 26 Apr 2019 07:20:34 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id z8sm16585686qth.62.2019.04.26.07.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 07:20:33 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3CB914111F; Fri, 26 Apr 2019 11:10:32 -0300 (-03)
Date:   Fri, 26 Apr 2019 11:10:32 -0300
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, jolsa@redhat.com
Subject: Re: [PATCH] perf/report: Report OOM in perf report status line
Message-ID: <20190426141032.GA23426@kernel.org>
References: <20190423105303.61683-1-tmricht@linux.ibm.com>
 <20190426140907.GB22086@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190426140907.GB22086@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 26, 2019 at 11:09:07AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Apr 23, 2019 at 12:53:03PM +0200, Thomas Richter escreveu:
> > An -ENOMEM error is not reported in the GTK GUI.
> > Instead this error message pops up on the screen:
> > 
> > [root@m35lp76 perf]# ./perf  report -i perf.data.error68-1
> > 
> > 	Processing events... [974K/3M]
> > 	Error:failed to process sample
> > 
> > 	0xf4198 [0x8]: failed to process type: 68
> 
> Thanks, applied to perf/urgent.

Well, I tried to, now trying to fix this...


[acme@quaco perf]$ m
make: Entering directory '/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j8' parallel build
  INSTALL  GTK UI
  INSTALL  trace_plugins
  CC       /tmp/build/perf/util/session.o
util/session.c: In function ‘perf_session__process_events’:
util/session.c:1936:7: error: ‘skip’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
   err = skip;
   ~~~~^~~~~~
util/session.c:1874:6: note: ‘skip’ was declared here
  s64 skip;
      ^~~~
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/util/.session.o.tmp': No such file or directory
make[4]: *** [/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/session.o] Error 1
make[3]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
make[2]: *** [Makefile.perf:559: /tmp/build/perf/perf-in.o] Error 2
make[1]: *** [Makefile.perf:215: sub-make] Error 2
make: *** [Makefile:110: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf/tools/perf'

 Performance counter stats for 'make -k O=/tmp/build/perf -C tools/perf install-bin':

     4,913,757,758      cycles:u
     7,432,572,002      instructions:u            #    1.51  insn per cycle

       1.345541349 seconds time elapsed

       1.412713000 seconds user
       0.572540000 seconds sys


[acme@quaco perf]$
