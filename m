Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5093EC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25470208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fau.de header.i=@fau.de header.b="kg3DYwAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfFZHfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:35:45 -0400
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:53095 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbfFZHfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:35:44 -0400
Received: from mx-exchlnx-3.rrze.uni-erlangen.de (mx-exchlnx-3.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::39])
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTP id 45YZZQ6r9Vz1yxy;
        Wed, 26 Jun 2019 09:35:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1561534542; bh=gp6Tguj4g2VW5LhH/dMc4rjnnkBx6aSvu3nTG+WqRsU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=kg3DYwAwifl4yXQA74DEw0vh448m38TK1+tmAg5FuLoQh3gHtidYD59WMBR1fWFvh
         mcgmSPREMcQXaiYKa7FU5vuhT7CHUAd5UEEZd7d5Ky7QVU/v7/knKtZwHMchnmjlUG
         GOxBw07iqqXnSFUsbA2Yosjh+09le53ixh1lHQpR2R05Zq6qCmdLvDE3xBNhVa5PyO
         GAzLcZjlh5wAa3/FrdAy9dJjCIFo1Dg72FG2dzMxoudvMd542jb8chIqHMprGN0wpd
         JBQ7bktbtocUdZY6mdksZX1b3qamiVErAqfVODKgrP3FL2JB8vOvpLx8JAes16BhR8
         uSCxx0zaqmgIg==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
Received: from hbt1.exch.fau.de (hbt1.exch.fau.de [10.15.8.13])
        by mx-exchlnx-3.rrze.uni-erlangen.de (Postfix) with ESMTP id 45YZZN51vcz1yyQ;
        Wed, 26 Jun 2019 09:35:40 +0200 (CEST)
Received: from MBX3.exch.uni-erlangen.de (10.15.8.45) by hbt1.exch.fau.de
 (10.15.8.13) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Jun 2019
 09:35:26 +0200
Received: from TroubleWorld.fritz.box (95.90.221.207) by
 MBX3.exch.uni-erlangen.de (10.15.8.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Wed, 26 Jun 2019 09:35:25 +0200
From:   Fabian Krueger <fabian.krueger@fau.de>
CC:     <fabian.krueger@fau.de>,
        Michael Scheiderer <michael.scheiderer@fau.de>,
        <linux-kernel@i4.cs.fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/8] staging: kpc2000: introduce usage of __packed
Date:   Wed, 26 Jun 2019 09:35:21 +0200
Message-ID: <20190626073531.8946-4-fabian.krueger@fau.de>
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

Replaced __attribute__((packed)) with __packed. Both ways of attributing
are equivalent, but being shorter, __packed should be preferred.
This refactoring makes the core more readable.

Signed-off-by: Fabian Krueger <fabian.krueger@fau.de>
Signed-off-by: Michael Scheiderer <michael.scheiderer@fau.de>
Cc: <linux-kernel@i4.cs.fau.de>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index c8fdb7e868f8..42d32de2230e 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -114,7 +114,7 @@ struct kp_spi_controller_state {
 
 union kp_spi_config {
 	/* use this to access individual elements */
-	struct __attribute__((packed)) spi_config_bitfield {
+	struct __packed spi_config_bitfield {
 		unsigned int pha       : 1; /* spim_clk Phase      */
 		unsigned int pol       : 1; /* spim_clk Polarity   */
 		unsigned int epol      : 1; /* spim_csx Polarity   */
@@ -133,7 +133,7 @@ union kp_spi_config {
 };
 
 union kp_spi_status {
-	struct __attribute__((packed)) spi_status_bitfield {
+	struct __packed spi_status_bitfield {
 		unsigned int rx    :  1; /* Rx Status       */
 		unsigned int tx    :  1; /* Tx Status       */
 		unsigned int eo    :  1; /* End of Transfer */
@@ -148,7 +148,7 @@ union kp_spi_status {
 };
 
 union kp_spi_ffctrl {
-	struct __attribute__((packed)) spi_ffctrl_bitfield {
+	struct __packed spi_ffctrl_bitfield {
 		unsigned int ffstart :  1; /* FIFO Start */
 		unsigned int         : 31;
 	} bitfield;
-- 
2.17.1

