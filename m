Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AE6C3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769D12086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fn+0WIoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfHPCxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:53:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41670 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfHPCxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:53:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id 196so2337599pfz.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 19:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vQhzhmYsBEIBgfK9bAXXCgiV+s/eGGEAcUASy+K8Kx8=;
        b=fn+0WIoH0hb2mJMlDjd6wAjb/WOyqALGh81FXElnV2+KThoCDaOiIEpWLr/jdFFK2h
         CZDJKXh/TsicRfPYvwDlVufv6EitdexkLe834jFlqA38Z8o+a5C5o/h0mIIB498qllEI
         v5SOrflJbA7ZdEYbdwgjEoYLGRWruEPQaAJJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vQhzhmYsBEIBgfK9bAXXCgiV+s/eGGEAcUASy+K8Kx8=;
        b=YZvCxg/J/K9kTt0I1h8b/dyeBikaFV9E5J8rbu/M/iC+5wJcAADDQXFr5+k5t9aIBN
         Jjl/GaTzP9XZqz6RCQeV+RfB9QGE/DOgUqy2SY8CfkH14rCuAqLxhksnjyPbDUDEs1Du
         llvyphntWGqo4VMhJUWLn27tmcncceax6myXyaOSiKEffFpAAQ0TX72GwPnoMcvVcre9
         r2KHlx1e0C0qj2XxMxNfIZmyhoPunS2/XWT/U6s/iDGfdwkOFjdwJ3EY+0Y164SA8MGp
         Sz+ZDedSjNm9KJw97WoD0DcFwxnTBSMueOoJgRZlG59Au0Amabfqj8cfHjLOsHWMa++9
         Fgug==
X-Gm-Message-State: APjAAAXXI7qwvHBTjhz+jC9nmTZRGs7iUbrQPqKi7E98YkaNsm83pGmw
        y06yKPRyWcKw3yg2tPiJWKkAPDqSfzE=
X-Google-Smtp-Source: APXvYqyPbqBdVP9ApqduTOxKTX2oXG6Jifh8f0SezzAVoJ0l7AxIUYxvlZ1OjWtqOkWKH/cX5b4U2g==
X-Received: by 2002:a63:6f81:: with SMTP id k123mr6067821pgc.12.1565924020785;
        Thu, 15 Aug 2019 19:53:40 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id v14sm4181258pfm.164.2019.08.15.19.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 19:53:40 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        frederic@kernel.org
Subject: [PATCH -rcu dev 3/3] RFC: rcu/tree: Read dynticks_nmi_nesting in advance
Date:   Thu, 15 Aug 2019 22:53:11 -0400
Message-Id: <20190816025311.241257-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190816025311.241257-1-joel@joelfernandes.org>
References: <20190816025311.241257-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I really cannot explain this patch, but without it, the "else if" block
just doesn't execute thus causing the tick's dep mask to not be set and
causes the tick to be turned off.

I tried various _ONCE() macros but the only thing that works is this
patch.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 856d3c9f1955..ac6bcf7614d7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -802,6 +802,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	long incby = 2;
+	int dnn = rdp->dynticks_nmi_nesting;
 
 	/* Complain about underflow. */
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
@@ -826,7 +827,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 
 		incby = 1;
 	} else if (tick_nohz_full_cpu(rdp->cpu) &&
-		   !rdp->dynticks_nmi_nesting &&
+		   !dnn &&
 		   rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
 		rdp->rcu_forced_tick = true;
 		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
-- 
2.23.0.rc1.153.gdeed80330f-goog

