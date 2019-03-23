Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3039EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAFC21841
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="mIi69M37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfCWVlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:41:35 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:49456 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfCWVlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 17:41:35 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 931A3D48
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 21:41:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QUVCuUv-7a7a for <linux-kernel@vger.kernel.org>;
        Sat, 23 Mar 2019 16:41:33 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 64F0BD1F
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 16:41:33 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id i63so5668516itb.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 14:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nz+3mHW/r6/cPTjvFh7Xv0Gnmybwq6RbDIuJDUvdaGI=;
        b=mIi69M37AWXSfMaL2ckKk1tMQYLWgfr1JXC/Ipykgw16dp7u23F8ram1fEQn7AU8bj
         X1/sMjX/gYePmAYqRcYApgUsQkLjGyfjx5fHoDDMA/uKk8nqdFrinO/BV7V7Cw69LULI
         soq349KzeuhA81Qtjx6nbfOphLt8h3VCAHYp+LKyNfdaIsbEZYZoJuCcIEs7QrKXwHd8
         c0AMzI1n7zRZaIwuNcc7RiHLDlFLSv/eCrcJEmoiMUxlE1yoCeP28aqmtQG3YFvlvdzL
         JuwnT150mJ7JZNkGeH9w1+umYLXrNZ0FY/bZm7Jpt1Q9b6wq64w4a+heEFXypfx3mlIk
         ExrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nz+3mHW/r6/cPTjvFh7Xv0Gnmybwq6RbDIuJDUvdaGI=;
        b=kC8zhTNTjckLeOvHY7RsoB+i//oB9yyofsCLVW47A7xTYIaSQnIGonI3xD8b868+wv
         l2a/s8q6HJ0XbEHsI3OamXkA07kZW+DxhPh6VJypY00bP4IO9YalXtQimmhUNd+XLMSi
         D+zKIkmhWOd2SHHAyyYMVocfFMdIZcgc3mpzKV/B2qFsjFuwpXkUFq8+fp58P9OwdNZg
         nhhVdp9iMs8CkhYfiXyNXTwrqIZXfCTQL7ueHdgrJovi5k4BpWztuzrnUuYPpNAjXMGp
         tR9hW/rRIDEVhyNfmlsGd8x106CWDBF7seOfw8ALGWnq5MdxcydaCPVNfv7JoKSmCAA/
         jyXw==
X-Gm-Message-State: APjAAAWCATKQ/7gmd7jR4wo53GWashU+8+qZ7+sgtYSF44ChONZqURgj
        S2guaQa0DlKf6CdYQhrMtVh2y6wudneILiRKNxuaE4LB4Dz5b6F0XHdStRpm9WO4Gy4l/o+VgNH
        a0zlU2dppKss/q0UZTKq6Lvk5Bqqd
X-Received: by 2002:a24:b349:: with SMTP id z9mr840905iti.77.1553377293043;
        Sat, 23 Mar 2019 14:41:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxGCg7FrqYBYcz1pWhbwLngsOi/MEqF87eI8Qr5X+DXO2LyftiWofxWhTnsTRPaTkd87ZJRNQ==
X-Received: by 2002:a24:b349:: with SMTP id z9mr840900iti.77.1553377292875;
        Sat, 23 Mar 2019 14:41:32 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id t74sm5115331itt.29.2019.03.23.14.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:41:32 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvdimm: btt_devs: fix a NULL pointer dereference
Date:   Sat, 23 Mar 2019 16:41:25 -0500
Message-Id: <20190323214125.10233-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case kmemdup fails, the fix releases resources and returns to
avoid the NULL pointer dereference.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v1: Free nd_btt->id in case of failure and avoid double free, suggested
by Dan Williams
---
 drivers/nvdimm/btt_devs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index b72a303176c7..119a4ead2e46 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -204,8 +204,14 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
 	}
 
 	nd_btt->lbasize = lbasize;
-	if (uuid)
+	if (uuid) {
 		uuid = kmemdup(uuid, 16, GFP_KERNEL);
+		if (!uuid) {
+			kfree(nd_btt->id);
+			kfree(nd_btt);
+			return NULL;
+		}
+	}
 	nd_btt->uuid = uuid;
 	dev = &nd_btt->dev;
 	dev_set_name(dev, "btt%d.%d", nd_region->id, nd_btt->id);
-- 
2.17.1

