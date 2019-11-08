Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CEBC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8BE222C5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213719;
	bh=7t+zd6ApZDLHyDBXxaHnsvqdU5V0/DfKsl898ThufDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GVp3bJyQgBYJSWr6UpUeZld+sEfBuDSi5P8sJtKgjtF17aXQ9ZGuUNQ7GgfQfAlXH
	 6uPORBYTrt5f29Ifwd2X41OEMEBqE51itSw97ZLxyDwzJychg9jNDVydAKC7udA6K+
	 m43rC971yXThN9FS5EefurolyWp42rALquo0CmnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391776AbfKHLsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:48:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:37078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391713AbfKHLsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:48:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA86F22473;
        Fri,  8 Nov 2019 11:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213688;
        bh=7t+zd6ApZDLHyDBXxaHnsvqdU5V0/DfKsl898ThufDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AUWgHiHFCRWQ/9SyTG1TDjhbRStH8znvxM35f9ZZc443MGbZviFRs1CiHL5IaZXqw
         9q3h3bwi71TbHH7eV5VtWUrqNeDTJdtn+1RSn2geAj4NJz0+YOM3kl+7TjeQD+qN0E
         l8mg2d5RTiIUa8zJqdcTUDZFTq0fAy9BFCd8dpKk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lao Wei <zrlw@qq.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 34/44] media: fix: media: pci: meye: validate offset to avoid arbitrary access
Date:   Fri,  8 Nov 2019 06:47:10 -0500
Message-Id: <20191108114721.15944-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114721.15944-1-sashal@kernel.org>
References: <20191108114721.15944-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

