Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDDCC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C5021951
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996541;
	bh=kiF7LpIZs7E8hkOpmeu+j/x0mZ6sFmbjCc3yKNlnRJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xcc6Ys/KSnfMU6qmiTOXKjzO2eq6furKZc/maAquWi17+UCJDXhpUBjMeJUURpRgP
	 ERkTmuZqlzSfKsLPslZQjgSFVy0Nw5aSr/TKE3jnkKpL+BKunFZ9/ICULl1C5jRFWM
	 dzjcfR8ckeEOg3OhHd2mngB9mt5Y2W3pJfnPQ1cU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfGXT3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:29:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387658AbfGXT26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:28:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A03D6229FA;
        Wed, 24 Jul 2019 19:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996537;
        bh=kiF7LpIZs7E8hkOpmeu+j/x0mZ6sFmbjCc3yKNlnRJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7HHe5AMXL7fWusW600rywxtkepFp/Zs4Hkn2YuJ8nc2zxj5fC4O7xaSoW/cVNBRe
         JX6JE0cftZQMTsPKDSClrMKNQhhk9JAymhocis8yKHccTWkoQNXADFHBlOcuIoIBvm
         3BrLp6C5nUnUVlTlBEPlHFKR15X3nAsEfm/ma01s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 132/413] nvme-pci: properly report state change failure in nvme_reset_work
Date:   Wed, 24 Jul 2019 21:17:03 +0200
Message-Id: <20190724191744.482131840@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 524d6bd6d095..385ba7a1e23b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2528,6 +2528,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_warn(dev->ctrl.device,
 			"failed to mark controller CONNECTING\n");
+		result = -EBUSY;
 		goto out;
 	}
 
-- 
2.20.1



