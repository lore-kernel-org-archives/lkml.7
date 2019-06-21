Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC60C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404D920665
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz6R5+e8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfFUQpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:45:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45729 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUQpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:45:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id z19so688206pgl.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6grt7dPTqDbEVmXKN5u88sLrQRXBDwvxKFqm7PTXnXE=;
        b=Bz6R5+e8ki5nOnHq6gQ25tqZI+/LG7ye4y5UOh7ShxcbAcqcB+IoqDQfqUYKw1ecm3
         Dx+6nQRtvhRCqR+iCrB/P2MQSPBOvwfRrR8/JF7kceIDWBLrYdbt2ZpRNXIXrrlDcyx1
         vM2a+pIWBhuYpUekQMCkO6XCX+Qb0zOj10pD1MxzPgzP35miFM6VsXun5gReifYNSABN
         KpiHq1q6X87bsnybzC0sfKoFTf+Az2qv3jooGW53ip60V5ufFdxNWAGXHpnVFLZBIe6b
         SSVwFQbN9GHmaSyYmS/oQej3TosPd2dZ1s9eKHH352/NPXtau0Gp78qDCxX0RuDM0wD5
         q5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6grt7dPTqDbEVmXKN5u88sLrQRXBDwvxKFqm7PTXnXE=;
        b=JS3WHXn412yAjIqDfn3GncALKqD06bEpsU926uo/tipOvgU3E7YRFix7khnilW1LW/
         dqPpb7nrzxjrLPTumG4s75kB6M/JBpj15/RngW5FFF3V21s/n2pK/O7kajwAA/qKP5+I
         BInYQWMA1Uw6XVjd7AqwWq2ah30M+X6cHFAKjDOFppfPzzg8ACl77Yo3rg46QICw548/
         619ue7/SadWPcX/C/aItXw44ZJrbqVogpa7E3Khyu0nDrMzia+o5OHX/Ou+ub5P0a3QD
         MH33ag7uJj1rNN/A0URQfbnRKze400LaGUxhMU5sQaLGjfZx5b6KHc+JhyNgc0MUYRjo
         /BiQ==
X-Gm-Message-State: APjAAAXPao/gT6UspHtYsCfAcOLjbCuNuYfpTDwGkAdFdtZtDwChzrHH
        XT+4yxJmI4Vei61Jc3UPqNc=
X-Google-Smtp-Source: APXvYqzbQQ06Q+VkjbL0j62tbBy6iEA/Ket6kvE7FKAdbKQ+XXS3UFz53fT7QKn187xEMgLUhrwWGg==
X-Received: by 2002:a17:90a:ac14:: with SMTP id o20mr7966696pjq.114.1561135515066;
        Fri, 21 Jun 2019 09:45:15 -0700 (PDT)
Received: from localhost.localdomain ([157.45.2.115])
        by smtp.gmail.com with ESMTPSA id z13sm2974783pfa.123.2019.06.21.09.45.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 09:45:14 -0700 (PDT)
From:   Harshavardhan Unnibhavi <hvubfoss@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     Harshavardhan Unnibhavi <hvubfoss@gmail.com>, mchehab@kernel.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: soc_mt9v022: replace symbolic permission with octal permission
Date:   Fri, 21 Jun 2019 22:14:53 +0530
Message-Id: <20190621164453.5075-1-hvubfoss@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved following checkpatch issue:
WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider
using octal permissions '0444'.

Signed-off-by: Harshavardhan Unnibhavi <hvubfoss@gmail.com>
---
 drivers/staging/media/soc_camera/soc_mt9v022.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/soc_camera/soc_mt9v022.c b/drivers/staging/media/soc_camera/soc_mt9v022.c
index e7e0d3d29499..f73f5460663c 100644
--- a/drivers/staging/media/soc_camera/soc_mt9v022.c
+++ b/drivers/staging/media/soc_camera/soc_mt9v022.c
@@ -25,7 +25,7 @@
  */
 
 static char *sensor_type;
-module_param(sensor_type, charp, S_IRUGO);
+module_param(sensor_type, charp, 0444);
 MODULE_PARM_DESC(sensor_type, "Sensor type: \"colour\" or \"monochrome\"");
 
 /* mt9v022 selected register addresses */
-- 
2.17.1

