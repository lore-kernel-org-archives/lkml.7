Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD61C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA6D21850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142961;
	bh=HXKXCfTe/YWivqt2/XHI9qBijHiI9BV3Ng/MsU6Ayxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eFgUPlNbd3IAlMM155cEZa/H2k17YyDwZauhIioVZmYpikX8KH5b+PlKBzG+bRAf7
	 9ddL1l/0GtwDvfVLJlPf+EtC6y+/M7w8Z5VGpP9ZsZyovcrwmP7f6I7xQ7W6NR0J4C
	 fqyht5uIa8p+MY24vtwmAQ5XLoFBVm0yBuePItkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbfKSFyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:54:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732125AbfKSFyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:54:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2765421D7B;
        Tue, 19 Nov 2019 05:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142861;
        bh=HXKXCfTe/YWivqt2/XHI9qBijHiI9BV3Ng/MsU6Ayxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kLkPCszOlaPDzyu6HMm9OsEG3CUqZa7N/SGXqfTbYS6IOfyKSNvwSWhI5MFrUvCDI
         1Sfse2KEN7U4wNGueoTHv/eiKWajEhvrkkqI3BuK/O+36A3cSUQxdw9Ai/1yVb+uDc
         UiKjS+Q2KD7e0uMPEag+UfmVu5w6NFb1b014KgTw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 226/239] scsi: NCR5380: Dont call dsprintk() following reselection interrupt
Date:   Tue, 19 Nov 2019 06:20:26 +0100
Message-Id: <20191119051340.397757166@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

[ Upstream commit 08267216b3f8aa5adc204bdccf8deb72c1cd7665 ]

The X3T9.2 specification (draft) says, under "6.1.4.1 RESELECTION",

    ... The reselected initiator shall then assert the BSY signal
    within a selection abort time of its most recent detection of being
    reselected; this is required for correct operation of the time-out
    procedure.

The selection abort time is only 200 us which may be insufficient time for a
printk() call. Move the diagnostics to the error paths.

Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/NCR5380.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index b13290b3e5d38..48f123601f575 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -2021,8 +2021,6 @@ static void NCR5380_reselect(struct Scsi_Host *instance)
 		return;
 	}
 
-	dsprintk(NDEBUG_RESELECTION, instance, "reselect\n");
-
 	/*
 	 * At this point, we have detected that our SCSI ID is on the bus,
 	 * SEL is true and BSY was false for at least one bus settle delay
@@ -2035,6 +2033,7 @@ static void NCR5380_reselect(struct Scsi_Host *instance)
 	NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE | ICR_ASSERT_BSY);
 	if (NCR5380_poll_politely(hostdata,
 	                          STATUS_REG, SR_SEL, 0, 2 * HZ) < 0) {
+		shost_printk(KERN_ERR, instance, "reselect: !SEL timeout\n");
 		NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE);
 		return;
 	}
@@ -2046,6 +2045,7 @@ static void NCR5380_reselect(struct Scsi_Host *instance)
 
 	if (NCR5380_poll_politely(hostdata,
 	                          STATUS_REG, SR_REQ, SR_REQ, 2 * HZ) < 0) {
+		shost_printk(KERN_ERR, instance, "reselect: REQ timeout\n");
 		do_abort(instance);
 		return;
 	}
-- 
2.20.1



