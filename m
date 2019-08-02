Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33AFC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7CD2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L06fNxwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392973AbfHBTvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 15:51:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44350 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732050AbfHBTvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:51:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id d79so55678489qke.11;
        Fri, 02 Aug 2019 12:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IhPFcfbz2/V11YFI7RTPpFSB5IsnZB+cpH43bf3h0Yc=;
        b=L06fNxwVoOB1WiC7Sej31HGPAKBjVBKjCxkZe4nIAtVSSwT7ouAvEW3BLLzlzBS+ee
         cxqwI6YzWOB8KDKVmopPQMh4cIwX4wRQJF2afhkmBma6l4/hbLahDcBG+afoKehhhGI8
         jmaLMU29VR+oOHupOCO1nIDpPqwiEHd18T87VRMxWEDpC6VsKmhMPY2OnxrrblUYp0Da
         wfZrQvgwMZiRU56bgo/xAc36IQLpWB4jwuW41ZLcwUxZEW575lCGUZs2A1Zp2I5UOD2P
         oSC6ypbuxfbTJ1N1lmyaAySqyZI2X7WbNOHZNWJCNgNO5k0T3dxKZpWQGpmlSF6/twCe
         ZsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IhPFcfbz2/V11YFI7RTPpFSB5IsnZB+cpH43bf3h0Yc=;
        b=UwFsRvIGdB3pMHOyUvefLvPYWx7jAihgvlKevCV1zBccTLD3HyC68ts8qIzfW9rvcs
         D9REY1tf3gmFvHNgLhrOwLuW8+jzsIrq9cAnjoF2ngm0tdozHwyZy7rTj0yE5eM6jAUq
         NY4NaV2WSnw4GQqCNOVh+rqiY6JB0KYBYFPFZDiL/oFgy+SGeqzn2ui/fEoSzyGCETcG
         dOnBoXTMxxogy2x4Lo7GdAtbaOYKtynZ+cDzl9ePWe7d8Cyp1LK18Lxa/Id5sOhTrvAb
         y3cnkGvQY620GG7o+4AqC4v15Uz0uOZKKtxrMw5iWn7hn7ezBZsqRoH7aU24FfmW9jyu
         wuSg==
X-Gm-Message-State: APjAAAX1+RwOQZbzbbAhLIJsykz1DOT7p8pnRsVY1r6l2qG70qp41rBW
        87i2Khpyepx9ybOyfOp4xBc=
X-Google-Smtp-Source: APXvYqw1Ox/GWHRh4qsgVB9Q+1JluAxvxs9jKO4UwOzgZlzth/9Kgbcz0COCRdgZRqFn4maQEsS/tA==
X-Received: by 2002:ae9:f702:: with SMTP id s2mr66915898qkg.28.1564775475426;
        Fri, 02 Aug 2019 12:51:15 -0700 (PDT)
Received: from localhost.localdomain ([138.204.26.247])
        by smtp.gmail.com with ESMTPSA id b4sm30262545qtp.77.2019.08.02.12.51.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 12:51:14 -0700 (PDT)
From:   Fernando Eckhardt Valle <phervalle@gmail.com>
To:     isdn@linux-pingi.de, gregkh@linuxfoundation.org,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers:staging:isdn:hysdn brace same line if
Date:   Fri,  2 Aug 2019 19:51:05 +0000
Message-Id: <20190802195105.27788-1-phervalle@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch error "ERROR: that open brace { should be on the previous
line" in drivers/staging/isdn/hysdn/hycapi.c:51.

Signed-off-by: Fernando Eckhardt Valle <phervalle@gmail.com>
---
 drivers/staging/isdn/hysdn/hycapi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/isdn/hysdn/hycapi.c b/drivers/staging/isdn/hysdn/hycapi.c
index a2c15cd7b..e5dc707d5 100644
--- a/drivers/staging/isdn/hysdn/hycapi.c
+++ b/drivers/staging/isdn/hysdn/hycapi.c
@@ -49,8 +49,7 @@ static u16 hycapi_send_message(struct capi_ctr *ctrl, struct sk_buff *skb);
 static inline int _hycapi_appCheck(int app_id, int ctrl_no)
 {
 	if ((ctrl_no <= 0) || (ctrl_no > CAPI_MAXCONTR) || (app_id <= 0) ||
-	   (app_id > CAPI_MAXAPPL))
-	{
+	   (app_id > CAPI_MAXAPPL)) {
 		printk(KERN_ERR "HYCAPI: Invalid request app_id %d for controller %d", app_id, ctrl_no);
 		return -1;
 	}
-- 
2.20.1

