Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE12C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2520F20B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YLSHDIxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732520AbfHFKSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:18:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47009 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFKSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:18:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so37659336plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 03:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=B2Az8FZ7ku0X2inJnd7funCGhhLUuh16TDsRGjU7wPY=;
        b=YLSHDIxEYeh158kEGbiXMI86GIByE6ZBeC0wvOq22XFHllvFtRDEVX/D4B2rCKIkpU
         B95CBSqrEOjKGdoZI6typuPUN1FG/78x+D6pL8LNHFsHe0YSQYZwO+nNZiMOca5i3WsF
         HH1Csge+AVd6PV0yT31mCQliC59Y77ttlGxFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B2Az8FZ7ku0X2inJnd7funCGhhLUuh16TDsRGjU7wPY=;
        b=gbq0jjWeWjW015xJBbWaC6GQcn3b93abRo6Fm1A2XvIJsWNnzj/lxWfkUWrvhr6wvq
         9jaukn9EL/n2Cs8cgt1Nzt3eXL3zYC+eYhjkqKEa2GLytwUqma0el14PC3c1JGW4s3im
         ZfrWdoJg4EKL08gdayq3yfs4EUDfJFA87vnOovKWasQ1QVvZw39W7565RIwizbDsMb0c
         LCIyUAC08/6arOxLDCC3JmVatNugFRnAKNJ5S5elb2ndCOoxZeoGt94Yod/ym4MUkJ6+
         /QjO/uyIvVZKnP9yQEZBLI4qu7I46kDkxhRWApCWZS2+Xygr8xSF6IwkIK4SgBPmSL4W
         dWHQ==
X-Gm-Message-State: APjAAAWFK7lwHeraBnmboW2m0GszYAVXNPcEK6vrdg3vRLHPnQrAqlT5
        cZKMGQwkjfjO4TvF+V2P7TQGtA==
X-Google-Smtp-Source: APXvYqxyS1wEbeR/Ana/G2s2t8MN3btZM/Gabob2KwSWhuZCr75sQgO/4yYcxz0amLEeqYPRTivpyQ==
X-Received: by 2002:a17:902:12d:: with SMTP id 42mr2319319plb.187.1565086712671;
        Tue, 06 Aug 2019 03:18:32 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y23sm90516588pfo.106.2019.08.06.03.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Aug 2019 03:18:31 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] spi: bcm-qspi: Make BSPI default mode
Date:   Tue,  6 Aug 2019 15:44:34 +0530
Message-Id: <1565086474-4461-1-git-send-email-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch back to BSPI mode after MSPI operations (write and erase)
are completed. This change will keep qpsi in BSPI mode by default.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
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

