Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7A3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB7E2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368327;
	bh=d4YPMmH+i3bU47CATnZ71KJ7uxoAoYkvL9eyS7quu18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iIxI3QSF6m8nQMRd/UK+a68ih7WswMihgMwycjS4NnmSrwI+h+lyKvagFoe2NeeAR
	 aIDGOfbRgfLKvNsIbgnbPBXsVLLGgdMFkRPReW4tSH8twl85xiAqani90rAn0w37TK
	 2xsDMycUqMeIL8KbuM/nG4bnS9QbJAvy4GaIaUSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfDDI6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730553AbfDDI6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:58:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F34EA2075E;
        Thu,  4 Apr 2019 08:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368322;
        bh=d4YPMmH+i3bU47CATnZ71KJ7uxoAoYkvL9eyS7quu18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lUmOVapF5dKKT2TbwIQBo6qCLj00Ijmk8FRPHFn5uyN6MB0AGjG6gqFwMQkz2iDA3
         uvW0ADWN1YgNxK5VIXGT7C00OVhjqDYH5hRFcJM7IdDzfv0PaNIzWVdc8fgAlzMucT
         YhCE5U+AYJNj1v19lYCbxYLBZ06Eq+9zcOrROOwI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Buland Singh <bsingh@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 104/121] hpet: Fix missing = character in the __setup() code of hpet_mmap_enable
Date:   Thu,  4 Apr 2019 10:48:12 +0200
Message-Id: <20190404084550.931702604@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index b941e6d59fd6..9dfb28b04559 100644
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



