Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6138FC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3217C2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfFZO3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:29:25 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:57249 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbfFZO3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:29:24 -0400
Received: from h2730561.stratoserver.net (h2730561.stratoserver.net [85.214.29.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 544CB1F44E;
        Wed, 26 Jun 2019 16:29:23 +0200 (CEST)
From:   =?UTF-8?q?Tobias=20Nie=C3=9Fen?= 
        <tobias.niessen@stud.uni-hannover.de>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de,
        =?UTF-8?q?Tobias=20Nie=C3=9Fen?= 
        <tobias.niessen@stud.uni-hannover.de>,
        Sabrina Gaube <sabrina-gaube@web.de>
Subject: [PATCH 2/2] staging: rts5208: Simplify boolean expression to improve code style
Date:   Wed, 26 Jun 2019 16:28:57 +0200
Message-Id: <20190626142857.30155-3-tobias.niessen@stud.uni-hannover.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190626142857.30155-1-tobias.niessen@stud.uni-hannover.de>
References: <20190626142857.30155-1-tobias.niessen@stud.uni-hannover.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bitwisen / boolean expression can be made more readable while
reducing the line lengths at the same time. This commit uses the
fact that

    a & (b | c) == (b | c)

evaluates to true if and only if

    (a & b) && (a & c)

is true. Since b and c are constants with relatively long names,
using the second form makes the code much more readable and shorter.

Signed-off-by: Tobias Nießen <tobias.niessen@stud.uni-hannover.de>
Signed-off-by: Sabrina Gaube <sabrina-gaube@web.de>
---
 drivers/staging/rts5208/xd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rts5208/xd.c b/drivers/staging/rts5208/xd.c
index c5ee04ecd1c9..f3dc96a4c59d 100644
--- a/drivers/staging/rts5208/xd.c
+++ b/drivers/staging/rts5208/xd.c
@@ -1155,10 +1155,10 @@ static int xd_copy_page(struct rtsx_chip *chip, u32 old_blk, u32 new_blk,
 					return STATUS_FAIL;
 				}
 
-				if (((reg & (XD_ECC1_ERROR | XD_ECC1_UNCORRECTABLE)) ==
-						(XD_ECC1_ERROR | XD_ECC1_UNCORRECTABLE)) ||
-					((reg & (XD_ECC2_ERROR | XD_ECC2_UNCORRECTABLE)) ==
-						(XD_ECC2_ERROR | XD_ECC2_UNCORRECTABLE))) {
+				if (((reg & XD_ECC1_ERROR) &&
+				     (reg & XD_ECC1_UNCORRECTABLE)) ||
+				    ((reg & XD_ECC2_ERROR) &&
+				     (reg & XD_ECC2_UNCORRECTABLE))) {
 					rtsx_write_register(chip,
 							    XD_PAGE_STATUS,
 							    0xFF,
-- 
2.17.0

