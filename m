Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAC9C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212A62072D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418774;
	bh=7t+zd6ApZDLHyDBXxaHnsvqdU5V0/DfKsl898ThufDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EqZOlqa1gauVcW5BpaeVlSZXeSdxRABmC3BVxDaV9zkcxqYFOm0xsex8xKweMeqrc
	 E0AKwIEr51aTdOQYDBzNfmc3YW3EXsNu0iE8uRmkKoqxXzSFjNf+AsIebAgEZemp1G
	 VV0KuN7rLMrZNLFZyrTJxhAN6Tc9OUQ7Ytc1ea08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfKVKct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:32:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbfKVKcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:32:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E790E20726;
        Fri, 22 Nov 2019 10:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418765;
        bh=7t+zd6ApZDLHyDBXxaHnsvqdU5V0/DfKsl898ThufDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VBlderYvG8ubym8YNaMbdNqKXY1DFkrJbnRsKol0xYoKj1iafbti1F5at7c/+ASZW
         ASXQsHubdvTVMqAWe96qOfvsohnoniDL8IgRvGQU+9TZ82YCRJkyZ0LQ/gjNyjLpnH
         0a86Quwj+cHEleCH5zBAW4ptgsK7Cpq4egOp6J+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lao Wei <zrlw@qq.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 045/159] media: fix: media: pci: meye: validate offset to avoid arbitrary access
Date:   Fri, 22 Nov 2019 11:27:16 +0100
Message-Id: <20191122100738.056313239@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lao Wei <zrlw@qq.com>

[ Upstream commit eac7230fdb4672c2cb56f6a01a1744f562c01f80 ]

Motion eye video4linux driver for Sony Vaio PictureBook desn't validate user-controlled parameter
'vma->vm_pgoff', a malicious process might access all of kernel memory from user space by trying
pass different arbitrary address.
Discussion: http://www.openwall.com/lists/oss-security/2018/07/06/1

Signed-off-by: Lao Wei <zrlw@qq.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/meye/meye.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/meye/meye.c b/drivers/media/pci/meye/meye.c
index ba887e8e1b171..a85c5199ccd30 100644
--- a/drivers/media/pci/meye/meye.c
+++ b/drivers/media/pci/meye/meye.c
@@ -1469,7 +1469,7 @@ static int meye_mmap(struct file *file, struct vm_area_struct *vma)
 	unsigned long page, pos;
 
 	mutex_lock(&meye.lock);
-	if (size > gbuffers * gbufsize) {
+	if (size > gbuffers * gbufsize || offset > gbuffers * gbufsize - size) {
 		mutex_unlock(&meye.lock);
 		return -EINVAL;
 	}
-- 
2.20.1



