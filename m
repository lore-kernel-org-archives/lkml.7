Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3490DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B822206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdebbbOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfK0RwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:52:04 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:40751 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfK0RwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:52:03 -0500
Received: by mail-il1-f195.google.com with SMTP id v17so17905178ilg.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 09:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fTmVS+hVHtiQTgwNuCFFA0kECrnZjg8eJI72GeuE00k=;
        b=FdebbbOlSL2DOl3FifLKPzujFS4QHXzJ4zeznPAEBlJo07rNlj+rF7jCmX5qUjq3FQ
         kyApSB/9P57W+WXslS63SW6QZ9zx5PX65mcEEk6KkYc+nDy3/6RXUOoqY4zN1WiHZ1Js
         RJ/B6UY2EMLhp0ODhG3YeWbsVU55VufytVa400VMUNk6OvjlgydVpwYymO6F/Wu2zS6L
         Fp60/jIHzJIvGjUK1/PJ1MsrFtNxNJ24lGPoapjY1ockKm0FdA0oD3Oiezyz3e2mmB38
         3JLw1foe963Hdgphbv/W41Yn+EDK9QBRWc0Fz6E/oav8e2Afas8EGpEeZAKMY8gSMGsa
         F42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fTmVS+hVHtiQTgwNuCFFA0kECrnZjg8eJI72GeuE00k=;
        b=b3U1QsrEsaXI+RvnSEH5Yc73gWUo+UhMlPMS42k7aciiK4mb4Id9YiEEsLGTebkaHW
         ZLvgkarykwcPNd0RyBXrAEGPNy+r4pn5smdjgnPKDnv05x0ybMlADF96o0p+8hoR3ONr
         yrZZOwrd8glwdfDoGY4g4Fzv6aKZ64HzG2jWqZ9QO9NqLXLn7fOO9Jau3IBwRhpF8ICH
         MrNXsB8ZvmK3LpRT/oaZoCSqzR/Z/LW7selsphLXeWwIB5PyeEW92uZdBlCyvGHQFwv6
         6eJ//JBToFFppHBiiOM7RL2gTC4z14jXPhl7qfF82RXjtkdAIAjCUSeN0XHeI0CMpgPu
         2QKg==
X-Gm-Message-State: APjAAAXOB4WCQLle/HhFKgulZfXKJOXNzt/hWGQOn3/4Ro8iX05VNVse
        oHQSs9qFtqDrDZknIq7lKLE485gneDo=
X-Google-Smtp-Source: APXvYqwRRWZwO3kcFluUx16cYJZCDzoGcLHD63RA3ZzJWyliQBYLDMBYzga++ueBgsearVUq6nNX7w==
X-Received: by 2002:a92:d581:: with SMTP id a1mr6723777iln.39.1574877122746;
        Wed, 27 Nov 2019 09:52:02 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id x62sm4568236ill.86.2019.11.27.09.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:52:02 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 16/16] dyndbg: make ddebug_tables list LIFO for add/remove_module
Date:   Wed, 27 Nov 2019 10:51:55 -0700
Message-Id: <20191127175155.1352058-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loadable modules are the last in, and are the only modules that could
be removed.  ddebug_remove_module() searches from head, but
ddebug_add_module() uses list_add_tail().  Change it to list_add() for
a micro-optimization.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 82daf95b8f64..99284e775682 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -960,7 +960,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	dt->ddebugs = tab;
 
 	mutex_lock(&ddebug_lock);
-	list_add_tail(&dt->link, &ddebug_tables);
+	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
 	vpr_info("%u debug prints in module %s\n", n, dt->mod_name);
-- 
2.23.0

