Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346D4C17440
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043A4222CF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610170;
	bh=ynIhFj/qx4jDaE1Oo3VHwQCKtQ8asuUgAcjpPSkosCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Aj4DAP9tiP0p+IE+huExifNoTanVQiblb2nDNy99VXWeopb4VfOHUNynGk+dwYx8j
	 JIn8KbQDCzFyJASJoDdwFEH/UFSy0Itv4cN42xJcOgM8zZbRyt2+Ad2Pa2nxENQEAa
	 pjrNXy9psYdyEIV3cEoESm6eFkQ2AW1wX03xaak4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfKMB4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:56:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729288AbfKMBzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:55:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E73722473;
        Wed, 13 Nov 2019 01:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610152;
        bh=ynIhFj/qx4jDaE1Oo3VHwQCKtQ8asuUgAcjpPSkosCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q8y3PzVaR1c1Chf6hfIKQC0qe0Dz3Q2zwSxo8UYriI4p5C4Y6xY82Z3MdydYQpgt4
         82CbEYhKPFPozUkyziGnDkrt46FsYHdefMqAyYncEauWkpnNbguRqHjbUz0SzOKzEz
         RnTLHHYgYQjsEpvdPLH4qYLSHkBHVvyuqYgmoT4c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhong jiang <zhongjiang@huawei.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 196/209] misc: cxl: Fix possible null pointer dereference
Date:   Tue, 12 Nov 2019 20:50:12 -0500
Message-Id: <20191113015025.9685-196-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>

[ Upstream commit 3dac3583bf1a61db6aaf31dfd752c677a4400afd ]

It is not safe to dereference an object before a null test. It is
not needed and just remove them. Ftrace can be used instead.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/cxl/guest.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index b83a373e3a8dd..08f4a512afad2 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -1020,8 +1020,6 @@ int cxl_guest_init_afu(struct cxl *adapter, int slice, struct device_node *afu_n
 
 void cxl_guest_remove_afu(struct cxl_afu *afu)
 {
-	pr_devel("in %s - AFU(%d)\n", __func__, afu->slice);
-
 	if (!afu)
 		return;
 
-- 
2.20.1

