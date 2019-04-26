Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599A9C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288E7206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhUNbksF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfDZOQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:16:17 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35577 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfDZOQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:16:17 -0400
Received: by mail-qk1-f193.google.com with SMTP id n81so1970410qke.2;
        Fri, 26 Apr 2019 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dP7J+8nxZ+kjQW0DXZh/ipoOUjxFN2AVNPeNAiwfJxY=;
        b=OhUNbksF262Q+nK/cgPWUTRrf8B1Ebw6XCxSNsHsyPLz9oLG+g4X7/gpW1teasMUlZ
         pEzRgilgCHx9we68ks8GLNAQC1+uv3BpxaSK2kFVvoyrTFSrMThHPdtyW2WO32JVbjrG
         +ZtNVeokJr8LK6iKoVhGlwVE+Pykrrb/yJcJBQWREjwXeV5TbfTkvEC/IUYBhkIt2xal
         9x0lFa3EeFlwBYtqBeCwNywGOJkoHRHoNe+1SYXUC0KYQOdeBC3EtoxTDXLW98TiqREi
         T5rMVtM1PjRbX1pImMmYb/E46kHK0Nira0y9YRWMvUrMtiRwzZYwwIi8Z+vS7C1hUhKc
         lrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dP7J+8nxZ+kjQW0DXZh/ipoOUjxFN2AVNPeNAiwfJxY=;
        b=fUGAKqtI3xstoSJ6fNQEhNMjRO8EgcHBJ3awzdoX2exq5lYD8c9RqHZAzdMaLU/sPO
         K0IHLrXRSH5T4lkWLj5WiXOJNW6apoLHiLcJQoTvl/8HZpFQwy331Gki7X2lhmEoynXa
         M4lDBcKxPTkgGEpUUn/n6uKHHTdDvKgt5XnWWc/RP77p5iM5R6UKfGUYmlHQtPTcgkHw
         VxkKAaanYFRMgKPdB3AP4XokYCKarZTtzv1Z8lZmS0Sgz61vkYur9RVYlhR3xrQz4dnY
         +g39vzOTeDagaEQ2o8n6iWftdI/8vUznhMEg/xEkaq+RoMIZYROrUkxyfBIKgnIU+53s
         uKZA==
X-Gm-Message-State: APjAAAVO/qYDPth7LrIeXN+49/b52xwEwvPlpy7TRo2OIod4SwrDtpDQ
        oJL5I8eh9xjoMuje4Z/rdSqdnhKJ
X-Google-Smtp-Source: APXvYqzF5Mlqqdaol9TFuWNx8kM1TDiWqjagbdy6grgdXHLMeIiww/MHXAUpvBULuRIPdtBLKVmX3A==
X-Received: by 2002:a05:620a:1403:: with SMTP id d3mr7926683qkj.167.1556288175884;
        Fri, 26 Apr 2019 07:16:15 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id g50sm2625357qtg.83.2019.04.26.07.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 07:16:14 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E5A8341120; Fri, 26 Apr 2019 11:16:07 -0300 (-03)
Date:   Fri, 26 Apr 2019 11:16:07 -0300
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, jolsa@redhat.com
Subject: Re: [PATCH] perf/report: Report OOM in perf report status line
Message-ID: <20190426141607.GB23426@kernel.org>
References: <20190423105303.61683-1-tmricht@linux.ibm.com>
 <20190426140907.GB22086@kernel.org>
 <20190426141032.GA23426@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190426141032.GA23426@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 26, 2019 at 11:10:32AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Apr 26, 2019 at 11:09:07AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Apr 23, 2019 at 12:53:03PM +0200, Thomas Richter escreveu:
> > > An -ENOMEM error is not reported in the GTK GUI.
> > > Instead this error message pops up on the screen:
> > > 
> > > [root@m35lp76 perf]# ./perf  report -i perf.data.error68-1
> > > 
> > > 	Processing events... [974K/3M]
> > > 	Error:failed to process sample
> > > 
> > > 	0xf4198 [0x8]: failed to process type: 68
> > 
> > Thanks, applied to perf/urgent.
> 
> Well, I tried to, now trying to fix this...
> 
> 
> [acme@quaco perf]$ m
> make: Entering directory '/home/acme/git/perf/tools/perf'
>   BUILD:   Doing 'make -j8' parallel build
>   INSTALL  GTK UI
>   INSTALL  trace_plugins
>   CC       /tmp/build/perf/util/session.o
> util/session.c: In function ‘perf_session__process_events’:
> util/session.c:1936:7: error: ‘skip’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    err = skip;
>    ~~~~^~~~~~
> util/session.c:1874:6: note: ‘skip’ was declared here
>   s64 skip;
>       ^~~~
> cc1: all warnings being treated as errors
> mv: cannot stat '/tmp/build/perf/util/.session.o.tmp': No such file or directory
> make[4]: *** [/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/session.o] Error 1
> make[3]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
> make[2]: *** [Makefile.perf:559: /tmp/build/perf/perf-in.o] Error 2
> make[1]: *** [Makefile.perf:215: sub-make] Error 2
> make: *** [Makefile:110: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf/tools/perf'

So, here is your patch:

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b17f1c9bc965..e89716175588 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1930,10 +1930,10 @@ reader__process_events(struct reader *rd, struct perf_session *session,

        if (size < sizeof(struct perf_event_header) ||
            (skip = rd->process(session, event, file_pos)) < 0) {
-               pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
+               pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
                       file_offset + head, event->header.size,
-                      event->header.type);
-               err = -EINVAL;
+                      event->header.type, strerror(-skip));
+               err = skip;
                goto out;
        }

[acme@quaco perf]$

What happens if (size < sizeof(struct perf_event_header)) is true? size
will have an undefined value, so the right thing is to have this patch
on top of yours, so that err get, as before, set to -EINVAL when the
size is less than the perf_event_header sizeof:

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e89716175588..bad5f87ae001 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1928,6 +1928,8 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 	size = event->header.size;
 
+	skip = -EINVAL;
+
 	if (size < sizeof(struct perf_event_header) ||
 	    (skip = rd->process(session, event, file_pos)) < 0) {
 		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",

---

With two Reviewed-by tags, I jumped to quickly at applying, please
compile test next time guys ;-) :-)

- Arnaldo
