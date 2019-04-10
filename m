Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7263EC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439342075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="j912k9RY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfDJT5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:57:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40441 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfDJT5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:57:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so2101874pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+zEMNc7324kqJ6udI8dxNG1UczLiZYFItO/G9LMbCUw=;
        b=j912k9RYViXXynkk1wOlbiUqGi5gVmM5St7S1BlBPu6+q2P3DgjDl+YznzwZDpy/hl
         gWY+3dwgbt6IfhjgUbx9m6jOM/d7OOe5psxO/7GbxrHFz+xE7v4Tf7xvwqhp0mhKs5VV
         MpzN1h19egcEapYxtfT1as9eY9rguCD4TJaF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+zEMNc7324kqJ6udI8dxNG1UczLiZYFItO/G9LMbCUw=;
        b=M9Klmldp566Ylws2jVA1FpeDE0QPoTm8tKS3GkT2dAk00VqcS1bS/VZ26nNapp3mqH
         vIeIqc+NDA647J4/FDnLsEAWlIKdao+F+pifskGXaLMIb8DOJ3gkR3jAZO2uUtihOXIp
         XLcih95IEXBlw+BCcllgl0cNufuFKemkKdWeSC/08Sk5WfjhsK8jPINWxX17akGI2P8N
         VYjGp5+aK9TvuWc4fNmQDNVSaqxmD6XeaMoXViJPDMuAZBs7+64zkXUwINiVfr7EOPIo
         c/Apu8QUXc5UZUPQ+ERacuSRLziSmCnEB7ZVFNbIoi1K9SpmOoKkn04iJ9Nv0iOPAciM
         TsKg==
X-Gm-Message-State: APjAAAXnNymkUhlEHO0qxhpp+X+/Fza6eFhDAvkuEw8dY7CAeAj1n/AK
        sXJK5l/K12i79FO76v+mKSYhZoFdP78=
X-Google-Smtp-Source: APXvYqxQvO0IbvL2miFcuCBLyOB0UE4xHrZeT7OhWqKm2iqMVPmm+uND50fcJC2SGWrV9EYsD8MM5Q==
X-Received: by 2002:a62:ee17:: with SMTP id e23mr45292744pfi.80.1554926250235;
        Wed, 10 Apr 2019 12:57:30 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v12sm48703375pfe.148.2019.04.10.12.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 12:57:29 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        mathieu.desnoyers@efficios.com, rostedt@goodmis.org,
        Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        rcu@vger.kernel.org
Subject: [PATCH v3 3/3] module: Make __tracepoints_ptrs as read-only
Date:   Wed, 10 Apr 2019 15:57:08 -0400
Message-Id: <20190410195708.162185-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190410195708.162185-1-joel@joelfernandes.org>
References: <20190410195708.162185-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series hardens the tracepoints in modules by making the array of
pointers referring to the tracepoints as read-only. This array is needed
during module unloading to verify that the tracepoint is quiescent.
There is no reason for the array to be to be writable after init, and
can cause security or other hidden bugs. Mark these as ro_after_init.

Suggested-by: paulmck@linux.vnet.ibm.com
Suggested-by: keescook@chromium.org
Suggested-by: mathieu.desnoyers@efficios.com
Cc: rostedt@goodmis.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/module.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index 8b9631e789f0..be980aaa8804 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3320,6 +3320,12 @@ static const char * const ro_after_init_sections[] = {
 	 * by the SRCU notifiers
 	 */
 	"___srcu_struct_ptrs",
+
+	/*
+	 * Array of tracepoint pointers used for checking if tracepoints are
+	 * quiescent during unloading.
+	 */
+	"__tracepoints_ptrs",
 };
 
 static struct module *layout_and_allocate(struct load_info *info, int flags)
-- 
2.21.0.392.gf8f6787159e-goog

