Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4761C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BEF2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U9J1t3Nx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbfCYWKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:23 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:43674 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730795AbfCYWKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:19 -0400
Received: by mail-ua1-f73.google.com with SMTP id o12so1333518uaj.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uYemRAgVTJFGahU1zMfb1n2EMnLkr+SSlEuKQqgKmLY=;
        b=U9J1t3NxYbQMopyhw2GE3bLit1uMhrE4YcCM5dJ1VZEcPOPoJohS9muHLwrm4vQlDT
         8XvcG/28ok21BF69yNbSQqCw3e6yjQAJUDrd2iaM/KgcHCo2BszrbFw8/6jMPHvtp/yf
         iWbLAQNCWBLdHGrn8i0OX9YYkOvt9fPMvh7laV3CW1NvPs5u0ovDE4DFMYQzJghhon6V
         bj6B9ZBfpvxXzkfjlaJuCbNMNi2Thezr5krapkJ9JEX32womUHt1rfjs8e8QB5aKcnQL
         DtOuGW6wgC0uGu7Lxs3FaIweVocdpEXRME7+Lfg6KE1hn5KohnaCb7igp2IE3uYR8ftF
         zagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uYemRAgVTJFGahU1zMfb1n2EMnLkr+SSlEuKQqgKmLY=;
        b=ZOjS4WW1/WXWGVON9Yjv/yZluD6WMbGl6k6RFSXPy5conk7lTulSzgWMiNw7Mr3zb6
         g4pnTzrsOw99ry7jkGhnnC/QwqCVkG6oc1NCbxfebEgN7j81bs+8DFMweSPuRgJfuMHf
         ZxvaKSPgOvWizb5osDVSTXaK+Xh9aeabu5VKHsGr7AmEKTWBII/7eNj6e6qTPQJqKMUC
         YYulah7ce9Jzh/D+VFl2tEHdUAqAJ3ZsIROcZhy9bTxJORn4VKztT0DeNlDZJvU4efKp
         gaOYxTu+R1lS293gbDreTkX8M1EYNH4zMggHQ/sX37HVrBYTeaoBH72+5gctuqPEiIzk
         lQ8Q==
X-Gm-Message-State: APjAAAW0BTT86ahZNWDkmmR9JiwcqoW2Vz/1iAUVELU0QE9bQzi7SmoI
        YJ2yMBxudOkVKgHCD4sJD2nN9uEYnQt5SB4RP8pqBA==
X-Google-Smtp-Source: APXvYqy7ER6okO+DXR1Hn9BcNwumz/DBgYufWQnxxDJBMiaFaOCwvLdckGZ0KGbfYqsKbYK+Droz0kzG4KKcv0gh0DEQqA==
X-Received: by 2002:ab0:65c7:: with SMTP id n7mr16136307uaq.3.1553551818764;
 Mon, 25 Mar 2019 15:10:18 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:35 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-9-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 08/27] hibernate: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Josh Boyer <jwboyer@fedoraproject.org>, rjw@rjwysocki.net,
        pavel@ucw.cz, linux-pm@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>
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
Cc: rjw@rjwysocki.net
Cc: pavel@ucw.cz
cc: linux-pm@vger.kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index abef759de7c8..802795becb88 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -70,7 +70,7 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 bool hibernation_available(void)
 {
-	return (nohibernate == 0);
+	return nohibernate == 0 && !kernel_is_locked_down("Hibernation");
 }
 
 /**
-- 
2.21.0.392.gf8f6787159e-goog

