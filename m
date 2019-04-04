Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBE2C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A7A20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5mjTTfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfDDAdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:33:44 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:48083 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbfDDAdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:42 -0400
Received: by mail-pl1-f201.google.com with SMTP id 1so617170ply.14
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e4y+ZQyWx4Nt0qrBtIg+M07eqiLDT0f94JTcXc0xkLQ=;
        b=S5mjTTfJvgYmtb0pk9yg2qX2kfDWmzoiE39gwWHtmT8W4jzuAMrOa2sDqQKxKxPa7h
         qjEP64Mrg6re+iDsC52FxgSOL8Nwvj5Qn+T9WlymnKpX+aDImqUrqqmltqI/0nuYY6zp
         HhSJeJSUCkfcP3v0hk0t0fKyRgxkTcCFNSnCCe5HCEi/GKcv7tV3CHSplyaFxYum0QUr
         uWyxlJtZwG98ThTRKjLMLMiCka/mfEjDJkkj8JE2WgCrYlSa3cpdxQ0A8pexRpHyJIpd
         KtAViuScjJnu54WbD+xdae1wvImjb/+YoDbJCokDwSzH/cvDBOimigtYjc3fP3mR6Pj/
         6kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e4y+ZQyWx4Nt0qrBtIg+M07eqiLDT0f94JTcXc0xkLQ=;
        b=O7sM511lzZIBtzVhi0BtYlV5bMZGbmjf0cXeXGY+vjGtdZeALxP4p335nAtnE5Px1j
         bDyNc1WE1SkG2GFPGgwu7GYXEBx/mdI5sDH9iPsL0n9pNkQF3/meIR+GMW4PMfisd1Xr
         xPuRTN5iWN7kgKsS1BSZAml6X1WWPfpmnoQ4l+ginaobYnqrDO2DgbJHk3+uyCoSou7r
         DSWLaBg116QSFNDDQ4pHNfbmpPoddRTq7DrIHaiHLZY4EtnvBjcam4q8iXjTI+yI8vxc
         w3rEvLFk5gyzTJg/I4TvgbH0pcVPIbVKs9HfienDac7rcl+ZmJcXqJvlXoTSgt9Uu7SQ
         J4pA==
X-Gm-Message-State: APjAAAU2AGI9cuf3EM3pZrEkRDRsA2mnRFcx3smYwpM/Q+TqdvdU3Sa2
        /0Z78u6YqqFFQfv28ZgfCBdKgARdi8Q4i/h9vl3osA==
X-Google-Smtp-Source: APXvYqxZ3QsT3lULnw7lBZvr1BvN0odte7SRH8IlhPgnw83tXJaUcphlw1Hdg/epzSwg8cAvt2Wu5dnI1NnNsIJginS1IA==
X-Received: by 2002:a63:a54d:: with SMTP id r13mr65091pgu.126.1554338021751;
 Wed, 03 Apr 2019 17:33:41 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:40 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-19-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 18/27] Lock down module params that specify hardware
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

