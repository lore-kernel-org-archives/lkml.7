Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19E0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C3E206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="WIyBizMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbfCZTYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:24:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41907 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbfCZTYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:24:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id y5so2084846plk.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 12:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cBJLe6/JGplG+Cy8Q3/cMVi7Shc7ruJGMSA1cWOMVqY=;
        b=WIyBizMngixWEhCS5V1bN1IbboWlbBa/zzrPjtzcGpBAqm9dDvsYykZKnRKho5FZvm
         waFLFVy194hEvmK7je9hxoDmUOzvW8fiSsEkt+sz2wr9ghG5955KLCCx49DjcgSR9E3z
         m0cbfO0jiIvx7ys5FH0c4R6IZ/KvKyvBD6wfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cBJLe6/JGplG+Cy8Q3/cMVi7Shc7ruJGMSA1cWOMVqY=;
        b=pAl7U5aVS7ax2TM96PXQry1c19QVhGh1orBjAa9TBlwgmfIk23/eY+UVBbP9rWQePc
         tCmFvDsemkn8HfJqYddauLldACBUVDD/4Xklky0STBEgOI+jto6knaTUtETbA12s3hrO
         IcQDLgzLAbJwUQcAmW8c4el3PATIifEVe28Op0Lwhdh6L7XquUNUYVj4n797oYB3j+vy
         if0cowg+pfBj9yyRHIT0nGwr8t0avxxIuM+m6EJGxVyK6Y5+6ZPmDQa/U7rin7c9ZJwZ
         psuS0laHd3suUi8maBZoPrEAX1efEOmvm03KomoYLej7K6KpB/wOc7pzoxhwjlJDW3xu
         EKHA==
X-Gm-Message-State: APjAAAVmTF/2QVS/rqa6lm9THPgrKTEHkA/UQC2T+Di+/lGTPvJKW/8i
        7F4wclhg3hsQ/SYEmaolHJHocDmSnl8=
X-Google-Smtp-Source: APXvYqypEKPXcoQJgDVy5MvfSX2VsoZ1x9Ur4x5YtgQwDWYTEU/kZATCqD9coRmyBcoDdt/Dx7aYRw==
X-Received: by 2002:a17:902:20e5:: with SMTP id v34mr33077657plg.319.1553628270382;
        Tue, 26 Mar 2019 12:24:30 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l12sm36761889pgn.83.2019.03.26.12.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 12:24:29 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>, kernel-team@android.com,
        rcu@vger.kernel.org, byungchul.park@lge.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 1/4] lockdep: Add assertion to check if in an interrupt
Date:   Tue, 26 Mar 2019 15:24:08 -0400
Message-Id: <20190326192411.198070-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rcu_rrupt_from_idle, we want to check if it is called from within an
interrupt, but want to do such checking only for debug builds. lockdep
already tracks when we enter an interrupt. Let us expose it as an
assertion macro so it can be used to assert this.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel-team@android.com
Cc: rcu@vger.kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 include/linux/lockdep.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index c5335df2372f..d24f564823d3 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -601,11 +601,18 @@ do {									\
 			  "IRQs not disabled as expected\n");		\
 	} while (0)
 
+#define lockdep_assert_in_irq() do {					\
+		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
+			  !current->hardirq_context,			\
+			  "Not in hardirq as expected\n");		\
+	} while (0)
+
 #else
 # define might_lock(lock) do { } while (0)
 # define might_lock_read(lock) do { } while (0)
 # define lockdep_assert_irqs_enabled() do { } while (0)
 # define lockdep_assert_irqs_disabled() do { } while (0)
+# define lockdep_assert_in_irq() do { } while (0)
 #endif
 
 #ifdef CONFIG_LOCKDEP
-- 
2.21.0.392.gf8f6787159e-goog

