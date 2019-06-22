Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14405C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFCF20656
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mw1nxxDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfFVAEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:04:30 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:41604 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfFVAE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:27 -0400
Received: by mail-pg1-f201.google.com with SMTP id x3so4998169pgp.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=E1ydClCjIQanqkYubDCe4fTQ8CyYEUPCl76Zws+exX4=;
        b=Mw1nxxDCj3KPV9UNkkVTuYDyrqaNw9yfe8VMRM7ZPzqyoc628ni6A1ID84X/NQY/eG
         TjqgdDZ2eclCmQYBtR64hrRsKfdJ0/b2ea/MKIjVjf5Schmnsf9z4DGGkKrP3ZMtf/4Z
         5fExcPm/lB+/BHv/goxmhPnXnifnIxGZIkdJL93w+OXXSyC4vIJylekCmcsMP9+JbsT+
         gVi97q0IioDlBycYNesWz61vacRTWYh1YbLAOH7R2x6khfBxHVRBC8C//eYSarvexPeG
         Uo1SHVP2bSJa/A300oItLeqbJObzG1tatKWOxjfQ/shMDZS2UzCNHcLYt+NAQWt6dMzw
         3Daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E1ydClCjIQanqkYubDCe4fTQ8CyYEUPCl76Zws+exX4=;
        b=AHcYMo+UzMtI2/ksNmDw2/IUaNiV++i+b4f4Z5G5s5btfFmbe9U3qrMCbUvofyn4dq
         j8Zlz5qgaSc6ugkICoa+TzKED2JqU/JSaCQi/me68ToF2ibly8Jk0QnSHj64vF37mkJP
         3ZjQmaCCHqOLjy7FxhBGKlgUsxtBTDrRX8J5r5jmoazyaUff1IY4mIcEZlXnDEbkBmB2
         lNmvz+bNJzKLAGF0sGQ3/srRdGLBnFKLLs61Xwp2/XvT5VzVY48h2HkWKZaGQvi0nqhs
         qp/tE2JBNTDdNY7jyd5M86VGAEXgF0rFAkmVcTfDIY5f9/tIYIolPOBH8ZTRQ9oQXxJd
         g4NQ==
X-Gm-Message-State: APjAAAVGGkj2TzmYnX8TThcph02cKwsClObyDP8VbL+dXfBmd6M31LkI
        9gIQ1LEWOGV9/Wn4GOZO1ERMTPoXu9fKQ5IfticsMQ==
X-Google-Smtp-Source: APXvYqzVsoigFEz9xV2syvjuZK/rAiWYW9AdGJzJFdfPo/qG/n7y42EqV0+KSVGLK/rbmx1Vz0/09WNn5tQlIgfdmqn5eA==
X-Received: by 2002:a63:e304:: with SMTP id f4mr20804148pgh.187.1561161866832;
 Fri, 21 Jun 2019 17:04:26 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:39 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-11-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 10/29] hibernate: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@fedoraproject.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, rjw@rjwysocki.net,
        pavel@ucw.cz, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Boyer <jwboyer@fedoraproject.org>

There is currently no way to verify the resume image when returning
from hibernate.  This might compromise the signed modules trust model,
so until we can work with signed hibernate images we disable it when the
kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: rjw@rjwysocki.net
Cc: pavel@ucw.cz
cc: linux-pm@vger.kernel.org
---
 include/linux/security.h     | 1 +
 kernel/power/hibernate.c     | 3 ++-
 security/lockdown/lockdown.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 00a31ab2e5ba..a051f21a1144 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -85,6 +85,7 @@ enum lockdown_reason {
 	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_DEV_MEM,
 	LOCKDOWN_KEXEC,
+	LOCKDOWN_HIBERNATION,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index abef759de7c8..3a9cb2d3da4a 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -32,6 +32,7 @@
 #include <linux/ctype.h>
 #include <linux/genhd.h>
 #include <linux/ktime.h>
+#include <linux/security.h>
 #include <trace/events/power.h>
 
 #include "power.h"
@@ -70,7 +71,7 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 bool hibernation_available(void)
 {
-	return (nohibernate == 0);
+	return nohibernate == 0 && !security_locked_down(LOCKDOWN_HIBERNATION);
 }
 
 /**
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 08fcd8116db3..ce5b3da9bd09 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -21,6 +21,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
 	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
+	[LOCKDOWN_HIBERNATION] = "hibernation",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

