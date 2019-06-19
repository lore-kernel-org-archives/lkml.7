Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B931AC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB0F2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbfFSPyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:54:10 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:34728 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbfFSPyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:54:03 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Jun 2019 11:54:02 EDT
Received: from faui06c.informatik.uni-erlangen.de (faui06c.informatik.uni-erlangen.de [131.188.30.202])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 8C90E2412D6;
        Wed, 19 Jun 2019 17:46:56 +0200 (CEST)
Received: by faui06c.informatik.uni-erlangen.de (Postfix, from userid 30063)
        id 7D7ACB006CD; Wed, 19 Jun 2019 17:46:56 +0200 (CEST)
From:   Lukas Schneider <lukas.s.schneider@fau.de>
To:     kim.jamie.bradley@gmail.com, pakki001@umn.edu,
        colin.king@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Lukas Schneider <lukas.s.schneider@fau.de>,
        Jannik Moritz <jannik.moritz@fau.de>, linux-kernel@i4.cs.fau.de
Subject: [PATCH 1/4] rts5208: Fix usleep_range is preferred over udelay
Date:   Wed, 19 Jun 2019 17:46:45 +0200
Message-Id: <20190619154648.13840-1-lukas.s.schneider@fau.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the issue reported by checkpatch:

CHECK: usleep_range is preferred over udelay;
see Documentation/timers/timers-howto.txt

It's save to sleep here instead of using busy waiting,
because we are not in an atomic context.

Signed-off-by: Lukas Schneider <lukas.s.schneider@fau.de>
Signed-off-by: Jannik Moritz <jannik.moritz@fau.de>
Cc: <linux-kernel@i4.cs.fau.de>
---
 drivers/staging/rts5208/ms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
index 1128eec3bd08..264887d8b3e6 100644
--- a/drivers/staging/rts5208/ms.c
+++ b/drivers/staging/rts5208/ms.c
@@ -3237,7 +3237,7 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 			return STATUS_FAIL;
 		}
 
-		udelay(30);
+		usleep_range(30, 40);
 
 		rtsx_init_cmd(chip);
 
@@ -4159,7 +4159,7 @@ int mg_set_ICV(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 #ifdef MG_SET_ICV_SLOW
 	for (i = 0; i < 2; i++) {
-		udelay(50);
+		usleep_range(50, 60);
 
 		rtsx_init_cmd(chip);
 
-- 
2.19.1

