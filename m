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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED68AC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECF321903
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQONPhns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389869AbfGWMrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:47:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43096 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729444AbfGWMrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:47:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so19101585pfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 05:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m3CjjylHJDgM8UoL8N43slI27v5A02DOYCpC+keeaAg=;
        b=jQONPhnsbtkqI89cDYc0XbTjhAMYlmACChJwcksDP4iNqLLEGtOGc7Fr3jqrf3A4E4
         8vydhwcufcKFSWeWVQHbGNRUTtSjaH/38/CNHUB4cO90CwWzRaFb2wscf53npIPO7N8A
         WYw10FlPHd0Y+ni458dxI/F0AaqkeHDzq7Sb6FVdfq6LvS+DMWVIyMi4rnyKWyA4JseN
         gqKSrKiPuVbEe40l6AMUHKl/OXQdds55rfkwnu/SmY+fuayu436lyMxv5yQzqPqH48xB
         3300c2zsFmkgMP3NNxJdbiFKKGRde2g+/mujOPOdS1WIzhkLMSK3b3GMTJSEhQ4Zgyt4
         U0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m3CjjylHJDgM8UoL8N43slI27v5A02DOYCpC+keeaAg=;
        b=Mw4XG/xstTv2nlazE4CscWnqjcaXjz/dQ5qqk2AeOFbk8ctrALTpM/XJb/mflE7ogY
         oGdBTf+4Q4eKECalV7Vr7AMmqVIz1s9tt5b5i02ttZyZoWM2ZBP/GCv4QUeNppBnkqFq
         n1h6XxuTrXpMBunM6QULfUpNSIJ0jqwyKtohL7TQvaZj43EdXu3RFSKQr5BeWkeMCJ2Y
         SXs09X+PerM8hxu6nhD/h0aguO5Rp1S6J/L1WYckJaS3Se4F+xX6PKTuyuscMAbtMNmk
         CGlmrY+wOVB/K5hM9t5JBttVXlcS/slDnEl0OJ/xZ05mfZut3L69YfFOAMUyktYrizse
         jBrw==
X-Gm-Message-State: APjAAAWGAILVhtK+JLIWEFoVvs0yqSydX7OqbwqluiBvKrsO/OLE0/l7
        peXXVYuT5jS6XZF0Hjio1Do=
X-Google-Smtp-Source: APXvYqwdkAzmhJXxPf+K5KhZ/iibjQIPyH8wy433dDDgalWcZ5KwuUtYD7Lv6DLARviwoKhMNZKbNw==
X-Received: by 2002:a17:90a:2562:: with SMTP id j89mr82421377pje.123.1563886052811;
        Tue, 23 Jul 2019 05:47:32 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id g2sm72335839pfq.88.2019.07.23.05.47.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 05:47:32 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] mtd: rawnand: r852: Use dev_get_drvdata
Date:   Tue, 23 Jul 2019 20:47:27 +0800
Message-Id: <20190723124727.24851-1-hslester96@gmail.com>
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
 drivers/mtd/nand/raw/r852.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index dae0d235bb17..77774250fb11 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -998,7 +998,7 @@ static void r852_shutdown(struct pci_dev *pci_dev)
 #ifdef CONFIG_PM_SLEEP
 static int r852_suspend(struct device *device)
 {
-	struct r852_device *dev = pci_get_drvdata(to_pci_dev(device));
+	struct r852_device *dev = dev_get_drvdata(device);
 
 	if (dev->ctlreg & R852_CTL_CARDENABLE)
 		return -EBUSY;
@@ -1019,7 +1019,7 @@ static int r852_suspend(struct device *device)
 
 static int r852_resume(struct device *device)
 {
-	struct r852_device *dev = pci_get_drvdata(to_pci_dev(device));
+	struct r852_device *dev = dev_get_drvdata(device);
 
 	r852_disable_irqs(dev);
 	r852_card_update_present(dev);
-- 
2.20.1

