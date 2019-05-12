Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543BEC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269242173B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKGp1cwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfELPyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 11:54:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39395 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfELPyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 11:54:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id z26so5803717pfg.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 08:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1vxIkomPQH1I9c3EfXtdAffirCBxYctwSQxs/tfCVVk=;
        b=nKGp1cwM0HpeQtIGPKLVLbdzwqo+4T2NhcX+2MwhkQOJl42LteJhZcwJTjqLy2eVuM
         D8PSISWWroylyI9r+JnXwmv6+lERMZnQ6eaNdxjNKxE0+B//6RdAzKo7xOIeVPAW7Y83
         jhE61YDsPz9NvOnMK6vh/jANUvWSaiLL0i4hVl3LtMriYCmwYBkZ4yKfxl/HZ0w7iHSp
         R7FFoADlMWA2l1fGL3pLEe4phuIuWSk84rZFi+F2J/OqNM9fyV0bwlXr8eoWD159yVYL
         VJFmRB61pUdMbSxCTZQniNI5JQm6T1uV85aVX5M3tdEO3I1TwRvYuGL6UQYF03yCSNak
         uiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1vxIkomPQH1I9c3EfXtdAffirCBxYctwSQxs/tfCVVk=;
        b=A6+0PcA1NDeg8A0OrMzZ75NfXG65qkjrJt2GpImAT8dfiDyw0Es8qKB4b0MmZEimaY
         RV8q1idT8aCdKgsaieUhwiPVohhUlY3b+QT8AZHl/fak6Mavg9Fcup2pW1xXYmbOtVFd
         ECRal7IliyW3K7QivK/Cq/8Wvzufrodc+JHAC84tMTu0WnI+4wi2PZZzf006CYlarPab
         r+FEwTgdl/c2tCHeSjSy62F4grjZElnAj7aIWUvWKofZN3YngCuntp65JRgUv5TNlaUO
         E/yV6JE0GZ638zZDSYSRfgC2HJolJtfbRloLLg9Meq1p4mwOFGnv0caXLQL1G6NWR60E
         JUqw==
X-Gm-Message-State: APjAAAUIdjq0Q03BYxgtWFhcTw7MdvyNtRm3vwI+4MDpZgAVT2KvjAD0
        y5wLjOBHQ9hbGejYMKJSvRs=
X-Google-Smtp-Source: APXvYqzKuq/nOTzNp4a0CIhbe/zEW80ewvYRP5VBoY8liCuefiCQCn0dB2vxlU4/fjnURQbjPzQ4Dw==
X-Received: by 2002:a65:6295:: with SMTP id f21mr26550078pgv.129.1557676484449;
        Sun, 12 May 2019 08:54:44 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:918e:f7e4:1728:3f45])
        by smtp.gmail.com with ESMTPSA id v2sm4470058pgr.2.2019.05.12.08.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 May 2019 08:54:43 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>
Subject: [PATCH v3 2/7] devcoredump: fix typo in comment
Date:   Mon, 13 May 2019 00:54:12 +0900
Message-Id: <1557676457-4195-3-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/dev_coredumpmsg/dev_coredumpsg/

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v3
- No change since v2

 drivers/base/devcoredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 3c960a6..e42d0b5 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -314,7 +314,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 EXPORT_SYMBOL_GPL(dev_coredumpm);
 
 /**
- * dev_coredumpmsg - create device coredump that uses scatterlist as data
+ * dev_coredumpsg - create device coredump that uses scatterlist as data
  * parameter
  * @dev: the struct device for the crashed device
  * @table: the dump data
-- 
2.7.4

