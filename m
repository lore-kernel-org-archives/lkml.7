Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7041C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4934206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ts06+0Qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbfCYWLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:11:51 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:36505 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731105AbfCYWKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:49 -0400
Received: by mail-oi1-f201.google.com with SMTP id t66so4479097oie.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5peyNALuutRmQZzMkIWMJWYer1k95cePDopKi9u624s=;
        b=Ts06+0QjEuiviBipZiSiGrSSEh1oAC6JXPVCji8k+m0Zn7BZRufrtCy2CLd89RguG/
         pqF5duWLMmUdMagMdQxcHOy1Ya16712JpQfA06qm/8mDiShXQRnyP3ZBlhvYjnRIUuns
         REBRk+x9bmbUP/+6ON+WA3NQAqar+FQvhR92k4wnx+/dSybe3GhsixWyjYMGTlDZAf3T
         VjUKh6uzHjquj4+SuDrT+TyGzey7XVWBJ9NvQr6BYW4L1jumi0rW+6EkToTT9IkWJjEM
         BtAm5WCBi3AvlfUMG+MrRrYoH2guLFsdX3QrkudGMou3AqKjR9viLVQCcAZOry/Myn9C
         HIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5peyNALuutRmQZzMkIWMJWYer1k95cePDopKi9u624s=;
        b=jNxZeu1BvOnWzkcvA1hzlQE9MV7Kf/PXFs3cqmQcKjjJ2xBhliRwpVkgyDWVYkoMrV
         RYSpk+maaJufkPrpLEAbmtKuNhUzTbCK6h1KhjIoPtLV7UEe5mW+FBFBJI10H09hoqwB
         jSxN4ArwaIXSS7x2EGDxChVZeriDQwEpGs/R60I9pHaHjuEynpyTVqHiZcamgm+dOQFj
         iZGiY5MryNLwbaT+2gFH7vXLlHVrBrUQJJG14TyJCBO3qkT56gm4W7HzcF+9GSYF4h7P
         4jadbIwF0m+DEmNj5dMlBY84hhiaq1twIldaT0y0Rj3Lfpq0QF31KkKVjSqCUHx2ak/l
         6/6g==
X-Gm-Message-State: APjAAAWc83gK4x4Ti6epJbp6XhI0Tg13+Ubw5VnMd6X/p3IL/Z2j5yOi
        +4jjmk5g8DFLt6DYH8B3aLlx5CAVsqs+5eF1vMYw3g==
X-Google-Smtp-Source: APXvYqzrfrJ6dLUvhvcnrxQhK4/6Y5+EAbdM8OEOt13tQTMHBHg67bdirfW2qugW/qN0xzgtq59HKDHeAJRqD/lVMIYw7Q==
X-Received: by 2002:aca:5108:: with SMTP id f8mr12490996oib.55.1553551848074;
 Mon, 25 Mar 2019 15:10:48 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:46 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-20-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 19/27] Lock down module params that specify hardware
 parameters (eg. ioport)
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Garrett <matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Provided an annotation for module parameters that specify hardware
parameters (such as io ports, iomem addresses, irqs, dma channels, fixed
dma buffers and other types).

Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 kernel/params.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index ce89f757e6da..8ac751c938f8 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -108,13 +108,19 @@ bool parameq(const char *a, const char *b)
 	return parameqn(a, b, strlen(a)+1);
 }
 
-static void param_check_unsafe(const struct kernel_param *kp)
+static bool param_check_unsafe(const struct kernel_param *kp,
+			       const char *doing)
 {
 	if (kp->flags & KERNEL_PARAM_FL_UNSAFE) {
 		pr_notice("Setting dangerous option %s - tainting kernel\n",
 			  kp->name);
 		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
 	}
+
+	if (kp->flags & KERNEL_PARAM_FL_HWPARAM &&
+	    kernel_is_locked_down("Command line-specified device addresses, irqs and dma channels"))
+		return false;
+	return true;
 }
 
 static int parse_one(char *param,
@@ -144,8 +150,10 @@ static int parse_one(char *param,
 			pr_debug("handling %s with %p\n", param,
 				params[i].ops->set);
 			kernel_param_lock(params[i].mod);
-			param_check_unsafe(&params[i]);
-			err = params[i].ops->set(val, &params[i]);
+			if (param_check_unsafe(&params[i], doing))
+				err = params[i].ops->set(val, &params[i]);
+			else
+				err = -EPERM;
 			kernel_param_unlock(params[i].mod);
 			return err;
 		}
@@ -553,6 +561,12 @@ static ssize_t param_attr_show(struct module_attribute *mattr,
 	return count;
 }
 
+#ifdef CONFIG_MODULES
+#define mod_name(mod) (mod)->name
+#else
+#define mod_name(mod) "unknown"
+#endif
+
 /* sysfs always hands a nul-terminated string in buf.  We rely on that. */
 static ssize_t param_attr_store(struct module_attribute *mattr,
 				struct module_kobject *mk,
@@ -565,8 +579,10 @@ static ssize_t param_attr_store(struct module_attribute *mattr,
 		return -EPERM;
 
 	kernel_param_lock(mk->mod);
-	param_check_unsafe(attribute->param);
-	err = attribute->param->ops->set(buf, attribute->param);
+	if (param_check_unsafe(attribute->param, mod_name(mk->mod)))
+		err = attribute->param->ops->set(buf, attribute->param);
+	else
+		err = -EPERM;
 	kernel_param_unlock(mk->mod);
 	if (!err)
 		return len;
-- 
2.21.0.392.gf8f6787159e-goog

