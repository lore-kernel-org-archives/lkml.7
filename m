Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2669C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB9924189
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190168;
	bh=bGWh8woQtXz5m+43YaRhu03gvWUMuFyE+qLFTPAiZ50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ere+vRLNHDZLB+CJTh0sRkzFbmIf6GxgToCWZoF8F+4/AnhrDtRUm9nYr22rvLN3K
	 IbPiZ+2ik88zLsFeSW63Ms2hmIuQ47UxAilWZFb12c+H2gPZ5790ITKpfZZSh4AOX7
	 QxwjV8eReq1UyG5xCNQLiM9oNIbxesBiawb3yzBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfE3EWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730089AbfE3DPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:15:04 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B892457B;
        Thu, 30 May 2019 03:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186103;
        bh=bGWh8woQtXz5m+43YaRhu03gvWUMuFyE+qLFTPAiZ50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJq2LPSahOZVIkPuPqXwv30AtT+Qe0JD6+N8P35TR929JEwaBuZJj9eF+eaY7nQ7d
         1cxw/7GBQCRH9yd2InX3t0K+5gTEei99UPHudzG9N5Cwuca1E82/f7w6P8uXJDlqkh
         vfF+16TjkMJPDibkrcy8uCDMMuZGF/I4+aBLhK/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 244/346] chardev: add additional check for minor range overlap
Date:   Wed, 29 May 2019 20:05:17 -0700
Message-Id: <20190530030553.382956498@linuxfoundation.org>
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
index a279c58fe3606..8a63cfa290053 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -159,6 +159,12 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
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



