Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C4DC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD3025270
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189904;
	bh=pQK9U6rZP+L8wvsXni62ESRUUwgsKaFdxKJqAymMupU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SFCq7lKHo1kMDWjwEAZFEYXUrTlPBQMqj/E/i5xIlEH333oocQb+NWEC11HyWjDr1
	 SY0sfnr822zosp2Gx456gFQQnaTw+QJi6Dksw59zx2dMv6ItSZWrnjYpMkw+X42jZa
	 JzmcHtR2trzxhqLUoY5P2JnPQFn8Bo3oEpw0GB64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfE3ESW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730339AbfE3DPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:15:32 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B7A624569;
        Thu, 30 May 2019 03:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186131;
        bh=pQK9U6rZP+L8wvsXni62ESRUUwgsKaFdxKJqAymMupU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qRzG+MHyRoa8NyXQ+Kg4EtbkMpAmjZx5ruyTfWHIM63zYjjsu51avSKwDlQ+/QyPX
         M9+xzENW5jimJxxk38HrSzc7jn4CWqhxnk1NigKeIs5hOt0N6Rhi13ydqLaL0jbu9d
         qH93+WwOHRgJVT2iRmfEhvQtgAhtv+wIyqVYAKU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 294/346] e1000e: Disable runtime PM on CNP+
Date:   Wed, 29 May 2019 20:06:07 -0700
Message-Id: <20190530030555.754421107@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 459d69c407f9ba122f12216555c3012284dc9fd7 ]

There are some new e1000e devices can only be woken up from D3 one time,
by plugging Ethernet cable. Subsequent cable plugging does set PME bit
correctly, but it still doesn't get woken up.

Since e1000e connects to the root complex directly, we rely on ACPI to
wake it up. In this case, the GPE from _PRW only works once and stops
working after that. Though it appears to be a platform bug, e1000e
maintainers confirmed that I219 does not support D3.

So disable runtime PM on CNP+ chips. We may need to disable earlier
generations if this bug also hit older platforms.

Bugzilla: https://bugzilla.kernel.org/attachment.cgi?id=280819
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 7acc61e4f6456..c10c9d7eadaac 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7350,7 +7350,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NEVER_SKIP);
 
-	if (pci_dev_run_wake(pdev))
+	if (pci_dev_run_wake(pdev) && hw->mac.type < e1000_pch_cnp)
 		pm_runtime_put_noidle(&pdev->dev);
 
 	return 0;
-- 
2.20.1



