Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2BFC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1BC222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611563;
	bh=RgYw0oBSLwQBhdw3WvYdr72j1tYCT0JVBwh8M+A/DAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I/MBaKf+Pisbq0tP1reQu1RZQvY1iPWVia2+ZtsMFtQ+TyYWJj5Ko20YyAtHx9/Rr
	 Bjgw/FgvrA7ysbjex59AmlEd5QHQ5SRUrMFP16hXXthqp/OXJCgJQxlkrmwD3FNrtY
	 EzzQgHRmAP37vudgqHBlFQAtER0gJE/xWhc8LNNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfKMCTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:19:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729068AbfKMBzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:55:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C303222CD;
        Wed, 13 Nov 2019 01:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610118;
        bh=RgYw0oBSLwQBhdw3WvYdr72j1tYCT0JVBwh8M+A/DAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N97tgouPjOSxzfN4UN0nTKCAT9du+rcWrRRmpcai3ZbRFl/TvOw/CyoLtkXVm0Ora
         EFMZK3wP5fyC/lyC+y9ngx/uLqfpxQqhUW705csK2v1dqEwjwgxmkC+6xYkz7Lu0Jk
         9euYKpAbhuZ69+KMILBOkvpPpi/Z9ktxQt4uh32I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 173/209] lightnvm: do no update csecs and sos on 1.2
Date:   Tue, 12 Nov 2019 20:49:49 -0500
Message-Id: <20191113015025.9685-173-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier González <javier@javigon.com>

[ Upstream commit 6fd05cad5ee1290b276dd8ed90a1e019b1fa577a ]

1.2 devices exposes their data and metadata size through the separate
identify command. Make sure that the NVMe LBA format does not override
these values.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/lightnvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 6fe5923c95d4a..a69553e75f38e 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -968,6 +968,9 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
 	struct nvm_dev *ndev = ns->ndev;
 	struct nvm_geo *geo = &ndev->geo;
 
+	if (geo->version == NVM_OCSSD_SPEC_12)
+		return;
+
 	geo->csecs = 1 << ns->lba_shift;
 	geo->sos = ns->ms;
 }
-- 
2.20.1

