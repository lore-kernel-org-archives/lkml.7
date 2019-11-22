Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146DCC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C9A20840
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420742;
	bh=ynIhFj/qx4jDaE1Oo3VHwQCKtQ8asuUgAcjpPSkosCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bsAgMPMi4+1KOnNLLHYKWdH+kHxJ869hyRmcimFyk2wwcE1r8YZ9iXb8DLHIAdfrA
	 POUit+wemVV8SX4Dfhmk+2VFj6pS/aCyeAAVFNszNLXnEVl2JE+XyUwGbgGu9ErRSV
	 jFwyN4NNOF3ZoGJQqsJV6LKA/FhlbJCHZWGDnF5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbfKVLFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:05:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbfKVLFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:05:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D312075E;
        Fri, 22 Nov 2019 11:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420738;
        bh=ynIhFj/qx4jDaE1Oo3VHwQCKtQ8asuUgAcjpPSkosCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QDPGXjZ7hzIoVCgrqZA8HPzfCpiN2vWxbdk3jUfVxc7VzlEeWsNrNwxWTydD1qrWs
         qunva8rLZHuxSAYtG8CvM+Y95BdyNN0Telu7E20dvz8TgxbYsgcSyI3NVmcaRt7jsM
         WPPt/eCN4DpGmo6D8N1bdKV5Jypf0ND1oZuRoUD4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhong jiang <zhongjiang@huawei.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 207/220] misc: cxl: Fix possible null pointer dereference
Date:   Fri, 22 Nov 2019 11:29:32 +0100
Message-Id: <20191122100928.666665210@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



