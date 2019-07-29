Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676EAC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3A321773
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429608;
	bh=+5NC13wVq7LZOXSnmNaYA6zVq/LnATFKJG7TkWDHLfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tLEtLRtWdZSKFd73gk/c5QcMMT7rWe3IDXOQFvFfgoVKMsQGrxrpysohsgVmLK6Z/
	 /I3GkxRX0fglMM8TxfAeP5gH1lcRnSY3BvG140SjazU2VJM8rnclX5GKgIYqFZsEvw
	 1Tr0iJYWJcRVcfIEPvvy1Hg0TNNhBjnMRfY0xk4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390241AbfG2Tqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389666AbfG2Tqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:46:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2567D205F4;
        Mon, 29 Jul 2019 19:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429603;
        bh=+5NC13wVq7LZOXSnmNaYA6zVq/LnATFKJG7TkWDHLfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ehGv0jiFXNALT3iJPH94a0FearYxxtR7EYTsziI0UpC9oirLJrRPRLqRC9+dkpwsu
         T2MALu8nMId2nw+P5sQ6axS4skl3rDbX5HPq1wPJyGp3BmYyaHeHlRy0D4p9y0S2OR
         EpnCysKYZj6iaCjonP+F9KuvTbUjlJPSikvq93LA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeremy Sowden <jeremy@azazel.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 009/215] staging: kpc2000: added missing clean-up to probe_core_uio.
Date:   Mon, 29 Jul 2019 21:20:05 +0200
Message-Id: <20190729190741.213814791@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit abb611d2c21c0a4fa8eab35dc936c80d9a07acd8 ]

On error, probe_core_uio just returned an error without freeing
resources which had previously been allocated.  Added the missing
clean-up code.

Updated TODO.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/kpc2000/TODO                 | 1 -
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/TODO b/drivers/staging/kpc2000/TODO
index 8c7af29fefae..ed951acc829a 100644
--- a/drivers/staging/kpc2000/TODO
+++ b/drivers/staging/kpc2000/TODO
@@ -1,7 +1,6 @@
 - the kpc_spi driver doesn't seem to let multiple transactions (to different instances of the core) happen in parallel...
 - The kpc_i2c driver is a hot mess, it should probably be cleaned up a ton.  It functions against current hardware though.
 - pcard->card_num in kp2000_pcie_probe() is a global variable and needs atomic / locking / something better.
-- probe_core_uio() probably needs error handling
 - the loop in kp2000_probe_cores() that uses probe_core_uio() also probably needs error handling
 - would be nice if the AIO fileops in kpc_dma could be made to work
     - probably want to add a CONFIG_ option to control compilation of the AIO functions
diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index e0dba91e7fa8..d6b57f550876 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -295,6 +295,7 @@ int  probe_core_uio(unsigned int core_num, struct kp2000_device *pcard, char *na
     kudev->dev = device_create(kpc_uio_class, &pcard->pdev->dev, MKDEV(0,0), kudev, "%s.%d.%d.%d", kudev->uioinfo.name, pcard->card_num, cte.type, kudev->core_num);
     if (IS_ERR(kudev->dev)) {
         dev_err(&pcard->pdev->dev, "probe_core_uio device_create failed!\n");
+        kfree(kudev);
         return -ENODEV;
     }
     dev_set_drvdata(kudev->dev, kudev);
@@ -302,6 +303,8 @@ int  probe_core_uio(unsigned int core_num, struct kp2000_device *pcard, char *na
     rv = uio_register_device(kudev->dev, &kudev->uioinfo);
     if (rv){
         dev_err(&pcard->pdev->dev, "probe_core_uio failed uio_register_device: %d\n", rv);
+        put_device(kudev->dev);
+        kfree(kudev);
         return rv;
     }
     
-- 
2.20.1



