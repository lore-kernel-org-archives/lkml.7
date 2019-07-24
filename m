Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804D6C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E202054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000349;
	bh=q+ot2fxsXnPozpPYSz+QkVHJLk2RXJQAoDWjkYnihxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZgJuKdro65aIiTgBzsA74YGyB8GNblTzHAFuVUKK6TYRlZs8sUJJhXld7ybWtJH0a
	 XXo2Yb2ldKo4uAOcV/BuoPwBOsOiuMRVOisPZYmnCE5SIPJ+bfWl12CUv/OlUvMBBF
	 I8R8Kg3qisWubUYw6h7cLpPefcDkvk/BvkZSuI/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbfGXT2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:28:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728886AbfGXT2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:28:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6541120659;
        Wed, 24 Jul 2019 19:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996531;
        bh=q+ot2fxsXnPozpPYSz+QkVHJLk2RXJQAoDWjkYnihxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mW8kXynhnlSX5OLjCEvoV/ND4zNX0iOJlmbJn9hkCc/JWqLoqMPfCtcDqf06tQrmI
         f4LgYF3/TTTojMfbQQcX9bZ8RnOHjlziygwSzl6muX4a/yKZPoj/ZP495izmiB6xs/
         bedA4GENImPrNba4O7NxCnVNrr+Dd9v14NquPHfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Borislav Petkov <bp@suse.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 130/413] EDAC/sysfs: Fix memory leak when creating a csrow object
Date:   Wed, 24 Jul 2019 21:17:01 +0200
Message-Id: <20190724191744.373441644@linuxfoundation.org>
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

[ Upstream commit 585fb3d93d32dbe89e718b85009f9c322cc554cd ]

In edac_create_csrow_object(), the reference to the object is not
released when adding the device to the device hierarchy fails
(device_add()). This may result in a memory leak.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: https://lkml.kernel.org/r/1555554438-103953-1-git-send-email-bianpan2016@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/edac_mc_sysfs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index bf9273437e3f..7c01e1cc030c 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -404,6 +404,8 @@ static inline int nr_pages_per_csrow(struct csrow_info *csrow)
 static int edac_create_csrow_object(struct mem_ctl_info *mci,
 				    struct csrow_info *csrow, int index)
 {
+	int err;
+
 	csrow->dev.type = &csrow_attr_type;
 	csrow->dev.groups = csrow_dev_groups;
 	device_initialize(&csrow->dev);
@@ -415,7 +417,11 @@ static int edac_create_csrow_object(struct mem_ctl_info *mci,
 	edac_dbg(0, "creating (virtual) csrow node %s\n",
 		 dev_name(&csrow->dev));
 
-	return device_add(&csrow->dev);
+	err = device_add(&csrow->dev);
+	if (err)
+		put_device(&csrow->dev);
+
+	return err;
 }
 
 /* Create a CSROW object under specifed edac_mc_device */
-- 
2.20.1



