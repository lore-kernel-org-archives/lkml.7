Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB9FC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DDB215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fau.de header.i=@fau.de header.b="W7HIqLrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbfFYLgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:36:50 -0400
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:54013 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731068AbfFYLgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:36:48 -0400
Received: from mx-exchlnx-3.rrze.uni-erlangen.de (mx-exchlnx-3.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::39])
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTP id 45Y3mp4HHbz2095;
        Tue, 25 Jun 2019 13:27:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1561462074; bh=sKhs0CkAhJnHxLD1lwQ+u94XLPegG9a5maTR0WjXfGQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=W7HIqLrA+FlWjhX2WSCDm8TPE1VePiLPLqsrtE5yzg2ZS6uebufrhJ55Tj5yOsOW0
         eTfxy7i1BdYMmeC/y5thQ12CjOw0ip9D0c2PLWMcWTlnA6frSvEUK7OfdtXInsTtMd
         nsj8MD1dEYPcxazAtuLSXh/sNEAOrG6yumEyQORRYf3tGHL1n002OItOzYdtcxM7WZ
         uRop+b2+FCHl+19KXLWPvRYJH2SUhLb+lxGbm4Y58g8dGn4OhzwGoCecshxJWdQ0nt
         2L93sCxk7/tm+bpL5nEqJbWV/fZXh0gUbemKaad7L8wKeTQ95RkD6KlHolb2s7DXDT
         bE+a1Jum5efWQ==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
Received: from hbt1.exch.fau.de (hbt1.exch.fau.de [10.15.8.13])
        by mx-exchlnx-3.rrze.uni-erlangen.de (Postfix) with ESMTP id 45Y3mm2vMKz1yKc;
        Tue, 25 Jun 2019 13:27:52 +0200 (CEST)
Received: from MBX3.exch.uni-erlangen.de (10.15.8.45) by hbt1.exch.fau.de
 (10.15.8.13) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 25 Jun 2019
 13:27:21 +0200
Received: from TroubleWorld.pool.uni-erlangen.de (10.21.22.37) by
 MBX3.exch.uni-erlangen.de (10.15.8.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Tue, 25 Jun 2019 13:27:19 +0200
From:   Fabian Krueger <fabian.krueger@fau.de>
CC:     <fabian.krueger@fau.de>,
        Michael Scheiderer <michael.scheiderer@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/8] staging: kpc2000: introduce usage of __packed
Date:   Tue, 25 Jun 2019 13:27:14 +0200
Message-ID: <20190625112725.10154-4-fabian.krueger@fau.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625112725.10154-1-fabian.krueger@fau.de>
References: <20190625112725.10154-1-fabian.krueger@fau.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.21.22.37]
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
---
 drivers/staging/kpc2000/kpc2000_spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index e0e7703c6e53..253a9c150d33 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -141,7 +141,7 @@ struct kp_spi_controller_state {
 
 union kp_spi_config {
 	/* use this to access individual elements */
-	struct __attribute__((packed)) spi_config_bitfield {
+	struct __packed spi_config_bitfield {
 		unsigned int pha       : 1; /* spim_clk Phase      */
 		unsigned int pol       : 1; /* spim_clk Polarity   */
 		unsigned int epol      : 1; /* spim_csx Polarity   */
@@ -160,7 +160,7 @@ union kp_spi_config {
 };
 
 union kp_spi_status {
-	struct __attribute__((packed)) spi_status_bitfield {
+	struct __packed spi_status_bitfield {
 		unsigned int rx    :  1; /* Rx Status       */
 		unsigned int tx    :  1; /* Tx Status       */
 		unsigned int eo    :  1; /* End of Transfer */
@@ -175,7 +175,7 @@ union kp_spi_status {
 };
 
 union kp_spi_ffctrl {
-	struct __attribute__((packed)) spi_ffctrl_bitfield {
+	struct __packed spi_ffctrl_bitfield {
 		unsigned int ffstart :  1; /* FIFO Start */
 		unsigned int         : 31;
 	} bitfield;
-- 
2.17.1

