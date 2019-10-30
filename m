Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D92CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BABE217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572451156;
	bh=UXs6zSj+eLEnOLZq+4WUzH3BveT4SgoNgiOc6NkYYRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AA/fKLdx2o0Cq2JKDT1p+aJs94ZSCL/9itnjrAe5DwJk2lcPNqnJxLOerssOYTWjE
	 osY1uTvEzPwKiTlsKwrzI2PvU5sKlKnSFosYHwWWiKsJaNH7E93G1QLDIuEnBYWgMY
	 Wzd6TOmqkLmDthG2cBTgnkymrHCPvp8ErlR7DTXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfJ3P7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbfJ3P5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:57:32 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E8CC2173E;
        Wed, 30 Oct 2019 15:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572451051;
        bh=UXs6zSj+eLEnOLZq+4WUzH3BveT4SgoNgiOc6NkYYRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bh3TNMf4tZR/wpyrdzXlIOkabAxAbjVDCfzN70e208Wz20O4ucOE+wE6uEcUciDjO
         Ea3IFkJQuuRi2NR5ny7XGZ0UjSzVG6HJ3sljUL9uCZ5QRnzAmo5RvesygUtnp6sO2+
         bIvBvJwCNxQUvPNusboJu+jxnA3nkpZx6PR0mv5g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        legousb-devel@lists.sourceforge.net, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 12/18] USB: legousbtower: fix a signedness bug in tower_probe()
Date:   Wed, 30 Oct 2019 11:56:54 -0400
Message-Id: <20191030155700.10748-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030155700.10748-1-sashal@kernel.org>
References: <20191030155700.10748-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit fd47a417e75e2506eb3672ae569b1c87e3774155 ]

The problem is that sizeof() is unsigned long so negative error codes
are type promoted to high positive values and the condition becomes
false.

Fixes: 1d427be4a39d ("USB: legousbtower: fix slab info leak at probe")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191011141115.GA4521@mwanda
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/misc/legousbtower.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/legousbtower.c b/drivers/usb/misc/legousbtower.c
index f56307059d48c..7cac3ee09b09d 100644
--- a/drivers/usb/misc/legousbtower.c
+++ b/drivers/usb/misc/legousbtower.c
@@ -898,7 +898,7 @@ static int tower_probe (struct usb_interface *interface, const struct usb_device
 				  get_version_reply,
 				  sizeof(*get_version_reply),
 				  1000);
-	if (result < sizeof(*get_version_reply)) {
+	if (result != sizeof(*get_version_reply)) {
 		if (result >= 0)
 			result = -EIO;
 		dev_err(idev, "get version request failed: %d\n", result);
-- 
2.20.1

