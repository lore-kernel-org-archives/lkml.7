Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619B7C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F6E20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tIP3gvod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfFZK2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:28:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43946 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfFZK2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:28:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so2071295wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 03:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YlUbQ+VAs6rWA6NRDoG6hvS1TSsas8Yc/9cAu2pyMdM=;
        b=tIP3gvod44Al3x47FF+xsWez/VYa6b2gxC0T7uJxplv8LEGvSgo6R3SDZz492YQ/+/
         +VovSEh7PJA08ySm+1GfbAQ7HwhQZtiw0BZvRCJLEyLY04OMJybeD+9qINWfh6bVzcnP
         eEk+ZAJz45tZC9S6V/quFPVTZ68gZspxFQ308vbbm+nRqr2CFveIxzGqVgnGTTi9VsEc
         J0p9ZnXcLVwOu5s8bAHyS0UxeS3p6cxct4AbJVM33Tat75A44rCL1B990eE9CR6Z0QZA
         V4VO77aUOjFct0GPFtCcmxZspZhj7MzGSaKkIrvUENsUU9uCCos4vCg6lQCN3VIxteqp
         JP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YlUbQ+VAs6rWA6NRDoG6hvS1TSsas8Yc/9cAu2pyMdM=;
        b=ZWj+6qv/O8cHDmdid1eLLuGYF6bqPSxGiu5xjdsJkAajAu9VlOO7PImfD0XPfkV7mz
         ENC3A6Ek3wnHMfQhOjpL1KEsWb/TF7+O8VsApaHI2hyPO/KR8QpcT4ukG4eBsQeh1jaI
         8AeUg1HW1Tj5BzDxSsdglPVdiCkH2qafDejsXo2e7XTU/dgSmFvftNSeknaZzknieT87
         a/crnNVmRY1jsLuGwA8qcgYYYxVEb1a/hU9dXvKZ6UZGc7kBMNAHI0s1muLzga6KSyy3
         ES554DRqsdOnz7hNTqY7X3PdHjVco8dPaKO29AwtzHXhrZ6VION5Twp6B5bmHlTD4dgy
         nUow==
X-Gm-Message-State: APjAAAWm9UKibwIbxofz4/W5FQXOefJVj7E/pWWKxHiRzxhrqNr3huo5
        eZJbRThGbUwYEadP1xoVG+mj/0da98M=
X-Google-Smtp-Source: APXvYqy0iyUV36QbnoqJrZK1ZkJorcCWzYgIAwzSda5IW0mN5/HZ983Vaul2yo84oimlD+IzcatT1w==
X-Received: by 2002:a5d:430c:: with SMTP id h12mr3100824wrq.163.1561544886476;
        Wed, 26 Jun 2019 03:28:06 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z19sm2212042wmi.7.2019.06.26.03.28.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 03:28:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/6] nvmem: imx-ocotp: imx8mq is compatible with imx6 not imx7
Date:   Wed, 26 Jun 2019 11:27:33 +0100
Message-Id: <20190626102733.11708-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626102733.11708-1-srinivas.kandagatla@linaro.org>
References: <20190626102733.11708-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

According to NXP Reference Manuals and uboot/atf sources the OCOTP block
on imx8m behaves more like imx6 than imx7.

- Fuses can be read/written 32bits at a time (no imx7-like banking)
- The OCOTP_HW_OCOTP_TIMING register is like imx6 not imx7

Since nvmem doesn't support uboot-style "sense" and "override" this
issue only affected "write" which is very rarely used.

Fixes: 163c0dbd0cb1 ("nvmem: imx-ocotp: add support for imx8mq")
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 340ab336f987..42d4451e7d67 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -469,8 +469,8 @@ static const struct ocotp_params imx7ulp_params = {
 
 static const struct ocotp_params imx8mq_params = {
 	.nregs = 256,
-	.bank_address_words = 4,
-	.set_timing = imx_ocotp_set_imx7_timing,
+	.bank_address_words = 0,
+	.set_timing = imx_ocotp_set_imx6_timing,
 };
 
 static const struct ocotp_params imx8mm_params = {
-- 
2.21.0

