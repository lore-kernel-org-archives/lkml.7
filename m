Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979FEC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5522177E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+uVdxVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388380AbfEXCpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 22:45:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45766 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387622AbfEXCpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 22:45:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id j1so5162051qkk.12;
        Thu, 23 May 2019 19:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JiwhV2okxhWw5WJSJ6pbgrKM3HJLc/AAgQnHKtq5ncg=;
        b=t+uVdxVAGAcOb/aB7ycv9PCCCXQruAWc0ZKqBSL3I2sZQfrHWAX5EmAkLmGFvCzmkx
         TQcuwfpzpza4Mwy05RHpOc2p9+u2ewc4g0H/vudJJ+NVdIFL+iFGOM1dig+sSX/Vi4XN
         /VCdOx3/AGLNrR48awdSfS1Rs269uilzpWZbnKDhx4jfZ7s952hTNt4LSIRBmqmmxbIm
         PrzgJButzpLehxYlOHLJNxfJIFvGzcxQoPOQ0dJmAKLz9beGb8oKJieIQibs6LILvCc3
         xRL5mfvr4pfiUqD8pPBb6Z9nQfNvDM5ZDUPLgONQU6yh2esjAZ2Ma3B1aSrp+uFgeel2
         DqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JiwhV2okxhWw5WJSJ6pbgrKM3HJLc/AAgQnHKtq5ncg=;
        b=rAFBUeCv33gktfw2Gt2huFyzx2/2WgsJTsVPgDUYOJiI/2cJtV3NUyGFIgit0tV8fG
         41Iy4TUs/5wnvmyzD+CczmVleMAt0wxRovEXLqWXc7R1BDm/eONUFSoUehDYv2OWM8OE
         YTmhtc7y4qMd6rXNbZAr5pfOcw+8yLoaaNf8zK5KpW4D3HaslTrhQHWghwIw3u1tSM4S
         BhidCmbxghRhz8MKWU4oJiccZnK34jSmd88Xu+B9+MhF2HIWNR3zFp14rAKMcQfRxFwz
         4gbq29Xhyc6X/6TlMK9/n4lAtxCardhpcqi+BpOGWcFHFrt4Bo2MSR2oSCBZ5efZYPAD
         CNAQ==
X-Gm-Message-State: APjAAAU9qe8H/4bBnUJgOMSb7C93aQ+z1KVfgotMYoRdJeF/y1umbCqz
        VojPcpyDTMdXLIEODgGRF5FeW8rH
X-Google-Smtp-Source: APXvYqwll1VcnQrzoF/oHPk7JFo+XRy22y7eY0y698BFWgLD0hsWT53P68nHfqkqo1OvV1yhW3pJ3g==
X-Received: by 2002:a37:8dc1:: with SMTP id p184mr59037678qkd.226.1558665914865;
        Thu, 23 May 2019 19:45:14 -0700 (PDT)
Received: from localhost.localdomain (189.26.176.134.dynamic.adsl.gvt.net.br. [189.26.176.134])
        by smtp.gmail.com with ESMTPSA id g20sm695968qtc.53.2019.05.23.19.45.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 19:45:13 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     liu.song.a23@gmail.com,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org (open list:SOFTWARE RAID (Multiple Disks)
        SUPPORT)
Subject: [PATCH] md: md.c: Return -ENODEV when mddev is NULL in rdev_attr_show
Date:   Thu, 23 May 2019 23:44:59 -0300
Message-Id: <20190524024459.6875-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c42d3240990814eec1e4b2b93fa0487fc4873aed
("md: return -ENODEV if rdev has no mddev assigned") changed rdev_attr_store to
return -ENODEV when rdev->mddev is NULL, now do the same to rdev_attr_show.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 drivers/md/md.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 45ffa23fa85d..0b391e7e063b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3363,7 +3363,7 @@ rdev_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 	if (!entry->show)
 		return -EIO;
 	if (!rdev->mddev)
-		return -EBUSY;
+		return -ENODEV;
 	return entry->show(rdev, page);
 }
 
-- 
2.21.0

