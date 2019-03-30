Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BBAC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1203218AE
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ri+lQLE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfC3AJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:09:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41680 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730154AbfC3AJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:09:09 -0400
Received: by mail-qt1-f195.google.com with SMTP id w30so4412878qta.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 17:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bvQgRGpefcYA2bGTxmohiIg6xpHzeJhgGf46Fxf6brk=;
        b=ri+lQLE6TeSykLvyMyVBjY8kg2VrNJ7GOO92YLsYox1mjO729eehksFOayX07jzAiA
         juQq1BAFLzI4VeE/JZ3hVFXMOYZLNtU7edhLvHTlBTTpmmqS/UnZ7Si1ssTwrck33cLH
         njXPnDdD4GKoHDhYbofb9jy4ZXtg0Cc0FlVrVgWvDxVf4FSIFwAIrYQEzYIkqUZ7q+Mv
         qc8oARbs7A/wa8aYaHRMxru0+iVLOpviW1mpyWpP8JnMAbxQ+xvtDgMJvg1XcK2MMbDP
         4Yx9FD5c+7pj386bm22dSYplu509yZV5QfrPCLkkofAwwCDnBSNpHWYpxHjXTBOkthz3
         6DNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bvQgRGpefcYA2bGTxmohiIg6xpHzeJhgGf46Fxf6brk=;
        b=Sly49QJKPENLfBAImvIfw+1X/u4UQypnztdx4rJI8e0dFJRCN3m/0LwpQP+DdBTjvW
         VInQJ++o6VO1TjPGOmg+sAE6Ujjpth2jcQ7mefMQrSxiHcNvFBnMJqnoWDnbIwDd5XI1
         mPb5Pq7BsobgWHWZwsCa3/yjVTTxubvsiQafqX5vgFtUv6NIntIHnJdMJKJYrqB2qjKr
         iaurnpNHEWCFflco0Bqic0AnI/f9fh2e2G2uPjAqSrsL5J+rurp6zdH+DrfFWx8ijRYj
         xed5Cvf+7d8twQlpSI5fWvLTnFLF0t4WmKdwC1BHdZ+l6VG2uwHFLZt4lZpixyx1lNiV
         nKAg==
X-Gm-Message-State: APjAAAUoOd3XgiLgxKxDxMvKVEpvBOaOu+V6cQNkXJMwXsG0MaZOW7mJ
        ZwUjLH3BdnoicY+4hnHpWM1sew==
X-Google-Smtp-Source: APXvYqyeM7h/sI4aeaUvVpuPS2E8tvTKe/0hQPkjjJbFACMVDBthlnAVQe1inAPaHwdEVTQQ4puoPw==
X-Received: by 2002:aed:3965:: with SMTP id l92mr30035771qte.117.1553904548198;
        Fri, 29 Mar 2019 17:09:08 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id i63sm1996757qkd.82.2019.03.29.17.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 17:09:07 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     peterz@infradead.org, tglx@linutronix.de
Cc:     ard.biesheuvel@linaro.org, yamada.masahiro@socionext.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com,
        alexei.starovoitov@gmail.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Simon Horman <simon.horman@netronome.com>
Subject: [PATCH 1/3] locking/static_key: add support for deferred static branches
Date:   Fri, 29 Mar 2019 17:08:52 -0700
Message-Id: <20190330000854.30142-2-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190330000854.30142-1-jakub.kicinski@netronome.com>
References: <20190330000854.30142-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add deferred static branches.  We can't unfortunately use the
nice trick of encapsulating the entire structure in true/false
variants, because the inside has to be either struct static_key_true
or struct static_key_false.  Use defines to pass the appropriate
members to the helpers separately.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
---
 include/linux/jump_label_ratelimit.h | 64 ++++++++++++++++++++++++++--
 kernel/jump_label.c                  | 17 +++++---
 2 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/include/linux/jump_label_ratelimit.h b/include/linux/jump_label_ratelimit.h
index a49f2b45b3f0..42710d5949ba 100644
--- a/include/linux/jump_label_ratelimit.h
+++ b/include/linux/jump_label_ratelimit.h
@@ -12,21 +12,79 @@ struct static_key_deferred {
 	struct delayed_work work;
 };
 
-extern void static_key_slow_dec_deferred(struct static_key_deferred *key);
-extern void static_key_deferred_flush(struct static_key_deferred *key);
+struct static_key_true_deferred {
+	struct static_key_true key;
+	unsigned long timeout;
+	struct delayed_work work;
+};
+
+struct static_key_false_deferred {
+	struct static_key_false key;
+	unsigned long timeout;
+	struct delayed_work work;
+};
+
+#define static_key_slow_dec_deferred(x)					\
+	__static_key_slow_dec_deferred(&(x)->key, &(x)->work, (x)->timeout)
+#define static_branch_slow_dec_deferred(x)				\
+	__static_key_slow_dec_deferred(&(x)->key.key, &(x)->work, (x)->timeout)
+
+#define static_key_deferred_flush(x)					\
+	__static_key_deferred_flush((x), &(x)->work)
+
+extern void
+__static_key_slow_dec_deferred(struct static_key *key,
+			       struct delayed_work *work,
+			       unsigned long timeout);
+extern void __static_key_deferred_flush(void *key, struct delayed_work *work);
 extern void
 jump_label_rate_limit(struct static_key_deferred *key, unsigned long rl);
 
+extern void jump_label_update_timeout(struct work_struct *work);
+
+#define DEFINE_STATIC_KEY_DEFERRED_TRUE(name, rl)			\
+	struct static_key_true_deferred name = {			\
+		.key =		{ STATIC_KEY_INIT_TRUE },		\
+		.timeout =	(rl),					\
+		.work =	__DELAYED_WORK_INITIALIZER((name).work,		\
+						   jump_label_update_timeout, \
+						   0),			\
+	}
+
+#define DEFINE_STATIC_KEY_DEFERRED_FALSE(name, rl)			\
+	struct static_key_false_deferred name = {			\
+		.key =		{ STATIC_KEY_INIT_FALSE },		\
+		.timeout =	(rl),					\
+		.work =	__DELAYED_WORK_INITIALIZER((name).work,		\
+						   jump_label_update_timeout, \
+						   0),			\
+	}
+
+#define static_branch_deferred_inc(x)	static_branch_inc(&(x)->key)
+
 #else	/* !CONFIG_JUMP_LABEL */
 struct static_key_deferred {
 	struct static_key  key;
 };
+struct static_key_true_deferred {
+	struct static_key_true key;
+};
+struct static_key_false_deferred {
+	struct static_key_false key;
+};
+#define DEFINE_STATIC_KEY_DEFERRED_TRUE(name, rl)	\
+	struct static_key_true_deferred name = { STATIC_KEY_TRUE_INIT }
+#define DEFINE_STATIC_KEY_DEFERRED_FALSE(name, rl)	\
+	struct static_key_false_deferred name = { STATIC_KEY_FALSE_INIT }
+
+#define static_branch_slow_dec_deferred(x)	static_branch_dec(&(x)->key)
+
 static inline void static_key_slow_dec_deferred(struct static_key_deferred *key)
 {
 	STATIC_KEY_CHECK_USE(key);
 	static_key_slow_dec(&key->key);
 }
-static inline void static_key_deferred_flush(struct static_key_deferred *key)
+static inline void static_key_deferred_flush(void *key)
 {
 	STATIC_KEY_CHECK_USE(key);
 }
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index a799b1ac6b2f..73bbbaddbd9c 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -244,12 +244,13 @@ static void __static_key_slow_dec(struct static_key *key,
 	cpus_read_unlock();
 }
 
-static void jump_label_update_timeout(struct work_struct *work)
+void jump_label_update_timeout(struct work_struct *work)
 {
 	struct static_key_deferred *key =
 		container_of(work, struct static_key_deferred, work.work);
 	__static_key_slow_dec(&key->key, 0, NULL);
 }
+EXPORT_SYMBOL_GPL(jump_label_update_timeout);
 
 void static_key_slow_dec(struct static_key *key)
 {
@@ -264,19 +265,21 @@ void static_key_slow_dec_cpuslocked(struct static_key *key)
 	__static_key_slow_dec_cpuslocked(key, 0, NULL);
 }
 
-void static_key_slow_dec_deferred(struct static_key_deferred *key)
+void __static_key_slow_dec_deferred(struct static_key *key,
+				    struct delayed_work *work,
+				    unsigned long timeout)
 {
 	STATIC_KEY_CHECK_USE(key);
-	__static_key_slow_dec(&key->key, key->timeout, &key->work);
+	__static_key_slow_dec(key, timeout, work);
 }
-EXPORT_SYMBOL_GPL(static_key_slow_dec_deferred);
+EXPORT_SYMBOL_GPL(__static_key_slow_dec_deferred);
 
-void static_key_deferred_flush(struct static_key_deferred *key)
+void __static_key_deferred_flush(void *key, struct delayed_work *work)
 {
 	STATIC_KEY_CHECK_USE(key);
-	flush_delayed_work(&key->work);
+	flush_delayed_work(work);
 }
-EXPORT_SYMBOL_GPL(static_key_deferred_flush);
+EXPORT_SYMBOL_GPL(__static_key_deferred_flush);
 
 void jump_label_rate_limit(struct static_key_deferred *key,
 		unsigned long rl)
-- 
2.21.0

