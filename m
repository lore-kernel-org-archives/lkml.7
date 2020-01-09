Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEF8C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC328206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiOmSTU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgAIJMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:12:23 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47092 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbgAIJMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:12:23 -0500
Received: by mail-pl1-f195.google.com with SMTP id y8so2308495pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 01:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bD7gyya4cAOQOb9p2IS6rqFYWX0Br0cfXVNEAUUuZu0=;
        b=CiOmSTU5BNBN1hJtADq9FoblA9dkVx8TbRrvQ4BV04gZEF7EqALG9U1zBveXUbZOyi
         /5c94wEqSz7SFiBafS8mzocek9/LTFzp22WGhiU2fa8iRvjFvJnwVNHJ8ibzk6Gz/wRt
         vC48MdAcH+8GVX1Q3pyPI8u/WFiWT3KasnXluCS2MuoGAxO0TygjH+doDuPVMtIdMLqV
         3LEQMQ5gXc9Q3TeLXqX0Z4gasm5eXUm86BJIjHa88jBfyqsKlD5nACZFELC2i4WQT0Am
         z1swX8JLT88JtLQ6fWuDeE3Tf5E1Zr38CLYrue+p3acW7SvfkW62ubrgg2fZtHH7Wz4B
         mAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bD7gyya4cAOQOb9p2IS6rqFYWX0Br0cfXVNEAUUuZu0=;
        b=N+8H2nnqK1MyKiUso16vWHJQu9zB1M65kovnaQlM5ZOCa5U5mgkbBbivbGH7VaW8Kb
         HbQfD99mO1fT7/DYzGOXorySsjJB6dhv/AVH7f6CPnTwTR8+hdik+cfbJKnGiMgGV9DA
         7xf/C5ULIzN+anHWkVvICjbvlOIEvRNs0BUhERUu85iqIyvVHF7riLDXeSOHRbjpbEXY
         cj4EUYXfQsiM//t3TQGoQtNKmAr+if5yU6kk61rwBXFWT2lItR2YTjw2c9Ip+w9L8f8V
         oU0Ii/dRlojZMEs9NOWqZo2wilq9aCCGN7oysr2lmUePV4g1GqmDeHN+Fb47k+C999SI
         TNXQ==
X-Gm-Message-State: APjAAAU1A4+5CXPrIMTvV4uQWhpEgDAQyDfmYDIhdMcAP/RquK2TPZWS
        cPGnQ7CJixwsEOvU8XMiRLU=
X-Google-Smtp-Source: APXvYqw/JpNaFke6Pcf26UCN0amj5bom7PxM+mJmP/X12nXxdLe8vKFxnV7oYLLFaOsQn34f2EUC2Q==
X-Received: by 2002:a17:902:6b06:: with SMTP id o6mr10577664plk.138.1578561142689;
        Thu, 09 Jan 2020 01:12:22 -0800 (PST)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id o19sm3364369pjr.2.2020.01.09.01.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2020 01:12:22 -0800 (PST)
From:   liuyang34 <yangliuxm34@gmail.com>
X-Google-Original-From: liuyang34 <liuyang34@xiaomi.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     liuyang34 <liuyang34@xiaomi.com>
Subject: [PATCH] trace: code optimization
Date:   Thu,  9 Jan 2020 17:12:17 +0800
Message-Id: <27225bf0ec9b4e2f3d313456aee75e294361d550.1578561009.git.liuyang34@xiaomi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1578561009.git.liuyang34@xiaomi.com>
References: <cover.1578561009.git.liuyang34@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use scnprintf instead of snprinr and no need to check
the return size again

Signed-off-by: liuyang34 <liuyang34@xiaomi.com>
---
 kernel/trace/trace_stack.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index c557f42..7b15e9a 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -329,9 +329,7 @@ stack_max_size_read(struct file *filp, char __user *ubuf,
 	char buf[64];
 	int r;
 
-	r = snprintf(buf, sizeof(buf), "%ld\n", *ptr);
-	if (r > sizeof(buf))
-		r = sizeof(buf);
+	r = scnprintf(buf, sizeof(buf), "%ld\n", *ptr);
 	return simple_read_from_buffer(ubuf, count, ppos, buf, r);
 }
 
-- 
2.7.4

