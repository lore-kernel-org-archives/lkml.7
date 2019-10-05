Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9725AC3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0BF20867
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZNHjWeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfJEOTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 10:19:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36080 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfJEOTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 10:19:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so10352587wrd.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 07:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5c+80gfuhaDVm4O1ji2rUPY3d7u88SmARcL9f7vN7dY=;
        b=mZNHjWeNPmo5BapnTp7RGJqxGLhREJ4bX3fwgK/s9gougd5fNMzMt7OPcJjngnFQ3x
         7xkaxz25z1VWtliMz7q6nAuBj4Y6qQnUbkf7eZg+vFaj21YfS8L05t1WjDknNK/u+tsq
         a9XHHC2bJMrWUx15w7NYLn9prPjMkYQ2pukIA/TGblZPBVHvB2pQCcxiowCmOfxy2oaN
         QtJ7JCwdi22t6uQkvYQOndUpobBfsOYWhvOJjXhrK0UaqOFtsecOve3iAbEVmjtkvdCp
         +6v+8CgsOCWE7kvOOtIDvy903zkYlIOlfBGtpAtZwxMi7NA8FfxX/zyByD0epPyHKGwC
         iI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5c+80gfuhaDVm4O1ji2rUPY3d7u88SmARcL9f7vN7dY=;
        b=hi37xYzQO2B4p9G61G16fNs/WBqiW5YNX0AnlGH0GarIEoX1LlLnJno7rKQ37VpxBW
         z/hlaToI2t4QcryVFTeRvsgx/WhJCvlq8ve59aLor3bt07D2ku4BMTvXSWpDrXlPJIyb
         VtouSqraHHQqooywFJfGo4nKVWMi7z7OPSpyvCP2wgabA2cit0qpFyR+eBoXTgBUjk7X
         PIAGYj0n858LJES0MB0gceNGTM1mwM8tA0FWVVEsXWPhyWv1ua4HCyITOpQ3j4Ih8VSw
         EcUlA0oCp7ptY9aFjavLWEcN4SkuAqm45THWFL69G1+hwnpxNbwf2Ex/x62vFrTFSjrA
         fjHQ==
X-Gm-Message-State: APjAAAVLA9fukctSbrYFvPeD/nifp0Q/EpThJABHzQ/wxwALi5aP+84D
        RKydE4pAmm/kfny1iryWK3U=
X-Google-Smtp-Source: APXvYqwscbFmjT1IGg3hC0Kg1mBJY6UX/5CYfa0zNu/seamnmezggP7S0/FwWrabio+Ge1irjUcDXA==
X-Received: by 2002:adf:e588:: with SMTP id l8mr1614352wrm.290.1570285142895;
        Sat, 05 Oct 2019 07:19:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id c17sm1480126wrc.60.2019.10.05.07.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 07:19:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove unnecessary asignment and initialization
Date:   Sat,  5 Oct 2019 16:18:52 +0200
Message-Id: <20191005141852.88712-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable badworden is asigned in two subsequent lines. So the first
asignment is useless and not needed. Also the initialization to zero
is not needed. Remove the first asignment and the initialization.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index 02c476f45b33..d191dbef0bb3 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -615,10 +615,9 @@ static bool hal_EfusePgPacketWrite1ByteHeader(struct adapter *pAdapter, u8 efuse
 static bool hal_EfusePgPacketWriteData(struct adapter *pAdapter, u8 efuseType, u16 *pAddr, struct pgpkt *pTargetPkt)
 {
 	u16	efuse_addr = *pAddr;
-	u8 badworden = 0;
+	u8 badworden;
 	u32	PgWriteSuccess = 0;
 
-	badworden = 0x0f;
 	badworden = Efuse_WordEnableDataWrite(pAdapter, efuse_addr + 1, pTargetPkt->word_en, pTargetPkt->data);
 	if (badworden == 0x0F) {
 		/*  write ok */
-- 
2.23.0

