Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F6CC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4A22133F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558996691;
	bh=UA7fj3vTWOkAM0XvKi65JTYz5hudMs3Lz/ggTW86Im0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YWQwVIv9XOSBL1Y68bRVUu3sNPhz4vveFl1JOy5SB2Wwni+VmPL9wTntXO/33qiyc
	 x+1GWyM1r8Jl+vY+c6iC4fNPZ2++GL/4bLq6exL9dUkevT+H2mGPeH4oBnlPtA9BWO
	 wEVsJZ9h8SqFzt2d8tQDtlvWium2AaB2NvFd4YpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfE0WiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 18:38:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727539AbfE0WiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:38:02 -0400
Received: from quaco.ghostprotocols.net (179-240-171-7.3g.claro.net.br [179.240.171.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D647121473;
        Mon, 27 May 2019 22:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558996681;
        bh=UA7fj3vTWOkAM0XvKi65JTYz5hudMs3Lz/ggTW86Im0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ya53kWYfwWpqiWS1GmS4Vh/bNrA6YNiKmcKjeHAQpvZj5lAhzZm7SAnO6LmVz1GhY
         +u3RB7LkCs+cRyyWq97kjqJTiKHL8Mo5lveGNw69dUGTH/EXk73auZxKNEevT8Z5Sg
         pwNMsmK325JRkvZp0QUGwALGJGfqtu1LGfyUX0dY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Shawn Landden <shawn@git.icu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/44] perf data: Fix 'strncat may truncate' build failure with recent gcc
Date:   Mon, 27 May 2019 19:36:51 -0300
Message-Id: <20190527223730.11474-6-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shawn Landden <shawn@git.icu>

This strncat() is safe because the buffer was allocated with zalloc(),
however gcc doesn't know that. Since the string always has 4 non-null
bytes, just use memcpy() here.

    CC       /home/shawn/linux/tools/perf/util/data-convert-bt.o
  In file included from /usr/include/string.h:494,
                   from /home/shawn/linux/tools/lib/traceevent/event-parse.h:27,
                   from util/data-convert-bt.c:22:
  In function ‘strncat’,
      inlined from ‘string_set_value’ at util/data-convert-bt.c:274:4:
  /usr/include/powerpc64le-linux-gnu/bits/string_fortified.h:136:10: error: ‘__builtin_strncat’ output may be truncated copying 4 bytes from a string of length 4 [-Werror=stringop-truncation]
    136 |   return __builtin___strncat_chk (__dest, __src, __len, __bos (__dest));
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Shawn Landden <shawn@git.icu>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
LPU-Reference: 20190518183238.10954-1-shawn@git.icu
Link: https://lkml.kernel.org/n/tip-289f1jice17ta7tr3tstm9jm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data-convert-bt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index e0311c9750ad..9097543a818b 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -271,7 +271,7 @@ static int string_set_value(struct bt_ctf_field *field, const char *string)
 				if (i > 0)
 					strncpy(buffer, string, i);
 			}
-			strncat(buffer + p, numstr, 4);
+			memcpy(buffer + p, numstr, 4);
 			p += 3;
 		}
 	}
-- 
2.20.1

