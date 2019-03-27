Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D2FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4BB205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713108;
	bh=reVFkqiAp1HrF7VKpjcfa+LqHqM9kSGWxN6mBfx7qws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bs/76YuhIr8BfDKd6kQv5Tuxio7ICAGsGHhyREW+dSHeMiTeRFPfG07l9H6oPzsv0
	 GRLt6hi//7aNT1KZe/b9KRlqp8OaacMyonYWb1KpPnR+SDtvOwVAUnXS2qOCW3Z285
	 rE+Tdn7Wxc37+IzgYVlx87qCOxVbYFptm58L/xYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390096AbfC0S60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389867AbfC0SPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:15:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D88C217F5;
        Wed, 27 Mar 2019 18:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710539;
        bh=reVFkqiAp1HrF7VKpjcfa+LqHqM9kSGWxN6mBfx7qws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQD/XTVBx9t0mg57OwzUDzOUxOTotGGat2dPEIX+w+/3EXEMhgdP+6rl5QxyGY3qt
         fR2PiWPlCjtu0uVHCWdaWrVkVZAwK2U1IWa9W8pM7OVHvdbjaFWdmjeJ857Ip0sm0K
         DZy16fgPFUbvY18cAVt2+ntHLlnE4BFZpITd9Qtk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Buland Singh <bsingh@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 165/192] hpet: Fix missing '=' character in the __setup() code of hpet_mmap_enable
Date:   Wed, 27 Mar 2019 14:09:57 -0400
Message-Id: <20190327181025.13507-165-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Buland Singh <bsingh@redhat.com>

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
index 4a22b4b41aef..9bffcd37cc7b 100644
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

