Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9DDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1472075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gCuYSH03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfDJT5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:57:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41972 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfDJT53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:57:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id d1so2048236plj.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s1KvMENHKJ+ARGp1Ak4XYk6a1UqyuJod6EXXmWFSMt8=;
        b=gCuYSH03rd2bfZfsXnJ+sf8RlAg6S8HoJ5JjqU+Zl/5+O0UlykXyfQCOeNcTUCaSR7
         6KNEjmqFrBVBBTO/0d485a41D1MP58vlbCrmYQincc9PoLW9MTuRfAdx7OyNyTQEbmh0
         smzNx1G68PwHw5YZpbUN3UtxvRAc4eRBOPJFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1KvMENHKJ+ARGp1Ak4XYk6a1UqyuJod6EXXmWFSMt8=;
        b=uC0PYw64Txz8Mm+Wqhn0b02CaljqXp8Em9ODu0uUls/HKVxAnfFolr84L5NfdPjKOj
         hpViIY89TEIwXsua50URCF0cWZ7kx+NZRqLVFSiUGVq8j0Ee8CBjP1RCJuCr/8pB7Reb
         p9Zp08MZc7qgIJtM3hGFdw+KIORgNmgaLhqLnZT2LwRms8JAgipumxz2kMvJhgTGUldO
         Wncrge31fNr7e/KDC4dMr+uU/d1D5ITgo/zAacXnTFq36txfe7Pwicc1xGQovym/aOU+
         6P0ldj4hmNLIf0oB1kMrZRdLKRQGB/bOHzibErNPdKCiCNy9ePYg74tvlS/63RZAA/A4
         RIaQ==
X-Gm-Message-State: APjAAAWAKIojQ5nSo+LxE3XRfDqCdAUTCY8AGhVPIAn6/zLPJFQAj2i+
        3WxSST94GYRnP3OPA5K0sf4rPIHtLtI=
X-Google-Smtp-Source: APXvYqx4UxF9E1rsmi7wYsghu/PXp1ymRPB3Mm4BYcwhDNZS9gsM2QmW9kWzaEw/StarCjaCmGV6RA==
X-Received: by 2002:a17:902:32b:: with SMTP id 40mr23706308pld.204.1554926248212;
        Wed, 10 Apr 2019 12:57:28 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v12sm48703375pfe.148.2019.04.10.12.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 12:57:27 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
        rostedt@goodmis.org
Subject: [PATCH v3 2/3] module: Make srcu_struct ptr array as read-only post init
Date:   Wed, 10 Apr 2019 15:57:07 -0400
Message-Id: <20190410195708.162185-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190410195708.162185-1-joel@joelfernandes.org>
References: <20190410195708.162185-1-joel@joelfernandes.org>
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
 kernel/module.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index 42e4e289d6c7..8b9631e789f0 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3314,6 +3314,12 @@ static const char * const ro_after_init_sections[] = {
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
-- 
2.21.0.392.gf8f6787159e-goog

