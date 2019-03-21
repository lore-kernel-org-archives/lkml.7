Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2020C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9184B20835
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IMN3oviF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfCUAfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:35:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32866 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbfCUAez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 20:34:55 -0400
Received: by mail-qk1-f196.google.com with SMTP id k189so10096287qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 17:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IC0+CtzpXGHhz69/AjInC3kSHyrQxff0OCscI7M8m1k=;
        b=IMN3oviFXuoURkXevt9lKXvEeYfyhNQHi8wgNDFVtGKzqa5oayf5HKfpSpy8fvePCp
         zkkJfKAaIwPVxZWnksglQ9TK2M1aupaojK0EVDMcB/GbvNOvxQHv6qI1fBp96JRFIyQL
         IPSkPNdEZHfdqWmLrAResI2wRxRPGHwZa9sZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IC0+CtzpXGHhz69/AjInC3kSHyrQxff0OCscI7M8m1k=;
        b=dL3DKQvmrpwj97IomaL7ZbHzRMRKkBXD4+nfTcZO22PuQBMX6SXbB/OC1Ib8MHEW0C
         eqx5ScjRgAAd6b3L/7VChrHRsyW5JxmRv+vIFRrcoQGxNFJg8o79xDWpnfNj1raSCf7V
         4YDYYcXFLNhXs1jwEgfrptvq8/2oQ9kqiMReMP//4xBihLNaQiPo5bHGaHIrSfJlGGPe
         QXdYW+l0fUiT/DoKXcO8/9HiMx6tUOLPbN96FUxryE03xoSaBntnL30oqCC18FU4a8fQ
         V+yiRXDbPph6i30bAdZo6VAV2DmnBAAfhzHMOiyIljzA+R5l+0CL0aG5SPIoohN+/JxZ
         /4gQ==
X-Gm-Message-State: APjAAAWEuJT/KLk2m3fUsCvW9nTnf6B++0VLiC6R0hFl9VGntyNsdw/o
        rZD4QYLNaJgvPLxVKSLtGT9b2Uc2Okg=
X-Google-Smtp-Source: APXvYqzW1ItlokDxvifd5fwoA/cXTdAYbCDJNxmjIBAACop7r9u618kPeesEna9EnhvcgqKDOdYwxQ==
X-Received: by 2002:a37:784:: with SMTP id 126mr471424qkh.10.1553128494280;
        Wed, 20 Mar 2019 17:34:54 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id u15sm2908475qth.54.2019.03.20.17.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 17:34:53 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 3/4] rcuwait: Annotate task_struct with __rcu
Date:   Wed, 20 Mar 2019 20:34:25 -0400
Message-Id: <20190321003426.160260-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
In-Reply-To: <20190321003426.160260-1-joel@joelfernandes.org>
References: <20190321003426.160260-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This suppresses sparse error generated due to the recently added
rcu_assign_pointer sparse check.

percpu-rwsem.c:162:9: sparse: error: incompatible types in comparison expression
exit.c:316:16: sparse: error: incompatible types in comparison expression

[From an RCU perspective]
Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcuwait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 90bfa3279a01..563290fc194f 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -18,7 +18,7 @@
  * awoken.
  */
 struct rcuwait {
-	struct task_struct *task;
+	struct task_struct __rcu *task;
 };
 
 #define __RCUWAIT_INITIALIZER(name)		\
-- 
2.21.0.225.g810b269d1ac-goog

