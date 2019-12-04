Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AEFC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983D62084B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482681;
	bh=HrvkQmIy1wCzH0pi9Xov1kIUGDIYQiuaTMJmZSTiLbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KmV0cJGVyoTS3RRfipT9ReSdSopjgKScGPXqB3o+PcBxZcrApYAylr3BKyT7tnzc1
	 isoHDHUKWAlI9DHCyWyrI9PDbpcwjSAPXLZQl1zOoKrRrvNkd/q42ApRuUuqIEHYtv
	 v3Ja3T4ybY4uD2VzkerepFzv3W7wJaIggxNgOnNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfLDSEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:04:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:50132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730242AbfLDSEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:04:38 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD0B520833;
        Wed,  4 Dec 2019 18:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482678;
        bh=HrvkQmIy1wCzH0pi9Xov1kIUGDIYQiuaTMJmZSTiLbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ONQiVXnXd/hL3b/VRF62TDYDjeDkPjDZHIG4F60Bp5Tz05EyT15S0UF4StI+x2wzM
         VAsBKnYfzgjr/npqs1JZ4vpLPLbItu6l3d4cG3baZPu9MA/qgtT3avCyGOQ3iK8xT7
         Ip5e4CEZIuNakijAh15ek4zAd8YCH/zqZiQBOD6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 090/209] scsi: csiostor: fix incorrect dma device in case of vport
Date:   Wed,  4 Dec 2019 18:55:02 +0100
Message-Id: <20191204175327.928606970@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Varun Prakash <varun@chelsio.com>

[ Upstream commit 9934613edcb40b92a216122876cd3b7e76d08390 ]

In case of ->vport_create() call scsi_add_host_with_dma() instead of
scsi_add_host() to pass correct dma device.

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/csiostor/csio_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/csiostor/csio_init.c b/drivers/scsi/csiostor/csio_init.c
index 28a9c7d706cb0..03c7b1603dbc1 100644
--- a/drivers/scsi/csiostor/csio_init.c
+++ b/drivers/scsi/csiostor/csio_init.c
@@ -649,7 +649,7 @@ csio_shost_init(struct csio_hw *hw, struct device *dev,
 	if (csio_lnode_init(ln, hw, pln))
 		goto err_shost_put;
 
-	if (scsi_add_host(shost, dev))
+	if (scsi_add_host_with_dma(shost, dev, &hw->pdev->dev))
 		goto err_lnode_exit;
 
 	return ln;
-- 
2.20.1



