Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E1DCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3A521E6F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaSodyjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfKDPBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:01:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52933 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfKDPBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:01:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id c17so9664259wmk.2;
        Mon, 04 Nov 2019 07:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BT9YBqZKiz2HvVHCMcbm7iccT4OKFPOob8w/3y/w+v0=;
        b=FaSodyjqCmumV/TI2UFoHmOMF5dU8qpXnDR/6g8ZCMlTjZxbIOUmDoeb1AnVwHanzy
         rl7SRzfoYF3NBlcUcKzef1i8DuJfgIPjKfisMn7spZcGTjOT/pMsHSuf5EjtALtPTPBc
         pqM/DvR9Fmi5yx0vX8O3R0Pik/x2sudIzNUh31s8yn59geRGi/mlbJSq+ZMEHOf4S62g
         E0WI2oRnHdGK7kCjDvn3xD9k3c4Kg8OKX0tl86VfnEXtQugQg7kaMP1CkVOVprtdimRy
         PXdspFR7bbRdkQr1FMUIKkQ6+rYBZxaSkA0BvbM0IGMAZwqMk7V5r4W5ZkJhDy/DuIrG
         qTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BT9YBqZKiz2HvVHCMcbm7iccT4OKFPOob8w/3y/w+v0=;
        b=Ygmsa0ONSMksV7Hr987DGXt1tbV6vLvPlQpeCxRylwFz0aZEJTeVnpG3oTJJVSj4+t
         85aXT3DxZKNHAtU6avdZdvrIFI5A34lCsTPAS/r99K/cUp78+cAaKm99TfjR1tj7cv2Y
         C1A5X7V0AENR/s/BYH6QESjgODUYRT6ZnaoaDM6pAn063eGL/cKYG+eTDeiWHRqmOl1U
         O9L8T+CZp2/sk3rdRjLxdOu4sNb3FJyA8q66gHApNCIa60WGptLj8FWmYuNjt1Y/4wz9
         YulshQ3CoEzy9arkWju9bQZl3XhlO4zRGNOX8daU9xJfzVTh9WWsThtjf7Pe4NI10BQ6
         2dLQ==
X-Gm-Message-State: APjAAAVoSYw1Naq9X9lDogATDk+7lSqtzgFAYIPosX2B16nzYsRAaIS1
        8Hp/0L8qpIrpYa19y+kzaQtFG8UnxXA=
X-Google-Smtp-Source: APXvYqywGRSQBr9zY0NjGjdjmaAK99TtLJdTvgBXgMEVATksrpdgAlZ/2mjRQBlZqUAt6uzAJOlOPw==
X-Received: by 2002:a7b:c84b:: with SMTP id c11mr16963467wml.158.1572879660689;
        Mon, 04 Nov 2019 07:01:00 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id o25sm21377302wro.21.2019.11.04.07.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 07:01:00 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] i2c: hix5hd2: add missed clk_disable_unprepare in remove
Date:   Mon,  4 Nov 2019 23:00:48 +0800
Message-Id: <20191104150049.6366-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to disable and unprepare clk when remove.
Add a call to clk_disable_unprepare to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/i2c/busses/i2c-hix5hd2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
index 8497c7a95dd4..224f830f77f9 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -477,6 +477,7 @@ static int hix5hd2_i2c_remove(struct platform_device *pdev)
 	i2c_del_adapter(&priv->adap);
 	pm_runtime_disable(priv->dev);
 	pm_runtime_set_suspended(priv->dev);
+	clk_disable_unprepare(priv->clk);
 
 	return 0;
 }
-- 
2.23.0

