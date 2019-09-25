Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57715C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BCF21D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlUx8bj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391613AbfIYPnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:43:12 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37335 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbfIYPnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:43:12 -0400
Received: by mail-io1-f67.google.com with SMTP id b19so15066263iob.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1Q00ynemAKKJ/MaIBjRv27jDNOvaD0z4mVtJwg+Ggx4=;
        b=TlUx8bj8sNScMxlvR9cpJQiju169VCIBczghi/BIQ+/kbKio6pxKQEcXSjPJN/pHGm
         eeddNXnlbkXN83gF2jt35B3NCYLGkGbx3sbeJ30Xq5jQAQPG7+qKLfkiJ2YyfyQvbLXU
         PUAxdurKheZOADHpQBtais8IP0w0ZUxeZwVdlfX+QCit4HmKmYo9IHjA54GWN/LnqCpL
         o8LlJbQz0G1KbK0HwS5qrBWnwO7KdU26nIg/O9EJmC3D6u4zKWENPnhN5cZHh1FknKBf
         N3AKPTPdLC8bbPZL/bIg1OTzTltClqhwd+LMgwkr8BFeM4jP7jR5cSBxsBLK39Gb5a/h
         F3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1Q00ynemAKKJ/MaIBjRv27jDNOvaD0z4mVtJwg+Ggx4=;
        b=HrHZ1YHx1ttvSpH1rMF53H+O00Jhu65quyFmm7HhUwIe6BbF049x/mIMCjmxN4Gvg7
         1nzlU339tClCHgus0COdLj+Dn8qliGah7xGvj4Q8burlpBBWnRp8k7ESNe4VACeSNrGi
         SkX1yY0tWv4dE7zDMguLNx7PhxiE7K+Q5aKa01kXHkhdSjTFyILW/kiRaJXOXlDzGeEs
         JJVfVJzO7uteRnTSzVPnbOWAcWbR2ceAe69PyOnhtKZhXVZLyKwnDUY58JJbEn8nfPyY
         rCHiSt200PA+s1q0v/beth+QeMcgc8ayk31jcP6P00rBI5WC803nhji2GM+zkkVPMOO7
         FJ8Q==
X-Gm-Message-State: APjAAAWNw60d2MUs9I4MLYqBAg6W1fv5Q3hPMdNnSiMuhMdntLTyAbRd
        Kc/9dFy9PdCfwTdlZaYzSoM=
X-Google-Smtp-Source: APXvYqxij5TFaLPw6sfDkSzhH8BD1KDP4TWRvF10GL4evq0Ql2LxLU+1IBy3atgOf6g7IKRAQmYZ5g==
X-Received: by 2002:a02:65cd:: with SMTP id u196mr5831930jab.3.1569426191113;
        Wed, 25 Sep 2019 08:43:11 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id c11sm4692723ioi.67.2019.09.25.08.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 08:43:10 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: onenand: prevent memory leak in onenand_scan
Date:   Wed, 25 Sep 2019 10:43:01 -0500
Message-Id: <20190925154302.17708-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In onenand_scan if scan_bbt fails the allocated buffers should be
released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/mtd/nand/onenand/onenand_base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index 77bd32a683e1..79c01f42925a 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -3977,8 +3977,11 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
 	this->badblockpos = ONENAND_BADBLOCK_POS;
 
 	ret = this->scan_bbt(mtd);
-	if ((!FLEXONENAND(this)) || ret)
+	if ((!FLEXONENAND(this)) || ret) {
+		kfree(this->page_buf);
+		kfree(this->oob_buf);
 		return ret;
+	}
 
 	/* Change Flex-OneNAND boundaries if required */
 	for (i = 0; i < MAX_DIES; i++)
-- 
2.17.1

