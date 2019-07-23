Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F096C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541AC21655
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwOqdcTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389161AbfGWKj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:39:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35662 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfGWKj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:39:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so18955420pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 03:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Di0g6EEgkUa8jtL/xEkGliBvl02Xk0g05krGCQwF+C0=;
        b=FwOqdcTPuWHslyIqWCg0jHZvRxaESjUl1kVvzINTDBMD1Pz/t53rxJBG58X7IdmmWL
         sGPB4oaAXM8veLfN8/TaJNN+KxLHZkIOAR5uX4uMCbJ9LDlpub0BP6KTl6wxxfmqcUe/
         0LJHP+CtHakkxv+3kGR0t0gqiArmXgtJezB9n6LryYiAW8ZKDk38hbqSOMgZyZwZN2H4
         G9QmrsvgHnufM9U8QHoa7FWJCypNLOPhGtDJRp3efrzHoDH+otqKwqbdKcrmXHv+768T
         KGU9mla+HYsr2XwDu2bMhs4PCzy876fa0Ik209o4naJVpmHOklGN6E9wmwEgjEHWLpX+
         KWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Di0g6EEgkUa8jtL/xEkGliBvl02Xk0g05krGCQwF+C0=;
        b=OvXpFo3SZ28+8i8LBapA3N8jIRJsEMUoQ5vVmqextRkCeLVQx8FQdcLYBeub6Yh8Kw
         bX38Y1M8CBtRorYFzOR5MWgH+eb2TrVfkxSOZIu/47gVmWgPdViEYIlBJ0slFsPvyMIB
         9zmnIVY5y6Xo27K38+gmzafyGcYMW7aTjM4ImfA/NAlPT0zOCIyL44pLeZU2tOfPFOAl
         M6LUhJCDHyRk/mqztRc8/gVrTYtsVVFVz2Os+GL2fG7yB3/1pGz2rQyJbgWkXehotxRr
         JVid3xVb2ixM3R1REhAHe0CFenqbjeO7uddO/clTgpfAZE1Fl5HI22aSPXOl4a569gee
         o1bQ==
X-Gm-Message-State: APjAAAVNIKGsGqZbKdBOjXIOW3k5MH0HXaAjZPD+0paycrFb3LYdWp/T
        vUqlHbgUZ4Sklt+IaiuQaBU=
X-Google-Smtp-Source: APXvYqy7Kjo9yItNbo9h6YPST0TITXU2NUUbMtA2mboZtD4dEoR9nnh4uwzcJcZLdh/lBbE4uEC2vQ==
X-Received: by 2002:a63:20d:: with SMTP id 13mr64729846pgc.253.1563878397922;
        Tue, 23 Jul 2019 03:39:57 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id x9sm20574868pgp.75.2019.07.23.03.39.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 03:39:57 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/nouveau: Use dev_get_drvdata where possible
Date:   Tue, 23 Jul 2019 18:39:39 +0800
Message-Id: <20190723103938.4021-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 7c2fcaba42d6..23203dae2137 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -883,16 +883,14 @@ nouveau_pmops_resume(struct device *dev)
 static int
 nouveau_pmops_freeze(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	return nouveau_do_suspend(drm_dev, false);
 }
 
 static int
 nouveau_pmops_thaw(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	return nouveau_do_resume(drm_dev, false);
 }
 
-- 
2.20.1

