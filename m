Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432C0C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1413221852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl1XMDih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbfDERrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:47:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46016 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731695AbfDERrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:47:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so3436145pgk.12;
        Fri, 05 Apr 2019 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4h9Nyqf/+CHjwR0GNBVcZWQPowVsjRY9nsfVCm7bZNA=;
        b=Rl1XMDihe97b1BCwFcVwt7ZYJsdT5/KIaQx9tfoNC8G2sFOBJ2A2Nww3bWBhbIu8jA
         uzI8nwLHkifqUu/hhbYxKTl06jab6byICC7xpMhrpAmQY3GmopPSAALBfueGvjZ6+hYw
         K4YGPISABLiwl12Pj6jHqJBozGeohYgoQbbRY630+Pgt4PorbijGa//dWn+jRc+ahwuK
         b3Cv/leaGU7zZL6t2xLAtgaM28SB3CIeofxr4I/pO+C1vdRwtP3DmSIEjKevESd5AyYx
         qH/wVMVIhVq3mfoNFPS6Bxh1XI71E2xK13ZOY0ppbrHvvGikzwqxXN1/5kROBnuCbc71
         Fk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4h9Nyqf/+CHjwR0GNBVcZWQPowVsjRY9nsfVCm7bZNA=;
        b=anc0iJ0BWUoi4RzAG/9+142oMzcz+4MV7UoxkJH9UzWGfPdz0+KY1+dc470PX1ayDA
         XqQZGDhpz0p9SUmIjdo7X3j62SQO2ArSbPcwiK1Hs1Pvwmpz7ti1gNRSimR+3a3uSqcO
         RPoOVd2a0VKdYC4loOeUQvpc59OQI4st0dsquzoJNr7GCcyD/n+fVH87/QhtFX0VNgsY
         JfIK8NBt4Y1Nx12EiRfT2kcst4EfyftEd2/zlOZJg7ywTFSv2vzMFKk4t+7cQctefi/y
         zo8QD326LlzNTXGjGNRqkJIS/MpUY5KlxSImDgQNrRU9iqjbJ9PlTguSMJA+G+9Cs1zi
         Aj3w==
X-Gm-Message-State: APjAAAVGb92WSWa/bZa5h8QDBfV6qee5H4lgypy/CZkJN14PqzWwNw7U
        gpukwWH5DZHSEfrNky3rgOTGDv1S83c=
X-Google-Smtp-Source: APXvYqxC3jqbkj+ORB7vRn7DygOVk5Dzxusq8Z7X8OScNuQATTAcm3U9zediCbruu2iVTXBWxogLdg==
X-Received: by 2002:a62:69c2:: with SMTP id e185mr13817411pfc.119.1554486460675;
        Fri, 05 Apr 2019 10:47:40 -0700 (PDT)
Received: from tower.thefacebook.com ([2620:10d:c090:200::1:ad20])
        by smtp.gmail.com with ESMTPSA id m2sm33169135pgr.74.2019.04.05.10.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 10:47:39 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v10 7/9] cgroup: make TRACE_CGROUP_PATH irq-safe
Date:   Fri,  5 Apr 2019 10:47:06 -0700
Message-Id: <20190405174708.1010-8-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405174708.1010-1-guro@fb.com>
References: <20190405174708.1010-1-guro@fb.com>
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
index 02c001ffe2e2..809e34a3c017 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -28,12 +28,15 @@ extern void __init enable_debug_cgroup(void);
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

