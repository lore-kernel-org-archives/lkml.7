Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64AFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C260208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lAD+Qzjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732831AbfCZS2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:28:45 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:53353 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732806AbfCZS2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:40 -0400
Received: by mail-oi1-f201.google.com with SMTP id c21so5714063oig.20
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e4y+ZQyWx4Nt0qrBtIg+M07eqiLDT0f94JTcXc0xkLQ=;
        b=lAD+QzjyPkuMWI1jtrwYUcf9ZLsCsgEAV8IiHR2c/Giu1mweyB6KOIX9V7bRUMz3KS
         21b4OTxu7xK5eC1N0v77eagIpq/LbKXwRJS5XlQ4ux8JVVcGH/79E9Aqu/MlHN+BG83Q
         s63yKyZH0rorrlhZwK4+OD/kLn5ykpACdXHTMpCcfhVzKV8mm56UXHrvwTEyIKgMLYwm
         9+nV2/SVnS29ukwpXBcLbBMVsylFeXxX3Dj86XBbxl6L2a9j4b0wOHCTSIs7/9yqe5xK
         dXu5KTEuDJcq3bINEDmkRQmgq1sNVXBJ2s3Tt6W87zlrp3KwKRdoIU0KG8z2jTxMlJO8
         svBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e4y+ZQyWx4Nt0qrBtIg+M07eqiLDT0f94JTcXc0xkLQ=;
        b=LILLvBLxzjFFOoivelBFDI8NFgtVc+bqYqfEjtRtKqlxlRoWW/yjQxQGTqmVEpWlRl
         iwZk6Vk7q6JjCgaj5Jy/Cfg53gDDedeOKfPRooeCurDlxXUGBIri1X1zadxtDG4tAjBQ
         Ly+SfF9fjLKxelh+nxKkWjHov2h6+9wP+6OkUtQ38sXVf2X4t+DO2npvQN8teOm/rBKX
         oS7XL/SagfMl0/aggCzfmotHK+EkPvZZooYo5scnoL0mqKTE0S+bqsZetDjcpXP2bVL2
         Xw6Va8Dryay/HXUhrqCcn6Phz3sLl2vp4jeKcF6EFjhBOwfbEd8GJg7sJIkOkc5eZKG7
         LwMg==
X-Gm-Message-State: APjAAAVnkU3d278WHWqyZvEyZa6V+f06o+g3lvNJhUogzTo9iEXe1ufq
        7URD0QrL1NymdKYOhklY9MHlE28+KxDohY3InaiRJA==
X-Google-Smtp-Source: APXvYqxKOCWDIgBn5rlg5DtWC2EvLiyCBHCBifCiS+zDJTN3dSw5kDx/CYcMYlbSMIB7aU/iaezdCEW+L4pijefSPl72Ng==
X-Received: by 2002:aca:3d44:: with SMTP id k65mr15898886oia.143.1553624920139;
 Tue, 26 Mar 2019 11:28:40 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:34 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-19-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 18/25] Lock down module params that specify hardware
 parameters (eg. ioport)
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Garrett <mjg59@google.com>
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
Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 kernel/params.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index ce89f757e6da..da1297f7cc26 100644
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
+	    kernel_is_locked_down("Command line-specified device addresses, irqs and dma channels", LOCKDOWN_INTEGRITY))
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

