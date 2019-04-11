Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE780C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63912184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EtKBSmFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfDKWB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:01:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35449 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfDKWBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:01:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so8498714wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 15:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TOmehU4NtJzE5DRqIgvNN4m9djQewwCjbGHx9sj8Xmc=;
        b=EtKBSmFxn8M86szFDp2PbLec2TxzAMfeQHUxm3wZnVjMXX/xmjfc9AsnTxnSI635sv
         x2KtCKSn4xhsZzr/22KpZhAuF5QvZ0xau0T0gg/3QdHUeGJrDpiVKhh/PBnI/mzkxLrf
         6m3A05Zsdrfz/3OYHOOBzenDN3vUl6GwnF9jD14dHDwFxMK83w/jxNg0qnV96zbzLD0H
         inpXP9+62EqOGeMFmgE5T9pHYv9OVYSr2dNS/HrqRyPyuAPbWmF9AgqKeD7hlxeT4g21
         3xmxuXekqTmlmPzc3DuJsOt+2qdqoxXD/IxkWvtadKJ3e1Ylk/VSXufySfbDTg7kcLo0
         OisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TOmehU4NtJzE5DRqIgvNN4m9djQewwCjbGHx9sj8Xmc=;
        b=TOFQKppsdXSpKN3lgCEwFZHXaM92UHZealhfYs0KUASy7S+SQg62UxWx0cz/ZMXjbw
         07qCuqpxoEtLMxVxw6ZEGYTRGcW7nhgc2Y5HDv0fjbgutsm0ce5lbIhVJUlwVL70YXlr
         B8YLSXW+GJ9Uex1VZa1xLL9rE0jxwW+Rnq7DOn3TNX085kg7yOF9PBggS8BdEMgadkT5
         mh0MLmRyfCycDWuxKVZzieeNAdx4pGdv/vfnvFHMFJZWMcca6f1bPhn0ytcSMFSrD0Vd
         NWZYk0OSPoXgb3aPY+N3we4I+UUOkN/hNirimfhFgBOfFsxAmcsSH2VPkvN/luP7dHyQ
         nWFg==
X-Gm-Message-State: APjAAAXJisTrMN3yY+d/w7GI3pl3DYRJHfsseeaU0ojtmCcFLkyE/zNu
        /XxFZ9SuZZP7dBj+eULdl6U=
X-Google-Smtp-Source: APXvYqyp2y/bXkFnt+6wuuBKNqjX/TVPl3xAEoP0SGsXv8/vf24Zk69nEmrvknj1iULPO1/MVPxdMw==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr8583638wmb.7.1555020081342;
        Thu, 11 Apr 2019 15:01:21 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD0009F15067C8D22C31.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:9f1:5067:c8d2:2c31])
        by smtp.googlemail.com with ESMTPSA id s189sm13266186wmf.45.2019.04.11.15.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:01:20 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     liang.yang@amlogic.com, linux-amlogic@lists.infradead.org,
        linux-mtd@lists.infradead.org, richard@nod.at,
        miquel.raynal@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org,
        jianxin.pan@amlogic.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/4] mtd: rawnand: meson: use struct_size macro
Date:   Fri, 12 Apr 2019 00:00:53 +0200
Message-Id: <20190411220056.19109-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411220056.19109-1-martin.blumenstingl@googlemail.com>
References: <20190411220056.19109-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the recently introduced struct_size macro instead of open-coding
it's logic.
No functional changes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mtd/nand/raw/meson_nand.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index cb0b03e36a35..c1a6af57dab5 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -1242,8 +1242,7 @@ meson_nfc_nand_chip_init(struct device *dev,
 		return -EINVAL;
 	}
 
-	meson_chip = devm_kzalloc(dev,
-				  sizeof(*meson_chip) + (nsels * sizeof(u8)),
+	meson_chip = devm_kzalloc(dev, struct_size(meson_chip, sels, nsels),
 				  GFP_KERNEL);
 	if (!meson_chip)
 		return -ENOMEM;
-- 
2.21.0

