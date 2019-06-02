Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3519EC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F4221277EF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKnd0Kfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfFBPiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 11:38:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36761 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfFBPiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 11:38:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id v22so8768210wml.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 08:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=ZXauEYaJBCTtV//RLwd7mo3vZGyUI4EXXU82EfWx/Ro=;
        b=hKnd0KfzRBVXuzJgqVcnZ9yHWXrCyI1/7EaSBAQEw6vFdPXppZ5i+lms8trhzCiG2C
         rnLfIw1pR4hM2TRlnZ+lOCIGU7yod1A5g90EbRivTar1xEucCTukTBYuNQxYnUu0l1Xb
         JoMsPP0K085RjZXwQRU4GyeaKiLWC9h/kBerlXazJm5FSZipTTL+KDphcvUkqNhHP1Tb
         kzx0oyuMK35bgiUKpdVddihKkySzJPaaEAYHj/AW80S8nuo4VZkNxa9TPT8CqG/GQOOQ
         4heuIS3gLbBbFlRbkC6RbJki6oZDCgTzB3Rpyv62hQFgoNMiyS90lj26hke1wBQ7bvsK
         UxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=ZXauEYaJBCTtV//RLwd7mo3vZGyUI4EXXU82EfWx/Ro=;
        b=FDTOkxJGSG1umT5vBgLO60OSJ8dvDr6tZx3Bq28jA0Ox29ditNvE0t9J0D1+eWZKbI
         6zBIoqjCfwYH7YrvzoEeBU/FJbmMbZ9MDHTQSh4fn2e/lco5z4loCow4Oj05OQOfcpe0
         BpdZLNv9LYrivwBA2dzCf9R0ncOknwbGocCYozPSfcEcN+SpR0vH1OHpkrMhDmG2vxnT
         Zl8iSeR6aeyyLYyR1KPtwufxJSFBRcqaS7cZwRqAtZUSLDnzdocA3RQRJcLsasZI0rUc
         ykfW5Dk710leaev4DYUEZlZpNXbeN8QuLQPMVPgl5BFZcLh7uw6Vj31ViRDQ/mlr9NnY
         T3Uw==
X-Gm-Message-State: APjAAAUgNfOzhAyF2dO1zD8vT/KoJR3bvw+GUB8zky+p/eElVg4z7fCM
        TUw0KF39GdLvBOyn4ncTpYKN1slnYzo9rA==
X-Google-Smtp-Source: APXvYqxVIfR0mM/cw4uZky9P9kJOt6/IKIo4/+P8WPslx1N7QYKjCvoz0Bi1eh+wStUeBxe3jbR5PA==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr10957067wmc.110.1559489888111;
        Sun, 02 Jun 2019 08:38:08 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C98712670014A3D3D52C57F0B4.dip0.t-ipconnect.de. [2003:c9:8712:6700:14a3:d3d5:2c57:f0b4])
        by smtp.gmail.com with ESMTPSA id c15sm2346652wrx.23.2019.06.02.08.38.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 08:38:07 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Joe Perches <joe@perches.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 1/2] pci: shpchp: Correct usage of 'return'
Date:   Sun,  2 Jun 2019 17:38:01 +0200
Message-Id: <20190602153804.15063-1-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'return(1)' with 'return 1' because return is not a function.

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/pci/hotplug/shpchp_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
index 078003dcde5b..a7b807b31726 100644
--- a/drivers/pci/hotplug/shpchp_ctrl.c
+++ b/drivers/pci/hotplug/shpchp_ctrl.c
@@ -342,7 +342,7 @@ static int remove_board(struct slot *p_slot)
 	int rc;

 	if (shpchp_unconfigure_device(p_slot))
-		return(1);
+		return 1;

 	hp_slot = p_slot->device - ctrl->slot_device_offset;
 	p_slot = shpchp_find_slot(ctrl, hp_slot + ctrl->slot_device_offset);
--
2.19.1

