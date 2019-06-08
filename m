Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFFDC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223C921707
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994512;
	bh=wQyL4LjmjDawgepeRfytkLoolpiBmgFOk14i/KzOLxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YN1VUlmp0akL94MFwK7D94udH5AA7HyxhCjCyz76I0b/DJkLjp05GnlngIQ3WWf8G
	 ca6ogbdQM6+HKwGXMt3zBno+ZvAWrZIldhiSlZZeX9UJGD7S1o7UXfHtxFgYLQwXTA
	 ECXfiYz2poiVF/mB+/P63egDGZMeKPXW3pzF/ogg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfFHLsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728995AbfFHLs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:48:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8087214AF;
        Sat,  8 Jun 2019 11:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994507;
        bh=wQyL4LjmjDawgepeRfytkLoolpiBmgFOk14i/KzOLxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fqSF4pK+anlCysfWwR1HvGUM0xoHkylG/ceMwoUGnMFeUHXm09UoyuHeSJFo5V0uY
         mYOeRnLROBNHaIsXT3ojwmef/f+4CQKY0z3VybAyQZLAe5vK8vFIz26jgSruTTvxh1
         CVgv+BUnG99+cCD+Fs38tb5vpgBE0pGyLawbagO8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shawn Landden <shawn@git.icu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 11/20] perf data: Fix 'strncat may truncate' build failure with recent gcc
Date:   Sat,  8 Jun 2019 07:47:47 -0400
Message-Id: <20190608114756.9742-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608114756.9742-1-sashal@kernel.org>
References: <20190608114756.9742-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shawn Landden <shawn@git.icu>

[ Upstream commit 97acec7df172cd1e450f81f5e293c0aa145a2797 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/data-convert-bt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 7123f4de32cc..226f4312b8f3 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -265,7 +265,7 @@ static int string_set_value(struct bt_ctf_field *field, const char *string)
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

