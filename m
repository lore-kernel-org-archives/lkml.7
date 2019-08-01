Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41B6C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8736A20838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsX9h6v0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388987AbfHAVB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:01:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40177 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfHAVBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:01:55 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so22285638iom.7;
        Thu, 01 Aug 2019 14:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hYk1p4XO50YHWglK7WQv5FDba8WVu0jGxZbnBmYxT0U=;
        b=WsX9h6v0sWIw9UZqgWKwYoxbHzXP+O8GZHjEmu+fHjKraZiFxmywfBPowTassSYhrO
         DZ+idaDNIsCqcPfR2dmLfLbFOSJlCCW+y+T32uR6n4SViSofTXsO4znvyykajmEsiELz
         +TmZel3pzTimGJ2dvG0+8/J49RnFZcMEuy7ONdHdSh+046juGbhrhrvuIvPlagsuweff
         xQE+KvsPYM7hRG9PquDIfUWD2LM7oIQR4qtFHyfprMjb5c7PkGCIhMr/JMvGzBTNa2jb
         +4yIHF+1L1rTltWHsj1U3ES9fe8I80SbJp10bJD7A8mf1Co9qbNhfr+TDLhmpIZJT8Yf
         8HbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hYk1p4XO50YHWglK7WQv5FDba8WVu0jGxZbnBmYxT0U=;
        b=qPV66XewVwGQ3qNewkHPh+2jyeS1eCUgJu0IJSZzn97/DrF4rROPI8iXGo8pbBEhNk
         pN+EHuy0B1ZtDA3j8ZZyUfooCvCN+y3Uicvq1sS2DFC1XxfhJ5Htn4mxtgPYBiCEU40/
         0Wt1nHURAhcGNRvZxI/yw6PR/p1TU24GYVD8XbEXPBocRAzxyNErFo1PNw33oIo/oJdE
         79ZhAKT0d+cE6qSwhf9WuZY8/Z9SpUNzvdQVFmt8WqawAC2XY60pscQMxcuNaJxR459r
         1Hp5+35Qan7xr3FdfFyemSt5BTN5brnvroPXyJsqO/XFBSv8UIwHytior1imTNVJRkiq
         IWQA==
X-Gm-Message-State: APjAAAW9EmqElH/rSasCzmP6u7gIV/g+0u0eapNvGQUjTJThdYiboMsU
        wXiaaU8duh44Pii6JMJxvRfoXIEpvYVkdw==
X-Google-Smtp-Source: APXvYqx1qXNn4zrShRhEW4FJxoqRTY2+moF4vrJlebUUd+k14iJhk2BPtqeX3DTrTf/z245SC8LW2g==
X-Received: by 2002:a5d:9642:: with SMTP id d2mr96884249ios.278.1564693314390;
        Thu, 01 Aug 2019 14:01:54 -0700 (PDT)
Received: from oc2825805254.ibm.com ([32.97.110.51])
        by smtp.gmail.com with ESMTPSA id s2sm51429162ioj.8.2019.08.01.14.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 14:01:53 -0700 (PDT)
From:   Ethan Hansen <1ethanhansen@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, paulmck@linux.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, Ethan Hansen <1ethanhansen@gmail.com>
Subject: [PATCH tip/core/rcu 1/1] rcu: Remove unused function rcutorture_record_progress
Date:   Thu,  1 Aug 2019 14:00:40 -0700
Message-Id: <1564693240-13363-1-git-send-email-1ethanhansen@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rcutorture_record_progress is declared in rcu.h,
but is never used. Remove rcutorture_record_progress to clean code.

Signed-off-by: Ethan Hansen <1ethanhansen@gmail.com>
---
 kernel/rcu/rcu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 8fd4f82..aeec70f 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -455,7 +455,6 @@ enum rcutorture_type {
 #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
 void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 			    unsigned long *gp_seq);
-void rcutorture_record_progress(unsigned long vernum);
 void do_trace_rcu_torture_read(const char *rcutorturename,
 			       struct rcu_head *rhp,
 			       unsigned long secs,
@@ -468,7 +467,6 @@ static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
 	*flags = 0;
 	*gp_seq = 0;
 }
-static inline void rcutorture_record_progress(unsigned long vernum) { }
 #ifdef CONFIG_RCU_TRACE
 void do_trace_rcu_torture_read(const char *rcutorturename,
 			       struct rcu_head *rhp,
-- 
1.8.3.1

