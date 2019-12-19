Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B5AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD9D21D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia8kEdT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfLSDUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 22:20:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35407 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfLSDUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 22:20:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id b19so2372431pfo.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 19:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=myMe1QwkZnF5nX58KJ75LAcGLicOPPY3P73wZ7ihcKg=;
        b=ia8kEdT3w0AGu1TZUC9FRWhFeospX94hSxPi51J1YQoavCj9UmQpWXusCabigHGUs7
         EYP6G8K6XhsexI3r7GaURDw9S6Dy3hmV3waThbzkXxN8Nnk9MDG0MzHz22cFguX3lMZD
         sQ9pMH7hRWKtOJf6+d6816XdBDpluUNwLGLDYaibxHZ8b2iCrcuRtWork+kpe+sUucLu
         HMCfkQGwd0hVOlfnuVK65CVQ7c2eOKP5FCdy/QMhURFGUVVUThfLOEN500bGYIA4IpIQ
         fLak64i81D38a6frFcDdYj3mASruGQiOYLAcXPYM6pgGoJmmKjGu/awEinsBDCQWhIOy
         AmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=myMe1QwkZnF5nX58KJ75LAcGLicOPPY3P73wZ7ihcKg=;
        b=WuVR+dBrTWGTzCS8xtNZsehWOLkoNlxPh9z7LAtV611mEWNc7OTIgykCH4a7q1p5Ro
         ryXcxq6XrdnmWQWxhxYj5YG3Ppv2+aQtolOE0YoPzn4r5yG/Y4mQXRF0eEb7gU7MTO5l
         HRWVPZcgY67Kur5uA7FeRhC7fR6J8vgOY2MVm2+UkksCJN16ssKWB6TIvSdinY/Ju655
         QWNbeKdiFdTRe2bj+5/p1EWu9FOTwDCBIKT11a9+dd1M47eyXKr6pmZt6o76g7LGieLX
         07XyZGoObgxDBGFLkui3MPIfh+LTWpNjlBoCUVwNrXX/vWI+uGIfSeTRFvnzjiGpCzFV
         i2AA==
X-Gm-Message-State: APjAAAVE+O55Q7GB9235ZM6sq4Ig633OlygECrz0fAdSLNT63sUY0C+6
        mEb3oPMRhB9XuuM9e6GrqIW0tFxFVBtKEQ==
X-Google-Smtp-Source: APXvYqxLCUfDqY2jqojMritJO5se/AtwS0zRhyNk8y17DL2VoewC8sku+NYR6qj3xiSrF9C8oUG5Cg==
X-Received: by 2002:a63:d958:: with SMTP id e24mr6579422pgj.31.1576725633389;
        Wed, 18 Dec 2019 19:20:33 -0800 (PST)
Received: from oslab.tsinghua.edu.cn ([166.111.139.172])
        by smtp.gmail.com with ESMTPSA id c3sm2350517pfi.155.2019.12.18.19.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 19:20:32 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux@dominikbrodowski.net
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] mtd: maps: pcmciamtd: fix possible sleep-in-atomic-context bugs in pcmciamtd_set_vpp()
Date:   Thu, 19 Dec 2019 11:20:23 +0800
Message-Id: <20191219032023.7177-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep while holding a spinlock.
The function call path (from bottom to top) in Linux 4.19 is:

drivers/pcmcia/pcmcia_resource.c, 312:
	mutex_lock in pcmcia_fixup_vpp
drivers/mtd/maps/pcmciamtd.c, 309:
	pcmcia_fixup_vpp in pcmciamtd_set_vpp
drivers/mtd/maps/pcmciamtd.c, 306:
	_raw_spin_lock_irqsave in pcmciamtd_set_vpp

drivers/pcmcia/pcmcia_resource.c, 312:
	mutex_lock in pcmcia_fixup_vpp
drivers/mtd/maps/pcmciamtd.c, 312:
	pcmcia_fixup_vpp in pcmciamtd_set_vpp
drivers/mtd/maps/pcmciamtd.c, 306:
	_raw_spin_lock_irqsave in pcmciamtd_set_vp

mutex_lock() may sleep at runtime.

To fix these bugs, the spinlock is replaced with a mutex.

These bugs are found by a static analysis tool STCheck written by
myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Change the spinlock to a mutex.
  Thank Dominik for good advice.

---

 drivers/mtd/maps/pcmciamtd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/maps/pcmciamtd.c b/drivers/mtd/maps/pcmciamtd.c
index 70bb403f69f7..2ac79e1cedd9 100644
--- a/drivers/mtd/maps/pcmciamtd.c
+++ b/drivers/mtd/maps/pcmciamtd.c
@@ -294,16 +294,15 @@ static void pcmcia_copy_to(struct map_info *map, unsigned long to, const void *f
 }
 
 
-static DEFINE_SPINLOCK(pcmcia_vpp_lock);
+static DEFINE_MUTEX(pcmcia_vpp_lock);
 static int pcmcia_vpp_refcnt;
 static void pcmciamtd_set_vpp(struct map_info *map, int on)
 {
 	struct pcmciamtd_dev *dev = (struct pcmciamtd_dev *)map->map_priv_1;
 	struct pcmcia_device *link = dev->p_dev;
-	unsigned long flags;
 
 	pr_debug("dev = %p on = %d vpp = %d\n\n", dev, on, dev->vpp);
-	spin_lock_irqsave(&pcmcia_vpp_lock, flags);
+	mutex_lock(&pcmcia_vpp_lock);
 	if (on) {
 		if (++pcmcia_vpp_refcnt == 1)   /* first nested 'on' */
 			pcmcia_fixup_vpp(link, dev->vpp);
@@ -311,7 +310,7 @@ static void pcmciamtd_set_vpp(struct map_info *map, int on)
 		if (--pcmcia_vpp_refcnt == 0)   /* last nested 'off' */
 			pcmcia_fixup_vpp(link, 0);
 	}
-	spin_unlock_irqrestore(&pcmcia_vpp_lock, flags);
+	mutex_unlock(&pcmcia_vpp_lock);
 }
 
 
-- 
2.17.1

