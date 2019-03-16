Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B32C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1718821904
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwnZvuGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfCPR6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:58:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37706 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbfCPR62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 13:58:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so5088256pfr.4;
        Sat, 16 Mar 2019 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oe77XjSU239xs9p3BqL+eqRFZwO25QtGRaXNUMRkpIk=;
        b=gwnZvuGx8dL29LbvdrxUS4TDzNVLwL9a/UvAPMbrh/qb8n4uLHvekCXX1uPBc21WZ+
         5YH3ptGRPoSgdmHtHIKjCa2cjHIVrn9RRbcrxXi5hZHm+qQpHybIuFWBgnxz1gBFUI43
         gabFF7Ok06E0fa1AfnvmX5kopie9ksPQ5YxeuUiqhwuX4FFXZqOQ81a67l8k51+ap0H4
         l+dAcoaXLYdRZPsSb3EpISiadKEdey3DlxVfvjfbEBgCyawiycyYagNihs9x0+rb9f7m
         qYR/9SHBGp9wRcnluG+VzGsDTvYgKlgH2mc72W+xyerzFSCx+7rQ8rcGIrLwYo2TMPxJ
         OOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oe77XjSU239xs9p3BqL+eqRFZwO25QtGRaXNUMRkpIk=;
        b=m/7pxryZuF60E1dbdSbc9NY/ST14+QscWh6NDq1WfQXnl36ZdKTrkK319fAvRHmEr0
         ihD01gFbhKi1osfNFzzkvWkWDC2ay+LJWCU44Orf6rPE7PCLOlylBEoM2zYZVWQJyt/0
         Ppr4citrJg1KvBJAopSq0MQM4zMMb7BEATo/uVKYCVVPbBFgjzMlFM5zuG99UO6kDN8+
         mUGz0Fg/FqzBUBZH4Za0zDPF88bW/1axsQljBTdH7D7OY4oyTT3pIJQfCqg+VBrWw3S/
         DkjZnAmNvTd/JrsJVBLypl61j9q4spg4l/+dS90SfsBmZ4TH0VHGE9Wi/Ti6Q46hWRmS
         gRWg==
X-Gm-Message-State: APjAAAU3v0nRHZ3qapmcGFn71xDbLO6/bQ04LeCHNMNwwGqWRHUREJoO
        INjqHu7/y15gpFdPMnGWqPA=
X-Google-Smtp-Source: APXvYqxsNYNoizd9rrSfQ8xDt9B+T+vYqEDRYTCHCxmYoLze+PL6YSEvaRzIeiMyfJue8k0Y92Wh+Q==
X-Received: by 2002:a17:902:aa92:: with SMTP id d18mr10421203plr.278.1552759107553;
        Sat, 16 Mar 2019 10:58:27 -0700 (PDT)
Received: from castle.hsd1.ca.comcast.net ([2603:3024:1704:3e00::d657])
        by smtp.gmail.com with ESMTPSA id p86sm11025638pfa.104.2019.03.16.10.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 10:58:26 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     Roman Gushchin <guro@fb.com>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 7/9] cgroup: make TRACE_CGROUP_PATH irq-safe
Date:   Sat, 16 Mar 2019 10:58:10 -0700
Message-Id: <20190316175812.6787-8-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190316175812.6787-1-guro@fb.com>
References: <20190316175812.6787-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use the TRACE_CGROUP_PATH() macro with css_set_lock
locked, let's make the macro irq-safe.
It's necessary in order to trace cgroup freezer state
transitions (frozen/not frozen), which are happening
with css_set_lock locked.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 kernel/cgroup/cgroup-internal.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index a195328431ce..cdfa34485022 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -27,12 +27,15 @@ extern void __init enable_debug_cgroup(void);
 #define TRACE_CGROUP_PATH(type, cgrp, ...)				\
 	do {								\
 		if (trace_cgroup_##type##_enabled()) {			\
-			spin_lock(&trace_cgroup_path_lock);		\
+			unsigned long flags;				\
+			spin_lock_irqsave(&trace_cgroup_path_lock,	\
+					  flags);			\
 			cgroup_path(cgrp, trace_cgroup_path,		\
 				    TRACE_CGROUP_PATH_LEN);		\
 			trace_cgroup_##type(cgrp, trace_cgroup_path,	\
 					    ##__VA_ARGS__);		\
-			spin_unlock(&trace_cgroup_path_lock);		\
+			spin_unlock_irqrestore(&trace_cgroup_path_lock, \
+					       flags);			\
 		}							\
 	} while (0)
 
-- 
2.20.1

