Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECBFC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F051021582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2SA3jxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfLRNl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:41:57 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35036 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfLRNl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:41:57 -0500
Received: by mail-pj1-f66.google.com with SMTP id s7so907085pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 05:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uV9emrToibtOtd5PwV/QEFcEzg9NL+MgjlxJNDfEwL8=;
        b=s2SA3jxImiV1cJdYXeJ5bMdJNOkWPu00GBypmHd+2bfmFA/bgWsvqXqKcn6CC7OCt4
         bQi3pH7Qd2vOqWCA8SSZGIzNruFEV3mkROQNkskNLD6DsCGnvqu9JVJuX4kBmPNnCLR1
         ZLwzdoXh4dgj2aA0gOe5KTznA6hhDSIazy2F3DmyYDgOrB3S764Q5PQQdrZ5GJb8xh0U
         9wXBXJuo7RYu0luX2hLHqPsjgCXCrPu09hnykK6jQJIK+IWSOxMvvbTe2DnqJbWM2Ev0
         9HJqQh/IzkqO08i8du0rIgbYsI0VR5yDuDeVF7YtqVLsDV6mGrgtuHdX7VoEslbkRUkT
         PESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uV9emrToibtOtd5PwV/QEFcEzg9NL+MgjlxJNDfEwL8=;
        b=HvjRUZotJRVqF3RdP9kKy1tL3b21VfhXx0YbpD4sYhUwByoIeDu1CIXqIKZ/yB4LD9
         Mp9c5ab9Klm/eAHbUX3PMwuWdQ+RvWMgFQ0NxnkfwWU5PDJy7MMFnV1srV2YExMJT694
         R/TwbkTAQE31t25HLcQTN5H9bmV9Wuqo+HaAxFtoEq520brWtJAeDgfQpB8mUwSifRuw
         fckHbYwOHkh/av5ZwjzrCR4rQmsPhY848um4JUO9jrKaac1TO363xdYMkmahr5FkSxlo
         Ga9MoSl/yDnzl/1Mf/BBE+cpkkQF1aAwxkP8xZJFjtJOfTK5hPqFWkMDXoQj0fDchZ9g
         VMag==
X-Gm-Message-State: APjAAAUm1ZBl1wmCMdLS/sfvRXe9E0gOXHaeozodZt0nciIGBRW4TKz/
        La5gn7lDFnBUX8MxdmNcPNZ58TgupNA7qw==
X-Google-Smtp-Source: APXvYqylPKSnWPJojqWBvbGZ8mrsyp/IhNnFJFkXhrv8y3TDQkj5gq67R6dz66q7+bg7y4Fk/ImB3g==
X-Received: by 2002:a17:902:a516:: with SMTP id s22mr2836320plq.89.1576676517024;
        Wed, 18 Dec 2019 05:41:57 -0800 (PST)
Received: from oslab.tsinghua.edu.cn ([166.111.139.172])
        by smtp.gmail.com with ESMTPSA id j3sm3323868pfi.8.2019.12.18.05.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 05:41:56 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] mtd: maps: pcmciamtd: fix possible sleep-in-atomic-context bugs in pcmciamtd_set_vpp()
Date:   Wed, 18 Dec 2019 21:41:46 +0800
Message-Id: <20191218134146.10803-1-baijiaju1990@gmail.com>
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

To fix these bugs, pcmcia_fixup_vpp() is called without holding the
spinlock.

These bugs are found by a static analysis tool STCheck written by
myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/mtd/maps/pcmciamtd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/maps/pcmciamtd.c b/drivers/mtd/maps/pcmciamtd.c
index 70bb403f69f7..d2cd1708aa49 100644
--- a/drivers/mtd/maps/pcmciamtd.c
+++ b/drivers/mtd/maps/pcmciamtd.c
@@ -301,17 +301,23 @@ static void pcmciamtd_set_vpp(struct map_info *map, int on)
 	struct pcmciamtd_dev *dev = (struct pcmciamtd_dev *)map->map_priv_1;
 	struct pcmcia_device *link = dev->p_dev;
 	unsigned long flags;
+	int fixup_flag = 0;
 
 	pr_debug("dev = %p on = %d vpp = %d\n\n", dev, on, dev->vpp);
 	spin_lock_irqsave(&pcmcia_vpp_lock, flags);
 	if (on) {
 		if (++pcmcia_vpp_refcnt == 1)   /* first nested 'on' */
-			pcmcia_fixup_vpp(link, dev->vpp);
+			fixup_flag = 1;
 	} else {
 		if (--pcmcia_vpp_refcnt == 0)   /* last nested 'off' */
-			pcmcia_fixup_vpp(link, 0);
+			fixup_flag = 2;
 	}
 	spin_unlock_irqrestore(&pcmcia_vpp_lock, flags);
+
+	if (fixup_flag == 1)
+		pcmcia_fixup_vpp(link, dev->vpp);
+	else if (fixup_flag == 2)
+		pcmcia_fixup_vpp(link, 0);
 }
 
 
-- 
2.17.1

