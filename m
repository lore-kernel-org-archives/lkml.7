Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1804BC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1186208C0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6iZibdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfFEQz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:55:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38250 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbfFEQz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:55:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id t5so3042986wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 09:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IK0GyUMMzaY1SH7H2AwbEA3bGJpZXL0LLtPICxDDdqk=;
        b=L6iZibdO2eyrgAPTmVEL2E1FnUtXzVrlVNqsTgxxovGuPlEImBtwC1AXfW7dbeZTJx
         G0Ml8LJCH1/zTCm8bYPTgyCfG480y8smdEhxRNV4hJY/CRDa3HcLvhMtfnOz2Lt28sMu
         jHY3vMNFSSldjAPgLpEQCnLvCJ7QlLJkqlXjbP9kFvVrODYcLZ4keMnin8Iwl40leUWk
         wIPk2BeSl5GeqceyQ94LsV6reLSF9VjM89jEPWSX17+2ktnIfTWHtlvnogOtLbbTwU+8
         fyP7SVC0RdhaqfGR3E5svoN052lGayDWhPAG+ppBqLLrfDPKymCBRDKeaU/CzPEbhSb3
         crfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IK0GyUMMzaY1SH7H2AwbEA3bGJpZXL0LLtPICxDDdqk=;
        b=L7+q6xPtwYWWMnQXvjYiofMXZTnDduxxU7//SYCIBpW3RDujDxuYPKhoRAj+nsY7aa
         AIPOMDs8xQvJB4gAIpi6Tf42y61WxKVMYdpLROyTbcBCpdIBSii+83RwvkL04nFWelPx
         w8UHMuMW46YjfQMlQZR9C1jya3GKAMkzOL4vffYglK1pBJ3lAI1Yj6ODgf4aMGbOICIL
         oEPECvIemixDj4Ld6iWrRv3LWqmz0YwD6Wyum0Xg4HGZ9kmZJn44DL7pq4wfaAPyIp13
         u2gSPmHu32TTHmmBHmPNS3IxDl7B0KTbPG3c4I9BXag65cdMuN0TzAuX84125DyreU4O
         aW/w==
X-Gm-Message-State: APjAAAUZIsW4xLwHjtd/Y5u0IlMR0uyHBdfeYDv8c9P0/X0sYRCFr5Ap
        f1XtjjUTJMLbLc0RtTC+IKTfcI8B
X-Google-Smtp-Source: APXvYqw8KASEExDoI4ZSJf9u0NtHcudJahZlzODCmfoghfC4hvcT/v7HxRytPDYiOBPIYAnOAqko5Q==
X-Received: by 2002:a1c:9c4d:: with SMTP id f74mr11057587wme.156.1559753725305;
        Wed, 05 Jun 2019 09:55:25 -0700 (PDT)
Received: from localhost.localdomain (host228-128-static.243-194-b.business.telecomitalia.it. [194.243.128.228])
        by smtp.googlemail.com with ESMTPSA id b69sm17060610wme.44.2019.06.05.09.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 09:55:24 -0700 (PDT)
From:   Valerio Genovese <valerio.click@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: staging: kpc2000: kpc_dma: fix symbol 'kpc_dma_add_device' was not declared.
Date:   Wed,  5 Jun 2019 18:55:16 +0200
Message-Id: <20190605165516.22183-1-valerio.click@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was reported by sparse:
drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c:39:7: warning: symbol 'kpc_dma_add_device
' was not declared. Should it be static?

Signed-off-by: Valerio Genovese <valerio.click@gmail.com>
---
 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
index cda057569163..bc208bb6777f 100644
--- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
+++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
@@ -36,7 +36,7 @@ struct kpc_dma_device *kpc_dma_lookup_device(int minor)
 	return c;
 }
 
-void  kpc_dma_add_device(struct kpc_dma_device *ldev)
+static void  kpc_dma_add_device(struct kpc_dma_device *ldev)
 {
 	mutex_lock(&kpc_dma_mtx);
 	list_add(&ldev->list, &kpc_dma_list);
-- 
2.17.1

