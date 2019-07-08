Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20672C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DB5216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599041;
	bh=fHVNVZ/yi3kAe7zp1/zq7MgpT0N4EdP/+nIB0OHB9BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SxAEHIF+LOCdZHA9THNeYEDSpZ+LnSfqApTqV3Nx1MX650IVTvcZ5D7lMZJPx76ol
	 27v856gBSRt5MBaasHIpJkcA13NjmsaM+AgfndTtHx653PdzLCS/p9AnzPRG2zVnWM
	 EZQ3wNqg592dzewOcXEmW4Jfz2o2nx/2g2MVrlyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbfGHPRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:17:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732777AbfGHPRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:17:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3862E2166E;
        Mon,  8 Jul 2019 15:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599033;
        bh=fHVNVZ/yi3kAe7zp1/zq7MgpT0N4EdP/+nIB0OHB9BY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BrRfn3aUa45dzJRVHSqsOwEQL+K+J8H2dzu14Qx+K/dkNA70zdsUUKp/6NOmTxZlB
         g/bCFJDIk5GztoK0HtkzdEHFM+S1bLgJ1+MMf/RQxpPsHPiG1OUghmm4J8Pbp4XA2H
         RQgj623eUujfebjH9hMHw/yCYkiBeoEdBL1fY/sY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.4 29/73] perf ui helpline: Use strlcpy() as a shorter form of strncpy() + explicit set nul
Date:   Mon,  8 Jul 2019 17:12:39 +0200
Message-Id: <20190708150522.673884057@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit 4d0f16d059ddb91424480d88473f7392f24aebdc upstream.

The strncpy() function may leave the destination string buffer
unterminated, better use strlcpy() that we have a __weak fallback
implementation for systems without it.

In this case we are actually setting the null byte at the right place,
but since we pass the buffer size as the limit to strncpy() and not
it minus one, gcc ends up warning us about that, see below. So, lets
just switch to the shorter form provided by strlcpy().

This fixes this warning on an Alpine Linux Edge system with gcc 8.2:

  ui/tui/helpline.c: In function 'tui_helpline__push':
  ui/tui/helpline.c:27:2: error: 'strncpy' specified bound 512 equals destination size [-Werror=stringop-truncation]
    strncpy(ui_helpline__current, msg, sz)[sz - 1] = '\0';
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: e6e904687949 ("perf ui: Introduce struct ui_helpline")
Link: https://lkml.kernel.org/n/tip-d1wz0hjjsh19xbalw69qpytj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/ui/tui/helpline.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/ui/tui/helpline.c
+++ b/tools/perf/ui/tui/helpline.c
@@ -23,7 +23,7 @@ static void tui_helpline__push(const cha
 	SLsmg_set_color(0);
 	SLsmg_write_nstring((char *)msg, SLtt_Screen_Cols);
 	SLsmg_refresh();
-	strncpy(ui_helpline__current, msg, sz)[sz - 1] = '\0';
+	strlcpy(ui_helpline__current, msg, sz);
 }
 
 static int tui_helpline__show(const char *format, va_list ap)


