Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE47C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694B72133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FHQSlTRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfDJBOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:14:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39417 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfDJBOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:14:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id a96so297903pla.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 18:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5twU0SQ7qeKqh0+CQCpWioa1s9Zf+6xNLzQqic9rlw4=;
        b=FHQSlTRZrxwWRPEy09RfK1EbzDl1zZ/P9DaKFB3KmUIfEkgu6OM3YJlfaFBN4rkxkl
         zSvWO+0TCb29HihZcJN1LzoQ7zSzMn+0Qq163kSLfVi8pivg9gruZWze/PBLZiriUT1/
         ISRaHB5ujKTs+R24ynJfXQsOp3PURKr+7ESkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5twU0SQ7qeKqh0+CQCpWioa1s9Zf+6xNLzQqic9rlw4=;
        b=fhJuoxqOG50whmWFLNbtnbc7DdexuEumOyFagseoxUgqUHdZOcsUAWq1ABqyBiaOTx
         rmiYGLzACDxOICZnKtEfDCqVWxcM+XwV+XwOSUzwnifEeZ27kNqZldBBh17AnYezlp51
         vEJ7P+bUP4QQWt3bsxAOJ6/YF2SYZDJ6hLi6/W6JSr4nNKnVWquyae9vABRmas0aVBh0
         ea5/96fWZZsBa4lL26xQkJYYpJd7FztBNkS71lXt/PGbZWPpChu1GxgLpb7fGAS4DNuG
         HDB2WIAjHswMJegJJvRz1ms1fgroFlGrOsIYkh8aFvqINvH1VPUnF19YZxokSMQdux5O
         sEJg==
X-Gm-Message-State: APjAAAUFjebybCpO1lGwzetGBYt7tgxwiKSQLmiU0M/PGLMOUVtiO28r
        6zHDrTGkhul09uiLQI2dmV0sjJUDfWU=
X-Google-Smtp-Source: APXvYqzWxp9Z/Hj7HaokzBOYz+F4nLfRw5ZzJJ2S8R4un2zhiLFXnFe1Jd45s4Oi3qlLbH7oSko44Q==
X-Received: by 2002:a17:902:e391:: with SMTP id ch17mr41547333plb.196.1554858871788;
        Tue, 09 Apr 2019 18:14:31 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d69sm1008867pfg.24.2019.04.09.18.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 18:14:31 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
        rostedt@goodmis.org
Subject: [PATCH 2/2] module: Make srcu_struct ptr array as read-only post init
Date:   Tue,  9 Apr 2019 21:14:18 -0400
Message-Id: <20190410011418.76408-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190410011418.76408-1-joel@joelfernandes.org>
References: <20190410011418.76408-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit title ("srcu: Allocate per-CPU data for DEFINE_SRCU() in
modules"), modules that call DEFINE_{STATIC,}SRCU will have a new array
of srcu_struct pointers which is used by srcu code to initialize and
clean up these structures.

There is no reason for this array of pointers to be writable, and can
cause security or other hidden bugs. Mark these are read-only after the
module init has completed.

Suggested-by: paulmck@linux.vnet.ibm.com
Suggested-by: keescook@chromium.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/module.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index f9221381d076..ed1f2612aebc 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3301,7 +3301,7 @@ static bool blacklisted(const char *module_name)
 core_param(module_blacklist, module_blacklist, charp, 0400);
 
 /*
- * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
+ * These are section names marked with SHF_RO_AFTER_INIT so that
  * layout_sections() can put it in the right place.
  * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
  */
@@ -3314,6 +3314,13 @@ static char *ro_after_init_sections[] = {
 	 * annotated as such at module load time.
 	 */
 	"__jump_table",
+
+	/*
+	 * Used for SRCU structures which need to be initialized/cleaned up
+	 * by the SRCU notifiers
+	 */
+	"___srcu_struct_ptrs",
+
 	NULL
 };
 
-- 
2.21.0.392.gf8f6787159e-goog

