Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D03C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C510E214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxWxkJAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389862AbfDRTMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:12:55 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41057 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfDRTMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:12:55 -0400
Received: by mail-ua1-f67.google.com with SMTP id l22so1108128uao.8;
        Thu, 18 Apr 2019 12:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rpL0d8MjwshzMxV+gjiSBZ6YvAWKpJ7Ot+t/hjN16F4=;
        b=SxWxkJAUzXF3+QtsVZ5VaCdmb38xyUf2Y92pZFu8WoQINdzAe6B0B5wugVHCwbe6If
         kubQ/KXjo/z95zbzM6gPtfCOs9o5XuUYDnL5xtPYfvCYnDvGavYgtphGOgBqDQH8E+C0
         17OmuKqezJgEVQmzaV3AUkxaccwIGHT02AAz2afeibTUnpI4y3LMP2IQzXZLiMtaPor4
         gtmiiF8/MI6nHbZmJAmDlf/aZbTIurUci1WK2TgFwU1J9/87DqUEEu6mKlwL2SsJjQfR
         93FxiaIOvjZu3u/5TqD+/ONrzt/sJq/WmP367G/su8hgJJgSz9AhtfiCcuMmiUgd7PzX
         LiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rpL0d8MjwshzMxV+gjiSBZ6YvAWKpJ7Ot+t/hjN16F4=;
        b=HPItyMtrqqC/z/mAx/3tOvW/TcIPbORXGlAzLx84KrKigpxKlzhM0pjw+2YNAuu2Qe
         TErnQreZMeNcm/8lORErm7fzC44k2r5ZZx6C2JILKUcbYfs2EBDLZyh3Y8i2/j3a4BcX
         pY99pfVszqTcO1j0deYbWPVjaJKC9CwuIwbZ+NU/B7Nzomv/TZ92R8mS60uGIQPxTATX
         J715F8kLfYBpJl+zGQHI57ovZDj8+0L1Dqiz6z6Tmillg0pahzKLSqyubK82ew592wma
         kIuZfLGZLf3EgTnsPHreqt8inBuJ8odN0/bzL8Qls8ps2UA+R0WLt2Ctavynl+W4kj+X
         MiGg==
X-Gm-Message-State: APjAAAX2xlMpO5egSPmU4U0hGwkyBYUmKwWtgsdt493+gnSQKHXYuDE+
        jfKsEH4dXcDGAzpve4r9wwbb8qBB
X-Google-Smtp-Source: APXvYqxfWK875QXBv+MhcG6VV2ijofQpwp1K6wT1G7sJkwGu8IeEh2S0eomMdIdF8/kxGPwAYaUR8g==
X-Received: by 2002:ab0:2692:: with SMTP id t18mr24216339uao.106.1555614773906;
        Thu, 18 Apr 2019 12:12:53 -0700 (PDT)
Received: from vps.qemfd.net (vps.qemfd.net. [173.230.130.29])
        by smtp.gmail.com with ESMTPSA id r3sm2252962vkr.18.2019.04.18.12.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 12:12:53 -0700 (PDT)
Received: from schwarzgerat.orthanc (unknown [10.88.0.2])
        by vps.qemfd.net (Postfix) with ESMTP id F196A2B805;
        Thu, 18 Apr 2019 15:12:52 -0400 (EDT)
Received: by schwarzgerat.orthanc (Postfix, from userid 1000)
        id D647C260119; Thu, 18 Apr 2019 15:12:52 -0400 (EDT)
Date:   Thu, 18 Apr 2019 15:12:52 -0400
From:   Nick Black <dankamongmen@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Simon Horman <horms@verge.net.au>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpupower: correct spelling of interval
Message-ID: <20190418191252.GA19135@schwarzgerat.orthanc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up multiple instances of "intervall" to correct
"interval" (all save one Italian instance).

Signed-off-by: Nick Black <dankamongmen@gmail.com>
---
 tools/power/cpupower/man/cpupower-monitor.1 | 2 +-
 tools/power/cpupower/po/cs.po               | 2 +-
 tools/power/cpupower/po/de.po               | 2 +-
 tools/power/cpupower/po/fr.po               | 2 +-
 tools/power/cpupower/po/it.po               | 2 +-
 tools/power/cpupower/po/pt.po               | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/man/cpupower-monitor.1 b/tools/power/cpupower/man/cpupower-monitor.1
index 914cbb9d9cd0..70a56476f4b0 100644
--- a/tools/power/cpupower/man/cpupower-monitor.1
+++ b/tools/power/cpupower/man/cpupower-monitor.1
@@ -61,7 +61,7 @@ Only display specific monitors. Use the monitor string(s) provided by \-l option
 .PP
 \-i seconds
 .RS 4
-Measure intervall.
+Measure interval.
 .RE
 .PP
 \-c
diff --git a/tools/power/cpupower/po/cs.po b/tools/power/cpupower/po/cs.po
index cb22c45c5069..bfc7e1702ec9 100644
--- a/tools/power/cpupower/po/cs.po
+++ b/tools/power/cpupower/po/cs.po
@@ -98,7 +98,7 @@ msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:74
 #, c-format
-msgid "\t -i: time intervall to measure for in seconds (default 1)\n"
+msgid "\t -i: time interval to measure for in seconds (default 1)\n"
 msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:75
diff --git a/tools/power/cpupower/po/de.po b/tools/power/cpupower/po/de.po
index 840c17cc450a..70887bb8ba95 100644
--- a/tools/power/cpupower/po/de.po
+++ b/tools/power/cpupower/po/de.po
@@ -95,7 +95,7 @@ msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:74
 #, c-format
-msgid "\t -i: time intervall to measure for in seconds (default 1)\n"
+msgid "\t -i: time interval to measure for in seconds (default 1)\n"
 msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:75
diff --git a/tools/power/cpupower/po/fr.po b/tools/power/cpupower/po/fr.po
index b46ca2548f86..b6e505b34e4a 100644
--- a/tools/power/cpupower/po/fr.po
+++ b/tools/power/cpupower/po/fr.po
@@ -95,7 +95,7 @@ msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:74
 #, c-format
-msgid "\t -i: time intervall to measure for in seconds (default 1)\n"
+msgid "\t -i: time interval to measure for in seconds (default 1)\n"
 msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:75
diff --git a/tools/power/cpupower/po/it.po b/tools/power/cpupower/po/it.po
index f80c4ddb9bda..a1deeb52c9e0 100644
--- a/tools/power/cpupower/po/it.po
+++ b/tools/power/cpupower/po/it.po
@@ -95,7 +95,7 @@ msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:74
 #, c-format
-msgid "\t -i: time intervall to measure for in seconds (default 1)\n"
+msgid "\t -i: time interval to measure for in seconds (default 1)\n"
 msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:75
diff --git a/tools/power/cpupower/po/pt.po b/tools/power/cpupower/po/pt.po
index 990f5267ffe8..902186585bb9 100644
--- a/tools/power/cpupower/po/pt.po
+++ b/tools/power/cpupower/po/pt.po
@@ -93,7 +93,7 @@ msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:74
 #, c-format
-msgid "\t -i: time intervall to measure for in seconds (default 1)\n"
+msgid "\t -i: time interval to measure for in seconds (default 1)\n"
 msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:75
-- 
2.20.1


-- 
nick black -=- https://www.nick-black.com
to make an apple pie from scratch,
you need first invent a universe.
