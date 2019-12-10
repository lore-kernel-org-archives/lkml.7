Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8104C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F16820838
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmjyDKJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfLJC2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:28:32 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:43506 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfLJC2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:28:30 -0500
Received: by mail-il1-f196.google.com with SMTP id u16so14712317ilg.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 18:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LT/pRsrWT3pMIKrncssoajx6IuISMr2YC8qd+ONeJyo=;
        b=PmjyDKJ+tpNXEJsW9zaAY/RCyfg7fcxIijZdILXDq/FD7uMOUvMfwwoxbP8NxMhpNn
         +Udc0FVzPdmHVybtgvk0JTt10eCWC7Y+Q1tbXWHpXmHZbwtS+JjknnFuweTBNQlEN8pW
         YLW5PBAPMmFrjCKcu9xfrnBl7vT8Es+znjXSalvv0RnZkr13qaYpzgSk42OvSLZn1K4A
         COV7ZTvwv6cSSFop6d2yeQlHD5mKKnqm/aEV9bNHYN/ph7UxBhs2pQ3c0TXBO7t9F6A6
         /RQoZcptK99IjPg4tY4rF5fjeYA2ec66bzWjg6uxOWYw1Lyjy3TafAvM3IBhy2T1v+oF
         KjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LT/pRsrWT3pMIKrncssoajx6IuISMr2YC8qd+ONeJyo=;
        b=a5w/RKojNYG126ckDnsSMXHbY6lRMgdtEuXnJONUem1i1CHJo1tKd45VvmG8bYQSYJ
         WFYjtBPiZgyhbQ50Q4Fr/W2N4+DUUgu7/k0Ua32heZm52gHxp/bCH+1kp+C7jbIe5nIy
         6jYrGvME+eS4zR/PqCWG0epZEjfH8TLtGBy8vV9/ODhFg12oytGjHDB6tZRkR0GNWzBU
         MvkBZCyXgvaTgEqsOCOAxIbbDbZ56MU3+VhiX43RdYcIxdpohBqDJXQ1v0wCkGMAkjLQ
         5bM6hL2H32NrL+iNnc5p67Auu8z4OiJDmkeZB6hKdI8x4zAGLV0zRPyDovyuDGC1mXBK
         9DHQ==
X-Gm-Message-State: APjAAAU9cAL/rSkascJK2tC6x/xFG+vtpKuzmfLHN3PAsou0VpPud6fE
        nSl/tGRfl+bEv86tq7uQjKa8Qew67rM=
X-Google-Smtp-Source: APXvYqzSOTmy0ySpadXxZXfLiq8KnEZDievZOFr3ixxOlivdF54AvGEs+82l6hBEHwS4S6Y6akMDng==
X-Received: by 2002:a92:cc:: with SMTP id 195mr24643064ila.212.1575944909114;
        Mon, 09 Dec 2019 18:28:29 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l9sm334052ioh.77.2019.12.09.18.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 18:28:28 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 16/16] dyndbg: make ddebug_tables list LIFO for add/remove_module
Date:   Mon,  9 Dec 2019 19:27:42 -0700
Message-Id: <20191210022742.822686-17-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210022742.822686-1-jim.cromie@gmail.com>
References: <20191210022742.822686-1-jim.cromie@gmail.com>
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

