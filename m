Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C61ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21932082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM8HlFhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391331AbfJPHtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:49:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45527 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfJPHtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:49:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1so12592667pgj.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rs+6eykEbLb/Ps0aGciaj263UzIFLf7dw4Limwb3wL8=;
        b=jM8HlFhiuTYhtmJOCTmJzNOeTLVRw5pTyiCmxt2o00wWDbh1v17ZaXt28TSyYalO6P
         j1ob7kakbGmYrklqJCxzKoQsKXFPNIReKbtpoWQzdnfRXCr7OMrReeHtDI510xAC9L8c
         75z9X6mzRQbcJO8SzpP2dqn+1KrH9QpU7rKh4V7lq01Igm9vPn0xmwYZrWw1Ry9zYnOH
         b+pottMfIudmdWLBe7vbnxcBO8W31VWvo5dm/xfDnBxmJCYV1yuwprulyd7XNv37d2ul
         7oOSQO9p/f0O1zj7ij6toeTM3z11WaFMxEN/hWo4qYXQm8CEvABwU5sDIVlALeMBdATp
         +1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rs+6eykEbLb/Ps0aGciaj263UzIFLf7dw4Limwb3wL8=;
        b=I+dl8Qf5Ysa90GzmEQPRRTxnEBozOHE20c12yQRYolKwo26MikOVvM9byBbiES2fa+
         F5TCrbmnPpwKaeUF/3LB2+el1GxFr21cOWqhyfWt7mjhusw4HJhki7ZfnicU6agCPwrc
         XylcFzhd1+AAZl6dG88vIx5+TEPzLGGMfAhM5lL4slbmk5rX2ntO/2ZzYe7Nyfgh9Vb7
         eze+rUu+On0v9Q5iAWhMzYlY5U4pjpoE3j9gcH41wYTbdPek4/Z31ACsPEetIACPPn/w
         O+myKSUWMu03Eq+QUcCOB3kozf8Vzem4px6URIl7EKR4efJc3m4PjOdyaSWENFT7DQzV
         1Zyw==
X-Gm-Message-State: APjAAAX/6ko9mcB1EBiP4/n0mQYHozUzP/zxx8YPutL3zv54wtKMMzTP
        3JMmb+X8G+QGjBjEFGIEDnQ=
X-Google-Smtp-Source: APXvYqwLcffu1Q+66LnpWVngP8agqKLvyV2NklzUg2UWiFFn6GuRXuPQIOJmn1VNbHJt5j5EvWcZeQ==
X-Received: by 2002:a62:38d5:: with SMTP id f204mr44000437pfa.209.1571212188617;
        Wed, 16 Oct 2019 00:49:48 -0700 (PDT)
Received: from localhost.localdomain ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id d1sm25185522pfc.98.2019.10.16.00.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:49:48 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, dan.carpenter@oracle.com,
        michael.scheiderer@fau.de, fabian.krueger@fau.de,
        chandra627@gmail.com, simon@nikanor.nu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] staging: KPC2000: kpc2000_spi.c: Fix style issues (alignment)
Date:   Wed, 16 Oct 2019 00:49:25 -0700
Message-Id: <20191016074927.20056-2-chandra627@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016074927.20056-1-chandra627@gmail.com>
References: <20191016074927.20056-1-chandra627@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved: "CHECK: Alignment should match open parenthesis" from checkpatch

Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
---
Previous versions of these patches were not split into different 
patches, did not have different patch numbers and did not have the
keyword staging.
 drivers/staging/kpc2000/kpc2000_spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 5712a88c8788..929136cdc3e1 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -226,8 +226,7 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 			kp_spi_write_reg(cs, KP_SPI_REG_TXDATA, val);
 			processed++;
 		}
-	}
-	else if (rx) {
+	} else if (rx) {
 		for (i = 0 ; i < c ; i++) {
 			char test = 0;
 
-- 
2.20.1

