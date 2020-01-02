Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C105C00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 07:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301BC22B48
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 07:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578034845;
	bh=we7pKnlhkto10e/KX0lmPcqpyOhRRQPuUUaKyEjfmD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NIdjOZq3fjDR9aVKR3pt1K4UR05Bdk+X0JmkD9VrWLC0fuEthy6CdLvPGkIloOicc
	 RyhLc38xFD9ccpVG9p1RrdPa9oPExDWgaYWggNrGunUT6rnIdX+cuwiUJi2HTaLoYo
	 9PUHvHVnb+ZttdYBQ2uUNOloc+UDlY5rOV+T730M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgACHAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 02:00:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgACHAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 02:00:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADFE62464E;
        Fri,  3 Jan 2020 07:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578034842;
        bh=we7pKnlhkto10e/KX0lmPcqpyOhRRQPuUUaKyEjfmD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zdcaZLsMEgkBS2zxyaU39JEf20w66MI6AjBLdLztuJa28i5IUrXCuXH+/Cga1gOed
         RCQ6JeJGNc+n4KbxgLJlB3Z9xggRW3mGMmbEdr858fnzD4MMuwkIPXavACWhCoYQ/9
         2DDsgJcH2KIH6aq0pKlZwtmfNQK+4StxIXnCm/lo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benoit Parrot <bparrot@ti.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 013/137] media: i2c: ov2659: Fix missing 720p register config
Date:   Thu,  2 Jan 2020 23:06:26 +0100
Message-Id: <20200102220548.514572546@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benoit Parrot <bparrot@ti.com>

[ Upstream commit 9d669fbfca20e6035ead814e55d9ef1a6b500540 ]

The initial registers sequence is only loaded at probe
time. Afterward only the resolution and format specific
register are modified. Care must be taken to make sure
registers modified by one resolution setting are reverted
back when another resolution is programmed.

This was not done properly for the 720p case.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov2659.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/i2c/ov2659.c b/drivers/media/i2c/ov2659.c
index 4f43e8c43950..6eefb8bbb5b5 100644
--- a/drivers/media/i2c/ov2659.c
+++ b/drivers/media/i2c/ov2659.c
@@ -419,10 +419,14 @@ static struct sensor_register ov2659_720p[] = {
 	{ REG_TIMING_YINC, 0x11 },
 	{ REG_TIMING_VERT_FORMAT, 0x80 },
 	{ REG_TIMING_HORIZ_FORMAT, 0x00 },
+	{ 0x370a, 0x12 },
 	{ 0x3a03, 0xe8 },
 	{ 0x3a09, 0x6f },
 	{ 0x3a0b, 0x5d },
 	{ 0x3a15, 0x9a },
+	{ REG_VFIFO_READ_START_H, 0x00 },
+	{ REG_VFIFO_READ_START_L, 0x80 },
+	{ REG_ISP_CTRL02, 0x00 },
 	{ REG_NULL, 0x00 },
 };
 
-- 
2.20.1



