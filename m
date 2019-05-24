Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD12C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3AC2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSGsRuhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389411AbfEXIGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:06:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33920 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389046AbfEXIGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:06:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id h2so1565982pgg.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QTdIOmj1SS151jb6XK8udh0fxhXIkCdxxTWwvFE+/JQ=;
        b=VSGsRuhS/Kd+oARJmriP5B1RIIi2hPENzu6c4tSUn8sHlGh5Uaz/lBMWus63IetDV4
         uuT5yUT+oIGirKOeuxQHH4dGqkUGGtz1/+u7T6K1R5aQeZORQgQ18QKlRBEWbM6YrLWu
         ygk9az5+rFJfQO2yp8b3ANxACLKznVV6hLLXVyaILY3vQ+ni4c3uvTOC2+/0LJKukuW0
         F95X39i6peFsFfRrvYtjeKkbyoc68ivuSL+zFgcY0xJjUZtu5483WO633tN/nAb92Jd/
         fEz2eeGUCXaPT5cDQMFqRC41msB9rqmwhj0HIMGYDSxpXfYYaMODKRiPOSzRFuFFz22b
         sjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QTdIOmj1SS151jb6XK8udh0fxhXIkCdxxTWwvFE+/JQ=;
        b=KArSxmXduVEVnKMaEPBOp3Jg4iX4Mxk87sDCrPQUj0BLSf/yFertAKrdILymti2gBv
         8cfJCGpx+OIly1hwVxrrdslZFQEqtKhjVce2JGzF8ppCclwbJJ9eW5TG5NX+bjXIpstm
         J+YUXUQMIhhGQ+LceBmYmh919f1Jtntg3cH6tx6ufy18WbviCazn4Kc1H+ENFNaJOKje
         e0E3xPzK3+EmHk1Po8mE/RANmQ2MyqNGsLGFet2IQ/LBEQMxoTfNhQBLrjGqXRYNY5bm
         /1opfh1+1qiIKttOk9qGuOmA+Nm7hC3+kvfzJTWLDQaAkKNuLS0XmdCTHRO2+0sFfTIv
         0qYA==
X-Gm-Message-State: APjAAAXeyGopkWjMppUqfda+UelbmqCmAHmUl24IgzQzvmnaUXie+Yy2
        fSR2RxAnmzaCjmcP/auRyOc=
X-Google-Smtp-Source: APXvYqxfcBtSzL3kpQs+wUBMcShVj1c66L7EVJ8uduwff5auuOlymKp4c8PSwyfZO/z0D2gIVKW6DQ==
X-Received: by 2002:a63:1d1d:: with SMTP id d29mr104116236pgd.63.1558685195519;
        Fri, 24 May 2019 01:06:35 -0700 (PDT)
Received: from localhost.localdomain ([110.225.17.212])
        by smtp.gmail.com with ESMTPSA id u11sm1607991pfh.130.2019.05.24.01.06.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:06:35 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH v2] staging: ks7010: Remove initialisation in
Date:   Fri, 24 May 2019 13:36:22 +0530
Message-Id: <20190524080622.4801-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the initial value of the return variable result is never used, it can
be removed.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
Changes in v2:
- Clarified subject line

 drivers/staging/ks7010/ks7010_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index 74551eb717fc..4b379542ecd5 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -380,7 +380,7 @@ int ks_wlan_hw_tx(struct ks_wlan_private *priv, void *p, unsigned long size,
 					   struct sk_buff *skb),
 		  struct sk_buff *skb)
 {
-	int result = 0;
+	int result;
 	struct hostif_hdr *hdr;
 
 	hdr = (struct hostif_hdr *)p;
-- 
2.19.1

