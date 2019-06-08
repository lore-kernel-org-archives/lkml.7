Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1767BC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78352168B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994473;
	bh=xjAg3KJZOD7vQU3QrEnwlOUgD9+g/NMDx/4/9G02528=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W8jRtJHY9M6vhyX+VATJnVy9bd2ZTzEHuDjewT0/M2nvJqL5i+Tj0H3V5wtpZrzQ4
	 PXbJ2nRedu9/IfFNYhAi+xKmwhe5eiXd3t/nq5t16CU26qi1PWMb7b4a5uNbngWnkW
	 dUKKsKyh7Yp8YIRFw3Z75mFDW9ibe5BahvIXtDzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfFHLrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:47:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729404AbfFHLrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:47:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB5E42168B;
        Sat,  8 Jun 2019 11:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994467;
        bh=xjAg3KJZOD7vQU3QrEnwlOUgD9+g/NMDx/4/9G02528=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E1QJz/o/Czs5u16a7aW3+ACG0lSJ0idZxVwxbLTDGsooR9E+emBC/l0Hb/YIjsuKa
         xf47EYa3Q41XPJSh6o95OZE6MGmOaAg3uEse955KbHl1G36kda7WvqMWcwmel98hlM
         6MeENQap97y2nsvkSDepy4TCHNzYH5+ta4j6Vu5w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Varun Prakash <varun@chelsio.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 27/31] scsi: libcxgbi: add a check for NULL pointer in cxgbi_check_route()
Date:   Sat,  8 Jun 2019 07:46:38 -0400
Message-Id: <20190608114646.9415-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608114646.9415-1-sashal@kernel.org>
References: <20190608114646.9415-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Varun Prakash <varun@chelsio.com>

[ Upstream commit cc555759117e8349088e0c5d19f2f2a500bafdbd ]

ip_dev_find() can return NULL so add a check for NULL pointer.

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/cxgbi/libcxgbi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
index 512c8f1ea5b0..902f5e03ec94 100644
--- a/drivers/scsi/cxgbi/libcxgbi.c
+++ b/drivers/scsi/cxgbi/libcxgbi.c
@@ -640,6 +640,10 @@ cxgbi_check_route(struct sockaddr *dst_addr, int ifindex)
 
 	if (ndev->flags & IFF_LOOPBACK) {
 		ndev = ip_dev_find(&init_net, daddr->sin_addr.s_addr);
+		if (!ndev) {
+			err = -ENETUNREACH;
+			goto rel_neigh;
+		}
 		mtu = ndev->mtu;
 		pr_info("rt dev %s, loopback -> %s, mtu %u.\n",
 			n->dev->name, ndev->name, mtu);
-- 
2.20.1

