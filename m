Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965D3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A01622CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="y+Hyjr6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfH1F0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 01:26:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44595 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfH1F0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 01:26:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id a21so1484420edt.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 22:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r3okL2IbB4x4scWePdszWm5yjyzaqmpt+xVUSaU+kT4=;
        b=y+Hyjr6NM9kKyVv7oP5Ti9zhf/pcJhuC2oOoUho/f2BNcnT7iIRSL6R/jalaG9bLiy
         aziSw7rnYsuz9UdeD2g/M55fCmIrvkOLby2VKoRKuku/zZwy6ZTePuxygdKCuDIkPUX8
         FuSJNVh+2J5paCQQenITMDt1B/tu7E0uzCoxcVltvNpy/mFbbABWan6Wg3rJenlZ5vmc
         /lFmfyQR6dpLdASTMxOFzDA++2cYRjSDiZ2BgGBzC6rd5XBK7M69ORS67wESEe2llhvT
         x1molnb6izKo7qx0kCFVvld6tfxgqVeboAc3sjFvkRpMj7mF9aTZVfImdBtzDSOLYUCG
         ma/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r3okL2IbB4x4scWePdszWm5yjyzaqmpt+xVUSaU+kT4=;
        b=qhxAuhDyArzGOad4PgISh5oG5itCVmtFaKMowCqe+7HnrnAu2d7IT7ZlnKa6gnR/hw
         JJnnX3ZKsR5/6VkbZpbRE+DhEc9lGlnebQCA2pZdft0YOhZA4Mn+Wylte/DeAzuVibwk
         RIkGcdITw8rwsROiyyAcN9XEhOcUh5UZsVDE45Uo6uQluNZixAm1Evu2E/XpRji/NN76
         cyvxIOf+4UxQqr5FFg64ELNp2K2aTHmFfXA7bongwdixGAftVJ3ykclGACLwBK5xOti0
         am9QV7/Ab9gN5puQ2opmJsIkYtu9oTFOAURFxBIzNO6LjZe67NK9A+XZYO7odLZck45s
         oJjg==
X-Gm-Message-State: APjAAAXLOyDEctg5SLHQY87RUnvBW1itwjjubefc/mP1Xzbkyca8v+NJ
        +X5jktIeIoq4IHDmKU82NyAG0w==
X-Google-Smtp-Source: APXvYqyhm1qTHfCMLpyOs0xVzJ87GEsoo5lej74oAdgQPJr0dpvMkc3KQX0zlpTe8V8LUyJTSZqeSA==
X-Received: by 2002:a05:6402:1594:: with SMTP id c20mr2168303edv.130.1566969978272;
        Tue, 27 Aug 2019 22:26:18 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id la5sm213063ejb.30.2019.08.27.22.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 22:26:17 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH 3/3] tracing: make trace_array_create() static
Date:   Tue, 27 Aug 2019 22:25:49 -0700
Message-Id: <20190828052549.2472-4-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190828052549.2472-1-jakub.kicinski@netronome.com>
References: <20190828052549.2472-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the W=1 missing prototype warning:

kernel/trace/trace.c:8319:21: warning: no previous prototype for ‘trace_array_create’ [-Wmissing-prototypes]

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4cd9855dcd88..c7491d9b0ac7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8316,7 +8316,7 @@ static void update_tracer_options(struct trace_array *tr)
 	mutex_unlock(&trace_types_lock);
 }
 
-struct trace_array *trace_array_create(const char *name)
+static struct trace_array *trace_array_create(const char *name)
 {
 	struct trace_array *tr;
 	int ret;
-- 
2.21.0

