Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667E9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39772205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0ypA8OD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436637AbfJRQR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:17:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33625 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfJRQRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:17:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id b9so6910808wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CyhruEuU6pTmlA6D3bKXso/kwHGIBQMWCr1O6b60mKA=;
        b=J0ypA8ODZliLj0Shal/ShLuBoaGjCaRr84iQio7xxm89cBkvs9UvKhR2Gb3ase1C1C
         LlFx3lKtHVtxSiAb4aRjJyCifk0vyeT2xV4Z4Fv8Sz5egAJLLz1lNctt3rVjQpnd8IHs
         3jJ3YIbBX01oKz3eJQnA5K+KeEfkOrPuYrJjkpQnxTC95UFBpTbNNPsOxzgmlf24uD0O
         lMLmvEz3qLYG2wCIa/RBwWgvv88cb8LBhsLDWp9KiLS9T1P2ihXZYn7VOuUM0MLCFEx+
         NJuvGpMMXGXt4n+A9z9FjlNKDDRYiJsR/V29R5uHfhlfI82GPk0vTyxyd6sCZCji6OPA
         aoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CyhruEuU6pTmlA6D3bKXso/kwHGIBQMWCr1O6b60mKA=;
        b=U6Fa6eiHzjfnWJJ0gFxdwXOg6U/sEro0dhhPT0zOazbKD3ezrQNq5/vWuDZBXo7EY3
         2lv0Nk0xrLGOpa56LFPKSRvfz4IOqX0FzK2s4VZuBm150vFE07vFClCjtRBOyYbg1Ip0
         kfFTl7ZCvTioQhatOht5EXrvohWolP4hKedMPjFG/Qm7zmJj5qISDrCeEll6RamvFVaM
         I6qSFdfgQ7jf447pgkkNTkNpGh6pRcISJJc7FtRZ8jGl0y2W9APjDrRZhL7OgWO+232w
         h2ZHDZgcbk0ccbiOLLPIp9IZBYTLI1XLgjEm+2EYOMirvJjJAwFQ7xUwi/PR387j04C0
         LsAA==
X-Gm-Message-State: APjAAAXSpvwk4l4eCabyGgoOA2Xot6SNyy36XpXSxCo302a9gaUSGvZS
        hyqx9aJPTLWTc69MmBS3gYA=
X-Google-Smtp-Source: APXvYqwa6d5OS9x+riQjidBKvT6ARV+GspvanegsMYs3asRR2Wx5cqxKP8OfUTFl7WgNID3H4fGMCw==
X-Received: by 2002:a5d:5222:: with SMTP id i2mr3406021wra.271.1571415443869;
        Fri, 18 Oct 2019 09:17:23 -0700 (PDT)
Received: from debian.office.codethink.co.uk. ([78.40.148.180])
        by smtp.gmail.com with ESMTPSA id n1sm6616605wrg.67.2019.10.18.09.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 09:17:23 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2] tty: rocket: reduce stack usage
Date:   Fri, 18 Oct 2019 17:17:12 +0100
Message-Id: <20191018161712.27807-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The build of xtensa allmodconfig gives warning of:
In function 'get_ports.isra.0':
warning: the frame size of 1040 bytes is larger than 1024 bytes

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

v2: check faliure of kzalloc

 drivers/tty/rocket.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index 5ba6816ebf81..fbaa4ec85560 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1222,22 +1222,28 @@ static int set_config(struct tty_struct *tty, struct r_port *info,
  */
 static int get_ports(struct r_port *info, struct rocket_ports __user *retports)
 {
-	struct rocket_ports tmp;
-	int board;
+	struct rocket_ports *tmp;
+	int board, ret = 0;
 
-	memset(&tmp, 0, sizeof (tmp));
-	tmp.tty_major = rocket_driver->major;
+	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	tmp->tty_major = rocket_driver->major;
 
 	for (board = 0; board < 4; board++) {
-		tmp.rocketModel[board].model = rocketModel[board].model;
-		strcpy(tmp.rocketModel[board].modelString, rocketModel[board].modelString);
-		tmp.rocketModel[board].numPorts = rocketModel[board].numPorts;
-		tmp.rocketModel[board].loadrm2 = rocketModel[board].loadrm2;
-		tmp.rocketModel[board].startingPortNumber = rocketModel[board].startingPortNumber;
-	}
-	if (copy_to_user(retports, &tmp, sizeof (*retports)))
-		return -EFAULT;
-	return 0;
+		tmp->rocketModel[board].model = rocketModel[board].model;
+		strcpy(tmp->rocketModel[board].modelString,
+		       rocketModel[board].modelString);
+		tmp->rocketModel[board].numPorts = rocketModel[board].numPorts;
+		tmp->rocketModel[board].loadrm2 = rocketModel[board].loadrm2;
+		tmp->rocketModel[board].startingPortNumber =
+			rocketModel[board].startingPortNumber;
+	}
+	if (copy_to_user(retports, tmp, sizeof(*retports)))
+		ret = -EFAULT;
+	kfree(tmp);
+	return ret;
 }
 
 static int reset_rm2(struct r_port *info, void __user *arg)
-- 
2.11.0

