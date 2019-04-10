Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB40C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDCF2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qTG4GW66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfDJTIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:08:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37416 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfDJTIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:08:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id w23so1983478ply.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+zEMNc7324kqJ6udI8dxNG1UczLiZYFItO/G9LMbCUw=;
        b=qTG4GW66i99y0JN8DLJIq2jNVfkuBzXgqFI0rmEU3GAPdkdJkateK3pWGh2YF+dLCI
         dmCEvn8CTEoJR/E1Rvlb42hCcIqCFcAeT1dyTbRv8THAR3vjr3E3jzeOKTkMic8zxMwQ
         oPm5VzkaHGwgPje6vpMhHBkngYlRQKLcSonyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+zEMNc7324kqJ6udI8dxNG1UczLiZYFItO/G9LMbCUw=;
        b=tRX2zO1hdSVgPY+yyYsJiZlKkIGIVblv61jDoX4tiLTf+m0svK7vtMLbtP+W9sisiD
         uff9iy/+VVpF9Fijns0icD3NRq6BVoCbYUBVNx1dmcbV5BJeCT9xIyhzlECKMcJ8aPUg
         UogUO0FF5MmLm6lhADNsx7q6BgJv8j+ws3aFXrPUaVGlxHEuiWONDBrNw80Z4SvzcUF8
         7a/OkRp0zmQch5Zp7dvhgcJfnMUqAlEMPCdkMEJXSJOMElbJ1U18lIFd4tA//uSppZl7
         jPfBIs56l5ti2fIepEV69qhFpCGi5bVio5suHInyy7VnCmSyYAhL+2TbCvzj9ga4ZLCx
         rchQ==
X-Gm-Message-State: APjAAAUfucVQ/e7QX7uEZq5Ofqsp7DeAsKwADWZoJRxEn2q/3kv/y3uy
        3Vu5lUbuWhCHXB+XFxxIqqpMQg0xsp0=
X-Google-Smtp-Source: APXvYqx2g6ttnni7llCeY5WLmqUlBGENhUrlnraL8MwbYXYx9R51uq9J7J1caYKZxyWZNNqdgPHTzQ==
X-Received: by 2002:a17:902:b706:: with SMTP id d6mr45474278pls.250.1554923322871;
        Wed, 10 Apr 2019 12:08:42 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v15sm52243547pff.105.2019.04.10.12.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 12:08:42 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        mathieu.desnoyers@efficios.com, rostedt@goodmis.org,
        Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        rcu@vger.kernel.org
Subject: [PATCH v2 3/3] module: Make __tracepoints_ptrs as read-only
Date:   Wed, 10 Apr 2019 15:08:23 -0400
Message-Id: <20190410190823.109172-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190410190823.109172-1-joel@joelfernandes.org>
References: <20190410190823.109172-1-joel@joelfernandes.org>
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

