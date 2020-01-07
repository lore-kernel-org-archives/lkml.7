Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B144C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7572080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432280;
	bh=Keft5cNz48ZkxfUyWXWdQD2X5bR09IZdkkQriQJCqzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SypiRWEP8Y9Acu64RjWOHP88UkRqJ1iZ0t7YLqSgJRrROx8++Yq8F2mdH3Zf3Dvm/
	 Y5s8NdHT6JLOXCeFY0JDIPDpREGnFtp+05/n3rlnhDp5kxR5786Fc7beDPWGPBHwTa
	 VyBiHUySYZiLelLCDcG+EMbEAUSlr6ZoPXuh9Hcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgAGVAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:00:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbgAGVAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:00:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FA532081E;
        Tue,  7 Jan 2020 21:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430809;
        bh=Keft5cNz48ZkxfUyWXWdQD2X5bR09IZdkkQriQJCqzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A8iXkoFqePqcJHpO+KJ3yNRmtTQ5F+vNLwjHH8lVKpcp7/dm/t2Osq1CMOfJ8CIW6
         NLX1hADxpZKL3+pOGzOlHqnwCj96+dWLF0iAJwHdjDAHsnjOKhQpUXm2g3BCef+ihG
         OzHH+PiohgmGcss/KKjCyCcY3oQrri2/FucKBHzk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 105/191] ata: libahci_platform: Export again ahci_platform_<en/dis>able_phys()
Date:   Tue,  7 Jan 2020 21:53:45 +0100
Message-Id: <20200107205338.610644493@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

commit 84b032dbfdf1c139cd2b864e43959510646975f8 upstream.

This reverts commit 6bb86fefa086faba7b60bb452300b76a47cde1a5
("libahci_platform: Staticize ahci_platform_<en/dis>able_phys()") we are
going to need ahci_platform_{enable,disable}_phys() in a subsequent
commit for ahci_brcm.c in order to properly control the PHY
initialization order.

Also make sure the function prototypes are declared in
include/linux/ahci_platform.h as a result.

Cc: stable@vger.kernel.org
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libahci_platform.c |    6 ++++--
 include/linux/ahci_platform.h  |    2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -43,7 +43,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_ops);
  * RETURNS:
  * 0 on success otherwise a negative error code
  */
-static int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
+int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
 {
 	int rc, i;
 
@@ -74,6 +74,7 @@ disable_phys:
 	}
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ahci_platform_enable_phys);
 
 /**
  * ahci_platform_disable_phys - Disable PHYs
@@ -81,7 +82,7 @@ disable_phys:
  *
  * This function disables all PHYs found in hpriv->phys.
  */
-static void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
+void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
 {
 	int i;
 
@@ -90,6 +91,7 @@ static void ahci_platform_disable_phys(s
 		phy_exit(hpriv->phys[i]);
 	}
 }
+EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
 
 /**
  * ahci_platform_enable_clks - Enable platform clocks
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -19,6 +19,8 @@ struct ahci_host_priv;
 struct platform_device;
 struct scsi_host_template;
 
+int ahci_platform_enable_phys(struct ahci_host_priv *hpriv);
+void ahci_platform_disable_phys(struct ahci_host_priv *hpriv);
 int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
 void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
 int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv);


