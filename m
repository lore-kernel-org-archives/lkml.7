Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04773C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07F82084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGxyIads"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDCR4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:56:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36764 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCR4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:56:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so7502683pfn.3;
        Wed, 03 Apr 2019 10:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pJq7AT0WkNCUqmu8i8FA6gz6eLWpTDQYNZ++cpLRooQ=;
        b=VGxyIadstbN8FEH1sVb8RLCqg8xO3ElX7KgnuUEH9wf9YAI8cg2ipb1Up8NtX7jowv
         nHdJJY17KmWHGpWl09IDsqHv+ayt5C+FjslsVFbUsg/CFfB39H4yvJsvaH7ri0HNlZhE
         XmijD2/4zBYpkhmxs3E7TxsfO31nLvYPDsDT5cCIjV2urLptK4WZXiEx/GuPNNMILBX0
         bUe1P0diEKZvpxBZwNEcH39coVC52sdNTkEZ2F7Uj+SnteVd0Ojqis3nRB7MuzTYv/oD
         /O0yN1g8gHSVviFunp5pG6k6VOuxg+C9hZ2PNKnKhpeVi06pdMtDxiVnW1DrmY9i6ywD
         QbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pJq7AT0WkNCUqmu8i8FA6gz6eLWpTDQYNZ++cpLRooQ=;
        b=Ldxo82+EgDjX0oqyPbxLJl1/c7c2GkrI3IOdRcou4r4tTc9Kqe7rDnDp+4e4XeqogG
         fVk5kSidvd5VAdJq8iVPd/KFQ3AsuPddxMKd9v9VaVu+oSyXWNZt/+nxFY16zmRr3uJT
         FCWu/tpmXQo1He2BwphwvvINTYiMe8081Sim7lRq1czTtqv9aDNGnHeXCOgHCbiGijVr
         yqeR1js4QpLzYBq9qb4TgVLQ0HbFSvu8rDBUzDy4/YeFvOcebNPQl8J+Wk6yfBmS72oG
         lpWyx/bog6yMoWsHEBSXj5R5CV2OEGnJk1/vtm3y6huI3UUjw4/DJ9BaJqaYeqv2xhfp
         JUmA==
X-Gm-Message-State: APjAAAVd29mepMUu9b8hAZzJ7mZubgbcQnv0UsKcpt81EnGAPDo/2epm
        nh3ZG1u0mlP7NjzmEns+SrAFIUfH
X-Google-Smtp-Source: APXvYqwIbjHymjMnGhxzYoSKiCZwf28T6Evi5Q/KKCspdelICuYVPlFMqCEufHfvJVDdNAbcuT6tCA==
X-Received: by 2002:a63:7141:: with SMTP id b1mr969032pgn.331.1554314212037;
        Wed, 03 Apr 2019 10:56:52 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v19sm31852836pfa.138.2019.04.03.10.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 10:56:51 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE)
Subject: [PATCH] of: Improve of_phandle_iterator_next() error message
Date:   Wed,  3 Apr 2019 10:56:33 -0700
Message-Id: <20190403175633.1839-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Understanding why of_phandle_iterator_next() returns an error can
sometimes be hard to decipher based solely on the error message, a
typical error example is that #foo-cells = <X> and the phandle property
used has a smaller number of cells specified, e.g.:

	#thermal-sensor-cells = <1>;
	phandle = <&scmi_sensor>

instead of:

	phandle <&scmi_sensor 0>;

Instead, make it clear what the expectations are towards debugging
incorrect Device Tree faster:

OF: /thermal-zones/scmi-thermal: #thermal-sensor-cells = 1, found 0 instead

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/of/base.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 5226e898476e..20e0e7ee4edf 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1350,8 +1350,9 @@ int of_phandle_iterator_next(struct of_phandle_iterator *it)
 		 * property data length
 		 */
 		if (it->cur + count > it->list_end) {
-			pr_err("%pOF: arguments longer than property\n",
-			       it->parent);
+			pr_err("%pOF: %s = %d found %d\n",
+			       it->parent, it->cells_name,
+			       count, it->cell_count);
 			goto err;
 		}
 	}
-- 
2.17.1

