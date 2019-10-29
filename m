Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82E6CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999E420717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="om+IK8gW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbfJ2JQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:16:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43681 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731643AbfJ2JQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:16:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id 3so9088071pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 02:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+5wZZ+PjzxLbMdDOyLUeg2K+18/C67QOv7Ke0t4fjo=;
        b=om+IK8gW9qPt4hDBCn7c37Yv8B4zorqfOIgpMJXy6PAJCQV9z/f0M2rSIne/RVoN0j
         5rW3sE8guoGkVDLi49tL1A7uPeLqQ0ri+sOcYAY1wXu6Mc0MsZxPgVHq7AOMblh7DXF8
         LWQUxD+6IPqWbG5R7MzujV3fHlI4usGnK9KW9vXXQCzJaQ7iH3phQ8ueaH1+aWXDCCTr
         fXaCNOZD4bjDAcpqwI8dh1/R/H3w2FGj2kS/kH9yoPae2871pGJWYri+/SSMT7IGi4Dg
         R7h/qacZm+6JTDxty6l4+QETsk5Bc/QmfChakWCbpP4rzOMe5XEhhlt859NH5zGbLnFD
         i0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+5wZZ+PjzxLbMdDOyLUeg2K+18/C67QOv7Ke0t4fjo=;
        b=NkoA/jVpazIHoxS3lH3K57/oq7y4msUyCPds+xKo15diwokuJMbHRaD4Lw7CYjIrOA
         CaeTWxPhLa96HildF1kVUp3EZqkIIR0z683Re4mDhIeIjk30KaM9vB7fXxLo+EQWhS2w
         sVGJylePdsfuawG8uXAkogkJcD052eO4/Hy37Tz2xaeU5cNHRlFeLVSkCbDk/XG6lyvj
         Zw+zr5jjy5CSslzSILgQ9OKqEP90WzSb7+HRYMgksn0XkcZYP89FbZbzieN1EbRBrPEZ
         g7S1kU8T+Y3rN/+m0xvcuuIx6AUh62GBI7YRJ3qhwrTcbGLkeibTS3XwyYXW4EkVrS7h
         f8Bw==
X-Gm-Message-State: APjAAAVz24xDS98s/ITCH/JiG5YVIM1nSxXK63Z/i5Spg9MzSjPktmCN
        ZCjbYgcFJcmd995/uq9wEaQ=
X-Google-Smtp-Source: APXvYqyQOz4GE04QEJRvj1rFGw3Ov1Ojp0YBda/lPfJEn4/0zVf45bsahr1XdFJxFxOoFLMdZTyGcw==
X-Received: by 2002:a62:82cd:: with SMTP id w196mr25694834pfd.156.1572340612500;
        Tue, 29 Oct 2019 02:16:52 -0700 (PDT)
Received: from localhost.localdomain ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id g18sm9910556pfh.51.2019.10.29.02.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 02:16:51 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, dan.carpenter@oracle.com,
        michael.scheiderer@fau.de, fabian.krueger@fau.de,
        chandra627@gmail.com, simon@nikanor.nu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] staging: KPC2000: kpc2000_spi.c: Fix style issues (alignment)
Date:   Tue, 29 Oct 2019 02:16:37 -0700
Message-Id: <20191029091638.16101-3-chandra627@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191029091638.16101-1-chandra627@gmail.com>
References: <20191029091638.16101-1-chandra627@gmail.com>
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
 drivers/staging/kpc2000/kpc2000_spi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 929136cdc3e1..24de8d63f504 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -313,19 +313,19 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 		if (transfer->speed_hz > KP_SPI_CLK ||
 		    (len && !(rx_buf || tx_buf))) {
 			dev_dbg(kpspi->dev, "  transfer: %d Hz, %d %s%s, %d bpw\n",
-					transfer->speed_hz,
-					len,
-					tx_buf ? "tx" : "",
-					rx_buf ? "rx" : "",
-					transfer->bits_per_word);
+				transfer->speed_hz,
+				len,
+				tx_buf ? "tx" : "",
+				rx_buf ? "rx" : "",
+				transfer->bits_per_word);
 			dev_dbg(kpspi->dev, "  transfer -EINVAL\n");
 			return -EINVAL;
 		}
 		if (transfer->speed_hz &&
 		    transfer->speed_hz < (KP_SPI_CLK >> 15)) {
 			dev_dbg(kpspi->dev, "speed_hz %d below minimum %d Hz\n",
-					transfer->speed_hz,
-					KP_SPI_CLK >> 15);
+				transfer->speed_hz,
+				KP_SPI_CLK >> 15);
 			dev_dbg(kpspi->dev, "  speed_hz -EINVAL\n");
 			return -EINVAL;
 		}
-- 
2.20.1

