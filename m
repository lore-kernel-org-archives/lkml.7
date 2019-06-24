Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E818EC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D07208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561371699;
	bh=auMCal2LoCfpgKRPytluCTINv39Soo4TNSQ4RmUdg4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QxKXdAPTArqyg8xgbTCpS+CqcQ6gns8lTsYt9sFx1c1H11aAPM8jQ182KFbAmCoNz
	 0jU9DOXr3T83X6M9bGuEtHXJOmaEAOvY4hshSkv7PFO+Q/PJ0vkciQlErAuTcpQdU0
	 jI2wOIaTA6AsU2OOshyV2XCS0FQTK4JRAcOrRF34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfFXKVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbfFXKVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:21:37 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 429B620645;
        Mon, 24 Jun 2019 10:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561371696;
        bh=auMCal2LoCfpgKRPytluCTINv39Soo4TNSQ4RmUdg4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M5izVy5F90M9pdtDShbt6Dnwc8AK5uefB287sp2U6RSGPdsqNinS/+G/qDwF4YxcZ
         6s/GmdbZdGRsK0aBgH0b6t2xMluk0HvTGQzWT1bnYBCnKjfad6v8n0DqgTObfzhztV
         lzQXLReCmz9GufIFxVvRCArUiJoyv6zMxjqZudvY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 078/121] scsi: smartpqi: unlock on error in pqi_submit_raid_request_synchronous()
Date:   Mon, 24 Jun 2019 17:56:50 +0800
Message-Id: <20190624092324.865190248@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
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
index 531824afba5f..392695b4691a 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -4044,8 +4044,10 @@ static int pqi_submit_raid_request_synchronous(struct pqi_ctrl_info *ctrl_info,
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



