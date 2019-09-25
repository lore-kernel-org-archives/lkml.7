Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2344C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B23222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atRyjKpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440147AbfIYSJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 14:09:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46981 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440035AbfIYSJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 14:09:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id u22so370065qtq.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QGz9lVjUUYmDPzsI/GOxWTXeDKg/AkMmVNx227mWBU4=;
        b=atRyjKpab4YukGa+7pHHXYmZW0gvEA9bCNrJBVrw6yY+ivfP+cTf8gvpCa0By8q0//
         e4D1wGMy1nPQewEWsklrX1mx+qg5W79Hvzm2Jd1Dirk2W2quemerRBinzzTg8wH2TN+y
         U82C5/6wJ4dpPh1ymDEfKuHIpjq7va4vjd/X7j3gIA7hGOnHKlKLGyWm5MniqrCSke9a
         my3z5S+9/3EuLbTLDS1FAoE6UByiM8jdJAYpY3ID7whqtnHeYFrAbWf/i3cblQqr7Vc/
         Sg8w38cFPxTd8pUdxy81oIihu7OijQACcUPD9RU32gJryPAIXd0FRm6MFhmzGCXPqA5K
         x0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QGz9lVjUUYmDPzsI/GOxWTXeDKg/AkMmVNx227mWBU4=;
        b=ePKXj2cxWzRs4uE9U9b5NqjyoiIz8o4qRILMAvffKdyKo/xLHCAVFsHIeJTa9xpW7F
         x41ydPGjmRf+FuP84QCSxynAaYq/dloPQ3US4yttJPdPA4a8gh77iOlDWa5u4mbTl9mO
         Si7O1zJ/N4FoydyqXNWx9w5D5xHXksZhfbw8ieKixMTTgSN7XM7J9OIqV1t2CwVN23xP
         8kxT5Eh0FDY8S3i13yheFQ3Jvjn2/IVlQ4fCuhPyTfBT4KRKZcmOxFWw1tLm2xQL54Rm
         S3FMOhdRBgSi19JV/7W+sDuRPlBNW1q9Yt3A/6dA0Ox7lvVok1rzmYsohhWr1ZVcxvbQ
         V25Q==
X-Gm-Message-State: APjAAAWE3mF+cCAaj+bNolehTOhyn4Shz1xABC15v1gNXoSD9XmL2AMl
        liaU4x/TOHj6/6aRb/hbPpI=
X-Google-Smtp-Source: APXvYqx049EScC4/u8X+unA98xAcrm2Zs7ogOWRg43Bw0MvMFCJTggaYpHrMMD0hDTF5MEDcLuUvmA==
X-Received: by 2002:ac8:7648:: with SMTP id i8mr628531qtr.363.1569434976225;
        Wed, 25 Sep 2019 11:09:36 -0700 (PDT)
Received: from ubuntu-XPS-8900.mobile.psu.edu ([104.39.62.174])
        by smtp.gmail.com with ESMTPSA id v23sm97817qto.89.2019.09.25.11.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 11:09:35 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     davem@davemloft.net, g.nault@alphalink.fr
Cc:     linux-kernel@vger.kernel.org,
        Dongliang Mu <mudongliangabcd@gmail.com>
Subject: [PATCH] fix typo
Date:   Wed, 25 Sep 2019 14:09:29 -0400
Message-Id: <20190925180929.24788-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>

Change Tinnel to Tunnel
---
 net/l2tp/l2tp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 105e5a7092e7..b4647fcfe3d6 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1138,7 +1138,7 @@ int l2tp_xmit_skb(struct l2tp_session *session, struct sk_buff *skb, int hdr_len
 EXPORT_SYMBOL_GPL(l2tp_xmit_skb);
 
 /*****************************************************************************
- * Tinnel and session create/destroy.
+ * Tunnel and session create/destroy.
  *****************************************************************************/
 
 /* Tunnel socket destruct hook.
-- 
2.17.1

