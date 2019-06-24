Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2C1C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295E0213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370716;
	bh=azXS+mVt+1QX2Snrb45t6VAefaIOpyEK6Fpfa/x6Vpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bqL8I/hYyGX+M0LGdfnLFMGJoEg4mtVgFKnukSScPfYtuWZJrRapDAopzZs/MFfp1
	 IKIowU711crWvnH06jVgt1ms7muAltASg9fOYu/IcPwe5V+twWtBpyD8KcY2oaoLBp
	 BWq5XYncPJZi7N4C6dSZdhnz8U2Qeu3In0Ek7XNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfFXKFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729852AbfFXKFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:05:04 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1D2C208E4;
        Mon, 24 Jun 2019 10:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370703;
        bh=azXS+mVt+1QX2Snrb45t6VAefaIOpyEK6Fpfa/x6Vpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x6ZoJxGRuRzchSoZr0AlqcvjG6L69q7QZ1n/e9R3BaNjZk/+4J85c+JQLHMx52IoC
         EP0dIlbslabRybNPsE5HRTovlmDchqaqb6dz+SMBZTEBr8dhNeao4uEo8AEi3dmwKX
         yMMhUbdwxEPPbFJA4bly5/gCIFbWr52lqQbpVqtI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 61/90] scsi: smartpqi: unlock on error in pqi_submit_raid_request_synchronous()
Date:   Mon, 24 Jun 2019 17:56:51 +0800
Message-Id: <20190624092318.124668687@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092313.788773607@linuxfoundation.org>
References: <20190624092313.788773607@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit cc8f52609bb4177febade24d11713e20c0893b0a ]

We need to drop the "ctrl_info->sync_request_sem" lock before returning.

Fixes: 6c223761eb54 ("smartpqi: initial commit of Microsemi smartpqi driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Don Brace <don.brace@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 411d656f2530..98f2d076f938 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -3697,8 +3697,10 @@ static int pqi_submit_raid_request_synchronous(struct pqi_ctrl_info *ctrl_info,
 				return -ETIMEDOUT;
 			msecs_blocked =
 				jiffies_to_msecs(jiffies - start_jiffies);
-			if (msecs_blocked >= timeout_msecs)
-				return -ETIMEDOUT;
+			if (msecs_blocked >= timeout_msecs) {
+				rc = -ETIMEDOUT;
+				goto out;
+			}
 			timeout_msecs -= msecs_blocked;
 		}
 	}
-- 
2.20.1



