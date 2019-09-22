Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C92C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9717621479
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178730;
	bh=wNr6pegQhACiQ4qzoUw117XMXI00XuVxmvoZN5YDoVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sy/LLHr8Nxz06ioCeZjloM+3lW7Iz5DM4JFETSO+4QccSQKaCMu+dc1ml0P2cZgwY
	 JBK4cYig4PeU5jk0X0g1dGopkYg5RARf7tYIPGiCxtL0JOCZMX9pCCYcVNOqf5qhYH
	 ZYRdjjEbal1g/HTxfJK7dMhun+jOzJU5V3bcQ3zw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438820AbfIVS6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394926AbfIVS6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:58:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C14E2190F;
        Sun, 22 Sep 2019 18:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178723;
        bh=wNr6pegQhACiQ4qzoUw117XMXI00XuVxmvoZN5YDoVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rc/7qLMHbf6WB9Z+tfw/oiOlUpMcBqbuRm7xCGeK8tMS9KjWJrrjL0dYC5496XQhW
         t0uiA0bDhSNeVqxuAJ/SFQL+eRBfQ8K8beuTSgk9YOAKYlklME/KKgzLWBU2L4oIpc
         lPWjX/DrknkBKfMOIFj6D/ag7qPO3fJnHv4UMLew=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 55/89] media: saa7146: add cleanup in hexium_attach()
Date:   Sun, 22 Sep 2019 14:56:43 -0400
Message-Id: <20190922185717.3412-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185717.3412-1-sashal@kernel.org>
References: <20190922185717.3412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit 42e64117d3b4a759013f77bbcf25ab6700e55de7 ]

If saa7146_register_device() fails, no cleanup is executed, leading to
memory/resource leaks. To fix this issue, perform necessary cleanup work
before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/saa7146/hexium_gemini.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/pci/saa7146/hexium_gemini.c b/drivers/media/pci/saa7146/hexium_gemini.c
index 934332f1fd8e6..a527d86b93a77 100644
--- a/drivers/media/pci/saa7146/hexium_gemini.c
+++ b/drivers/media/pci/saa7146/hexium_gemini.c
@@ -304,6 +304,9 @@ static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_d
 	ret = saa7146_register_device(&hexium->video_dev, dev, "hexium gemini", VFL_TYPE_GRABBER);
 	if (ret < 0) {
 		pr_err("cannot register capture v4l2 device. skipping.\n");
+		saa7146_vv_release(dev);
+		i2c_del_adapter(&hexium->i2c_adapter);
+		kfree(hexium);
 		return ret;
 	}
 
-- 
2.20.1

