Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DA2C32770
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2519224653
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578155899;
	bh=bqhF0L40EGFJKUz5HKsqP3OOOwagJwjevt+LerYJluc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=o1hOPITM1Y/MQjNLfnx9WGHqXjpx6KyN/v9H6DrpKT1xRb/gwNuAQar0S9b63qfOC
	 d6RhHVRMqKHIh8oer9JZ3XY/9t224DvLaL70CfWdKWzPHRZP2hjma3BJCSYAQkzp6s
	 of4IzBj9+xvEWYri8qRM6HNq3yeIguHRh4xMMywE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgADQiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 11:38:18 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:17151 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgADQiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 11:38:18 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 004GbK3g014547;
        Sun, 5 Jan 2020 01:37:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 004GbK3g014547
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578155840;
        bh=eVPEihLHvjWVdkHTKHyBtb7lWwnPyh5OmidubGr2h+E=;
        h=From:To:Cc:Subject:Date:From;
        b=Owo0KpWI83RZ8ZIBybFOknpo+F6+l2b9sd9skrV+L5JShGTDTyH3852v4juZhVduw
         MYyMytG0KGrPXjglbxSzotesdmp02vJs8Pp8C+BB5QpuxjgZy+/CLoMs8/71OP77hv
         DQ/122xP4fAb3xFvAnupptg93HsPxbvR/36nxuzEfQgAG6t+I6/zQZTYfUCbsyxlar
         YIVQfOTfH/ittgEWac2QJWPRdZzASkEMuSVJj6FcQFvS+Lb12aTxRe3GFk67a/3IQ7
         lbPOIiKPBsVdLPHDBDiMbawTVplbnYQaTTLF7CvyF8uHvKxXyMiOIqLhxvuhXMzsLM
         lADupzK04bneA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Mukesh Ojha <mojha@codeaurora.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: remove unneeded header include path
Date:   Sun,  5 Jan 2020 01:37:10 +0900
Message-Id: <20200104163710.21582-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A header include path without $(srctree)/ is suspicous because it does
not work with O= builds.

I can build drivers/staging/rts5208/ without this include path.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/staging/rts5208/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rts5208/Makefile b/drivers/staging/rts5208/Makefile
index 6a934c41c738..3c9e9797d3d9 100644
--- a/drivers/staging/rts5208/Makefile
+++ b/drivers/staging/rts5208/Makefile
@@ -1,7 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_RTS5208) := rts5208.o
 
-ccflags-y := -Idrivers/scsi
-
 rts5208-y := rtsx.o rtsx_chip.o rtsx_transport.o rtsx_scsi.o \
 	rtsx_card.o general.o sd.o xd.o ms.o spi.o
-- 
2.17.1

