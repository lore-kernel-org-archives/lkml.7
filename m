Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D89C282CE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A9020848
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9JKg/oN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfFEBKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 21:10:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39470 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfFEBKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 21:10:09 -0400
Received: by mail-qk1-f193.google.com with SMTP id i125so4146407qkd.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 18:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uYuZk3WfkaKX49xvAd+SIaFxKGOozQxDXCkeJBh9dxI=;
        b=g9JKg/oNEjc8gCZny9L+JKTZ8IXlkOb51oA5UCsAk79uHj9HxL0oJj2T093uVL7U3W
         tZaNJOL1EEnXV4E8dyhLzfNhkFSjmBojQG3rfhszbSwx9mFqXkbAjQBh+j4MewBbn8HD
         VbMUwl99PQ/FRT6A/sMFPO9v6vzSKa2DEDi1bHidQjB2cRAgQE9yvrMtx0BIkYBsm796
         vD9qFJ3339QGhxRMCDVCLQYo0AEIljJOqawv29YvvpQMeSIZdDvW2uWPNcJLT01MZduy
         Tw+3DH+cPK5FlS8H4d9VovuS9XKhN1vAjbL9yTiTiGRduStKYceXbbvXqciOqY8LWyEG
         d7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYuZk3WfkaKX49xvAd+SIaFxKGOozQxDXCkeJBh9dxI=;
        b=QEDnZijeciCGX8j2bx2uZc6elBwcMq95IRWA5C61RObz6BtzDrg/FsRdtb1fITf7ka
         LCubVwksMbdmVr3v4vJ1Pdj1Cc1aTdCdho0DA/THB4suZHTOSBp3RxnSUkXk5CVw7w07
         fdFCYXhTxBxayJLiYRiWLLFnZh6e1Esy+oQSVxxljWZULXzEzaxgPRhT8yh7MIhDVq5z
         tB1AUed/kAMMzzIHIH7ARujLEy2cki3RtIZjEmuvZ4vy8c+bYq84ONvgz6Eg3TJZrDD8
         j2PPMlZm0KlTXJge6loVk1VOmxWM8397QYhZVN99Q517iZWPHRbp0fvsyP7b6OnqZ6EY
         qQeg==
X-Gm-Message-State: APjAAAX9J8pIOgjvunxY15hB2VPu/MEn2/WNWdtB59cL1ayBKjEhE/gX
        gNhaLj11EdXHZ7optHeWP58=
X-Google-Smtp-Source: APXvYqxaaBOsP/tJ5p9FEY7HcHhhanA8z99jbfvf4pfydxtj/y3fVkTaELzh94+xa25rVwaoUK5JMA==
X-Received: by 2002:ae9:f20c:: with SMTP id m12mr29856938qkg.58.1559697008489;
        Tue, 04 Jun 2019 18:10:08 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id v41sm7169401qta.78.2019.06.04.18.10.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 18:10:08 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Geordan Neukum <gneukum1@gmail.com>,
        Mao Wenan <maowenan@huawei.com>,
        Jeremy Sowden <jeremy@azazel.net>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] staging: kpc2000: kpc_spi: remove unnecessary struct member chip_select
Date:   Wed,  5 Jun 2019 01:09:11 +0000
Message-Id: <1980fe831f6444a6bf47928bdc9e09c8fe3b6da1.1559696611.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559696611.git.gneukum1@gmail.com>
References: <cover.1559696611.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure kp_spi_controller_state, defined in the kpc2000_spi
driver, contains a member named chip_select which is never used after
initialization. Therefore, it should be removed for simplicity's sake.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 61296335313b..07b0327d8bef 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -109,7 +109,6 @@ struct kp_spi {
 
 struct kp_spi_controller_state {
 	void __iomem   *base;
-	unsigned char   chip_select;
 	s64             conf_cache;
 };
 
@@ -267,7 +266,6 @@ kp_spi_setup(struct spi_device *spidev)
 			return -ENOMEM;
 		}
 		cs->base = kpspi->base;
-		cs->chip_select = spidev->chip_select;
 		cs->conf_cache = -1;
 		spidev->controller_state = cs;
 	}
-- 
2.21.0

