Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F6EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B29206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ls/83NAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387698AbfG2L3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:29:07 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.38]:34125 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387676AbfG2L3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:29:07 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id EE296400CBF9A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 06:29:05 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id s3pxhKHHQiQers3pxhjRfK; Mon, 29 Jul 2019 06:29:05 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nTNq8k0oMaS+PPNp0AqzfLae8nXfzeNscQDCOrTOOdA=; b=ls/83NAkEaXSGpDkCGJhhzQXmg
        vhrXJ8dTfh17VYQYN2BgzQoyPHoCNjCemvTZ+Iq7rkUscRfwa7GlQmF38GnaxiUwKhgQeFW97IKJm
        x2gcsRC29B18WF8wyaDo2UiCY+x6gpSl4B/ZSZt33xgIn+q7YBQVk8xB6Z13JNSnttExV2zX7N8J5
        6qsBrJjgJVYHxygEsf3emqIhFjxvjeN3Jj4brrr9g+lnv/7kQQtcydf4ciwoe2mqfWz7WjMNUAK8U
        p2FQH48AXxrPtCB3MRUf46dZk0PgIn1e632NMa1jFlzgI6BBFp+Mv2pDf84abUNLMap60DvWMFrd/
        4E7P8TVg==;
Received: from [187.192.11.120] (port=47322 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hs3pw-000Joy-Pw; Mon, 29 Jul 2019 06:29:04 -0500
Date:   Mon, 29 Jul 2019 06:29:02 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Michael Cyr <mikecyr@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] scsi: ibmvscsi_tgt: Mark expected switch fall-throughs
Message-ID: <20190729112902.GA3768@embeddedor>
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
X-Exim-ID: 1hs3pw-000Joy-Pw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:47322
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 30
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings (Building: powerpc allyesconfig):

drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_adapter_info':
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1582:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (connection_broken(vscsi))
      ^
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1584:2: note: here
  default:
  ^~~~~~~
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_ping_response':
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:2494:16: warning: this statement may fall through [-Wimplicit-fallthrough=]
   vscsi->flags |= CLIENT_FAILED;
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:2495:2: note: here
  case H_DROPPED:
  ^~~~
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:2496:16: warning: this statement may fall through [-Wimplicit-fallthrough=]
   vscsi->flags |= RESPONSE_Q_DOWN;
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:2497:2: note: here
  case H_REMOTE_PARM:
  ^~~~

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index 7f9535392a93..a929fe76102b 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -1581,6 +1581,7 @@ static long ibmvscsis_adapter_info(struct scsi_info *vscsi,
 	case H_PERMISSION:
 		if (connection_broken(vscsi))
 			flag_bits = (RESPONSE_Q_DOWN | CLIENT_FAILED);
+		/* Fall through */
 	default:
 		dev_err(&vscsi->dev, "adapter_info: h_copy_rdma to client failed, rc %ld\n",
 			rc);
@@ -2492,8 +2493,10 @@ static long ibmvscsis_ping_response(struct scsi_info *vscsi)
 		break;
 	case H_CLOSED:
 		vscsi->flags |= CLIENT_FAILED;
+		/* Fall through */
 	case H_DROPPED:
 		vscsi->flags |= RESPONSE_Q_DOWN;
+		/* Fall through */
 	case H_REMOTE_PARM:
 		dev_err(&vscsi->dev, "ping_response: h_send_crq failed, rc %ld\n",
 			rc);
-- 
2.22.0

