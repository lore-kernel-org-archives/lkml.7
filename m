Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E25C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D422082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="K1niSa9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfDJTIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:08:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34001 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfDJTIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:08:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so2127590pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1Qx3/w7WRcsYn9eaUPF4C/V6e/ThCB6vwEWsBbRAUs=;
        b=K1niSa9XrmXDprUUjfMYdOBFSp2971yq6KfPCwZQB8zLkTG1hoq4Be1dObMgZbLp0D
         FgA32CQNknYoP/LwUlvsogre3kTd77MjYHx13oD0Jew4VYRShWVM/pJBSYocrrntdmAu
         D1sXx3I/JxMC9QxZQlnvOYUI8RX8F/VfgZzSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l1Qx3/w7WRcsYn9eaUPF4C/V6e/ThCB6vwEWsBbRAUs=;
        b=qvnopPl2xvXv15BAKmNOFwrjtZEgB3dgw9IR+0MyQQ80UAbhqk0B4dVHt7zvML9VK0
         MSuOT5tOMA3+5EsWqp/ppvxGznEzIOSR0bfQnNVmvjdZk3MG2IeCgrJADFKMH/SGh7LO
         CfFAAZJyOk7TMZDiNAL1W4u/3ybSf+AD2XEloA/cetS4xz5wkW+CqXPFRcKLr/FYkA44
         3+9dbA1HitomzbDBEKNOXpDpnmBc+Mc0mQqJCnuCYo84ga/5OzX3AFOIw/CKn/S+89xj
         vBVhi/rGH39ou4gNvchRoBgXNHYv4uX/+TNO9IUEPIXZWDODy757a6wtp/DhaPoDtFi7
         q9/g==
X-Gm-Message-State: APjAAAXIN7agUNSHcuDdBTvS7xpSHbJBBYHZCAeqPcbaQyaMc5JL/nUZ
        YC3yF9Hsbi4mMWwW+7QZJnvjLZKIvhw=
X-Google-Smtp-Source: APXvYqz+MW7nlOFWhyh3M8V1FDWmZWoua6y9RzTsKCv7M5lQ1B8chUn0jXM05TM41vfWXGVzHTm4EQ==
X-Received: by 2002:a62:e304:: with SMTP id g4mr39107478pfh.71.1554923320781;
        Wed, 10 Apr 2019 12:08:40 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v15sm52243547pff.105.2019.04.10.12.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 12:08:40 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
        rostedt@goodmis.org
Subject: [PATCH v2 2/3] module: Make srcu_struct ptr array as read-only post init
Date:   Wed, 10 Apr 2019 15:08:22 -0400
Message-Id: <20190410190823.109172-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190410190823.109172-1-joel@joelfernandes.org>
References: <20190410190823.109172-1-joel@joelfernandes.org>
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
Acked-by: keescook@chromium.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/module.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 1acddb93282a..8b9631e789f0 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3305,7 +3305,7 @@ core_param(module_blacklist, module_blacklist, charp, 0400);
  * layout_sections() can put it in the right place.
  * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
  */
-static char *ro_after_init_sections[] = {
+static const char * const ro_after_init_sections[] = {
 	".data..ro_after_init",
 
 	/*
@@ -3314,6 +3314,12 @@ static char *ro_after_init_sections[] = {
 	 * annotated as such at module load time.
 	 */
 	"__jump_table",
+
+	/*
+	 * Used for SRCU structures which need to be initialized/cleaned up
+	 * by the SRCU notifiers
+	 */
+	"___srcu_struct_ptrs",
 };
 
 static struct module *layout_and_allocate(struct load_info *info, int flags)
@@ -3336,7 +3342,7 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
 
 	/* Set sh_flags for read-only after init sections */
-	for (i = 0; ro_after_init_sections[i]; i++) {
+	for (i = 0; i < ARRAY_SIZE(ro_after_init_sections); i++) {
 		ndx = find_sec(info, ro_after_init_sections[i]);
 		if (ndx)
 			info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
-- 
2.21.0.392.gf8f6787159e-goog

