Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01EAC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D7E2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P9G6y5o0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfHLWgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:36:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35063 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfHLWg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:36:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id u14so50442195pfn.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 15:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ARqGVqps+UvD6gPycAavcJDE2CdT6bD5OYORFnIVyA4=;
        b=P9G6y5o0oRHI87G+Axh3H0Q0lFVxG69Ev11gPscknQxS++hpSgrVr+Dz6m6gko17ad
         ndY5JECMTxJve5nKky69rtBFiunmAm0EkOnERFYVcbyhmyFZL20WXAzpaT5zaevxqmZh
         ICi/9Scec6pPJIaFjZ4EY496D2VMLbQFWuVF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ARqGVqps+UvD6gPycAavcJDE2CdT6bD5OYORFnIVyA4=;
        b=bF+v2lm8WoMi/mOcY0d0bZ2Hu3L2/8ri2GtG9sTnEVzxMimtlFoE1Gmo+8XMedvcGq
         ifb0NOlr+NTncieUJ4gRt3PHiRhQ9wiTfbSyvlrrORsGPQ1LYHu4GWsfJhSa6GhoikBc
         ec01yBj73IcSmCqebU5Ony/v/pbTElzt90PZDgimahdJNrZd1+o151y8Rmq40cLEC3xu
         6Z2m1FJBDbxdP6ElEzLdlRoSQMwU1kzbQEgBCPRKXlTPQYFihwgcEX9CHn2PdnFR0qLY
         4t8/D9Qe3XqNOtxYLeYnRJzuT9fuOsD5gP08PVpdkpjkCkpbJ2mEmDdPKcd6OM1Aru3P
         qL9w==
X-Gm-Message-State: APjAAAUMuLzl6YOSUohkqvjH5jkyBIjz0NuEJ7iAqoEOwjYQk7lJLETe
        dToJU1S7R2r9sc/HZ9XpBeFXfg==
X-Google-Smtp-Source: APXvYqzUWfHrQolgxy4D/V0dl/A2RBuv86RieLCSdSWbN9BhIfnP3A1Tjww9sDQhKmaZIUj7PkFxRQ==
X-Received: by 2002:a62:db43:: with SMTP id f64mr21707438pfg.38.1565649387079;
        Mon, 12 Aug 2019 15:36:27 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b6sm93911594pgq.26.2019.08.12.15.36.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 15:36:26 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH v4 3/6] tpm: tpm_tis_spi: Add a pre-transfer callback
Date:   Mon, 12 Aug 2019 15:36:19 -0700
Message-Id: <20190812223622.73297-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190812223622.73297-1-swboyd@chromium.org>
References: <20190812223622.73297-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cr50 firmware has a requirement to wait for the TPM to wakeup before
sending commands over the SPI bus. Otherwise, the firmware could be in
deep sleep and not respond. Add a hook to tpm_tis_spi_transfer() before
we start a SPI transfer so we can keep track of the last time the TPM
driver accessed the SPI bus.

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Duncan Laurie <dlaurie@chromium.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/char/tpm/tpm_tis_spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index 819602e85b34..93f49b1941f0 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -44,6 +44,7 @@ struct tpm_tis_spi_phy {
 	struct spi_device *spi_device;
 	int (*flow_control)(struct tpm_tis_spi_phy *phy,
 			    struct spi_transfer *xfer);
+	void (*pre_transfer)(struct tpm_tis_spi_phy *phy);
 	u8 *iobuf;
 };
 
@@ -129,6 +130,8 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 
 		spi_message_init(&m);
 		spi_message_add_tail(&spi_xfer, &m);
+		if (phy->pre_transfer)
+			phy->pre_transfer(phy);
 		ret = spi_sync_locked(phy->spi_device, &m);
 		if (ret < 0)
 			goto exit;
-- 
Sent by a computer through tubes

