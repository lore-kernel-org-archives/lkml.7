Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC1AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108D2206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOcSTbr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfK0QGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:06:04 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38536 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0QGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:06:03 -0500
Received: by mail-qk1-f194.google.com with SMTP id b8so5027701qkk.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 08:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pm0nHf2qWbhYZmIpkrxRFtnuowMm90TkL50DL+ud1fI=;
        b=BOcSTbr2ARkuCWvACG1TjIuzuMJbsFmzz7ZIPsRqOh3pzJChnAEcHP/4BHhgt9VSlt
         HWQJUy166gaiGD9B3X7grKTJBjqeucb4wq03qieInR9yWmfrermFKlbdvqyOh6kMKOpf
         MaI7F/Vlbv8m/aYTNeS8Rn3F4R+Y+dKFnd4NdOaukRSzk9pw/DUe4ttpPryvrdh4+wOW
         GUnagXkqZ1J+FpJEMtNkEvOWA+jFfY2Mp2xiAUOGselzFuFcKpJeNnXKv2GfufktA6FX
         kgjO+ssxE6Kx5HB8OY7E2SdCnUl+Nm+YXpiGs0yRIUSQE5GWh6LmHpjccsbD6mhPi8yl
         w9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pm0nHf2qWbhYZmIpkrxRFtnuowMm90TkL50DL+ud1fI=;
        b=dhld02ym/3XWdbcVWWqtmjvmDE3lb2JSFec3e4dF0C6z2/Da5QEkOQVS8Qp8RHYEkv
         xGHKPBTpfEqs9I9SYLEdWUyw+igV/EV7VeWqQuP0z4uiJN7TyN5WonGoSwi4BAw0HCY9
         HgPvCPoMY2RgBrK3TEOYH467VbD1vjTPUesQcRlBBiV9nXmebPsX0xo0cOfnXMGhbYD0
         kE6Xbi7B6+6hMbk6qWG1id3nOVt9Yi4vm9pkehL1c72BnE4UOvfplp0Iq6woMI3P0aw9
         DKlMOAod/GTp/UQYKlzMJx2AkoSvVZWElYmIltPB0w1UrsTjD8wn08nL+Vl7S3NETNh2
         vz0Q==
X-Gm-Message-State: APjAAAWsgw/sUeaoMXrF+qRCCNC7pQp67wR3Tb9QZuoHLNZWBU3yz4en
        kmSG71fgi34KrjAO1ch8iT0=
X-Google-Smtp-Source: APXvYqyv/08F7hmnFJQQMk9ilBoq5vrurb3IInnTI/W74N64kUQ7wb5MFzxn26RV6v9/JkS71FHxzQ==
X-Received: by 2002:a05:620a:228:: with SMTP id u8mr5159058qkm.88.1574870762207;
        Wed, 27 Nov 2019 08:06:02 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id y15sm6992048qka.6.2019.11.27.08.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 08:06:01 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DABC340D3E; Wed, 27 Nov 2019 13:05:58 -0300 (-03)
Date:   Wed, 27 Nov 2019 13:05:58 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf jit: move test functionality in to a test
Message-ID: <20191127160558.GM22719@kernel.org>
References: <20191126235913.41855-1-irogers@google.com>
 <20191127152328.GI22719@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127152328.GI22719@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 27, 2019 at 12:23:28PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Nov 26, 2019 at 03:59:13PM -0800, Ian Rogers escreveu:
> > Adds a test for minimal jit_write_elf functionality.
> 
> Thanks, tested and applied.

Had to apply this to have it built in systems where HAVE_JITDUMP isn't
defined:

diff --git a/tools/perf/tests/genelf.c b/tools/perf/tests/genelf.c
index d392e9300881..28dfd17a6b9f 100644
--- a/tools/perf/tests/genelf.c
+++ b/tools/perf/tests/genelf.c
@@ -17,16 +17,15 @@
 
 #define TEMPL "/tmp/perf-test-XXXXXX"
 
-static unsigned char x86_code[] = {
-	0xBB, 0x2A, 0x00, 0x00, 0x00, /* movl $42, %ebx */
-	0xB8, 0x01, 0x00, 0x00, 0x00, /* movl $1, %eax */
-	0xCD, 0x80            /* int $0x80 */
-};
-
 int test__jit_write_elf(struct test *test __maybe_unused,
 			int subtest __maybe_unused)
 {
 #ifdef HAVE_JITDUMP
+	static unsigned char x86_code[] = {
+		0xBB, 0x2A, 0x00, 0x00, 0x00, /* movl $42, %ebx */
+		0xB8, 0x01, 0x00, 0x00, 0x00, /* movl $1, %eax */
+		0xCD, 0x80            /* int $0x80 */
+	};
 	char path[PATH_MAX];
 	int fd, ret;
 
@@ -48,6 +47,6 @@ int test__jit_write_elf(struct test *test __maybe_unused,
 
 	return ret ? TEST_FAIL : 0;
 #else
-	return TEST_SKIPPED;
+	return TEST_SKIP;
 #endif
 }


