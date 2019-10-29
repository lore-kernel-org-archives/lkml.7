Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B78ACA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B902067D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tH1vqV7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390710AbfJ2RJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:09:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41539 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbfJ2RJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:09:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id p26so5878479pfq.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 10:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aoq6jyjkoC3LpN2Vxb6LSXbZ7+YI0W6uo+6lRedmGDE=;
        b=tH1vqV7j2AqRq678Xfjq3gRUPwBGXd8w1sEUZwdL9SAx56yGie9zKFY8TI/UUNvK+Z
         mHGRXsyubOzva7SVlwrAlyjrtlkvn2ryMDjR6fs01Bfv8yKZOS2KNVvYqHzcIFvW9zX0
         CXcOWcGOhh6vbAa/xPZPvHKByOFDfTtaQxT/4+zwnOHBJ1cLjDdVBaX8sRm1fWV0nfbW
         G63MtcQWbN44+cB/XV+w4a780UjE3Sk9Xlugk+qudl7qAVmnC6u7oP1fftT87lUMwowQ
         6/zdg/TB0USvZlBBq5kFcN8sFgFXZDP5gt4pHBri8zevrZwDj7pfBrM3kKj9TFj89+6+
         CZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aoq6jyjkoC3LpN2Vxb6LSXbZ7+YI0W6uo+6lRedmGDE=;
        b=PUSeJ5FnND1TWuwRdByDODqWeNmpN4HclnbiRYDdT7IQzm8jk1axpN/t1Z6UDogEww
         IEh8EUR+7l/aueJMLw72qL1J7f+mhDeCLjNMm5wg/KjcL11lkhkkgZMJIiV5dlvDTadL
         Bol9mAHlmM4e5pJJeRe2PgJUWKlUMrVt73AY5norJoO8gWxeZ4j2p0hStdwJ8DyUWBBr
         alnDnD40VfMafCkg7LDlMjgAvc9x9o2Y4/Doxe0uj50fHs46Ff1A1ZGCcwNPG7F0Crlu
         4jRUi3ye+3rimdUJXKq+l2oTNJbGXMzs8dUpDq4E8awtmqgqEHQiZYUQ3wWeNV/QKo5M
         LPzQ==
X-Gm-Message-State: APjAAAX9KECGGcAYMgjMrZVVGSR5lNkZOaAYqkITszksAZbg2+wmakQy
        ceenBRPOmpBmOeR9PurnZlE=
X-Google-Smtp-Source: APXvYqzTkzwJ0BXcf4IXcjo6Y78qFVRs5sX4tLnGbhmCgxWUiKRqBDt8mz1dGXIVGLdT2IDSgeSRyQ==
X-Received: by 2002:a63:2d81:: with SMTP id t123mr28815254pgt.306.1572368939385;
        Tue, 29 Oct 2019 10:08:59 -0700 (PDT)
Received: from saurav ([117.232.226.35])
        by smtp.gmail.com with ESMTPSA id o12sm13253177pgl.86.2019.10.29.10.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 10:08:57 -0700 (PDT)
Date:   Tue, 29 Oct 2019 22:38:49 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     joern@lazybastard.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH v1] mtd: devices: phram.c: Fix multiple kfree statement from
 phram_setup
Message-ID: <20191029170849.GA6279@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove multiple kfree statement from phram_setup() in phram.c

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---

Change in v1:

- Add change suggested by Miquel Raynal <miquel.raynal@bootlin.com>
  "The goto statement should not describe from where it is called but the
   action it is supposed to take. 'goto free_nam;' would be better."

 drivers/mtd/devices/phram.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index c467286ca007..38f95a1517ac 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -243,22 +243,22 @@ static int phram_setup(const char *val)
 
 	ret = parse_num64(&start, token[1]);
 	if (ret) {
-		kfree(name);
 		parse_err("illegal start address\n");
+		goto free_nam;
 	}
 
 	ret = parse_num64(&len, token[2]);
 	if (ret) {
-		kfree(name);
 		parse_err("illegal device length\n");
+		goto free_nam;
 	}
 
 	ret = register_device(name, start, len);
 	if (!ret)
 		pr_info("%s device: %#llx at %#llx\n", name, len, start);
-	else
-		kfree(name);
 
+free_nam:
+	kfree(name);
 	return ret;
 }
 
-- 
2.20.1

