Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE389C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC8E20821
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6CqbbCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfDSU6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:58:51 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46377 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfDSU6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:58:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id s24so5186045otk.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N1W8LuisafzPG22GTbbXaTDt59BPFMJ1rINmkc7NvLM=;
        b=D6CqbbCZ296hgBHOniva9HLqHUXJ095kL3fh96HTHVpcc+lMeXrGc9R+KdS6vqNgpN
         ynZJCQVk1ZXBmt5djxkWV3jbR+FbZ1TIgq+nJHMnDnncqd9F/2kW9U5spWQJPrkqdwdn
         DgO/wEWzQKgqL+h5BzfmtSPhGoukCc2K4rytQNYJWGwUYdEyNEs8VyMuYZYlQqDjMSZt
         PCgGtj7BqH0QwdGeHmVXf9/6rMWLDznLkE5WSfp5gXwFqUK2xP599bVrrws7KJmqtlNw
         GJ7pMYivKbld5RjohgzMXI1b9yTVVr3y0ssiqHcKvCvEceN8yBhb1xbAnBtwQzaNJZvO
         hZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N1W8LuisafzPG22GTbbXaTDt59BPFMJ1rINmkc7NvLM=;
        b=M4aagvsxHf14F3ZoXfTU8eWj4PdPRfrUWSafxJkaJ8O5Jl5c3tyw4vVPaVz8kXHKmv
         kxCUIKTrvr1iSo7Aht/sNhYPMOUg91ERfeyoRjgPd0oTPa+CvV15EJO6OyTCwRb0DM3K
         QN0Jeux2kxyRNABqYQGT0LkgVVbvTuF6eUDxIOcrQqgYn93R+Vt9HGXypoNtSPlY0KBd
         mrWpemxSpaNjdr80xouZ9iUDti5xzAdGk58Uht81jXxZLSohvjo7B6RI1dP7mhPlKhbP
         YvufzSAMVBj/SSwbjRlfHmFs/YbQwgcC7/qXPR2myYf+irJZ+7sIpExqPLPZosMtSlLZ
         vpLQ==
X-Gm-Message-State: APjAAAVIV27RYc+OIm0pVP7CxJ/aljZWPrBD6pOAjg8vhFIpTtJPwpU7
        Igh0vJO4CPPoxwfit+B8AHs=
X-Google-Smtp-Source: APXvYqx2PKSaxFqomLVzIGW5T2N1vY1DFaFZt/d2fnTXrHQjI2ZXSZhXWCdVhHLM3qePdy7cwd+6GA==
X-Received: by 2002:a9d:3f05:: with SMTP id m5mr3555236otc.59.1555707529919;
        Fri, 19 Apr 2019 13:58:49 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:151b:11be:d797:d50])
        by smtp.gmail.com with ESMTPSA id q25sm2211897otl.60.2019.04.19.13.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 13:58:49 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH] Staging: rtl8723bs: core: Replace return types
Date:   Fri, 19 Apr 2019 15:58:45 -0500
Message-Id: <20190419205845.586-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unwanted assignments and replace return types.

Issue suggested by Coccinelle.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index b9d36db762a9..2474fa6fb49b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -204,8 +204,7 @@ struct	sta_info *rtw_alloc_stainfo(struct	sta_priv *pstapriv, u8 *hwaddr)
 	if (list_empty(&pfree_sta_queue->queue)) {
 		/* spin_unlock_bh(&(pfree_sta_queue->lock)); */
 		spin_unlock_bh(&(pstapriv->sta_hash_lock));
-		psta = NULL;
-		return psta;
+		return NULL;
 	} else {
 		psta = LIST_CONTAINOR(get_next(&pfree_sta_queue->queue), struct sta_info, list);
 
@@ -586,12 +585,10 @@ u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
 
 struct sta_info *rtw_get_bcmc_stainfo(struct adapter *padapter)
 {
-	struct sta_info *psta;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
-	psta = rtw_get_stainfo(pstapriv, bc_addr);
-	return psta;
+	return rtw_get_stainfo(pstapriv, bc_addr);
 }
 
 u8 rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr)
-- 
2.17.1

