Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18AFC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7594520862
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQzOmXyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfEYRUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 13:20:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43035 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfEYRUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 13:20:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id c6so7159341pfa.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 10:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=M6D54Y9cAdwUjftrKOdf9/RVXWKvemPtHhP4qHuwDPc=;
        b=oQzOmXyiswoQAHAKdEwj0INIkSyCBfdhsp23Y8yvpbSv8OJ2y/xrSB3fNaGfHTEsPE
         W494Lrnnzdh6Pc5FTSRe2bSKc3BFDH80azlAPda+MXGuMa/F+kilgPgcAX4czQo+zxvB
         hBHLzWpxzkarYsDEMelf7pCRrYIeYMZ9TPPWuGytLZci/MZU8ob3V4HFNUIZrS6t3b9q
         lR5iMBZ9pxPp8ZCSK8t31Ia/Mwd6LEjyTla4/g+T6LEvGx61Lo2vtisNEmwtlQVwU8Ej
         euRNnaTfXzldXKhMeAeihdQCFngYhzDGMutFTVlrAKwsot0DAccO2/xg51hL3PARDTjl
         KzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=M6D54Y9cAdwUjftrKOdf9/RVXWKvemPtHhP4qHuwDPc=;
        b=qg8b0c4SqUnb0n9mLaFii6W/FuqwBVCafpqX079ojNrJUCtzm2HeJFjJcY8ErbL7el
         G//YoVVo1B9x/c6cAeE1ZC1Hh0Owe7NpgHENNMmiu3LJSEXTvi8BlGr6b6ypqe61AuIM
         thGOC0B9ixynBqGM/xY+5SHsQ5Xq9ZK0ailk8L1tTDZAiaZMVsnaDDGiKSqrm/eSmxVt
         5jZPhrdEUkJnmrcVnNahRK3rwY3ArVuq3M6ZRXVs9uwev9+gqUUbtxjnl8qnCiUJ3kcO
         3gjrFJ7DXw9xjDkX5KO3pBkNvFyRbKwRJjXfhKNYt++Sptrif1+VRCMpWmmOuwq1JVwj
         CJZA==
X-Gm-Message-State: APjAAAUWLPXs7/iDNq/yw5g3J9ZnWOpPZzAZg4DKQ6d1wNNFeZslEwjw
        pZU9jpBs/hRHZQaet9sJhB4=
X-Google-Smtp-Source: APXvYqyhqu3gDCAGd3Nfla0MLJAy5xt2tYnQsgvABDULwzrRsJo83IWwUZxnXD//ER5h4B+4Id/SBw==
X-Received: by 2002:a63:c24c:: with SMTP id l12mr114354053pgg.173.1558804806540;
        Sat, 25 May 2019 10:20:06 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id m9sm6861513pgd.23.2019.05.25.10.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 10:20:05 -0700 (PDT)
Date:   Sat, 25 May 2019 22:50:00 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: rtl8723bs: hal: fix warning possible condition with
 no effect (if == else)
Message-ID: <20190525172000.GA18730@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch fixes below coccicheck warning

./drivers/staging/rtl8723bs/hal/odm_DIG.c:499:1-3: WARNING: possible
condition with no effect (if == else)

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_DIG.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_DIG.c b/drivers/staging/rtl8723bs/hal/odm_DIG.c
index d7d87fa..70d98c5 100644
--- a/drivers/staging/rtl8723bs/hal/odm_DIG.c
+++ b/drivers/staging/rtl8723bs/hal/odm_DIG.c
@@ -496,13 +496,8 @@ void odm_DIGInit(void *pDM_VOID)
 	/* To Initi BT30 IGI */
 	pDM_DigTable->BT30_CurIGI = 0x32;
 
-	if (pDM_Odm->BoardType & (ODM_BOARD_EXT_PA|ODM_BOARD_EXT_LNA)) {
-		pDM_DigTable->rx_gain_range_max = DM_DIG_MAX_NIC;
-		pDM_DigTable->rx_gain_range_min = DM_DIG_MIN_NIC;
-	} else {
-		pDM_DigTable->rx_gain_range_max = DM_DIG_MAX_NIC;
-		pDM_DigTable->rx_gain_range_min = DM_DIG_MIN_NIC;
-	}
+	pDM_DigTable->rx_gain_range_max = DM_DIG_MAX_NIC;
+	pDM_DigTable->rx_gain_range_min = DM_DIG_MIN_NIC;
 
 }
 
-- 
2.7.4

