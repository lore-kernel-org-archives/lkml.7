Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83342C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564EC2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TV+xdT09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfH3EdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 00:33:23 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33732 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfH3EdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 00:33:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id go14so2725817plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 21:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KklhaOrcJjumUOcMoajjDCuKO1cn0WIKBTfo3oVxm7U=;
        b=TV+xdT09IOmtbG2hmZwo+q6JqoJtHVEdeKhgG4HQ4X/3cu6L+wYMCA2IiQmiJETnIP
         kO3JKDv4I8yC50ikVI1dRbHa165dBQLFumdF3OPjd/72iA/CHRrfEEEn6XuIDgi1Ux0q
         SVSVCNK3b03oS1A/2ORZ+E8NQpQUkUS1gELg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KklhaOrcJjumUOcMoajjDCuKO1cn0WIKBTfo3oVxm7U=;
        b=o1+2JWWvi2P8dtEei4/snRs0rSyNF9PWIoD7HliuO4htDwrPB7mqAe4uXVJd1CbuXx
         YpMcXEzdJvqPgB2gdxK/77DWSkVUU/fXjBwrEqmV8HgPFRKmGWGaWywWy5W68Bnpuyg6
         w9dHZBC5RqL5JqjxHDaErxKRmddiY8HuO+2m73VzTV6AqQzBnw/3Mq2WqRUBR0J+tVgh
         uzy5dwM5FIzshTLvS3SNxaYFX/5FcQEFYrh6weWG1/sSO8NM7M6GNhcz4+spmKOwD7K+
         uFrkgWDa1i2YtdxVWorz1mVuYqSONNw71cXZtslW9xVI6znETsFWIagRctsEL6ICbWSK
         AW5g==
X-Gm-Message-State: APjAAAWQ+XjUM2ULQj7EFSl1XXGRW/ENJUREMmawCOUBa7zI9Z4hp1JO
        YiAkUPVnYqLGDLAAaS+VZQrzhQ==
X-Google-Smtp-Source: APXvYqymW9vh3nPRzh8A/jrCiyA0Q3efc0k3mPI7rCtKnhANQGoF3EGZTwupRFVwNyETHVslldm7MQ==
X-Received: by 2002:a17:902:6a82:: with SMTP id n2mr13024583plk.53.1567139601347;
        Thu, 29 Aug 2019 21:33:21 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id ev3sm17753974pjb.3.2019.08.29.21.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Aug 2019 21:33:19 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH V3 1/1] spi: bcm-qspi: Make BSPI default mode
Date:   Fri, 30 Aug 2019 09:58:45 +0530
Message-Id: <1567139325-7912-1-git-send-email-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spi-nor controller defaults to BSPI mode, hence switch back
to its default mode after MSPI operations (write or erase)
are completed.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
changes from V2:
 - Address code review comment from Mark Brown about changelog.

Changes from V1:
 - Address code review comment from Mark Brown.

 drivers/spi/spi-bcm-qspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 902bdbf..46a811a 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -897,6 +897,7 @@ static int bcm_qspi_transfer_one(struct spi_master *master,
 
 		read_from_hw(qspi, slots);
 	}
+	bcm_qspi_enable_bspi(qspi);
 
 	return 0;
 }
-- 
1.9.1

