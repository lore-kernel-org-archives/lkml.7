Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A4EC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22CD216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDlX7aiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfFZRwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:52:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40042 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfFZRv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:51:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so1551483pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PYRuyD1HElut26s/f7k9wlmyAWeFCl38SzC1C9BI8tY=;
        b=XDlX7aiZwQokBsiCMdvUOmEJQsIlxeCrOI3mc84lr5R7kBNv78OIPHppyWoDe5UeNH
         QGAj8tK1u83UflPF+m0lb+fllt8uoyjJhH1wQi218pbhA1yZMinKQjkB4S3O5xksopTG
         ts9als020BCHH6PJmv5n88nInO2k+zonOtT4BxxwdVE3mUCqBWV7rKjA5Rt1K4W6ANYu
         s7I8Suz73D05eUsDH6sQN9+k/6S9yjHlerk5gCLWKy0CAnbU5E1jd9bdUgUtUdEUMEaD
         E8rD4vUuwZrvESBgAwV5b+aYt1BMHx/4vYJd8TVsrAcLZBVdBHEwZ62DinJDao4tNWn5
         jkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PYRuyD1HElut26s/f7k9wlmyAWeFCl38SzC1C9BI8tY=;
        b=bitQjjOb+WY2BqDKUh5XBGnkNQI1FBMMHvluP6d5pEpns5A+fb9OguU5w7re7BBzE9
         T26rooaecWfqGvtIlwlVAsOo17N+GBlg49gdgKihZGhLgYlaAAXnTxVcizaovaFg8gzS
         hO7iahMk08O4SRoUMex5qj71TjGINM66UfuGSjh3qV7jD7Qi47qbKUDuWOZu8NoCLgeT
         FhADEnjl3VACvVju20KsUOaeURJkXtovd4vV9yZEEddXkx8fVksYB9rzGRJXcQrghLKh
         d6pFrZnKINKxokH5OJJid2QkYJY9y0ZzUWFNQpHUi89CFGGb04zUETiJPlr84VK2bT41
         c4GQ==
X-Gm-Message-State: APjAAAXAakwN+1gbrh/eXpu7fz9iY7LXyb9oV/DaY0NWGQ3MBNvRfGTf
        FF1dzyhC0x7b2vb9BLZHZC4=
X-Google-Smtp-Source: APXvYqwTJk2prCUh4y+T1TfDWS6E+syxqfxVUP1FpSbpCkIQJbYVwja7RnF65f4XO2fpa2hhxlGJCw==
X-Received: by 2002:a63:1723:: with SMTP id x35mr4053469pgl.233.1561571519161;
        Wed, 26 Jun 2019 10:51:59 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id s9sm2465026pjp.7.2019.06.26.10.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 10:51:58 -0700 (PDT)
Date:   Wed, 26 Jun 2019 23:21:55 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: hal: rtl8723b_rf6052: collect return
 status directly
Message-ID: <20190626175155.GA9162@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable rtStatus and return phy_RF6052_Config_ParaFile function
directly

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
index c205345..d0ffe0a 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
@@ -194,7 +194,6 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 int PHY_RF6052_Config8723B(struct adapter *Adapter)
 {
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
-	int rtStatus = _SUCCESS;
 
 	/*  */
 	/*  Initialize general global value */
@@ -208,8 +207,7 @@ int PHY_RF6052_Config8723B(struct adapter *Adapter)
 	/*  */
 	/*  Config BB and RF */
 	/*  */
-	rtStatus = phy_RF6052_Config_ParaFile(Adapter);
-	return rtStatus;
+	return phy_RF6052_Config_ParaFile(Adapter);
 
 }
 
-- 
2.7.4

