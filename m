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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93955C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67091218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfIH0IUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfGCNPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:15:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38706 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCNPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:15:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so1274582pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 06:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TOAiuu/wlD5D7o5/mqIHnTG4uZtldrOoIUofef28WiU=;
        b=lfIH0IUL8bnlFMDRimVxIwkNQ/20moehxMR8XeG6e1vo0CHjFIa7S4/IFzeJrzgJlU
         q2EJ1FOEjXJguDQSyMFXH7k3X9n1scvRb7MkJjtKkRBfWxe8gnqZdhJTTVtiiemk1hZ8
         JEsWEwZyeYK5LrcZYxqtxqYOB84MaPfNmB0WpIoCWpbsKR17eWSZ/DL4BpVsMdWBspi3
         XBGVX5QsFJ2A9jlFpjBiIrBKWiWS6s+R4q4WHhiK4NP1F7C+nhehr4iK/vSnZH9RFSc2
         eCufZv73Y0MyVNOl+ObekcnzpEHus2zpOUjXEVq9ou6kVad7pijQPkngK46W9dWsm/zJ
         axEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TOAiuu/wlD5D7o5/mqIHnTG4uZtldrOoIUofef28WiU=;
        b=dlCJUpaLSBycb3zmPLm52W//v+wEVMco7F2oaAaZ1W/6jxZT+d4PHEgh4pT27P7U2F
         lqWukXv7qoG1cXiN+tNd2bwzTpTZ8HtxUSe8hNwdqr+XidptKWvIaf5inYWobfpYgZvU
         nyp87wq20i4R7ODTeHM6yLTJVMeMyVoca49ZWaZnpcob0T5LLrA7mV+kNbOqEPuXbkCC
         BVXmZ6awyov1zgNirm2B3GUYX4bUiVRKv/3DeYgqXDv/RFibHh+Tc2SNINDQ3MyC4ZrL
         z7T9cKUJyKI31YTufg/VRbAcLxZa0Dq18vAaxNcA2D9aoXSB1jo86C6XWbm3gpzXuOg3
         Nkug==
X-Gm-Message-State: APjAAAV4enyNDeqXcpYpPM/6+bmuGYV0YpWMk7SS6xBvl3MlJaFbiaRh
        DRTJiH5Ci+tyaF5isRDAT70=
X-Google-Smtp-Source: APXvYqyiVfU9tnl97ooPeC5zImq20DdkMsp/940AfLqBE2Jk+gaxyNTMhh6g4w5deJAwDI1B1gTb8A==
X-Received: by 2002:a63:f510:: with SMTP id w16mr37865515pgh.0.1562159700244;
        Wed, 03 Jul 2019 06:15:00 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id j14sm2877028pfn.120.2019.07.03.06.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:14:59 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 09/30] macintosh: Use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:14:52 +0800
Message-Id: <20190703131452.25085-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/macintosh/adbhid.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
index 75482eeab2c4..5d14bebfb58f 100644
--- a/drivers/macintosh/adbhid.c
+++ b/drivers/macintosh/adbhid.c
@@ -789,7 +789,8 @@ adbhid_input_register(int id, int default_id, int original_handler_id,
 
 	switch (default_id) {
 	case ADB_KEYBOARD:
-		hid->keycode = kmalloc(sizeof(adb_to_linux_keycodes), GFP_KERNEL);
+		hid->keycode = kmemdup(adb_to_linux_keycodes,
+			sizeof(adb_to_linux_keycodes), GFP_KERNEL);
 		if (!hid->keycode) {
 			err = -ENOMEM;
 			goto fail;
@@ -797,8 +798,6 @@ adbhid_input_register(int id, int default_id, int original_handler_id,
 
 		sprintf(hid->name, "ADB keyboard");
 
-		memcpy(hid->keycode, adb_to_linux_keycodes, sizeof(adb_to_linux_keycodes));
-
 		switch (original_handler_id) {
 		default:
 			keyboard_type = "<unknown>";
-- 
2.11.0

