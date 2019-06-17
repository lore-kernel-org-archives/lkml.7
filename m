Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FDFC31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313AB208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806509;
	bh=7Avpruq10B8PjRBA3qo8Siwkz9o5NVv9sRuRjaB5YiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yhV0LW+Qyt38YxalzkjMgFThm/Fy+iBxT5l7CS4Wa5g6Du+k5WO5/3VtLZHvFu8EM
	 /1aEh+bYKDy5JuO14/Kmr21Kbf42r+vklWFAV7Qg/jx6cv9VPTHXncSIEAKT7mZ5i4
	 MxMrLu6tgDnCMZS3v0BG7x9v3GiSpmlINxS7eh9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfFQVVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:21:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729409AbfFQVVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:21:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 442E6208E4;
        Mon, 17 Jun 2019 21:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806502;
        bh=7Avpruq10B8PjRBA3qo8Siwkz9o5NVv9sRuRjaB5YiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPqj1eOCHLZkomXCQ7kRgoZGEonnTdg3BH6dhitmRNWRR+ceMuFFNk7LrNAzZiJAs
         4wJFmlm4eBMsljJm4q/evVr10DniEPC6bVeG2GT/lzlZ8KH26eWHJb6IABGzU6CcFR
         rYcYTi9GDXbfdEoRKAtsFHxBHBGE/VKFanD1jWbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 073/115] scsi: myrs: Fix uninitialized variable
Date:   Mon, 17 Jun 2019 23:09:33 +0200
Message-Id: <20190617210803.771553605@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 41552199b5518fe26bee0829a28dd1880441b430 ]

drivers/scsi/myrs.c: In function 'myrs_log_event':
drivers/scsi/myrs.c:821:24: warning: 'sshdr.sense_key' may be used uninitialized in this function [-Wmaybe-uninitialized]
  struct scsi_sense_hdr sshdr;

If ev->ev_code is not 0x1C, sshdr.sense_key may be used uninitialized. Fix
this by initializing variable 'sshdr' to 0.

Fixes: 77266186397c ("scsi: myrs: Add Mylex RAID controller (SCSI interface)")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/myrs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index b8d54ef8cf6d..eb0dd566330a 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -818,7 +818,7 @@ static void myrs_log_event(struct myrs_hba *cs, struct myrs_event *ev)
 	unsigned char ev_type, *ev_msg;
 	struct Scsi_Host *shost = cs->host;
 	struct scsi_device *sdev;
-	struct scsi_sense_hdr sshdr;
+	struct scsi_sense_hdr sshdr = {0};
 	unsigned char sense_info[4];
 	unsigned char cmd_specific[4];
 
-- 
2.20.1



