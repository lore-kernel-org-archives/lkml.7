Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D216C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424CF218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366809;
	bh=9bEFR+7lUF+0Au33SffRpEzZCdzHodQs1r+AOQr+XAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=chGGzMF28ppDnifgLyYAu7gUeXS2DMgISVnDyhRpghuyZTcxv3TIVBxaB8nDBcAzk
	 X+tq9aFQpTU7VkOALsTQNqJyiMYcVo+SI0kOgl5P5F4z0Fl8e3dNfddvJSq2H48Ipg
	 gx2qflqha63tNHwj6WATSITUY7Jgr0devbOY5S2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388418AbfB1PN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:13:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388393AbfB1PNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:13:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33378218D8;
        Thu, 28 Feb 2019 15:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366799;
        bh=9bEFR+7lUF+0Au33SffRpEzZCdzHodQs1r+AOQr+XAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b3v0co9ps6LLgsH/jhX+5VGaNMr/m7Uxfb6lvqO+qXsxblPO48UcW+VYBeEmKqPyh
         ekjOUBm8h50yeYW4NbGqxqmzGEJrkYMYpAiCpFEpETsdMfchMA5PNo50Vjm4Y8dxGA
         Oa2ygZfOeCtZFyMvXD5ccyaLjRlunZy00DcIMwOM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 55/64] Revert "scsi: libfc: Add WARN_ON() when deleting rports"
Date:   Thu, 28 Feb 2019 10:10:56 -0500
Message-Id: <20190228151105.11277-55-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit d8f6382a7d026989029e2e50c515df954488459b ]

This reverts commit bbc0f8bd88abefb0f27998f40a073634a3a2db89.

It added a warning whose intent was to check whether the rport was still
linked into the peer list. It doesn't work as intended and gives false
positive warnings for two reasons:

1) If the rport is never linked into the peer list it will not be
considered empty since the list_head is never initialized.

2) If the rport is deleted from the peer list using list_del_rcu(), then
the list_head is in an undefined state and it is not considered empty.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libfc/fc_rport.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/libfc/fc_rport.c b/drivers/scsi/libfc/fc_rport.c
index 372387a450dff..1797e47fab386 100644
--- a/drivers/scsi/libfc/fc_rport.c
+++ b/drivers/scsi/libfc/fc_rport.c
@@ -184,7 +184,6 @@ void fc_rport_destroy(struct kref *kref)
 	struct fc_rport_priv *rdata;
 
 	rdata = container_of(kref, struct fc_rport_priv, kref);
-	WARN_ON(!list_empty(&rdata->peers));
 	kfree_rcu(rdata, rcu);
 }
 EXPORT_SYMBOL(fc_rport_destroy);
-- 
2.19.1

