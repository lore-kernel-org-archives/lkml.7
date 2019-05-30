Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89521C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558F524C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559187729;
	bh=u/o9e/Zn2ubRLqes5gnJEJABVXFhgeWSjSpwDT/8djA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bNZlXYVrC9AQUR7H/cHXOJ9qKDuLbDFko8tzvPXL2BvSdw7pxvs3lsxJ2D+ZkvoI6
	 nXhGpiDIDfDMYkv+DzuhYhY9ukKyFR0mMyrj+LrN0IvSgapXCKB/6f39NJfGoVK0y+
	 2Uy1KPAht99Ml8R6lGF7FJsU5Kuv2ZhHfXp4zvY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732770AbfE3DmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730805AbfE3DVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:21:14 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5600249DA;
        Thu, 30 May 2019 03:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186473;
        bh=u/o9e/Zn2ubRLqes5gnJEJABVXFhgeWSjSpwDT/8djA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+3V/+dkr754WXFAwbboXUadkxl+yL2BfCaYDNDbw9lCGrKcGNJQfhYf3JeMmerkN
         Dw/XkLaR+HZyaVJ3rvxl/sf+/jNE03l4F7CSPqkIqU0ToC7jOtMIFiHKT0b6lPSvlU
         EsRTGs+EWHw0SlMO4es08Phh6H68Pnlhw0pqh930=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 104/128] chardev: add additional check for minor range overlap
Date:   Wed, 29 May 2019 20:07:16 -0700
Message-Id: <20190530030453.326003210@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030432.977908967@linuxfoundation.org>
References: <20190530030432.977908967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit de36e16d1557a0b6eb328bc3516359a12ba5c25c ]

Current overlap checking cannot correctly handle
a case which is baseminor < existing baseminor &&
baseminor + minorct > existing baseminor + minorct.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/char_dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 44a240c4bb658..a112a4745d8b3 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -134,6 +134,12 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
 			ret = -EBUSY;
 			goto out;
 		}
+
+		if (new_min < old_min && new_max > old_max) {
+			ret = -EBUSY;
+			goto out;
+		}
+
 	}
 
 	cd->next = *cp;
-- 
2.20.1



