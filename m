Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB33C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4C5206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="aEMwnak/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfG2OaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:30:11 -0400
Received: from gateway30.websitewelcome.com ([192.185.148.2]:16276 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbfG2OaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:30:10 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 6F12EA110
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:30:09 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id s6fBhNOp8iQers6fBhmXnU; Mon, 29 Jul 2019 09:30:09 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0RJo8enbcNLdJ2TXKB/Bo9r6HXH+BZhHSn25BJmwwc0=; b=aEMwnak/TqMhZPljJxLMAzT+2z
        H+18G5XudUiKbSQj3/w+38q2eyf/a+pkOseoZC33aApPWYe/2Dw+BtE3b0fHzTQQTN4UULKZzUW3+
        /UJU4HVIYvsginxtu9KhcoTZkwDoyufa1/Pr24rkUCJ8DdqDXQ2fbu8UM9nIJMoS2VC+wstAwux/r
        rUuw74/VBKuKogdVZywvxeuYTcNGHUhp04HMQ6X+sXN+sbMmOVuDt7btihTbdg/31vvkwDW9T8iuh
        xZ+woM881dhPqLnelNfOkFFJVNpZVm8WFTPScTsxTkcFf4BZKrEJKOIkN/+a3Ls6DF4zFLE24UkUV
        CM0Wc3nw==;
Received: from [187.192.11.120] (port=50422 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hs6fA-002KU8-C1; Mon, 29 Jul 2019 09:30:08 -0500
Date:   Mon, 29 Jul 2019 09:30:07 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] scsi: sun3_scsi: Mark expected switch fall-throughs
Message-ID: <20190729143007.GA8067@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hs6fA-002KU8-C1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:50422
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/scsi/sun3_scsi.c: warning: this statement may fall through
[-Wimplicit-fallthrough=]:  => 399:9, 403:9

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/sun3_scsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/sun3_scsi.c b/drivers/scsi/sun3_scsi.c
index 3d80ab67a626..955e4c938d49 100644
--- a/drivers/scsi/sun3_scsi.c
+++ b/drivers/scsi/sun3_scsi.c
@@ -397,10 +397,12 @@ static int sun3scsi_dma_finish(int write_flag)
 		case CSR_LEFT_3:
 			*vaddr = (dregs->bpack_lo & 0xff00) >> 8;
 			vaddr--;
+			/* Fall through */
 
 		case CSR_LEFT_2:
 			*vaddr = (dregs->bpack_hi & 0x00ff);
 			vaddr--;
+			/* Fall through */
 
 		case CSR_LEFT_1:
 			*vaddr = (dregs->bpack_hi & 0xff00) >> 8;
-- 
2.22.0

