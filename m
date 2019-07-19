Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B36C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CDB21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F30SYFLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfGSHJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:09:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34464 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfGSHJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:09:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so7819728pgc.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 00:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hw2kNiLoj+LvvfY1YdobU4HU5vXnmTyj3KhgfWP8Lyc=;
        b=F30SYFLzLUaEvZZyNkrfusWAtMzfDxAGnKIlXrIl6LOCJF2OhfQDsDLT9cmynvdevK
         JwjuT2TZXcF7zudqpIWMz5/gKm7J0X+6DBmaiQWIZz5dAtOiAitm4MlmT3q+az3sfLrq
         lAjPAWrRlY/T2WWHlDSv6/2omGMuIyOvfC8PwRKM85273cve4F8Tft6YALL0ynYxhIv/
         CH7yoVCrZPA0JjDcZeBNWyPX/AMfNdFDhZOFC9bgc1KRlwop6/yxHjX62T9H5Pujnjvv
         MhXFDeDWxctuByVAbbgvmXY4NjfDmZKaXHs65AJ1zUhplntVEUSR7kzG+yIfgk/dQlY1
         7tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hw2kNiLoj+LvvfY1YdobU4HU5vXnmTyj3KhgfWP8Lyc=;
        b=Qn6MjT1oO82tXotPZwnITKbaz/SoRSVap8lCBwtm2V3VJu7EJGY4zxtj0C4FhJ3Gyd
         nkXF9+YNcIZT9sIRqah3V9UWgToS0+w13Go2nQAxMjPxkyfxucpLoKVyqNPzE34cN5rV
         ihvvtdCrJv+4xYG9cB+D8tOnYzhkP3MfGhzejtLl2rKmCvHq7e583slL57BI1IBzomwD
         L0hz5Yw0LzBmu2NTD9wUdO1gAe/bRKl/xwKczs3lA1lkwCzkMnAFugnyK8kFTdPkAOir
         6vXZy9uP8vO+DATu/3kZNdw7w3H518xxI42tpnyVBYN6BHae7QfaN/cQNJPbqoBSszCY
         gBxQ==
X-Gm-Message-State: APjAAAUp+ibZk9Iet2VlP/8ALro/UhH09r0WoJCQPQfuNbSR6ZY6FsAE
        5KQ/IgsEX5WNA7IMy31Ejk0=
X-Google-Smtp-Source: APXvYqyPYlKJsxcZlDbnkyt2zjKgqcTXPGjGOmY0RYcfU9CmypL8Bb/NbeFOHQDzySOm0VehvgYREA==
X-Received: by 2002:a17:90a:208d:: with SMTP id f13mr54371662pjg.68.1563520192524;
        Fri, 19 Jul 2019 00:09:52 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id r18sm17470274pfg.77.2019.07.19.00.09.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 00:09:51 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] staging: rtl8712: Merge memcpy + be16_to_cpus to get_unaligned_be16
Date:   Fri, 19 Jul 2019 15:09:22 +0800
Message-Id: <20190719070921.27749-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge the combo of memcpy and be16_to_cpus.
Use get_unaligned_be16 instead.
This simplifies the code.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_recv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index 5298fe603437..9969e5265a40 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -245,8 +245,7 @@ union recv_frame *r8712_portctrl(struct _adapter *adapter,
 	if (auth_alg == 2) {
 		/* get ether_type */
 		ptr = ptr + pfhdr->attrib.hdrlen + LLC_HEADER_SIZE;
-		memcpy(&ether_type, ptr, 2);
-		be16_to_cpus(&ether_type);
+		ether_type = get_unaligned_be16(ptr);
 
 		if ((psta != NULL) && (psta->ieee8021x_blocked)) {
 			/* blocked
-- 
2.20.1

