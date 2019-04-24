Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131BDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA1D2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126070;
	bh=8SXN7kVEbWneN/fUkuZsPwDRcUCNZxC/qJjPUpWZTNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xe9LVyj2v50wrLEhbTqH57Raf+sQjoh23zXq065T74EjAF7nFDw41oQpLFR9yyhUR
	 8025+CexMYtV3Dvqcn/LOdMQKpqRvXjpnpRzW8kA1hXCMY6nqW1lhmaAb8zlxYg9OC
	 pDmv53qqtZgfUVyD+Y3Hpjb8pIVpTorkOy4q8TeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388075AbfDXRO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388062AbfDXROY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:14:24 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B5AD218FE;
        Wed, 24 Apr 2019 17:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126063;
        bh=8SXN7kVEbWneN/fUkuZsPwDRcUCNZxC/qJjPUpWZTNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vnIdkv5U5s+4FK4ORMnAETbJWxn8TS5tLnRt4AIq7bZwNuF6+onedthmtI4vHlb6S
         dLpueLIem8vYepDApjOXZcbQHa4BRAWLGqAPiuDYA5srps4J8W7ferIz/1W39NWPQL
         2pw3CuRRwmGwIHB0U30Juw0ADcNe+3BUdwjLzFoo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Buland Singh <bsingh@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 035/104] hpet: Fix missing = character in the __setup() code of hpet_mmap_enable
Date:   Wed, 24 Apr 2019 19:08:52 +0200
Message-Id: <20190424170858.170359281@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 24d48a61f2666630da130cc2ec2e526eacf229e3 ]

Commit '3d035f580699 ("drivers/char/hpet.c: allow user controlled mmap for
user processes")' introduced a new kernel command line parameter hpet_mmap,
that is required to expose the memory map of the HPET registers to
user-space. Unfortunately the kernel command line parameter 'hpet_mmap' is
broken and never takes effect due to missing '=' character in the __setup()
code of hpet_mmap_enable.

Before this patch:

dmesg output with the kernel command line parameter hpet_mmap=1

[    0.204152] HPET mmap disabled

dmesg output with the kernel command line parameter hpet_mmap=0

[    0.204192] HPET mmap disabled

After this patch:

dmesg output with the kernel command line parameter hpet_mmap=1

[    0.203945] HPET mmap enabled

dmesg output with the kernel command line parameter hpet_mmap=0

[    0.204652] HPET mmap disabled

Fixes: 3d035f580699 ("drivers/char/hpet.c: allow user controlled mmap for user processes")
Signed-off-by: Buland Singh <bsingh@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index d5d4cd82b9f7..978a782f5e30 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -377,7 +377,7 @@ static __init int hpet_mmap_enable(char *str)
 	pr_info("HPET mmap %s\n", hpet_mmap_enabled ? "enabled" : "disabled");
 	return 1;
 }
-__setup("hpet_mmap", hpet_mmap_enable);
+__setup("hpet_mmap=", hpet_mmap_enable);
 
 static int hpet_mmap(struct file *file, struct vm_area_struct *vma)
 {
-- 
2.19.1



