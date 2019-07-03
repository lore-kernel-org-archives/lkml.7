Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548B2C06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AAA218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZqJ9WmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfGCQam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:30:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38031 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfGCQam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:30:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id 9so1528915ple.5;
        Wed, 03 Jul 2019 09:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7wXx06T/IUNp6oBgghvWe6cqc1XKSwPyK8KitWgobzA=;
        b=RZqJ9WmQQAn1gBWJEAInQbDWB1RxPxh6bFHZFJHz7j9fn+AVDgFdXiCr2GUpPZ14hc
         Lt23+XGQ+9a266T2hwpF7MVzpjzKp90TQaEZpI5vwywoX8/+Oe3Zd2gpM9DXNYuiNXP8
         WXpToLF9UvUgUOqn6YAXS7rjMI28dX0kmYpCxZ1DEFc7MbLFAZJEU3llhM/kE0mjwki6
         sAa1XPyXW3Yaiou7u9nG++Ob5sFk2AbhD4yQy0EdxvAjaV5MEQZI2m0uCVhlfW83wtNc
         w9ZdE6OU8KBgQ0Bwj792DKBGRopLbaUxGCZtFxPa+3U53+oxovtDIl6xdGMCwhY3y5Wu
         eBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7wXx06T/IUNp6oBgghvWe6cqc1XKSwPyK8KitWgobzA=;
        b=pjGZzXSaZZX8/oH+EfOxf0PeBOEftA8dH+pS6x4hgZty6ZcgzuR6Ll1HEn0EjosHgb
         NSkg4+gnVC2AkpJZ7ff923rSKxAL9qk/XawTCPBTsS0wty3Q5/k42awKQsYAgG6aiE+9
         DI+1E/ab43/MMj7HY3Bb6s/Cntn+XxaDo1ebaQUOiDqNtymlov0Pt8JNMFTZmAJrtbro
         QEVFo/CFxus8tC6vilH+E+FWVrWRBv1bJBDW02sJx2BrXbzFmbNi0q4k9hkZofRWiwuv
         JW5uPpbgWrMhpI/OtFzpbieIaW8oKdrMW8auGKgy9qMaSRwkRaOI5Xt3lGdI0CtgnyKa
         rcXw==
X-Gm-Message-State: APjAAAWAVJy2arI0TeGlVyQPncmW+3hayW5++xK6PwboYuLT8qF1dyJv
        3i7UlV0h54Ekt7VDKgjKq49iJxjkJOA=
X-Google-Smtp-Source: APXvYqw4o0oxVLBmrbz0jv8BE45v8P5Frva/GlaNzQRYHirRI5pvAY2fMjfBVdbbxVgIlDHxXS+mxw==
X-Received: by 2002:a17:902:8205:: with SMTP id x5mr44053928pln.279.1562171441723;
        Wed, 03 Jul 2019 09:30:41 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id r2sm3258932pfl.67.2019.07.03.09.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:30:41 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     QLogic-Storage-Upstream@qlogic.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 24/35] scsi/qla4xxx: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:30:33 +0800
Message-Id: <20190703163033.456-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)

 drivers/scsi/qla4xxx/ql4_os.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 8c674eca09f1..8f8c64e5f02d 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -3559,21 +3559,18 @@ static int qla4xxx_copy_from_fwddb_param(struct iscsi_bus_flash_session *sess,
 	conn->port = le16_to_cpu(fw_ddb_entry->port);
 
 	options = le16_to_cpu(fw_ddb_entry->options);
-	conn->ipaddress = kzalloc(IPv6_ADDR_LEN, GFP_KERNEL);
+	conn->ipaddress = kmemdup(fw_ddb_entry->ip_addr, IPv6_ADDR_LEN, GFP_KERNEL);
 	if (!conn->ipaddress) {
 		rc = -ENOMEM;
 		goto exit_copy;
 	}
 
-	conn->redirect_ipaddr = kzalloc(IPv6_ADDR_LEN, GFP_KERNEL);
+	conn->redirect_ipaddr = kmemdup(fw_ddb_entry->tgt_addr, IPv6_ADDR_LEN, GFP_KERNEL);
 	if (!conn->redirect_ipaddr) {
 		rc = -ENOMEM;
 		goto exit_copy;
 	}
 
-	memcpy(conn->ipaddress, fw_ddb_entry->ip_addr, IPv6_ADDR_LEN);
-	memcpy(conn->redirect_ipaddr, fw_ddb_entry->tgt_addr, IPv6_ADDR_LEN);
-
 	if (test_bit(OPT_IPV6_DEVICE, &options)) {
 		conn->ipv6_traffic_class = fw_ddb_entry->ipv4_tos;
 
-- 
2.11.0

