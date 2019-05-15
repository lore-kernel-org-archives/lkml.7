Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85232C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DDC20881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3pAosNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfEOORi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 10:17:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37463 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfEOORi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 10:17:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id g3so60161pfi.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 07:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bGUs/J4ZxiFyXk4eO3sDQIKqJUCedWLILRfaUclL2/Y=;
        b=G3pAosNUUYLoUYFUutD6MWZ0Lx7EuCMq0LKWFwPzGDGaQHwlAKtAbWSyEy9OM5HfPT
         Wjzz15gDLoR4E5FGZPtqbk2Iclqvo/ybYyPs8KFFtWs74wWDiU7skJNLx6S8i19rzPwf
         eireGe/NMbdHk1F6pO8IUPRBwh8vq+xTRUWQk7xY5s2atdxX1q3NjTQR2wsgjgQDIBOW
         cAdV9m2k2NmQ7QrgaP9OBQDxgGj82Tyw8TYSw+McbiZSk/wvZnB0g/WYqnQgFKKBjj4W
         EhuVFhJt33q+8Eu6k99hCtXdZRDDTRZh5NlkTXwNKMQ8WX66RAiprah2omrglSbsThVT
         Xh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bGUs/J4ZxiFyXk4eO3sDQIKqJUCedWLILRfaUclL2/Y=;
        b=Hz2qnLS68NkemsWHgcWDj6zW1MLSYUDgkcvRQo9IE97rUjDcDBljm2c155zcEMA5tF
         sI4oWKb+w5eqjbiUrfhd+fKU1c3tZa+O2oteftv6gmqFEBg7XWu3jJQ4Vt2tuGzNIFvM
         L71YKkwwPXePZpfExSihL+BS4yji9K4Emoe0gS137E93hugPwRBLrzPYAnz2HP63+tKu
         uTHq0WbSGNN1/fDYQu64koFNchD/M2pdQX3K26R9l/bvxiHLSU/NQp2tb2GgtWNTm0RY
         TSQofcbzJ5gBuXZ4FWXk70E4oIYavXYnbghlXnvOMg6CwmIxFGaKBMNUAcgjgZ2IefD+
         zlkg==
X-Gm-Message-State: APjAAAWeJ+sSSZHJ84wQPbb8YeYV6CF4gOrH5ZSOmt5Y3zBC5fNjwjcr
        oduG1KUA9VZAouPHT8umHqE=
X-Google-Smtp-Source: APXvYqxFRLjTcQF9Iw7UvGqH1ybpMoUgLjZzgqRHFjji/PvUsys7B4fXdifAgudy2pgbSZF9WfUxuA==
X-Received: by 2002:a63:2118:: with SMTP id h24mr44897464pgh.320.1557929857701;
        Wed, 15 May 2019 07:17:37 -0700 (PDT)
Received: from hydra-Latitude-E5440.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id z124sm3781457pfz.116.2019.05.15.07.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 07:17:37 -0700 (PDT)
From:   parna.naveenkumar@gmail.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Naveen Kumar Parna <parna.naveenkumar@gmail.com>
Subject: [PATCH 3/3] char: misc: Move EXPORT_SYMBOL immediately next to the functions/varibles
Date:   Wed, 15 May 2019 19:47:31 +0530
Message-Id: <20190515141731.27908-1-parna.naveenkumar@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>

According to checkpatch: EXPORT_SYMBOL(foo); should immediately follow its
function/variable.

This patch fixes the following checkpatch.pl issues in drivers/char/misc.c:
WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable

Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
---
 drivers/char/misc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 53cfe574d8d4..f6a147427029 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -226,6 +226,7 @@ int misc_register(struct miscdevice *misc)
 	mutex_unlock(&misc_mtx);
 	return err;
 }
+EXPORT_SYMBOL(misc_register);
 
 /**
  *	misc_deregister - unregister a miscellaneous device
@@ -249,8 +250,6 @@ void misc_deregister(struct miscdevice *misc)
 		clear_bit(i, misc_minors);
 	mutex_unlock(&misc_mtx);
 }
-
-EXPORT_SYMBOL(misc_register);
 EXPORT_SYMBOL(misc_deregister);
 
 static char *misc_devnode(struct device *dev, umode_t *mode)
-- 
2.17.1

