Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F13EC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B6A22BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWuTVaH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbfGZTB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:01:57 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36745 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387743AbfGZTB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:01:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id z4so53700224qtc.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=syecGPLAVxXKoScF58JM1nKaJhwv9Ro0xqH2lWpKv7s=;
        b=mWuTVaH89MAVhGcqtln7I6cJDGBVNDmPF17LnLwz0UxffNJfpG/ImSkR3c2jfLNuTm
         O0p7ixMqV0hOZSHCjs007Er1FZ35YkvK8X97JYMbRWVVH9JwElPeZS15wfVfwRLBTyoe
         y32zsnQZ/uv8IydTJTTruGaxfyauVNIV4xIC1P0KlzLLIr6BFZhD66Otx23acTsDQQgX
         apnBA3eW9PSBjW/9s6rXSEddGFynj1SVfXA7YSwcG4iDXyuTY0mvIX9bJjooe5ucwZuP
         e7t7etJqCtt+m2Sri8Z+HWsfAalh2tcHnwTCCPHkTF6ikfwBGDWOn7Y7hEALSIJhN4i2
         zAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=syecGPLAVxXKoScF58JM1nKaJhwv9Ro0xqH2lWpKv7s=;
        b=IeMVX4euZj8iYGb4JpjlX0dUvxKBGXOu5/bHh8mper6cvu7rT0mHc3MxPC0mQ6oOFX
         gQ/lsn0jvZWixH46Vkzob08oCvZvw/o71298WO9UJO1NBLUuFLIrquOhvy2b8PbTP97a
         T7mTOCqnjuPI39FfY7XKn30bbXtQ1/t1oEdIOf/tjuabkXFncnrfalmVMflEcbiUo/fD
         1sA50wI65JSTleBt5d+WAsTcHKirn4DAusv+vpzhishsOqt300hiC/t711Xe5UlddoJt
         Ru1QvuswYrlWYrbk8gGUr7n1TQhvg/jhrMm4O3EcCbnaGo2CAfRVoqgfmg2tdChDhvJy
         0E5w==
X-Gm-Message-State: APjAAAXvFD7Baxq7ZlVDTYAuJn5RHQaKkgYv0iiqXvDX8xcvlar2ObLa
        M4u0eZ+M4DF8KpmZuof6ces=
X-Google-Smtp-Source: APXvYqzrMQuk02/iXrXtRaLD6D5IA8xZF45GCR2iy/tCNubwNavnBZHpamZyjQxpD1SFWtfNVrnOGg==
X-Received: by 2002:a0c:e001:: with SMTP id j1mr70180692qvk.110.1564167715842;
        Fri, 26 Jul 2019 12:01:55 -0700 (PDT)
Received: from localhost (ec2-3-84-150-207.compute-1.amazonaws.com. [3.84.150.207])
        by smtp.gmail.com with ESMTPSA id u16sm27436019qte.32.2019.07.26.12.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jul 2019 12:01:55 -0700 (PDT)
From:   Abhinav Jain <crazypsychild@gmail.com>
X-Google-Original-From: Abhinav Jain <ubuntu@ip-172-31-129-142.ec2.internal>
To:     gregkh@linuxfoundation.org
Cc:     himadri18.07@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Abhinav Jain <crazypsychild@gmail.com>
Subject: [PATCH] Staging: rtl8192e: fixed a function prototype definition issue
Date:   Fri, 26 Jul 2019 19:01:46 +0000
Message-Id: <20190726190146.10875-1-ubuntu@ip-172-31-129-142.ec2.internal>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhinav Jain <crazypsychild@gmail.com>

Added the identifier name in the function prototype definition.

Signed-off-by: Abhinav Jain <crazypsychild@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 2dd57e88276e..f55153270a8d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1940,7 +1940,7 @@ int rtllib_encrypt_fragment(
 	int hdr_len);
 
 int rtllib_xmit(struct sk_buff *skb,  struct net_device *dev);
-void rtllib_txb_free(struct rtllib_txb *);
+void rtllib_txb_free(struct rtllib_txb *txb);
 
 /* rtllib_rx.c */
 int rtllib_rx(struct rtllib_device *ieee, struct sk_buff *skb,
-- 
2.17.1

