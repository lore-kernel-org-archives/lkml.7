Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C32C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 20:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07F620862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 20:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOcOfoux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfJFUvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 16:51:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33773 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfJFUvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 16:51:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id r5so16454569qtd.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 13:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QkysCBSB9fGqKPV8g/1PIAYcEKj+5HCVtkPSug6S7x4=;
        b=cOcOfoux4Df7/s9EkUQGrbPexSBOt3WXuQ6fU4InY9ASkZfOT1H4oszYBQao6riw/k
         VXTm3ZxkLndtrobWYJ6Wpm2gLJtAPc+YeDdEU+Vzea9fblEzy8iPj25BZtesJ3Ym0iYU
         oelu7zpxaomQ0gRsFoW7JhZbb+sLgJgpfMykiu1tRPDtIs9bb482IsrozXiDSKZFdzNc
         0llDAebPCIEeb6kNpWPRnSR8KRk14Vb+7cNCMLhJULK+PfNS6LGwgvgOul0UqBTL/nKs
         UX1himK/rZtQPOMeIbSr56wvOpIUGvy737VYgOB+puIXTKwoHvSUNXoso2N3zdTWPaID
         qanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QkysCBSB9fGqKPV8g/1PIAYcEKj+5HCVtkPSug6S7x4=;
        b=YMFsHaNcBuYIP+HeI3R0svdbznlde3wr+0G7lppZrYP3POXlcZri70M0LmGdCk91iQ
         Wg7jTN3jEU4eQkm/OFBozkIl3XJvSubENMiL+P9xwrk+y0K2wE96IGcdwcNIv2+3xB1F
         N1MmKvpG7E8QUiQH5C1gFO/qb27k8OyQ/LLjheqQdvfpwdUliXnPsEmM3rObjqqcRk09
         mm5xDRvWlq7EhbuM93NTXVBuMe3lrdy2J6llAN4eoXFkODW5lIAHKSF/drTOp5PJvhW3
         Wxabe1hRnp/fa7NV43TH8016iQ2l3mq2jvQ95wbu9R01z86HZqFDKpA5whurikF87UWM
         vHEQ==
X-Gm-Message-State: APjAAAVc9yvnm4s1hNj4A+xchttSfVf2e84PGcwS34D91JG1T4VgGURm
        PV+HVrtDYA+t1PVssxLzQFo=
X-Google-Smtp-Source: APXvYqwR0q1/blUrqYR+XMlkhidWKj/s2ojzVV8263BY2FCeizUcrqO88TL/aFATj4L8kqpsqpyA4g==
X-Received: by 2002:aed:2448:: with SMTP id s8mr27213725qtc.173.1570395102993;
        Sun, 06 Oct 2019 13:51:42 -0700 (PDT)
Received: from GBdebian.terracota.local ([177.103.155.130])
        by smtp.gmail.com with ESMTPSA id a36sm6949492qtk.21.2019.10.06.13.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 13:51:42 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
        nishkadg.linux@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH] staging: rtl8712: align arguments with open parenthesis
Date:   Sun,  6 Oct 2019 17:51:35 -0300
Message-Id: <20191006205135.11791-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Alignment should match open parenthesis"

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/rtl8712/recv_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/recv_linux.c b/drivers/staging/rtl8712/recv_linux.c
index 70a4dcd4a1e5..808f21c5767a 100644
--- a/drivers/staging/rtl8712/recv_linux.c
+++ b/drivers/staging/rtl8712/recv_linux.c
@@ -61,7 +61,7 @@ int r8712_os_recvbuf_resource_alloc(struct _adapter *padapter,
 
 /*free os related resource in struct recv_buf*/
 int r8712_os_recvbuf_resource_free(struct _adapter *padapter,
-			     struct recv_buf *precvbuf)
+				   struct recv_buf *precvbuf)
 {
 	if (precvbuf->pskb)
 		dev_kfree_skb_any(precvbuf->pskb);
-- 
2.20.1

