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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AF8C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 14:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6D9277FF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 14:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMdB6L2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfFBOaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 10:30:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39488 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfFBOaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 10:30:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so9579773wrt.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 07:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=lST+j8LPF+mnG5nlGg6apJU8aLFby39eS3di2S2h/Hs=;
        b=LMdB6L2LC0UxLaCjwzR6knFhfBM1WAKhURQ0V6OMK4SGxYRfKJ77tQtxVa9rQSijhC
         F6WAibIJ/jCLAIgt2LOwI5aTsRaemCcyvhm2O0D9JWXDveiVB5E8zgvDqiZfeFRvKuKl
         nqufdOFn9DSESJJY+p1puW1Qs/GSRr/fhg5JnhS+eZRzDH7HPsHFr+/xeJBu4QG5a1Pm
         NG/YjvihR4Dqft5af73Er2PQIinP+tDxGw5Pf5AqQ1nO2hh4v+8bnwyNgKLv5lMK03mU
         IEfWibece566awAuflh5CGNkW36jR8OnwnmoZfBJrymfCi0cJKZFQRwZf/36jxcQgrs4
         ERww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=lST+j8LPF+mnG5nlGg6apJU8aLFby39eS3di2S2h/Hs=;
        b=Fb/qQX6XpthKGkgzazZ5/IZ79GBmJvkTMSuyJeudOLlcEaWV5ydTcbgGsys9AdAWZm
         t3JZzus/pZQ05ScSWRAu2pHra71ofI6K7C4fWc+fAa3sHdA3R41YOWKKd9+QGTUMKisa
         aZSJZ2IaSHuFDAZHAoOTFkln+y8QnVLb6R/M9VGNfBH2mr1i1vB5fsvp7nxn/0Bt7RN2
         HXAyYFNoW3wc2OO61TdUjBDIroUc9AbnoFcD/jzkeHGUstY4OKHyuGvVY3o9UHnuqu+x
         P/rBPjmVJzNNyfbMAUlzLqCQvC2RwXCnLMm2yUNGG0Xzk5zNzLuSIBw1FQbopijiycmQ
         ed3A==
X-Gm-Message-State: APjAAAV6lHEodUy9vziJnEF/OTwXn4658hL7HSJRDKCm5HVtemd+YEwj
        iCSNhQZmWydWsEJmsyUkk8DeF+i6SJo=
X-Google-Smtp-Source: APXvYqzRYCC/Vk/hMAT52YMLdNU9AXHeaBFaZdczBOZc20Qk/G1dWy0Vpl/7ZQHQpeEqBCNzCEkNMw==
X-Received: by 2002:adf:f804:: with SMTP id s4mr12949116wrp.136.1559485819413;
        Sun, 02 Jun 2019 07:30:19 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C98712670014A3D3D52C57F0B4.dip0.t-ipconnect.de. [2003:c9:8712:6700:14a3:d3d5:2c57:f0b4])
        by smtp.gmail.com with ESMTPSA id y9sm1084508wma.1.2019.06.02.07.30.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 07:30:18 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>
Subject: [PATCH] pci: ibmphp: add check of return value from pci_hp_register()
Date:   Sun,  2 Jun 2019 16:30:12 +0200
Message-Id: <20190602143017.19645-1-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the return value of pci_hp_register() in Function
ebda_rsrc_controller()

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/pci/hotplug/ibmphp_ebda.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
index 11a2661dc062..7e523ce071b3 100644
--- a/drivers/pci/hotplug/ibmphp_ebda.c
+++ b/drivers/pci/hotplug/ibmphp_ebda.c
@@ -896,10 +896,17 @@ static int __init ebda_rsrc_controller(void)
 
 	}			/* each hpc  */
 
+	int result = 0;
 	list_for_each_entry(tmp_slot, &ibmphp_slot_head, ibm_slot_list) {
 		snprintf(name, SLOT_NAME_SIZE, "%s", create_file_name(tmp_slot));
-		pci_hp_register(&tmp_slot->hotplug_slot,
-			pci_find_bus(0, tmp_slot->bus), tmp_slot->device, name);
+		result = pci_hp_register(&tmp_slot->hotplug_slot,
+					 pci_find_bus(0, tmp_slot->bus),
+					 tmp_slot->device, name);
+
+		if (result) {
+			err("pci_hp_register failed with error %d\n", result);
+			goto error;
+		}
 	}
 
 	print_ebda_hpc();
-- 
2.19.1

