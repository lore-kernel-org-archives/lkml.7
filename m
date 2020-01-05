Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12E7C33C99
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 19:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE9120848
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 19:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrTXnHNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgAETwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 14:52:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35914 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgAETwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 14:52:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so13259729wma.1;
        Sun, 05 Jan 2020 11:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7eXrRrejXo5cY1s8ikFeeHu4Vmh0gYXwb9IV/BMbSdM=;
        b=VrTXnHNKjx1Bgwv5ROAzLRxL39MWdd/yk8k/yMK2eaP06Fd4kHeVNwchYZFifJ02XI
         WefXs6YVWJ5yEMfe1VptI35mkjA86Fxt9f8v5WhNcW26ci8i2O7Ti5Pd5vnbw6cocjgK
         Ni7QateIZF9shgfkO2+4+hWCWxy5SHp3tJUYspjjF/VSdJIHhnGocCCmt6NTnjEoF0bO
         4hLfihkuzTiQ1Y+OmMxH2usaSGz8dZsH0rIdP6dmkG8jqRtoJU6USLTFIq5tqPXLYjvb
         6tjhP+rMti8O3Xg1MO3r0p1lKteIOc7rOS5gT1gd40QRbgQMpjxU+ZhZ6kwPKvxiLHmP
         XL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7eXrRrejXo5cY1s8ikFeeHu4Vmh0gYXwb9IV/BMbSdM=;
        b=TS9bIMIMbW91jqeeenjvm+JPcvt+iS2kxoLHoYV4rfMU7/ONk0FRGM79tygpe8FcZR
         gLyry5ceb8BfZ145ovUsQ7TwCTLLLQ+fUyZxFtzCZcL5dmidhvM3AHRh/xStV31JLUxJ
         7MUJJszX7nqOWRVIAvcnLwi33ktZXq91iATjKcgQSRREHaVHZSuJXmLY2xZu0AiZTxDc
         GOkbCmPqBYo++Qvzv3f0O9m4+JwjkonEj+foPj7A5+2QpWmUXEk4J6QLLETamL8cHEOu
         JzeKXp5qOPyQ9exq1+3w19/TNbsDdb4XXZsvAEFVgQHp5zL+LDTQWAW61hbl7F8Fulj3
         UpxA==
X-Gm-Message-State: APjAAAUlKElxqG9NgrltWwzA3j/EbVz2C6vAx8lke3LwrvCZL2vF5Fsw
        mAD/5u9K0JRuvbHCVVZNe2aqaiA+JEpqRA==
X-Google-Smtp-Source: APXvYqy/8DaerA+VPEjKP+Bf0WTY7J+6iCjArVKTjkd1gL6/pzsJMUoSyeYv9cbDpugIkc+GCv2bSA==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr32226967wmf.136.1578253941444;
        Sun, 05 Jan 2020 11:52:21 -0800 (PST)
Received: from localhost.localdomain ([37.152.140.242])
        by smtp.gmail.com with ESMTPSA id s1sm20979413wmc.23.2020.01.05.11.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 11:52:20 -0800 (PST)
From:   carlosteniswarrior@gmail.com
To:     corbet@lwm.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Carlos Guerrero Alvarez <carlosteniswarrior@gmail.com>
Subject: [PATCH] Documentation: filesystems: qnx6: fixed a typo 
Date:   Sun,  5 Jan 2020 19:52:14 +0000
Message-Id: <20200105195214.8684-1-carlosteniswarrior@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlos Guerrero Alvarez <carlosteniswarrior@gmail.com>

Fixed a typo.

Signed-off-by: Carlos Guerrero Alvarez <carlosteniswarrior@gmail.com>
---
 Documentation/filesystems/qnx6.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/qnx6.txt b/Documentation/filesystems/qnx6.txt
index 48ea68f15845..28e40a7f310f 100644
--- a/Documentation/filesystems/qnx6.txt
+++ b/Documentation/filesystems/qnx6.txt
@@ -163,7 +163,7 @@ tree structures are treated as system blocks.
 
 The rational behind that is that a write request can work on a new snapshot
 (system area of the inactive - resp. lower serial numbered superblock) while
-at the same time there is still a complete stable filesystem structer in the
+at the same time there is still a complete stable filesystem structure in the
 other half of the system area.
 
 When finished with writing (a sync write is completed, the maximum sync leap
-- 
2.24.0

