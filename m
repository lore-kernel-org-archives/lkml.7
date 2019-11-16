Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346F0C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE0621844
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921564;
	bh=SD6S9bo++cYRRK6kefZiQBJRytQMJgndY+nz+hpr/To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W0p/c5FWluHmWQmNbysuv8JNYYvYJ/Ntw5+CUKTVg4vIcseeSrfxjwIB9Qb/KSzgQ
	 PVQweOMg68Wi998b6lNtKgb3ld66I0Jd9ngs5fuDzoy2LXlfU2obYuNwzf236DTefF
	 dXfK5bTjmQQ8xy7vxmDSCOryW2hE8uFuh1+Lk8QQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbfKPQZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:25:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbfKPPmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:42:01 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A1742084C;
        Sat, 16 Nov 2019 15:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573918920;
        bh=SD6S9bo++cYRRK6kefZiQBJRytQMJgndY+nz+hpr/To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fjKOVzzVHcq+0tQgNsRwIG9TC7eGCoVG3qHLhisLMFaV0GDSybRwkUV4XI8j1emLF
         ZTywrHqqJO7fYuJUQHKuWdJWgWJPIicN830yVZgCOm3bPPhf+280PP89Ed4ybtx0fw
         gUEkEE+sA8nw/H5f31TtaQ6CXFTq/u6wt6NAJFvk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 045/237] scsi: ips: fix missing break in switch
Date:   Sat, 16 Nov 2019 10:38:00 -0500
Message-Id: <20191116154113.7417-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit 5d25ff7a544889bc4b749fda31778d6a18dddbcb ]

Add missing break statement in order to prevent the code from falling
through to case TEST_UNIT_READY.

Addresses-Coverity-ID: 1357338 ("Missing break in switch")
Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ips.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index bd6ac6b5980a1..fe587ef1741d4 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -3485,6 +3485,7 @@ ips_send_cmd(ips_ha_t * ha, ips_scb_t * scb)
 
 		case START_STOP:
 			scb->scsi_cmd->result = DID_OK << 16;
+			break;
 
 		case TEST_UNIT_READY:
 		case INQUIRY:
-- 
2.20.1

