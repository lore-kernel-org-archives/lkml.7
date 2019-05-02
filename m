Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E733CC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4FD2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP7/MpcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbfEBKEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:04:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38577 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfEBKEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:04:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id a59so790223pla.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 03:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b21nQs4hwdc7XpbVZxSzer3RlFLMwf7lrAQyyiOML0s=;
        b=AP7/MpcZ/LaYdNIMRQGWob+QB0uOoyFXCZOc2ppFmMUjMw7JuLWO23BZ4xCu/p2SyO
         CjMePr0F5iDM4Sc7RB7+ZefJf9RA5wa45ISOUP8fuOJgX+w44wS1iHzjRa8ykbdsgsTS
         E5LiN26HJdCJhLtuuDm6H0XxyvOJuydjLE62F9tH9hQXhq26tVg6cHZF+V1qFeyymJGG
         2WpIiiSTJAUWeD61HdAP4oXW854KCaci8/SQv9tLIyp2BXFVrectKFcIpg9BQ8peZFH4
         nq8Q0HM1bSlKfX6y7kzA4tqPcGqFF9lgmKyrsjFgU8ky4OBDCFuPMrFEwYcploV0lOCX
         mMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b21nQs4hwdc7XpbVZxSzer3RlFLMwf7lrAQyyiOML0s=;
        b=fd8PBl9exxkUn2Vlj/h+JKFiD3p0mpfWXBxYlIs1tC9xqZLpjt3zllp7V2kpyi/Wgy
         gC5Zkfnb9WlZZSIAFcmNVNUDXZe9Wn3fJ3x1eRKRfMPoreFi9U50UIqTSzAcBOwx2X2L
         lgdf7WPQ/3Hi2Ksge90fTX12ZTAcObbIs55ZwE3DHor68NDqNzjHuFsHklpaibP82HEw
         /5i6D9yhIkShhEDkk6ke6Cum8rSiGjjWXyrs6hH/PY4kd4d0LgY+YIrFfJfJCN73RoPO
         R5KiHCp6TbQ59Dwencmy5qST9+Lzi0LprcHLv9Du5ry/EFQ8p+eEwkZPZFEeS4As4NRs
         KoUA==
X-Gm-Message-State: APjAAAWV8WK5RBJo2+/zprNiFYp7T6tMq2hV+k2owUylHNp8c/0VM3YO
        IVXhtTrQc6bJ5C6QZAJt8P0=
X-Google-Smtp-Source: APXvYqxlX61hSSz0HiSlUTgrCq6qMROgylXjxnMdE6nxG72EfvzoQN1YiGX2rxvuqTc1X/F1eCxBnw==
X-Received: by 2002:a17:902:8f82:: with SMTP id z2mr2887113plo.51.1556791476499;
        Thu, 02 May 2019 03:04:36 -0700 (PDT)
Received: from localhost.localdomain (mx2.daiict.ac.in. [14.139.122.121])
        by smtp.googlemail.com with ESMTPSA id r138sm52386405pfr.2.2019.05.02.03.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 03:04:35 -0700 (PDT)
From:   Himadri Pandya <himadri18.07@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        julia.lawall@lip6.fr, mikelley@microsoft.com,
        Himadri Pandya <himadri18.07@gmail.com>
Subject: [PATCH] staging: wlan-ng: Fix improper SPDX comment style
Date:   Thu,  2 May 2019 15:34:12 +0530
Message-Id: <20190502100412.25582-1-himadri18.07@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPDX license identifier should have the form
// SPDX-License-Identifier: <SPDX License Expression>
for a .c source file. File hfa384x_usb.c has instead the form
/* SPDX-License-Identifier: <SPDX License Expression> */
which is the form for C header files. Hence this patch corrects it.
Issue identified by checkpatch.

Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
---
 drivers/staging/wlan-ng/hfa384x_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
index 81a6b0324641..6fde75d4f064 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR MPL-1.1) */
+// SPDX-License-Identifier: (GPL-2.0 OR MPL-1.1)
 /* src/prism2/driver/hfa384x_usb.c
  *
  * Functions that talk to the USB variant of the Intersil hfa384x MAC
-- 
2.17.1

