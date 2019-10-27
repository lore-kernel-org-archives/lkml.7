Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABFACA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EA521783
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211349;
	bh=DE6oLFqWPXUyOeGDl5G6gq5/MeLhyJjImTLVpPE1KSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1ThfK5M5prwejz0JY3JTs8KjHrqZCqNtfw11Jq6CXhcDZBX3PrjK9mcPZ8GokN2CB
	 xY0+0mzQlESqKvdCV8PqUprmQDcAve3+/bQQ22/n00x87mkZNUX0FewtQ9ri5p1V3J
	 WczIir8vzZ7fKWX7ukK+IFhRqgTDRIIhcClAR0j8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbfJ0VW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732129AbfJ0VWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:22:24 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D07921783;
        Sun, 27 Oct 2019 21:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211344;
        bh=DE6oLFqWPXUyOeGDl5G6gq5/MeLhyJjImTLVpPE1KSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sUdD4eqoRW8LcVPvPS3R5nX4Nl+WFrYakFKxNWZVuVS1Qu8NSRxm9CbtQPpqn3Tdn
         iBX94W+D4kllvuMZwLpCSLXDP5xdQkbdM9pNl0rlHNkCt6k4OYyP2PSlzL82KQnyDz
         2bOqD29oVRNVs8H4AxSFrOuWoosUhlNfaHGXTzVs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dixit Parmar <dixitparmar19@gmail.com>,
        Martin Kepplinger <martink@posteo.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.3 117/197] Input: st1232 - fix reporting multitouch coordinates
Date:   Sun, 27 Oct 2019 22:00:35 +0100
Message-Id: <20191027203358.050781046@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dixit Parmar <dixitparmar19@gmail.com>

commit b1a402e75a5f5127ff1ffff0615249f98df8b7b3 upstream.

For Sitronix st1633 multi-touch controller driver the coordinates reported
for multiple fingers were wrong, as it was always taking LSB of coordinates
from the first contact data.

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
Reviewed-by: Martin Kepplinger <martink@posteo.de>
Cc: stable@vger.kernel.org
Fixes: 351e0592bfea ("Input: st1232 - add support for st1633")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204561
Link: https://lore.kernel.org/r/1566209314-21767-1-git-send-email-dixitparmar19@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/touchscreen/st1232.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -81,8 +81,10 @@ static int st1232_ts_read_data(struct st
 	for (i = 0, y = 0; i < ts->chip_info->max_fingers; i++, y += 3) {
 		finger[i].is_valid = buf[i + y] >> 7;
 		if (finger[i].is_valid) {
-			finger[i].x = ((buf[i + y] & 0x0070) << 4) | buf[i + 1];
-			finger[i].y = ((buf[i + y] & 0x0007) << 8) | buf[i + 2];
+			finger[i].x = ((buf[i + y] & 0x0070) << 4) |
+					buf[i + y + 1];
+			finger[i].y = ((buf[i + y] & 0x0007) << 8) |
+					buf[i + y + 2];
 
 			/* st1232 includes a z-axis / touch strength */
 			if (ts->chip_info->have_z)


