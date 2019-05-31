Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27103C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DA626E97
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlUP7gvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfEaTuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 15:50:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46270 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbfEaTuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 15:50:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so1994220wrw.13;
        Fri, 31 May 2019 12:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SaljSGPBs1Vy/QQOwSmaxLHUgbHVYPG29dMMTCQXDKE=;
        b=LlUP7gvoGXzz0zxT7Yy3VIIX9ItIBxJZHksTMh0DcRNbi7fKUHQtrSLGB4LYg6tL76
         pxCWl7qIPgCYiEEUilv9AR8v/EaNTYFe/qT38JAusjolRb/dmxGS0+GHolL/tPlzS62o
         zb4pWTrc9NUxnxVvOeaV8yqo2CLjpBdmobQt5IjvJMka3I7Jyg4sMDfpjA4aMiFZCuD0
         8Ni8bu0e4yxNO0C0729hgkJhOGQMK4REVnFxxsPivXohhpMPVPDXJXWAKq6yTdX65h77
         5bZ6vMAuiXiu0M4kMpS7apBiaS9rErJbACqSjCKYigrJfjZqfhjPgHCtL4TodI5Zcaz2
         Hd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SaljSGPBs1Vy/QQOwSmaxLHUgbHVYPG29dMMTCQXDKE=;
        b=h4hEA6zFLTG0qUs282T4j0rQZZ3+XHA/PGTJoxZp0IY30j3gXjkziBW65JRvvV7z4w
         zkjHqKIqUjriLe8au2tZZPTtzs38gIvskTB+1F6s6LEKyvhoUmO1VxxLi+pAJKB7psMJ
         NoeIU+bOPT6S6WBri0KF0fbGzwl2jlfR3FAqWkYCKxoBl7eMN8/yFz4ScD6u+yo9uPxF
         neqZSvk2v28qx2f0NBe9raVvtHRTwQHoqz1HauXexNwv1R5tKrSzYgjjB4gWm90q7dBi
         YbHJlAPU8Dp7GeGD0Rdx2+QloLu19BkpX471Q+zTJEfDB3CScW/n9o9sb3PtfUOOJvRB
         +XRQ==
X-Gm-Message-State: APjAAAXd3arIgJ1a3wqjHYE2TlDI5aC5xVW3lYqJvPYrcBXmQk5ftkZz
        /BQUc19V11A0I3PhhLnCx6YHu3xM5w0=
X-Google-Smtp-Source: APXvYqzCXOCOUKWH3VTrDlGqM25J7kihDzbkpcAPEAZmQ3o4lGl/bBnkr/DfXw9kf4iooO+5zQj8oQ==
X-Received: by 2002:a05:6000:120a:: with SMTP id e10mr7978940wrx.171.1559332222786;
        Fri, 31 May 2019 12:50:22 -0700 (PDT)
Received: from Thor.lan (89.red-2-139-173.staticip.rima-tde.net. [2.139.173.89])
        by smtp.gmail.com with ESMTPSA id y1sm4716107wma.14.2019.05.31.12.50.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 12:50:21 -0700 (PDT)
From:   Albert Vaca Cintora <albertvaka@gmail.com>
To:     albertvaka@gmail.com, akpm@linux-foundation.org,
        rdunlap@infradead.org, mingo@kernel.org, jack@suse.cz,
        ebiederm@xmission.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, mbrugger@suse.com
Subject: [PATCH v3 1/3] Move *_ucounts functions above
Date:   Fri, 31 May 2019 21:50:14 +0200
Message-Id: <20190531195016.4430-1-albertvaka@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we can use them from proc_handler functions in user_table

Signed-off-by: Albert Vaca Cintora <albertvaka@gmail.com>
---
 kernel/ucount.c | 122 ++++++++++++++++++++++++------------------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index f48d1b6376a4..909c856e809f 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -57,6 +57,67 @@ static struct ctl_table_root set_root = {
 	.permissions = set_permissions,
 };
 
+static struct ucounts *find_ucounts(struct user_namespace *ns, kuid_t uid, struct hlist_head *hashent)
+{
+	struct ucounts *ucounts;
+
+	hlist_for_each_entry(ucounts, hashent, node) {
+		if (uid_eq(ucounts->uid, uid) && (ucounts->ns == ns))
+			return ucounts;
+	}
+	return NULL;
+}
+
+static struct ucounts *get_ucounts(struct user_namespace *ns, kuid_t uid)
+{
+	struct hlist_head *hashent = ucounts_hashentry(ns, uid);
+	struct ucounts *ucounts, *new;
+
+	spin_lock_irq(&ucounts_lock);
+	ucounts = find_ucounts(ns, uid, hashent);
+	if (!ucounts) {
+		spin_unlock_irq(&ucounts_lock);
+
+		new = kzalloc(sizeof(*new), GFP_KERNEL);
+		if (!new)
+			return NULL;
+
+		new->ns = ns;
+		new->uid = uid;
+		new->count = 0;
+
+		spin_lock_irq(&ucounts_lock);
+		ucounts = find_ucounts(ns, uid, hashent);
+		if (ucounts) {
+			kfree(new);
+		} else {
+			hlist_add_head(&new->node, hashent);
+			ucounts = new;
+		}
+	}
+	if (ucounts->count == INT_MAX)
+		ucounts = NULL;
+	else
+		ucounts->count += 1;
+	spin_unlock_irq(&ucounts_lock);
+	return ucounts;
+}
+
+static void put_ucounts(struct ucounts *ucounts)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ucounts_lock, flags);
+	ucounts->count -= 1;
+	if (!ucounts->count)
+		hlist_del_init(&ucounts->node);
+	else
+		ucounts = NULL;
+	spin_unlock_irqrestore(&ucounts_lock, flags);
+
+	kfree(ucounts);
+}
+
 static int zero = 0;
 static int int_max = INT_MAX;
 #define UCOUNT_ENTRY(name)				\
@@ -118,67 +179,6 @@ void retire_userns_sysctls(struct user_namespace *ns)
 #endif
 }
 
-static struct ucounts *find_ucounts(struct user_namespace *ns, kuid_t uid, struct hlist_head *hashent)
-{
-	struct ucounts *ucounts;
-
-	hlist_for_each_entry(ucounts, hashent, node) {
-		if (uid_eq(ucounts->uid, uid) && (ucounts->ns == ns))
-			return ucounts;
-	}
-	return NULL;
-}
-
-static struct ucounts *get_ucounts(struct user_namespace *ns, kuid_t uid)
-{
-	struct hlist_head *hashent = ucounts_hashentry(ns, uid);
-	struct ucounts *ucounts, *new;
-
-	spin_lock_irq(&ucounts_lock);
-	ucounts = find_ucounts(ns, uid, hashent);
-	if (!ucounts) {
-		spin_unlock_irq(&ucounts_lock);
-
-		new = kzalloc(sizeof(*new), GFP_KERNEL);
-		if (!new)
-			return NULL;
-
-		new->ns = ns;
-		new->uid = uid;
-		new->count = 0;
-
-		spin_lock_irq(&ucounts_lock);
-		ucounts = find_ucounts(ns, uid, hashent);
-		if (ucounts) {
-			kfree(new);
-		} else {
-			hlist_add_head(&new->node, hashent);
-			ucounts = new;
-		}
-	}
-	if (ucounts->count == INT_MAX)
-		ucounts = NULL;
-	else
-		ucounts->count += 1;
-	spin_unlock_irq(&ucounts_lock);
-	return ucounts;
-}
-
-static void put_ucounts(struct ucounts *ucounts)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&ucounts_lock, flags);
-	ucounts->count -= 1;
-	if (!ucounts->count)
-		hlist_del_init(&ucounts->node);
-	else
-		ucounts = NULL;
-	spin_unlock_irqrestore(&ucounts_lock, flags);
-
-	kfree(ucounts);
-}
-
 static inline bool atomic_inc_below(atomic_t *v, int u)
 {
 	int c, old;
-- 
2.21.0

