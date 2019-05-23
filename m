Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B33C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB4621019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="YX2nFP1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbfEWMwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:52:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36454 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730878AbfEWMvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:51:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id z1so5357647ljb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 05:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vGQS4M0GPNHznQS2lsbs87t2GSHBkkows3KhdrMM+/0=;
        b=YX2nFP1S98XkOe4dzmtQv40gXL3+FkuOQj+bAhW2T7iaA6Ldf6brMJVN8LEOcpqlLO
         rJ4rCNt/WDGJPSR6Y8tZ3F5DfcoqC1/rUHXRcGP6jmmuBMQoEX9OdeJ1kOYEFf9wICa1
         QoY2Xc+L0I0gP04cDnAkA/KTUn/4m1BBqlxrsJPpQxwq/jQ3E/a+wjJa2Hz0NNz+MPEv
         /imYbQnKyEBg54nNuOMUWgliSIsbnsXNRIcaeN+UXCcnA27W2taYxyXgGvu1qpyALFhj
         BHcHbtBBtKwjQ4530rhz7mhEdwUDPyPl6wYKHstXtnngaRMjl6G5Zp89ix+frqdF1d9u
         aTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vGQS4M0GPNHznQS2lsbs87t2GSHBkkows3KhdrMM+/0=;
        b=VKDhqLZ2KgA03namXLHDNjpY3WiHI0+1rWDEkr71e3EU28bXZcCuul56LwxzRXW/0h
         CjIBFszFME/AqpdxOb8gPDhMHWGBI9bZMcyv1KiveqyS02Y/6DTrkLlIqWCYOLXot6cz
         kccOhp3NR5UjgPkF9QlYRmhRX8UbQ40Vh3n6risa3CFL3HZ4HsS8zBbE1jQH6YW8MAQ1
         L1LBFB69mUCDnKwTurHxKwdx+EubTvrY4W2b24XG48yd8BOOQIQ4P+7yPdqISzEy7Ese
         PoxzEflCTznKrKVGvPRfr5qTdy/AqYsyk6h8oPh3wPhXKgiM6ZK+yFI3/MhEblEkF/h4
         E88g==
X-Gm-Message-State: APjAAAU0jdpzKtXFfHCtswTMhcVe9ZWKt09ab1wVimFSPih2u1Abh+D9
        DU/1NRn4Wlb+zfAXBJ05VgEoDYaoSh6EFg==
X-Google-Smtp-Source: APXvYqytmvQHDdy/WQuWvI8+ZKRI5lnE9GgsvaGTz8l5yBVNdt411zwhco/I+VfZia5nnOPDq4Pk9A==
X-Received: by 2002:a2e:9cd1:: with SMTP id g17mr8738574ljj.191.1558615912139;
        Thu, 23 May 2019 05:51:52 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id c19sm5947154lfi.69.2019.05.23.05.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:51:51 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] staging: kpc2000: use kzalloc(sizeof(var)...) in cell_probe.c
Date:   Thu, 23 May 2019 14:51:40 +0200
Message-Id: <20190523125143.32511-7-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523125143.32511-1-simon@nikanor.nu>
References: <20190523125143.32511-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warning "Prefer kzalloc(sizeof(*kudev)...) over
kzalloc(sizeof(struct kpc_uio_device)...)"

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index f8d19e693f21..caf48256aa2e 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -292,7 +292,7 @@ static int probe_core_uio(unsigned int core_num, struct kp2000_device *pcard,
 
 	dev_dbg(&pcard->pdev->dev, "Found UIO core:   type = %02d  dma = %02x / %02x  offset = 0x%x  length = 0x%x (%d regs)\n", cte.type, KPC_OLD_S2C_DMA_CH_NUM(cte), KPC_OLD_C2S_DMA_CH_NUM(cte), cte.offset, cte.length, cte.length / 8);
 
-	kudev = kzalloc(sizeof(struct kpc_uio_device), GFP_KERNEL);
+	kudev = kzalloc(sizeof(*kudev), GFP_KERNEL);
 	if (!kudev) {
 		dev_err(&pcard->pdev->dev, "probe_core_uio: failed to kzalloc kpc_uio_device\n");
 		return -ENOMEM;
-- 
2.20.1

