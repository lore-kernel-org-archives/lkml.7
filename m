Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FD7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F15C218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z1+rvoth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388095AbfB1XNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:13:02 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:36952 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387939AbfB1XM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:57 -0500
Received: by mail-it1-f202.google.com with SMTP id q141so9824093itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8KM4GPF8H/ZA8qZu4X13d5O4g08OSMJQgTj+Sn30UNM=;
        b=Z1+rvothKUqR2tRl+zH/aPd+au+70MAgtzcgA3i6y553uX+/QzIYSKO8X1D+XAkhO1
         0cl1XIShXKMwqyV6SVOjdEECCNLnNp+Z+xJ+RdtzV7mU2UBm1BwrIw7MdCFoZGEPgTyo
         9wjPyw6bEZD8qzrKYAL4ox04cDYhyezdGMVSzQSkQgBzEUNhcY/tY/qjGleZanIupMtu
         /RE567QzdS2BRSNaNuv19QZraWcbeTaKiX/lUHm8VfdT/iyEnAQ/QeymKlMFvz5QzdmQ
         3y7uAMlcmrGK7Cd9rmYXZVD5vZxSWp/JwAVzW5gt5Xku7HymwCegv48ovK72haVv4bgM
         wxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8KM4GPF8H/ZA8qZu4X13d5O4g08OSMJQgTj+Sn30UNM=;
        b=uD2N8MnLHadTPZ4ZN025r1AT5HzmLYg6bYsoJgiijkmUDH6lxkVedgQQ+4UHg0Fp2l
         x3RDRZB/VmEzEUaC/7XKNQsAqsI+DZzNEC/gy/Cf2BqLdkTXnYzWJ/lgN0zJR3MqVJ5m
         kMuWTbjuADWGLqfhjKbSWmnYqqjHWVZa18SrDikwY63PwjoZXTOOV8Fb00jv6I9KeoDD
         cHjXjY3RxYy4suXkri4Mo+S4T4WnY7Zw89+y8XwWUwAmjoX30dIUb+6XlFXzR/ljMxGy
         gWM+0i/wRb0HC0onDhox8q/XNtDbWYWphpqC3+GcRcc5apEspGZBA5Gv6GWlg/3Guz3n
         5nfw==
X-Gm-Message-State: AHQUAubVHyoEgIb7LBOK0uniw0nKgN75YwUeAsS6xu7ufXQGYqRf7H/e
        YCrJJfAzsU5OeBZz/cSy/BCQLT5jIYI3HqVDbyMt3Q==
X-Google-Smtp-Source: APXvYqyYIIPpi6LMvPSKodYDlF1Q3NR9zGkxdJ+I+B3eh9JF55kOsrbcWMzonXnT5HJXudG42GD3brjdc1roSdr3TYkjjw==
X-Received: by 2002:a24:612:: with SMTP id 18mr1507443itv.7.1551395576756;
 Thu, 28 Feb 2019 15:12:56 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:56 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-20-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 20/27] Lock down module params that specify hardware
 parameters (eg. ioport)
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
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
2.21.0.352.gf09ad66450-goog

