Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D75DC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6056821726
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557917971;
	bh=Rigk2BP1vhzhrGcwtIj8zm7+kw/wq++uhMPtlRGgHN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lKir1c28McXVhQtYZpMwWLoTamNuPnxG18BA60ShBpcWS/ANlIEGwVsalVc0/C6j1
	 OJ3UQoTvj092G5cUFAL3xYFBkKyvZYsgseDsiaPEmwWqBiDRSU9bdwI2+8+4/gSxcL
	 /NVHoyAe47/p8AQVzP4CZlI7iIPv4w4/Sc+RNwNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfEOK7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbfEOK7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:59:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD0662166E;
        Wed, 15 May 2019 10:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557917965;
        bh=Rigk2BP1vhzhrGcwtIj8zm7+kw/wq++uhMPtlRGgHN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JWEa4yJAU+x8hHsPqhP2FyuYZ72mDyTLm3DS6abLuy1ZySc0nxAJDgdIO2a/yODU0
         v1/+CoSeGYv6RH9A4zJqfoLkMNViO2yVSX1qiUASbviWST8jYebvjjhia1y60IeVQ7
         ec7Au3o4cq4XopBTv166en+eYBeVG6nqoTBKqJzQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Long Li <longli@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 42/86] scsi: storvsc: Fix calculation of sub-channel count
Date:   Wed, 15 May 2019 12:55:19 +0200
Message-Id: <20190515090650.899536539@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090642.339346723@linuxfoundation.org>
References: <20190515090642.339346723@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 382e06d11e075a40b4094b6ef809f8d4bcc7ab2a ]

When the number of sub-channels offered by Hyper-V is >= the number of CPUs
in the VM, calculate the correct number of sub-channels.  The current code
produces one too many.

This scenario arises only when the number of CPUs is artificially
restricted (for example, with maxcpus=<n> on the kernel boot line), because
Hyper-V normally offers a sub-channel count < number of CPUs.  While the
current code doesn't break, the extra sub-channel is unbalanced across the
CPUs (for example, a total of 5 channels on a VM with 4 CPUs).

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/storvsc_drv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 96c6e75bbfe6..bc29b571e3fb 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -788,13 +788,22 @@ static void handle_sc_creation(struct vmbus_channel *new_sc)
 static void  handle_multichannel_storage(struct hv_device *device, int max_chns)
 {
 	struct storvsc_device *stor_device;
-	int num_cpus = num_online_cpus();
 	int num_sc;
 	struct storvsc_cmd_request *request;
 	struct vstor_packet *vstor_packet;
 	int ret, t;
 
-	num_sc = ((max_chns > num_cpus) ? num_cpus : max_chns);
+	/*
+	 * If the number of CPUs is artificially restricted, such as
+	 * with maxcpus=1 on the kernel boot line, Hyper-V could offer
+	 * sub-channels >= the number of CPUs. These sub-channels
+	 * should not be created. The primary channel is already created
+	 * and assigned to one CPU, so check against # CPUs - 1.
+	 */
+	num_sc = min((int)(num_online_cpus() - 1), max_chns);
+	if (!num_sc)
+		return;
+
 	stor_device = get_out_stor_device(device);
 	if (!stor_device)
 		return;
-- 
2.20.1



