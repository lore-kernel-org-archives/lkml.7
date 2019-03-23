Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E6FC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5253E218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="COJxgHDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfCWDYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 23:24:30 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:49290 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfCWDY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 23:24:29 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 362EABC0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 03:24:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZBf__zmFfDqf for <linux-kernel@vger.kernel.org>;
        Fri, 22 Mar 2019 22:24:28 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id EC336992
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 22:24:27 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id q184so3687578itd.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 20:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v6X34qxWQckvLPk6rymloIf7kEi5ux17Mascwad/QGU=;
        b=COJxgHDF7+4sszqGNLAJeToigqDJ6iOVrC2EdFZPiIxut9VPd30ilhQB6K5dLyb0eg
         uNHK6wPxF5Rjif7SAhhVi4N3PxgTNKm6jmT5XgrEI+qkPeLo6WGPrbJQP5Cmo+iSRVBm
         zkPP604+oNit+tIeDnaofsjY9pk6bXO6Gvr9ojWqeViRIgtWYZJB1nbd+kH+ULxep/OH
         N+jSXIutRVvWbxEoIXB60sWf3zzw4NrtNPgbAhR3HyzPJPVykFFzJ3m+teYds3tCqnue
         yyAW3rYRwkabsopvU2V6hUvU9cPzK1y4IrCSCBJ2JtLOtEPjl4pu577oIR+xjdbk0Aka
         woJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v6X34qxWQckvLPk6rymloIf7kEi5ux17Mascwad/QGU=;
        b=P/+S3VjfrB3oNpg0UpMv3urVw4MVON0Aq2+1tXIg56x96qOyV1OUTm02+32MzKlQXI
         PqBangCAGB2UQSTRViUFgrlT1FtqHncLmoWJy1zlTDkW+cCt5UMR4/1k3szyvrKfvM4d
         /hJN//I0eY2qx2NorpElTc104YV/R/KC6DqV4rqP+WMqe4hIUnizJTFEeocSfc7DWaD2
         1dm0GFiZ1H4gTSeNt0rLILuZmX5YAYr3gVodXjyTo4PioY5iYjoWtRHUaHNehp1CoclL
         lePUJEE3O4bEP5tXIZOUqOvZisDA3+ABQaamzsgAO+yCMRqYg6OPoYveIdZoNxI+CR2t
         A3HQ==
X-Gm-Message-State: APjAAAVgDJzkBgUq6VXWMEFO5e1FYK/w0mWig0fRAAKqxg9OE3L9/YLb
        sK7ef8NAUl3EYPZ4x1ajlK0J1icpkNY+oaaQx+GFm8oCLt1Kq3kRSWJQDQwCWTFoBy/EZl4DtG3
        74GPzK9HkEexcSsEPzG/0mL2vQImo
X-Received: by 2002:a02:9042:: with SMTP id y2mr1379018jaf.113.1553311467606;
        Fri, 22 Mar 2019 20:24:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwfyvGaEzDavLFFr9P3BsB4hbE3XD42J05DCFoM+GpCMHuClSCfMZoxpQZW6EH1hRNn7Hv3/g==
X-Received: by 2002:a02:9042:: with SMTP id y2mr1379013jaf.113.1553311467391;
        Fri, 22 Mar 2019 20:24:27 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id f9sm4086670ioo.24.2019.03.22.20.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 20:24:25 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Ulf Hansson <ulf.hansson@linaro.org>,
        Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v2] net: liquidio: fix NULL pointer dereferences
Date:   Fri, 22 Mar 2019 22:24:19 -0500
Message-Id: <20190323032420.21162-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190311.121710.968693621648443243.davem@davemloft.net>
References: <20190311.121710.968693621648443243.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case octeon_alloc_soft_command fails, the fix reports the
error and goes to cleanup to avoid NULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
V2: goto setup_nic_dev_free for cleanup
---
 drivers/mmc/host/mmc_spi.c                         |  2 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 32fea585262b..a3533935e282 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -820,7 +820,7 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
 
 	status = spi_sync_locked(spi, &host->m);
 	if (status < 0) {
-		dev_dbg(&spi->dev, "read error %02x (%d)\n", status, status);
+		dev_dbg(&spi->dev, "read error %d\n", status);
 		return status;
 	}
 
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index 54b245797d2e..e653072846b0 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -611,6 +611,12 @@ static void send_rx_ctrl_cmd(struct lio *lio, int start_stop)
 	sc = (struct octeon_soft_command *)
 		octeon_alloc_soft_command(oct, OCTNET_CMD_SIZE,
 					  16, 0);
+	if (!sc) {
+		netif_info(lio, rx_err, lio->netdev,
+			   "Failed to allocate octeon_soft_command\n");
+		return;
+	}
+
 
 	ncmd = (union octnet_cmd *)sc->virtdptr;
 
@@ -1960,6 +1966,12 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 		sc = (struct octeon_soft_command *)
 			octeon_alloc_soft_command(octeon_dev, data_size,
 						  resp_size, 0);
+		if (!sc) {
+			dev_err(&octeon_dev->pci_dev->dev,
+				"Failed to allocate octeon_soft_command\n");
+			goto setup_nic_dev_free;
+		}
+
 		resp = (struct liquidio_if_cfg_resp *)sc->virtrptr;
 		vdata = (struct lio_version *)sc->virtdptr;
 
-- 
2.17.1

