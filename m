Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5BAC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A362080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432434;
	bh=0+yaXhQnBErVecFvrQQyawxTBnfvijIfEZBpnGNzXgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MDhNYoxs6h7Rxkoe8xWENA+bTlij51GmTI98YDgwnLOZfaWqInN3wmezq8TVCt5y/
	 zPZ9ZrmSBU1GmdTBu26NuUKYuz/m4r9QL25J4YmPL9hirUVxyGTvGF57i4Mc3tyTsX
	 YqJFvInggmmQ+FOCTQ8bQBsoRlemrQ4i5CYhUhtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgAGU6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:58:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbgAGU57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:57:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E2D22467E;
        Tue,  7 Jan 2020 20:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430679;
        bh=0+yaXhQnBErVecFvrQQyawxTBnfvijIfEZBpnGNzXgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EI3X4EBQrSa/Q0uMEPfpikZscOfjazE661LVZ4AMtUWM7IT7ifSVaO8zMqLas5zQ8
         NO5uN17uYd0ZXgVB117S4nOzkFVc8+J8UsQWYBeWMOqTC+yK7ZkT0laKZWDQqxCI62
         azlcGBIBkgnbw0f8T9Ku7MvylmoQuzbEcGNpVQZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 044/191] md: raid1: check rdev before reference in raid1_sync_request func
Date:   Tue,  7 Jan 2020 21:52:44 +0100
Message-Id: <20200107205335.350334571@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhiqiang Liu <liuzhiqiang26@huawei.com>

[ Upstream commit 028288df635f5a9addd48ac4677b720192747944 ]

In raid1_sync_request func, rdev should be checked before reference.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index bb29aeefcbd0..c7137f50bd1d 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2781,7 +2781,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 				write_targets++;
 			}
 		}
-		if (bio->bi_end_io) {
+		if (rdev && bio->bi_end_io) {
 			atomic_inc(&rdev->nr_pending);
 			bio->bi_iter.bi_sector = sector_nr + rdev->data_offset;
 			bio_set_dev(bio, rdev->bdev);
-- 
2.20.1



