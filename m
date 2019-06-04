Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D20C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6E2206C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559690994;
	bh=gdp1gQtM2ceiyjQvm9vbN7CyP+I+8rGZ6ccZ02bLGLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KB067nXxG31Eu1LYdMetNE7NUzALIrGQWf3j0/IwqmEdYJxLnAS2g1f+mUg5b+dtP
	 8IfqemlLrXdmy8r+geAVIQvWnKUsy1EhcaSk3L0+VmyA88c7dAf7lZu7jPFTfRWN3F
	 PT7wWSpkEgXoNKlXl+ReuV7f8IJroOKXT5Ej1hyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfFDX3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:29:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727480AbfFDXYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:24:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48E2C20866;
        Tue,  4 Jun 2019 23:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690645;
        bh=gdp1gQtM2ceiyjQvm9vbN7CyP+I+8rGZ6ccZ02bLGLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=13etlnz65dgoNHnwEbbAn711jhHhf/QfmSRdaN7CelQYFryLWN4+mzB5ifGqDXH+h
         2/pfOfJVp1aqs9tWoyM/HJUjDtUHmyJltTT68Kn3FLxw/nxt6Xj3szE8HH+Z7Tb2AQ
         zSfMuRFMxkdwDj0CFVvHG2a1Y+POlWqLJyw9YATo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 18/36] nvme: remove the ifdef around nvme_nvm_ioctl
Date:   Tue,  4 Jun 2019 19:23:13 -0400
Message-Id: <20190604232333.7185-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232333.7185-1-sashal@kernel.org>
References: <20190604232333.7185-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 3f98bcc58cd5f1e4668db289dcab771874cc0920 ]

We already have a proper stub if lightnvm is not enabled, so don't bother
with the ifdef.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 44d8077fbe95..1cdfea3c094a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1311,10 +1311,8 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned cmd, unsigned long arg)
 	case NVME_IOCTL_SUBMIT_IO:
 		return nvme_submit_io(ns, (void __user *)arg);
 	default:
-#ifdef CONFIG_NVM
 		if (ns->ndev)
 			return nvme_nvm_ioctl(ns, cmd, arg);
-#endif
 		if (is_sed_ioctl(cmd))
 			return sed_ioctl(ns->ctrl->opal_dev, cmd,
 					 (void __user *) arg);
-- 
2.20.1

