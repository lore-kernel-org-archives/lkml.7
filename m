Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2139CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C307E2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSYnU4t9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbfJVNAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:00:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33559 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731093AbfJVNAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:00:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id 6so3645933wmf.0;
        Tue, 22 Oct 2019 06:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eyay/8zntu7rIdOGWbuuJlhvNDUp8DvLGfNMZ5zr0AE=;
        b=FSYnU4t9/vZp2uPLVq3Fg0KlMo56fPAyUqjsSrDs8h5CtcGzsoWkwC7X+6Sb0blIjs
         mh9CH1u1wtd8olscTGb16Qp9MIhcqwN1ATuwMbM118OlNfsiM2V1XKMV+SKDvx4uvSRZ
         HatP9lEQRcxCvNyPII/+tBdNeLLjM7lBDLCxxVy/23DwbGTSeZabUaPXvhM4LzqmPGp1
         uPb+raskjXqzLLrW1CJBb5AGgj679jDAgiLqDJD/yvK0cdtOkwZEB949d6cniw6y/6mv
         w9wxqcC0idJrH2VRkn5glabT0H1GEG4ZW+8Rb0es4GjOwrK8gSzSKVtCH5E0xzxeOGIN
         FcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eyay/8zntu7rIdOGWbuuJlhvNDUp8DvLGfNMZ5zr0AE=;
        b=BdxJXi+l+kJhZtZjx7ZaorPBBxZ/w3kjK8XZcJEwwqPwVj5+q45e90Y9qLZGxK76hS
         LyRZ9pKBCvSYTgissCm7UOHJj6//i2ZTwlaguw1g/OKXGbAjjRZKFArkYLauhLnx81ZU
         30l08Hmn3lEgHJh6hW9I8psja5FSuWFc83ejLOtfTv1zalXVvASC9BfXRUAliQVkOMm1
         BTsxtdloWIoV6Bz2CAR9XghDoOkelQWG+60ONKRAmGZ33nI7j8NnmKLVeZd45TZoBS5n
         poOt+pRsOtAd94CSoAJC6ovz+CIIXzhJ4H4zu2OOs//22NnOkIYwxa2OGAUSAXLRgnDv
         gIVw==
X-Gm-Message-State: APjAAAUQOawMctAp8vLNPaKY6YEieXTmIcgNUTI0ydIZ57ECsDKFWcDz
        9leo/SI4T21x4RaIO1JljIY=
X-Google-Smtp-Source: APXvYqybM6ZsQXLzFphVl6khI9qS0LBEyihcOwpRXwt6K/+SMZPRCd+NlKqTs2m/weKn7AXrxv4OBA==
X-Received: by 2002:a7b:c049:: with SMTP id u9mr2901966wmc.12.1571749249658;
        Tue, 22 Oct 2019 06:00:49 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id b62sm25935509wmc.13.2019.10.22.06.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 06:00:48 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] mmc: block: remove unused variable
Date:   Tue, 22 Oct 2019 14:00:36 +0100
Message-Id: <20191022130036.23877-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of 'status' was removed but the variable itself was not
removed and thus adding a build warning.

Fixes: 05224f7e4975 ("mmc: block: Add CMD13 polling for MMC IOCTLS with R1B response")
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/mmc/core/block.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ee1fd7df4ec8..95b41c0891d0 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -497,7 +497,6 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	struct scatterlist sg;
 	int err;
 	unsigned int target_part;
-	u32 status = 0;
 
 	if (!card || !md || !idata)
 		return -EINVAL;
-- 
2.11.0

