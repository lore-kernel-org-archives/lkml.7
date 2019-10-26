Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88247CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5534C206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096492;
	bh=8mBqH8vbD/k/fQkmUBFop3VZFHsaPRKIhxQaiD8pzqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yYfEVGL5/be8d20JC+T3w02zE5o10xURWjUh0UXnhbhDLT/LapjDJX6zHDYpRPJ3o
	 ibOr9/jg3XR+pFJz51O9kihZHm7mt7Rrg6jxr6xlQZpPJWv92LBPsPIR2YVyZ30xOH
	 g05YunNWnkaDpebov07u7lRA8c9M3XIEViVCqksQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfJZN2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbfJZNVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:21:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7567E222BD;
        Sat, 26 Oct 2019 13:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572096074;
        bh=8mBqH8vbD/k/fQkmUBFop3VZFHsaPRKIhxQaiD8pzqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XJcpYRbMvcD70xDmu+xE7ESLOfv8SZDF1UPDt8F2/0vhIs+YLG9ftI+OvgluliwTl
         AQZiXOMDBa3gdyGSYlK1HoLMLcA3wQWyxe1PzNAWZbqhOK9XcIV/7LGqswK003nDA0
         +oZOlib332Ga1q7G0t/bxgZJhICzDK4tWH29oXbw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 03/33] nvme: retain split access workaround for capability reads
Date:   Sat, 26 Oct 2019 09:20:40 -0400
Message-Id: <20191026132110.4026-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026132110.4026-1-sashal@kernel.org>
References: <20191026132110.4026-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

[ Upstream commit 3a8ecc935efabdad106b5e06d07b150c394b4465 ]

Commit 7fd8930f26be4

  "nvme: add a common helper to read Identify Controller data"

has re-introduced an issue that we have attempted to work around in the
past, in commit a310acd7a7ea ("NVMe: use split lo_hi_{read,write}q").

The problem is that some PCIe NVMe controllers do not implement 64-bit
outbound accesses correctly, which is why the commit above switched
to using lo_hi_[read|write]q for all 64-bit BAR accesses occuring in
the code.

In the mean time, the NVMe subsystem has been refactored, and now calls
into the PCIe support layer for NVMe via a .reg_read64() method, which
fails to use lo_hi_readq(), and thus reintroduces the problem that the
workaround above aimed to address.

Given that, at the moment, .reg_read64() is only used to read the
capability register [which is known to tolerate split reads], let's
switch .reg_read64() to lo_hi_readq() as well.

This fixes a boot issue on some ARM boxes with NVMe behind a Synopsys
DesignWare PCIe host controller.

Fixes: 7fd8930f26be4 ("nvme: add a common helper to read Identify Controller data")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cd11cced36781..3788c053a0b19 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2274,7 +2274,7 @@ static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 
 static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 {
-	*val = readq(to_nvme_dev(ctrl)->bar + off);
+	*val = lo_hi_readq(to_nvme_dev(ctrl)->bar + off);
 	return 0;
 }
 
-- 
2.20.1

