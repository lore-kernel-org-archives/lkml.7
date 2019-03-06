Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A603C10F00
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290FD20663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miWti6Bj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfCGAAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:00:22 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:45705 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfCGAAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:00:19 -0500
Received: by mail-pf1-f202.google.com with SMTP id b15so15431441pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IdVfFnhFbXtJ1p9edmpEjpXYYyA3kgeVT7S8ioUS5wI=;
        b=miWti6BjaJ9xhyuyzcg9fulsDcsx5hrWoVxexTNUp6cG96sXJZg2aJm3xzAMwTzM0f
         yom5fwu85Oc3gbfqvU4MT9rIJu4yzS5y6yH6FGVLOtRP5ifcxbp+GJS0lU7mvX3a/rr5
         eEIteTb76gg0LnPklB2z14hPboM4l8q2QPLUN0X1NAWX1VzzxvfM6qSimMKgVouLlqDn
         CjpRLUJp/eA/akAxu9BdNlgYzIQKKwc7bdtAsvhFE6A/Q5IVz1lvSYUEN6nzjO8A2L3V
         x2BgK2d4yd55qCvx3Dk9iAI+5sGtbaMuSg0wCmgXmsVcIMumaQd66hbX2fTEpyUZdNOs
         X1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IdVfFnhFbXtJ1p9edmpEjpXYYyA3kgeVT7S8ioUS5wI=;
        b=QC76x79tUp++POdTUMs0CAMSAxuYNi9DX4csBmPzaurEWKwZA/1HvVHEqvZeFxCFVV
         4vxAPeYOqNBp6f9viehuEpEAJYRfXc6bSNwrCD83uJY87i6Xsr1rj5Iglnm3ixHNpZIl
         dE/3VyEfnZK4pX3yc4PdhwWzKwNXeXckSg+oE8GK35MGfV5nDTbi294/YUFuHQHxLiy9
         6H6fW5tZGt20RgepI+Kaz9iUJLx3o6aROKuRSQt/1FLWW5To+dWsVU55TvYN98p10YCh
         h7RoKjMA+CTSOR3yZxvgacZOHnO9RdGYM2vFDGEP9h2lGl1xrReOQ6qv7gZewGOuB8x1
         i4hw==
X-Gm-Message-State: APjAAAWkgk4NYQiG6HVaTfjAMNCWEqg+uKvHguZpdviLDKy8/Y/Wbh7J
        6NGS9RLp/6iFJG4F0szwx8bes6dCyvVDiEjqwAnieA==
X-Google-Smtp-Source: APXvYqzuMdXhB+JQDhn/jZvkysiN7UpsUi+51+G/P1uyrCn2dFNevUmM8fPQ7LjRFpo4VAJuXceadCsJ/fcgh0w80TFhaQ==
X-Received: by 2002:aa7:9313:: with SMTP id 19mr3840216pfj.101.1551916818945;
 Wed, 06 Mar 2019 16:00:18 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:59:06 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-21-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
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
2.21.0.352.gf09ad66450-goog

