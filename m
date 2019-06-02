Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64872C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 12:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202D4278F7
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 12:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNugs5Vl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfFBMHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 08:07:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44401 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfFBMHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 08:07:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so120094pfe.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 05:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qX3ghjlw/x61cEZZaOOANDltXvTi7Um5dbpJ/suOwPo=;
        b=bNugs5VlHZPS4tZ2VPhAX09sWOYYGdVuKnoOLgjmuOdLsm6J2zmLxYDwlanH7ezVMX
         d2ATyFvXAdfIBBL6pukfNrxawsTimGZkOnAmr5ngT8EYiWM5dxN7k8zNSXF0Dy36kR7L
         wix5aoCXP8t/SU7WdSrKg+rh3m1faTCtS8lKiNImTIVDdYjx2H2H+zanoOTMeYX2PqTg
         anwfOhV9UyQXvaQgrAb/Tn2OvnA+h3n4TVnIeiA+KpLEp6YRiSS0Eu5EU5RAmZwG9/Zx
         DFR2lpvve+CAN+uS+nylIbCd027VJipl/LxoU9XaYMscmqttlwS/bqWpj6xTykrljg/g
         eVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qX3ghjlw/x61cEZZaOOANDltXvTi7Um5dbpJ/suOwPo=;
        b=mC5XlBrZkVfLUxoGtKJMTlD1WuGlIgdRNVmU5u1w0hSh7b+7RTYl23myz4FLLSNQ9h
         59eKfL7PA1jyt9m9tcgdNPwfz4dboE6rFKAx4dWu/PH3ha8zhOWJr1t0cSntZKv0aTPm
         YxAitmpyGvOf572ds1zW1I5idgsKRu4SvBKiktAvB/UyErsB809fgDsq4c9zToDvJW42
         GZZu11+wBUcTHgoo+vkQhNp7JZTthUi4YNez5cNu/4OzgScmsID2Elqopxfv+TNK8I63
         3SxjWON7MuMiGY8F4KtDcC+tnyA5LiQfmGZQ+ic2EcD+qMA8tWilbTAZ1LAXjajcax61
         KG3g==
X-Gm-Message-State: APjAAAXmzjMjr/gxUSaiaPjAZo+mVR5ZUB11kAPCvZJJBK35q+YUk3PH
        al7RaplZVsw/ryhQBl6FBN6vre+aXGQ=
X-Google-Smtp-Source: APXvYqzm2wJW1+YOTI30uFW4t5o4z2n5SL6LKrDTNG9aLkdwk+rTGDGuQD+/ySgk9af0E2r2tIFxaQ==
X-Received: by 2002:a65:5684:: with SMTP id v4mr21788486pgs.160.1559477262974;
        Sun, 02 Jun 2019 05:07:42 -0700 (PDT)
Received: from localhost.localdomain (119-18-21-111.771215.syd.nbn.aussiebb.net. [119.18.21.111])
        by smtp.gmail.com with ESMTPSA id x28sm13668510pfo.78.2019.06.02.05.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 05:07:42 -0700 (PDT)
From:   Rhys Kidd <rhyskidd@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Rhys Kidd <rhyskidd@gmail.com>
Subject: [PATCH] drm/nouveau/bios: downgrade absence of tmds table to info from an error
Date:   Sun,  2 Jun 2019 22:07:27 +1000
Message-Id: <20190602120727.4001-1-rhyskidd@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Absence of a TMDS Info Table is common on Optimus setups where the NVIDIA
gpu is not connected directly to any outputs.

Reporting an error in this scenario is too harsh. Accordingly, change the
error message to an info message.

By default the error message also causes a boot flicker for these sytems.

Signed-off-by: Rhys Kidd <rhyskidd@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_bios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.c b/drivers/gpu/drm/nouveau/nouveau_bios.c
index 66bf2aff4a3e..bdfadc63204a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bios.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bios.c
@@ -935,7 +935,7 @@ static int parse_bit_tmds_tbl_entry(struct drm_device *dev, struct nvbios *bios,
 
 	tmdstableptr = ROM16(bios->data[bitentry->offset]);
 	if (!tmdstableptr) {
-		NV_ERROR(drm, "Pointer to TMDS table invalid\n");
+		NV_INFO(drm, "Pointer to TMDS table not found\n");
 		return -EINVAL;
 	}
 
-- 
2.20.1

