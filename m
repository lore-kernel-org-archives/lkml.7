Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DC0C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950B720B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h1JRpI0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfFZK2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:28:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41078 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfFZK2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:28:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so2083834wrm.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 03:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p/mgZFZvtz5MXeK97S6RAma7XXrIP4D9tjHX9nEHACY=;
        b=h1JRpI0JBRfQ+DluKeXamJpk4K1xEhaXO9qNejSpmI2TPx6pE6d0M/X0rx6rND0y5j
         QkCOjv+8SKTcJSBjx6qzWuyqzQWVDccPIQvjSmth3U45tdO5j9nV7qah3hOY8LrqGTIz
         CyZaCFdvCuKCUyIhaUgxSnW2QdZx42O5Cf59ZrNQlCgFBc2v0cOacMc4UmJFCxyoUDNf
         pNcS/G4MaJg3r/sRiC2fI2Ul+RQ2HzXudlA+TT62lbeltM4+rM3i3HGhLJlN5jdWEovs
         +tSmZUlUczr64N34sWFPtmpR5Vb1DwuIwzNnL+I1NEqcNEwM8WxU+rf2qxJInvbGmoZ6
         MF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p/mgZFZvtz5MXeK97S6RAma7XXrIP4D9tjHX9nEHACY=;
        b=KNsVHDQeZIsd/HAw69LcLzo7WTpcVFFPGY5WUjbYjJI8KuyTamMgoLObECl8BWIbuz
         QXcG5Ouswkr59/jZ9RrrAS24neQwmOhG9O8pPr7MNofHnPSUDFkWEyc+1lB+kzxe5GKI
         L8dogKaAsmAtfNLX4jEkmnVF7AYdNymOKwgLbuJx/ebRXq0hKdmOqLR7MsyHiwDhETH6
         3nHU+/cMZovCq5ehi0HHkH5/MiM09wDY208oJASZ3XDca8qn7WAvRW+JikCI2CIO1m0j
         3JSlAnpyBM62SuleLMI28OUGLejenjZUg8NcO96EFsbWnxA1LLaQupx5l/m1MF4i+IMO
         jd8w==
X-Gm-Message-State: APjAAAXtShpQ2DgiBN++QWAnjYe6r5sfMhlBoyepXlvVUKLSr0s36K77
        UTM3hMSTq1DN4PMlfejYHH5LfQ==
X-Google-Smtp-Source: APXvYqyd0lrlxYf8LbmV4gTNQrlvndp90tSEhm81oxft/RmyBefcCA8J5bLEeYx7Gg53Kc04x6nMhw==
X-Received: by 2002:adf:e40f:: with SMTP id g15mr2944999wrm.174.1561544881765;
        Wed, 26 Jun 2019 03:28:01 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z19sm2212042wmi.7.2019.06.26.03.28.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 03:28:01 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/6] nvmem: imx-ocotp: Elongate OCOTP_CTRL ADDR field to eight bits
Date:   Wed, 26 Jun 2019 11:27:28 +0100
Message-Id: <20190626102733.11708-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626102733.11708-1-srinivas.kandagatla@linaro.org>
References: <20190626102733.11708-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Donoghue <pure.logic@nexus-software.ie>

i.MX6 defines OCOTP_CTRLn:ADDR as seven bit address-field with a one bit
RSVD0 field, i.MX7 defines OCOTP_CTRLn:ADDR as a four bit address-field
with a four bit RSVD0 field.

i.MX8 defines the OCOTP_CTRLn:ADDR bit-field as a full range eight bits.

i.MX6 and i.MX7 should return zero for their respective RSVD0 bits and
ignore a write-back of zero where i.MX8 will make use of the full range.

This patch expands the bit-field definition for all users to eight bits,
which is safe due to RSVD0 being a no-op for the i.MX6 and i.MX7.

Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index bd016b928589..14c2bff2cd96 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -39,7 +39,7 @@
 #define IMX_OCOTP_ADDR_DATA2		0x0040
 #define IMX_OCOTP_ADDR_DATA3		0x0050
 
-#define IMX_OCOTP_BM_CTRL_ADDR		0x0000007F
+#define IMX_OCOTP_BM_CTRL_ADDR		0x000000FF
 #define IMX_OCOTP_BM_CTRL_BUSY		0x00000100
 #define IMX_OCOTP_BM_CTRL_ERROR		0x00000200
 #define IMX_OCOTP_BM_CTRL_REL_SHADOWS	0x00000400
-- 
2.21.0

