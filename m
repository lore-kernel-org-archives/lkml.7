Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25A1C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939AC2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="I/kvaUzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfDZOub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:50:31 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3022 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZOub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:50:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc31abc0000>; Fri, 26 Apr 2019 07:50:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Apr 2019 07:50:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Apr 2019 07:50:30 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Apr
 2019 14:50:30 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Apr
 2019 14:50:29 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Apr 2019 14:50:29 +0000
Received: from jilin-desktop.nvidia.com (Not Verified[10.19.120.158]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cc31ab50004>; Fri, 26 Apr 2019 07:50:29 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <linux-usb@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Jim Lin <jilin@nvidia.com>
Subject: [PATCH 3/6] usb: fotg210:Adjusted for usb_hub_clear_tt_buffer
Date:   Fri, 26 Apr 2019 22:50:27 +0800
Message-ID: <1556290227-9480-1-git-send-email-jilin@nvidia.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556290237; bh=3FkiFNr2zoIxXp2r2T2xlqeRKWH8cfTl48gxMEQN488=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=I/kvaUzH13PQbyhYrhER5I3TZvtlc0iaPlt32BNc5h5135no/oZMc8L9LAf4Andi9
         Fi0FpjYFHBIkxnsmHJd/Gu6VQY4XrdG9y1YUof9MT+lfYUkWzmI5qwqjJwAVZgsweQ
         bkPYlaifBylYU+c2BntcNhSpxgG52T1TTHzq7V4oPBcIvNxtOzzUhIrJj8Sha6Eks+
         7F2nSIUsfptxXGeD8VvLaolKuNm+W5uESuMOf8wLH1W2qVJwpJphUsq7my02+1jd/z
         bTgkYMZn2Iayvhd6u/8WJ7MFUq3XdrGPz3WGlJZ/viZokRC48kgzXX6563UlhUp0ho
         WkQYVDI0vKqMA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add argument for usb_hub_clear_tt_buffer to specify device number
that will have the TT state of its hub cleared.

Signed-off-by: Jim Lin <jilin@nvidia.com>
---
 drivers/usb/host/fotg210-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index 0da68df259c8..bd29ed0fbd46 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -2123,7 +2123,7 @@ static void fotg210_clear_tt_buffer(struct fotg210_hcd *fotg210,
 
 		if (urb->dev->tt->hub !=
 				fotg210_to_hcd(fotg210)->self.root_hub) {
-			if (usb_hub_clear_tt_buffer(urb) == 0)
+			if (!usb_hub_clear_tt_buffer(urb, urb->dev->devnum))
 				qh->clearing_tt = 1;
 		}
 	}
-- 
2.1.4

