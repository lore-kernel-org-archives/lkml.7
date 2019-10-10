Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEA4C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9894820659
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkcZfWzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfJJRVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 13:21:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43982 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfJJRVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:21:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id j18so8847876wrq.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tcMFZrYzkXthDN2tPL7urUoh2Atq6M3SFm7VW5KGajA=;
        b=LkcZfWzUVAWf/bqrwArXIPyypKwGXOf1p3QX2ZQUZX9A29nRGH1d8b19tbfjBnk5L8
         sbTfW+HpzeLJ8t7mb8uiaXfutckcbijR6kDvAwMwyhl8+7ndlFpbiPux7tQEumPugjAp
         cohSbhOlPeE0L4dgVYDcnGgHqOzSJYIUCzb2EFXZn0dBjweOJynyl4689nG/TErLCe3O
         6oy2lJ4H99/xfuUJUu8ASzBtuItX+7x8Wx7Dclwlm9fo1BlMQwBhqo74KbqDa4Bah0h6
         ux053NaZChG7r16Yip7K/spNk4bjLJuocT7rLKvn1gLtl+xdX361/bO8wB7Fe7MOrl7w
         CAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tcMFZrYzkXthDN2tPL7urUoh2Atq6M3SFm7VW5KGajA=;
        b=Bw0KsKuj8ulQ3uNSKEHDt6dd1qM9XENAr+LV24di36anqvXHCswUP5UGHVL/A9cosw
         QXrJmq/7SssApNuMTgIpooiBVw9pSZLECf1gBdUfoOjjhPoj2c5lSGG6up8wcKtkq4LG
         7mx0ExJ5TuG/wef7eIp5fvoBltxMxSBp6D8UoF8sXx9wu4Ayslqo82oxUL6jPPtuf9Dc
         BEDyNtMibgf+ta376CWV1zneliVN/GD8zNOfPfTRzkA5UeNt2rlvogzV3vg2tjlTlQ3/
         //30L0P5P1rQRAON6vWHu+/GRDIVsQq9pW9r/4ASf/VMACzBI4NPK+fL3VSHlRIJPhep
         Q6TA==
X-Gm-Message-State: APjAAAWAeN3nOq5a4zAV096IeIni1gvkE5OfAashmS/3oAwG7ThtIay9
        +moNi0sKDGNmbIHx9d2eVQ==
X-Google-Smtp-Source: APXvYqwh4JQKHmQGA7zvATE+l3bRYx4mHPNLiy9MYUBN7U6F8fs8oiYz3XeDYeid4ntItM/uM9TgTg==
X-Received: by 2002:adf:e646:: with SMTP id b6mr9138851wrn.373.1570728091281;
        Thu, 10 Oct 2019 10:21:31 -0700 (PDT)
Received: from ninjahub.org.net ([94.119.64.23])
        by smtp.googlemail.com with ESMTPSA id y18sm11734475wro.36.2019.10.10.10.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 10:21:30 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, Jules Irenge <jbi.octave@gmail.com>
Subject: [RESEND PATCH] staging: qlge: correct a misspelled word
Date:   Thu, 10 Oct 2019 18:21:14 +0100
Message-Id: <20191010172114.12345-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a misspelling of "several" detected by checkpatch

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/qlge/qlge_dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
index 5599525a19d5..28fc974ce982 100644
--- a/drivers/staging/qlge/qlge_dbg.c
+++ b/drivers/staging/qlge/qlge_dbg.c
@@ -354,7 +354,7 @@ static int ql_get_xgmac_regs(struct ql_adapter *qdev, u32 *buf,
 
 	for (i = PAUSE_SRC_LO; i < XGMAC_REGISTER_END; i += 4, buf++) {
 		/* We're reading 400 xgmac registers, but we filter out
-		 * serveral locations that are non-responsive to reads.
+		 * several locations that are non-responsive to reads.
 		 */
 		if ((i == 0x00000114) ||
 			(i == 0x00000118) ||
-- 
2.21.0

