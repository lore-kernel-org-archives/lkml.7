Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0F0C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BE6206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tstw7iZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDZQ5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:57:01 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:56632 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfDZQ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:57:00 -0400
Received: by mail-oi1-f201.google.com with SMTP id j202so1705526oih.23
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 09:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LdtpNCBMXVEYh5+9sDcKIELQmRtwCEZfEh/KIYFOBOU=;
        b=tstw7iZxA9nBCcJm42TviKa3bi3ItAr7vfTnG5YC9Kqym6BPPvFKMw4mIP/esb1Yre
         /CMlYKOQJbOgKiCHWaeSZ1w+/XYFN9f4aLobh+zg4n7IbmnPQc0jkvCsUIRTDwa43Zwb
         84S7GwrJ2F6mS7l2MkMjUuUxw+3zWXnLRozAko6nXAOUz0MgIg+mnXnwHXPSwr2ULpB6
         83/g53qmLpOfbAncr55eDmfW0C+yLh0R8/TRQOJT9CC8Or6uneQm0hbGPU/omorcfvGZ
         HcW6GH6eQ3lBvlPYvVs2YVDA2D6CmSxTljsmMGFbTMU1Rm17Z9MsIRgy1L4Xx4k1uz4D
         yXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LdtpNCBMXVEYh5+9sDcKIELQmRtwCEZfEh/KIYFOBOU=;
        b=UVIBwr79z9/rx3HW5mjjkbJcIt9Ssh3Alw38HTfjS85ZB8/2PBNWJep1OU/zc/tqW6
         YavzKjKrbXVBp3a3DpLwMBargToxf5tdc1mTeUztwD73E3mVKK3sTpPxdRdF9CKKp/IR
         D5gY/aeoUoDI173mjONfFwpQpV6r1kNoWUzbK7cNmXShE03h4OhKZbHY2P2U1ZGEY6lv
         CMFXFL+UMlQtzUKA8FTb1fPRMgbD+bqYA3rK1igj5QAi+6l21Xv2nTEeU9aQp5ftwfza
         IU6ychRxZQiRESy98N8m2RpkQPnXRE/bYagkANd7glV6NGx90FBY5AtxCLZ6ZOVrLUXr
         kxLQ==
X-Gm-Message-State: APjAAAUgiQzb0CLd8sQm3qrxnD/UZhhK/VG+g5KOTfFGKAdfQJNHZj9y
        xZEUHzhkkZa4Z0zloCMgFyzaPdP2Tyl7
X-Google-Smtp-Source: APXvYqxENZKm3ZkZkcsCV1tk0VR2N3BgC4a0+IxpAnry9JlIqN/BVvLewUEqBomJYIiy3BCfhYSlTLwujoih
X-Received: by 2002:aca:5d57:: with SMTP id r84mr7966908oib.143.1556297820067;
 Fri, 26 Apr 2019 09:57:00 -0700 (PDT)
Date:   Fri, 26 Apr 2019 09:56:55 -0700
Message-Id: <20190426165655.218228-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH] misc: aspeed-p2a-ctrl: fix mixed declarations
From:   Patrick Venture <venture@google.com>
To:     venture@google.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        joel@jms.id.au, andrew@aj.id.au
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        arm@kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up mixed declarations and code in aspeed_p2a_mmap.

Tested: Verified the build had the error and that this patch resolved it
and there were no other warnings or build errors associated with
compilation of this driver.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Patrick Venture <venture@google.com>
---
 drivers/misc/aspeed-p2a-ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/aspeed-p2a-ctrl.c b/drivers/misc/aspeed-p2a-ctrl.c
index 9736821972ef..b60fbeaffcbd 100644
--- a/drivers/misc/aspeed-p2a-ctrl.c
+++ b/drivers/misc/aspeed-p2a-ctrl.c
@@ -100,6 +100,7 @@ static void aspeed_p2a_disable_bridge(struct aspeed_p2a_ctrl *p2a_ctrl)
 static int aspeed_p2a_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	unsigned long vsize;
+	pgprot_t prot;
 	struct aspeed_p2a_user *priv = file->private_data;
 	struct aspeed_p2a_ctrl *ctrl = priv->parent;
 
@@ -107,7 +108,7 @@ static int aspeed_p2a_mmap(struct file *file, struct vm_area_struct *vma)
 		return -EINVAL;
 
 	vsize = vma->vm_end - vma->vm_start;
-	pgprot_t prot = vma->vm_page_prot;
+	prot = vma->vm_page_prot;
 
 	if (vma->vm_pgoff + vsize > ctrl->mem_base + ctrl->mem_size)
 		return -EINVAL;
-- 
2.21.0.593.g511ec345e18-goog

