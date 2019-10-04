Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140F2C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD07C2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEuWIAjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbfJDRTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:19:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44896 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387635AbfJDRTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:19:24 -0400
Received: by mail-io1-f65.google.com with SMTP id w12so15093214iol.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 10:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jtoSVXtrhkJf1hDDCpHF8eGDYq27zVP1O774BwN2yFA=;
        b=uEuWIAjmWZC2lobpMCOJTDjl/s5815lvaflCenIocA8vV0nW425V5dnH+6mZPkd4Vz
         XUxuSFBxRAoNyjtPDEthhP3MdPmPJ+j+UF7q+diD1gOch5U0gI3ACLE2oU+Fs+XJ/23g
         0eClghImRh8A2lRcvMd+dTegBcIb4mymqkub+xittk11wLhax/0+iubbD6YGCPhlJUpe
         +A9FZUJQ0gynepj89NG85hfqV5egfEp0SQ02NeHJMqqH3bmzHuDSEVSFeeBXxkNQ/2o3
         9HNqPQwaklpxPDsSiEHhQGmCCQslyyD6KgD33YfUubmNugxfGji7IorwH3hvzJQmA0k5
         bIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jtoSVXtrhkJf1hDDCpHF8eGDYq27zVP1O774BwN2yFA=;
        b=q8NGuBjTQv6evrBfjeVw+Qwcd1WRQKUYXhf3TLrHIwDxetYRyMTd/8qrwYqAhFbc8K
         n4tEm1fY9WI54OeVCaei9kZKbqO/RXm1zTeTRvkToWhtVQE+AvP9dEwo7MdR4aK84sgC
         7jqs5GscvMhiH5siZx6gz1ijb0wchi4EleeN0LfGo8EeFUGrXsG12JlTAdE6Ke3yqah5
         vao62Hez1UxBMhf5U6ouZUnJEp0GA2WResxiTAAo6SRTSl0FSFpCvs/76FCHaFLEnHq/
         oUPTwd02lAktUK5OlSVsEkwbq2Hz+kBchZJKVHEh/N3OuSAem5BGV36O8egHxlUQnZdE
         HQQA==
X-Gm-Message-State: APjAAAV3uISPb4c+A005t3ZyQaOS2U5boi3w9X5kN0Pz/RLSqFSHbkGp
        D1X/PJI1GAWKi3+tCHAJF5g=
X-Google-Smtp-Source: APXvYqxF0fH1FHeLeb/+4F7Sw9KcP3cCcMmpy0s8scdkUAgLYnFwYQd2ajU1J1M/tSF1hZskuCrn2g==
X-Received: by 2002:a02:b782:: with SMTP id f2mr15929972jam.48.1570209562004;
        Fri, 04 Oct 2019 10:19:22 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id i67sm4018502ilf.84.2019.10.04.10.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 10:19:21 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: onenand: prevent memory leak in onenand_scan
Date:   Fri,  4 Oct 2019 12:19:05 -0500
Message-Id: <20191004171909.6378-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004175740.5dd84c38@xps13>
References: <20191004175740.5dd84c38@xps13>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In onenand_scan if scan_bbt fails the allocated buffers for oob_buf,
verify_buf, and page_buf should be released.

Fixes: 5988af231978 ("mtd: Flex-OneNAND support")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
Changes in v2:
	-- added release for this->verify_buf (thanks to Miquel Raynal
for the hint).
---
 drivers/mtd/nand/onenand/onenand_base.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index 77bd32a683e1..6329ada3f15c 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -3977,8 +3977,14 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
 	this->badblockpos = ONENAND_BADBLOCK_POS;
 
 	ret = this->scan_bbt(mtd);
-	if ((!FLEXONENAND(this)) || ret)
+	if ((!FLEXONENAND(this)) || ret) {
+		kfree(this->oob_buf);
+#ifdef CONFIG_MTD_ONENAND_VERIFY_WRITE
+		kfree(this->verify_buf);
+#endif
+		kfree(this->page_buf);
 		return ret;
+	}
 
 	/* Change Flex-OneNAND boundaries if required */
 	for (i = 0; i < MAX_DIES; i++)
-- 
2.17.1

