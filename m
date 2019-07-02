Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC950C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821092184B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562054718;
	bh=XBgL/AxOnIaiBDWMNPVZmAQbbKZScC6wBMWUyyDEQ0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UrI0AVuop890ZCkdE7MLXNfx8e3wtrOe49zxSUUrCVrZztOEnDYkIMKgABeyE6PXk
	 9OEMvD6fgvYEhl1bdvRd/vnvQdwhoVjeZGXpbJOx5BMcyJUeg8ni7LvtydRPSw2AH+
	 RFTMECpiULaFB0rxj2UYeuEpR/vFownIQL3qfRfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfGBIFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbfGBIFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:05:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5198221851;
        Tue,  2 Jul 2019 08:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054711;
        bh=XBgL/AxOnIaiBDWMNPVZmAQbbKZScC6wBMWUyyDEQ0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uqFIXFlpO3wX59mmr+n1k6ozY097JpSAHG7HKxpqPqKt5aVCbgYdmrRUhIz/Ni0ts
         fqi7OYgaUgG8KXB471Z18WYYr+C9RKstQ/8n2joKi47Uks0Kteh77FMqABh24q+Xqp
         HnhGG+ra6WTde3HSj2rHgc3t87jPAXnfom3RIFsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.19 01/72] perf ui helpline: Use strlcpy() as a shorter form of strncpy() + explicit set nul
Date:   Tue,  2 Jul 2019 10:01:02 +0200
Message-Id: <20190702080124.647899315@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080124.564652899@linuxfoundation.org>
References: <20190702080124.564652899@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
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
@@ -24,7 +24,7 @@ static void tui_helpline__push(const cha
 	SLsmg_set_color(0);
 	SLsmg_write_nstring((char *)msg, SLtt_Screen_Cols);
 	SLsmg_refresh();
-	strncpy(ui_helpline__current, msg, sz)[sz - 1] = '\0';
+	strlcpy(ui_helpline__current, msg, sz);
 }
 
 static int tui_helpline__show(const char *format, va_list ap)


