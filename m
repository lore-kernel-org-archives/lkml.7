Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05AFC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6C12086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fau.de header.i=@fau.de header.b="kVphtJm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfFZHhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:37:48 -0400
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:41291 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725797AbfFZHhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:37:47 -0400
Received: from mx-exchlnx-2.rrze.uni-erlangen.de (mx-exchlnx-2.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::38])
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTP id 45YZcp2XXhzPkxq;
        Wed, 26 Jun 2019 09:37:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1561534666; bh=bH4X2CuaDjpodRmVzF7XktQDkJsgyq/GdwVju7mHXLI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=kVphtJm3q0TfRV8j/Cj90JKL3ZT4A+4ZQClujLq2ajz++cNJesb6deeDwSyjT/6Da
         AlU2Phd3tSyQekTY3GOAF/Q7PBSAV6Tz3DGWDkZlfrX8AI9lmsezeZfcCaLeKSYakq
         QcsM43P8BjA6/6Dv1DU3wi22z1jNGNiE+WCmJ12eJhyPyR7YCZOcab22G16eXAkdeD
         1rJMYnAY5MAKNqiudwL1pL57buyFXjQdoX5pW8ufqx7c2dLTHV4gNSo12By54caBNH
         35bMa83M8Il9bvjKg4KDpHAkWpvEHC7fKhvB6au/WiEz+NKB7kzbz86ANgaryuy3vk
         VBIIeE/SOsMyA==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
Received: from hbt1.exch.fau.de (hbt1.exch.fau.de [10.15.8.13])
        by mx-exchlnx-2.rrze.uni-erlangen.de (Postfix) with ESMTP id 45YZcm1LdCzPkDJ;
        Wed, 26 Jun 2019 09:37:44 +0200 (CEST)
Received: from MBX3.exch.uni-erlangen.de (10.15.8.45) by hbt1.exch.fau.de
 (10.15.8.13) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Jun 2019
 09:36:56 +0200
Received: from TroubleWorld.fritz.box (95.90.221.207) by
 MBX3.exch.uni-erlangen.de (10.15.8.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Wed, 26 Jun 2019 09:36:56 +0200
From:   Fabian Krueger <fabian.krueger@fau.de>
CC:     <fabian.krueger@fau.de>,
        Michael Scheiderer <michael.scheiderer@fau.de>,
        <linux-kernel@i4.cs.fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/8] staging: kpc2000: remove needless 'break'
Date:   Wed, 26 Jun 2019 09:35:26 +0200
Message-ID: <20190626073531.8946-9-fabian.krueger@fau.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626073531.8946-1-fabian.krueger@fau.de>
References: <20190625115251.GA28859@kadam>
 <20190626073531.8946-1-fabian.krueger@fau.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.90.221.207]
X-ClientProxiedBy: MBX3.exch.uni-erlangen.de (10.15.8.45) To
 MBX3.exch.uni-erlangen.de (10.15.8.45)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unconditioned jump will prohibit to ever reach the break-statement.
Deleting this needless statement, the code becomes more understandable.

Signed-off-by: Fabian Krueger <fabian.krueger@fau.de>
Signed-off-by: Michael Scheiderer <michael.scheiderer@fau.de>
Cc: <linux-kernel@i4.cs.fau.de>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 55bed617b0d8..1e1e747a0f6c 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -486,7 +486,6 @@ kp_spi_probe(struct platform_device *pldev)
 	default:
 		dev_err(&pldev->dev, "Unknown hardware, cant know what partition table to use!\n");
 		goto free_master;
-		break;
 	}
 
 	return status;
-- 
2.17.1

