Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A110C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0740A20645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZBsT+3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfDSSvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:51:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45893 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDSSva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:51:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so2995740pgk.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2b8mK8Me8HIUmgFaW4+r4/xe+L+c5HvMhbinr0qC3pQ=;
        b=SZBsT+3dfvYu5aMne7Cb6M4w40yyr/gFEMwo61lPb0mBHpL+dA6FJ32IhEXy0gzAkC
         Rl3O1NZPnIflzoDsXo1bxNhSspasI9DdxojF1F3Ac89IYdpGVugnGHQ43DctU620p1kb
         LQTq76X1JpGP0MAXFCZByezNstaA4jzAxAw+zmf8YZUG9ovkWzgq+CJg1H+cmDmibABH
         FrnIAtoGVjQLWNMopM+OnWHF/uYGXX9/XT8M0RQkawbW6iMortGLCKEaIvo/ckAFFHDJ
         U2Z2l7xAv5GkcPtUzsuFB+fks1zdt4m7n7kTWFY8V/3FL07F5/dGBZqc9aqeMlCPYyk3
         aT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2b8mK8Me8HIUmgFaW4+r4/xe+L+c5HvMhbinr0qC3pQ=;
        b=g8cFjOvCsCxSg+f3U0w3Q4+QY9v6uJPeeFnZxuth70ij0uSR+ZxpCI6GslwTr8M8Wp
         zSe4sBwPzdAaaUHlwBncxFjXN8YbXQ0AnW0m5+t3eQLAPlUSs04xvS+pHXrPI16XSdHp
         4dS1entJ+mQCObmM1gv8nxU47bwnClyIMYHNZxYIG4O6IbXzHY29zJbWzWuoLdnEiXrK
         MQPsLjSEYfbDUTYARoT3QoML4H40b++Cq0aw72wGmC5ot8f22i0jPiDpgpUt6MReiU9n
         4rp71NPLIt+JWvT8GYgD+XJOcN54TEEFjxx5d8JPTvlchL5ItyQZc6vgTsEbFNq1lqwl
         kgDg==
X-Gm-Message-State: APjAAAUi0iAlEYySYkLzFaBZRiAwHoBFU/anr08CVwG4I2+uSmiA140I
        r0vnTXOUAznwqkGYgGwEYV++J+2mzII=
X-Google-Smtp-Source: APXvYqwEDuHfmUMoazgC/wAOOqqA6A11WfScIXNX8SLlbpxs98NYbYX+cLcnpizZXq2p8bG8AmWWyQ==
X-Received: by 2002:aa7:8c13:: with SMTP id c19mr2986338pfd.225.1555669404147;
        Fri, 19 Apr 2019 03:23:24 -0700 (PDT)
Received: from bhanu-VirtualBox.danlawtech.com ([183.82.102.247])
        by smtp.gmail.com with ESMTPSA id t5sm6480356pfl.106.2019.04.19.03.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 03:23:23 -0700 (PDT)
From:   Bhanusree Pola <bhanusreemahesh@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] Staging: rtl8723bs: core: Replace rtw_malloc with kmalloc
Date:   Fri, 19 Apr 2019 15:52:43 +0530
Message-Id: <1555669363-19782-1-git-send-email-bhanusreemahesh@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace rtw_malloc with kmalloc to make code OS independent
use kmalloc second argument as GFP_ATOMIC as these are called by functions
that holds lock.

Signed-off-by: Bhanusree Pola <bhanusreemahesh@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 18fabf5..6a6683c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -128,7 +128,7 @@ static void update_BCNTIM(struct adapter *padapter)
 		}
 
 		if (remainder_ielen > 0) {
-			pbackup_remainder_ie = rtw_malloc(remainder_ielen);
+			pbackup_remainder_ie = kmalloc(remainder_ielen,GFP_ATOMIC);
 			if (pbackup_remainder_ie && premainder_ie)
 				memcpy(pbackup_remainder_ie, premainder_ie, remainder_ielen);
 		}
@@ -1686,7 +1686,7 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	remainder_ielen = ielen - wps_offset - wps_ielen;
 
 	if (remainder_ielen > 0) {
-		pbackup_remainder_ie = rtw_malloc(remainder_ielen);
+		pbackup_remainder_ie = kmalloc(remainder_ielen,GFP_ATOMIC);
 		if (pbackup_remainder_ie)
 			memcpy(pbackup_remainder_ie, premainder_ie, remainder_ielen);
 	}
-- 
2.7.4

