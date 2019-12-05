Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE791C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B14221835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq6nuJX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387521AbfLEVwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:52:41 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35859 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387502AbfLEVwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:37 -0500
Received: by mail-io1-f67.google.com with SMTP id l17so5271356ioj.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 13:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LT/pRsrWT3pMIKrncssoajx6IuISMr2YC8qd+ONeJyo=;
        b=hq6nuJX4luL/9yaICI9qXxs/k4ZRnvQvv66J9Uz/LzFnhXlIsWnizNO6MA448ySYjy
         Ir71vVJhzVazXoqYZxE19DzbQJHvrP87NWiYOTYb1WrjNBK1WIXlgajwblKXxp+hgcKA
         /q7F+/Ltg/M6P6B7aomEeZlbYob+xYo16ocldq/MukWIoAGM9txRLpDKe/6KwPVvQULQ
         1vLMC6u1M/FupPMlQRJI8zKGNSPSJaXblXzCCAefTaTzA0urNhz/ztPH3x8Sm6md7WPm
         XXrwm9pdTZCDZg9V9MfnVnIaKWqROfD0c3u7RUeDx0iueKK8Y+z87oLt8KKN9iwL1OP4
         VksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LT/pRsrWT3pMIKrncssoajx6IuISMr2YC8qd+ONeJyo=;
        b=amZcbUL4kifecYfV0hYZsI/O/BX3a70Jjq+JidCLX7kNOeZsDXcw1WA255bDCQ1YlO
         QOal2xdaBhMhVIVQe3PUdSKhXMLtaZ/Z2YaYPo3HQmC2rAN2Ja0N0tbQm3OGSZiAC72O
         3BIq3a7y6NeWsjSWnfqUz+oGq4bUGgZtgB7npLt/BPIsq0+oBD6ZPA21xf55z8LyQwjc
         F7PtuMvainiLHNENTnSJzh5p3kWZ1Jzy3XzY7IVoQNASPT10Bk+TitZtkWDq0cSTyx/c
         9HRYB9VDlmcOLgI2cfS8JageG3Wrp4bBlVX4VFkrjI8QDLsQoUt7eaOYGdRiLGyj5W/D
         qSMA==
X-Gm-Message-State: APjAAAUwLQgpEgoEvThJzSr5kfxZnlOkaYYOfG7m7z6ayRm/EoIjryk8
        cAkItBuqVoA4gOBSEuqQDbA=
X-Google-Smtp-Source: APXvYqzPg/fbZaaARbpfHJCXlQffTAlpcMkqL5Iq5ihVaRblZ8KZxILwFo0VmFMBLeQ+6SwzIUXjOg==
X-Received: by 2002:a02:9404:: with SMTP id a4mr10372996jai.67.1575582756872;
        Thu, 05 Dec 2019 13:52:36 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:36 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 16/18] dyndbg: make ddebug_tables list LIFO for add/remove_module
Date:   Thu,  5 Dec 2019 14:51:49 -0700
Message-Id: <20191205215151.421926-19-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
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
index 15bb9939df97..d056fca96b9d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -958,7 +958,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	dt->ddebugs = tab;
 
 	mutex_lock(&ddebug_lock);
-	list_add_tail(&dt->link, &ddebug_tables);
+	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
 	vpr_info("%u debug prints in module %s\n", n, dt->mod_name);
-- 
2.23.0

