Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A09C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92B32067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="CeVA8+jr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfG2VDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:03:16 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.187]:22674 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbfG2VDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:03:16 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id ED370204D9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 16:03:15 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sCnbhhCqu2PzOsCnbhn5BQ; Mon, 29 Jul 2019 16:03:15 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rYB1Oi2xBUPftVqsW5ammk/X8WPDKxniD3s8r/ZdzcM=; b=CeVA8+jrcwcsJ7eq5lJ5gEx6Rm
        NgaRix678if4vKht58ojdct83PV9/zRxP2jaPu1h6el1aQpmHCb5iDzEIXNjRIaQv1rZim+QB4jj3
        lYCQybOH7fMXkuWhEgNAI4DZKEyRVPAN25oPsqIVeNVtpWaJPGTnhrQg3Lr5XecpMUrRc/UlbSSRk
        yFzm+OXDCto/MKakRsqXHwxtwmHa3kaKiGxTr8uX7c+bDDuXMHEv5gJYUPcI59KlME8OV+NM6XdNF
        vv7+oCWJI6cHphi78Vbfc/AuuM0VhHGkjYfJsJYF/Yo18rQoxTlXig/FpVvEv4vVppFWT0WZbieEL
        0tbQLieA==;
Received: from [187.192.11.120] (port=59782 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hsCna-001QA0-H3; Mon, 29 Jul 2019 16:03:14 -0500
Date:   Mon, 29 Jul 2019 16:03:13 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] scsi: wd33c93: Mark expected swich fall-through
Message-ID: <20190729210313.GA5896@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hsCna-001QA0-H3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:59782
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: m68k):

drivers/scsi/wd33c93.c: In function ‘round_4’:
drivers/scsi/wd33c93.c:1856:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
   case 2: ++x;
           ^~~
drivers/scsi/wd33c93.c:1857:3: note: here
   case 3: ++x;
   ^~~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/wd33c93.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
index fb7b289fa09f..f81046f0e68a 100644
--- a/drivers/scsi/wd33c93.c
+++ b/drivers/scsi/wd33c93.c
@@ -1854,6 +1854,7 @@ round_4(unsigned int x)
 		case 1: --x;
 			break;
 		case 2: ++x;
+			/* fall through */
 		case 3: ++x;
 	}
 	return x;
-- 
2.22.0

