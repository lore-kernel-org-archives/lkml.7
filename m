Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA7BC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D902183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIy1bJ6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfFNSj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:39:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45105 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFNSjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:39:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id s21so1998864pga.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 11:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Vv8HpRf7Hu/R/ZRM8tgXZJAcDsLxD756/PD99XhHUQ0=;
        b=tIy1bJ6dHcsVslfqVQNgSb97wWB7k4tEE79aBbBlaLKfvzQYeFL5Gx4Hfyx+Gfr/0u
         DnDEB7R2jsXWhanKOucZBllYkNCWLhKgfFDEMnykIVu/LKYbaWjcjFOponK80G0p71IQ
         7BkZoOkEd3SipZDmUiV5kQJOwrVki2nZGANN2ncaNBT1bW5aJDX01ZFK1lBC1ImbFZ8S
         9D7DQm+dBYOqrszl3abwmenOvQfG9TccwuzM7rBVivqnjjBXMeKcHmBv50xye7PP/ZHE
         spz/XW4NBhxLmwLouW1frMIyJck/3aWKtlCcRpUV+Q6joe/KTZKwh7clCV0p8kXW+v39
         fL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vv8HpRf7Hu/R/ZRM8tgXZJAcDsLxD756/PD99XhHUQ0=;
        b=qaWEXGjo6T6OKasx5Q/kGJjXFwxBpNqvbPQ9Qv00ZRH913ElgjFRnruDpXraXRnSWU
         LoZe4rn9VN7kJedI+8CYh9ODV87G5MDuPwhwEAWlm5OUAiXbwusXUN9de28VsPk8z/4v
         irbO2uxvfu41vFQ2otBMWs4PmXo3U+CYLmpSDXLBjIhl4b7rmov51rwL6cZg9BnUX02c
         TTgpqyawBDe9iLm/JtQeOd9mUdXk7Er0bD/uhM2//jVagicZUA74pA1PkCxK/3PftxIC
         /obgN9mUZAAjECWmB9jtmjp4spLwFAKeiSfuN1fS3vJc3xj2yYwg6uTJSOgVaDfv+4Em
         Y6/w==
X-Gm-Message-State: APjAAAWKN2AeTfTfHLQaukzhIiUc4FLZ6CixrL2aJA7vGjwsMafacDbK
        oh6YXDrZZWUXLVVk5suPck/1Z97q
X-Google-Smtp-Source: APXvYqyiaMgFPj+CkPM47ELWrf0147PHRpW6Wcxa59owFfakI996tInGONtaGAVSx6/iQISskhclPQ==
X-Received: by 2002:a62:5b81:: with SMTP id p123mr101111195pfb.158.1560537594771;
        Fri, 14 Jun 2019 11:39:54 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n17sm7833279pfq.182.2019.06.14.11.39.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 11:39:53 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Stanislav Fomichev <sdf@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH] perf: Don't hardcode host include path for libslang
Date:   Fri, 14 Jun 2019 11:39:47 -0700
Message-Id: <20190614183949.5588-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardcoding /usr/include/slang is fundamentally incompatible with cross
compilation and will lead to the inability for a cross-compiled
environment to properly detect whether slang is available or not.

If /usr/include/slang is necessary that is a distribution specific
knowledge that could be solved with either a standard pkg-config .pc
file (which slang has) or simply overriding CFLAGS accordingly, but the
default perf Makefile should be clean of all of that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 tools/build/feature/Makefile | 2 +-
 tools/perf/Makefile.config   | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 4b8244ee65ce..f9432d21eff9 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -181,7 +181,7 @@ $(OUTPUT)test-libaudit.bin:
 	$(BUILD) -laudit
 
 $(OUTPUT)test-libslang.bin:
-	$(BUILD) -I/usr/include/slang -lslang
+	$(BUILD) -lslang
 
 $(OUTPUT)test-libcrypto.bin:
 	$(BUILD) -lcrypto
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 85fbcd265351..b11134fdf59f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -641,7 +641,6 @@ ifndef NO_SLANG
     NO_SLANG := 1
   else
     # Fedora has /usr/include/slang/slang.h, but ubuntu /usr/include/slang.h
-    CFLAGS += -I/usr/include/slang
     CFLAGS += -DHAVE_SLANG_SUPPORT
     EXTLIBS += -lslang
     $(call detected,CONFIG_SLANG)
-- 
2.17.1

