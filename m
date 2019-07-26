Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C511DC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918FA22ADA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nONwtblm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfGZNcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:32:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46336 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfGZNcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:32:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so51595891ljg.13;
        Fri, 26 Jul 2019 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ndf+C19KCI/wn1UnH3ACuvGKYzFyQFlM48xOYxZPmMQ=;
        b=nONwtblmmefOBB7rTSOrzsqGehJMAqZlbGJK1D55WzblZXsNR2voAR+/DGJvnaKGU3
         FkeTTsCMgNe/rUL1/MucPE8eY+hKj4RA0kfkNtC9vvFyJ7Ogi62el3L8wT6i7F4cpw6b
         WmDy8BtnniHWQuHimyJUQgy2Z7g47XilDLUkfBeRxP8OBh16Q1mvDIdn4J/LYSLzBwz5
         d8BIbjojReTvhOOC7gwXY2SkXECh3A9BoghE4u7rPbANfZHw1QPH6ffDzpz0tIhgN9hP
         8iLoOMkmfnfWQAf6lSzuqL3YZY1ec66EGBMFnH2XZXbhSjIgXJleTdHLMGgb3GUjBLcj
         7wPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ndf+C19KCI/wn1UnH3ACuvGKYzFyQFlM48xOYxZPmMQ=;
        b=HkMVnPc7QJegVojw48L96HMdMzNUuzCJGBPB4iTKEJ13QUcCFzphUfg2R47VOzaBZQ
         UCWS9BHpePXCeqYJaTu79RWwPaTJMXuUxza0t1pP5VX/nV2tgwBnV2B3/RC8mW/QyLC7
         4FfOi7xWoXuj32Szf1TwgF2fWmQkEWKvhCBd4DfEDBaLViH5XbJezuVMV68TooHlSRbH
         2MUhl1YTX2tchgBYHVvX+FDHiPTXPPWXdIM74Jc9WcSAciZNXCmxVZ/rkGrQBA/33Qpm
         XxJlr84Algdpbi17Pr/I4TLkP+sqPuqbrodyPa8ROb9QCWn/Lz1kgaxh1j2iCYctI5J1
         1kQA==
X-Gm-Message-State: APjAAAWoqCb1f1ANIHI+XjD6Bp5gO3pkS+E/qp++Q8/aZf76ssKRfkSu
        jCq+A0qrJajKUr8B419cfcs=
X-Google-Smtp-Source: APXvYqzK3S4WmRa2VX9hXCiWLt+XR4QQdZ80aCnuiaJ/VPG3WuwqJ4J8yabqEF47Jy/X8QtTFsQCdQ==
X-Received: by 2002:a2e:870f:: with SMTP id m15mr49788710lji.223.1564147942130;
        Fri, 26 Jul 2019 06:32:22 -0700 (PDT)
Received: from ul001888.eu.tieto.com ([91.198.246.10])
        by smtp.gmail.com with ESMTPSA id u13sm8369578lfi.4.2019.07.26.06.32.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 06:32:20 -0700 (PDT)
From:   Vasyl Gomonovych <gomonovych@gmail.com>
To:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com
Cc:     Vasyl Gomonovych <gomonovych@gmail.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] AppArmor: Remove semicolon
Date:   Fri, 26 Jul 2019 15:32:10 +0200
Message-Id: <20190726133210.9084-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded semicolon

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 security/apparmor/path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/path.c b/security/apparmor/path.c
index c6da542de27b..b02dfdbff7cd 100644
--- a/security/apparmor/path.c
+++ b/security/apparmor/path.c
@@ -142,7 +142,7 @@ static int d_namespace_path(const struct path *path, char *buf, char **name,
 			error = PTR_ERR(res);
 			*name = buf;
 			goto out;
-		};
+		}
 	} else if (!our_mnt(path->mnt))
 		connected = 0;
 
-- 
2.17.1

