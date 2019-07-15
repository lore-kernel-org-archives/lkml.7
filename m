Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679EBC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3205E20896
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563200597;
	bh=Eym8MS50yHo72lBKZmtYkwak9akjxUM9NVoKAzzueeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D6H1v6RzifJdclZzA3tJVZj/IDQkiJqndf6WY+97elBJmRQV7SS55DBdLQOOfc8YA
	 /vy3GaVgE83Mea9Z4GY1GpCKCGV6ReFatho0ydLZTZAUkz8yWE4mdIz81iDEnlvMl7
	 TaoQ4eVCGOb8xuO320I6+xd93lwp+neqOym0t9A8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390729AbfGOOXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:23:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730883AbfGOOXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:23:13 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49EAF2053B;
        Mon, 15 Jul 2019 14:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200592;
        bh=Eym8MS50yHo72lBKZmtYkwak9akjxUM9NVoKAzzueeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2CpBa21LS6TLnpKFy+vRg76EyOaLhUC5GPfL3ZPoPODvv51yCiCvI2Pr1gTGdBFF
         LgBtOS34uL1IdQZ6ZRxOSz1bWbSsb6x+xDIpOsAhGsvsnoRzpPIN1j2THNBEMirvvG
         IWWF+eC8i40jv6t1NhVmJjSmxAB0jtysjx3m7614=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Minwoo Im <minwoo.im.dev@gmail.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 086/158] nvme-pci: properly report state change failure in nvme_reset_work
Date:   Mon, 15 Jul 2019 10:16:57 -0400
Message-Id: <20190715141809.8445-86-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715141809.8445-1-sashal@kernel.org>
References: <20190715141809.8445-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minwoo Im <minwoo.im.dev@gmail.com>

[ Upstream commit cee6c269b016ba89c62e34d6bccb103ee2c7de4f ]

If the state change to NVME_CTRL_CONNECTING fails, the dmesg is going to
be like:

  [  293.689160] nvme nvme0: failed to mark controller CONNECTING
  [  293.689160] nvme nvme0: Removing after probe failure status: 0

Even it prints the first line to indicate the situation, the second line
is not proper because the status is 0 which means normally success of
the previous operation.

This patch makes it indicate the proper error value when it fails.
  [   25.932367] nvme nvme0: failed to mark controller CONNECTING
  [   25.932369] nvme nvme0: Removing after probe failure status: -16

This situation is able to be easily reproduced by:
  root@target:~# rmmod nvme && modprobe nvme && rmmod nvme

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c8eeecc58115..03e72e2f57f5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2294,6 +2294,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_warn(dev->ctrl.device,
 			"failed to mark controller CONNECTING\n");
+		result = -EBUSY;
 		goto out;
 	}
 
-- 
2.20.1

