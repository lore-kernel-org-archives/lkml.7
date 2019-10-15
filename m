Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5175ECE59D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886552083B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0mEzJ+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388497AbfJOU7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:59:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33950 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387762AbfJOU7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:59:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id y135so3166835wmc.1;
        Tue, 15 Oct 2019 13:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ogtau3Uh0A4ADmjc9/qgEzfRMjPeR7tQvaVRI8Bj8aM=;
        b=q0mEzJ+xvj7olp4fPt3m+zHUwJMGxg/yurUQobCwB1fAMuyL4TEC8sOeswPQG6WCx8
         judxGSBphzglY4itOq0X4MUtb+oSRTj993jh6Dcn53VeVZooGDolngXdz+eZbzi5w2F2
         Yys4GXk4SVwk3PLNHURny2IbE6Hp8UvjPAYPLfERyNs5dT4lYg5sAS/UxqRFHL7Jq8pq
         xvVw6gKmbziszw2y0ocg2J4laEQeIr82cgQAHxr6eZZ+gkl4yzseePteZ5Lr8WU0qkeT
         eYxb7ENCg7NO4Y02QH1r6JCuqCujvviqrwAbkQYRbzv81mCGnsFXgi54SXo812x/D9BX
         5C7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ogtau3Uh0A4ADmjc9/qgEzfRMjPeR7tQvaVRI8Bj8aM=;
        b=Iy/Ifq80vXrb3UxW8Ae5po0VyLkl3HwIZ0wNMEp0TKyZMp4x4kwJONOmCL51MVx74a
         1LD0rz8TEb5q6iZYu2zc3VwNkY77D9i9s68phlzByYWNSP6PAszfYjHyGh4FCVWynkQg
         LFSOqnf8L2FaBI3nk+d+COPU7/+zbkOtkHzcHZZiqLC+kugZxQNFhYFf6KnncUmY49LW
         CO6hPsE6nJ/qPuTQmf/bmrkQCM/g4+teLc0VZqam0mwA7owSalKXkyyBzDMFlnL5u+x9
         bVmCRY8Ctxj1v0PO0XZc++TC2ZdSLnLy8nGQjZMUWieZcojjqATk2DKYfp4n/RATdYhW
         NCxw==
X-Gm-Message-State: APjAAAVLgbaPMqoRfkqPDwIlPIUGyFlGNio16JBP0Wn/ltjMvz99gNk0
        BsnxuC1X1RjFvVnAl/1D53g=
X-Google-Smtp-Source: APXvYqzlLqMWB6ZoWhuayr8R9lneMMXByJF4r2POBJBFL/aXpfLfbf+owDml9VFIq2cXb25zvzih6A==
X-Received: by 2002:a05:600c:21d2:: with SMTP id x18mr397536wmj.146.1571173141891;
        Tue, 15 Oct 2019 13:59:01 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j18sm19216963wrs.85.2019.10.15.13.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 13:59:01 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] include: dt-bindings: rockchip: mark RK_FUNC defines as deprecated
Date:   Tue, 15 Oct 2019 22:58:52 +0200
Message-Id: <20191015205852.4200-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191015205852.4200-1-jbx6244@gmail.com>
References: <20191015191000.2890-1-jbx6244@gmail.com>
 <20191015205852.4200-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defines RK_FUNC_1, RK_FUNC_2, RK_FUNC_3 and RK_FUNC_4
are no longer used. Mark them as "deprecated"
to prevent that someone start using them again.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 include/dt-bindings/pinctrl/rockchip.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/dt-bindings/pinctrl/rockchip.h b/include/dt-bindings/pinctrl/rockchip.h
index dc5c1c73d..6d6bac1c2 100644
--- a/include/dt-bindings/pinctrl/rockchip.h
+++ b/include/dt-bindings/pinctrl/rockchip.h
@@ -50,9 +50,9 @@
 #define RK_PD7		31
 
 #define RK_FUNC_GPIO	0
-#define RK_FUNC_1	1
-#define RK_FUNC_2	2
-#define RK_FUNC_3	3
-#define RK_FUNC_4	4
+#define RK_FUNC_1	1 /* deprecated */
+#define RK_FUNC_2	2 /* deprecated */
+#define RK_FUNC_3	3 /* deprecated */
+#define RK_FUNC_4	4 /* deprecated */
 
 #endif
-- 
2.11.0

