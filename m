Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FB2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9A7214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udQRHSr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfCLUVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:21:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33401 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfCLUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:21:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id c13so2948950wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 13:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HH+jQMaT4Yn+FaRGXChKBaqLRe+FNQahkiLUcZY3bfs=;
        b=udQRHSr625o0SXjKS8MIDZv4gNZ3gKxAP3eFErEfVBRmvCqh8eekbpBQqkW+bErWm0
         B9vSmmayCGh+2zCfaklfvpoUpxotRIkIZFeUigMB0cyEclj0ScY8oMwgwNOI5fxdB6vn
         aTxk5sBjnvzmvToLt1m06OkIwhW2E2tyv7tXZX9JEbi6wtvumFAhf+nQSG0dke/ZtUb4
         4Kz6zVcJr1FG19Cf2rMhSkbMFODa2OZLWRvPcQG0uHa9yqzwu+uDLDi3ih5/6WNe557P
         t/UybdYzjyac2450SmAbO7O6X+6uX9FHuRTWXDdrWVtaJIAFXQYamOd3YZ0ZaBjO6pp5
         WHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=HH+jQMaT4Yn+FaRGXChKBaqLRe+FNQahkiLUcZY3bfs=;
        b=lPywHbJ1jpEDTcGbP89gVPyGx+1ndjKrh9n9HnDsNnn0JgltIs2wd3GN+Px0YEUJ50
         JDKW+0f5z53bqpNDOa5MqfO/KiaJ+fck+1GZwDiWOPEUJEKRCtUr/vHuoie4z1icS3KZ
         yJ0otejwWR9iGjPATHO3V+/BcC3o5f9NoAjMB6dLJi2PTaz41X+cJQfJhGS+cH2ipZ05
         ZGKJAt4fo5XZoeXENck+3UXz/wz161fSjpZSFo+n04nIOMQY4SwkaFtOIInpaJqhJOWK
         hMscPl5tDW/nAdrPyKnTwh/e/lUXmlWtxzc9JAnFScJUQrxeMIGJPv4fnkc3A4r65/yJ
         suTA==
X-Gm-Message-State: APjAAAVffMjwYypMHtuB71dPxa7kc2J0tU8kzwLGn/RjQ/NvSXeOAVH9
        G4sKUl4cvJWR6Z0o2d2N1Ag=
X-Google-Smtp-Source: APXvYqxtvUGQKUVrVtyLvBz29yABPfIeBXVlY7Wvao/jJVJ4wZ1cCix11vlwi6w11BgHrYUlDSJKpw==
X-Received: by 2002:a1c:c5cb:: with SMTP id v194mr3854524wmf.150.1552422105818;
        Tue, 12 Mar 2019 13:21:45 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id a74sm5951683wma.22.2019.03.12.13.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 13:21:45 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id F2916114655E; Tue, 12 Mar 2019 21:21:33 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/workqueue: Use __printf markup to silence compiler in function 'alloc_workqueue'
Date:   Tue, 12 Mar 2019 21:21:26 +0100
Message-Id: <20190312202126.29868-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence warnings (triggered at W=1) by adding relevant __printf attributes.

  kernel/workqueue.c:4249:2: warning: function 'alloc_workqueue' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/workqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4026d1871407..56b7cf898f10 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4208,6 +4208,7 @@ static int init_rescuer(struct workqueue_struct *wq)
 	return 0;
 }
 
+__printf(1, 4)
 struct workqueue_struct *alloc_workqueue(const char *fmt,
 					 unsigned int flags,
 					 int max_active, ...)
-- 
2.20.1

