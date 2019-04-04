Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01021C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5ED62186A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554367969;
	bh=aHx3hjDYKQkjyGsE2ZRx93zXo6zlWegeaqlcEdZLIUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BF8fcdf9pzoHjnBrXGEV2tfovRpTgeOjNYll0ur2uEt5MCf/pk1uxrMvGVeTpHGpa
	 0r0b3OCfC4iOQqv5vu1hb8tXUr0N6wgeMziuUTa0eB3Pvb8/7iPdJEbfiLnqg8C1FB
	 f+9lPJRK+Nqj/901HZY8UWvNPiyaZcyTiUVms2m8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfDDIws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbfDDIwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:52:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B45D321850;
        Thu,  4 Apr 2019 08:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367964;
        bh=aHx3hjDYKQkjyGsE2ZRx93zXo6zlWegeaqlcEdZLIUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e/9+9NapkGd/iA9b/OggGx7VSBo9Y58JbmPMtS//YZd5wTngXPATGBNgePFAMatYX
         5YB4o0DyxT0HBrO3p4h4uDl3DwhdKJloe0VuaOcRNjynXuy3BcBWjMewayfVvMxM11
         AQdsbcJfaipAVO9dO3kJCss3sARc0UYJAqoT/1i8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Buland Singh <bsingh@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 78/91] hpet: Fix missing = character in the __setup() code of hpet_mmap_enable
Date:   Thu,  4 Apr 2019 10:48:02 +0200
Message-Id: <20190404084539.963963008@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index 50272fe81f26..818a8d40e5c9 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -376,7 +376,7 @@ static __init int hpet_mmap_enable(char *str)
 	pr_info("HPET mmap %s\n", hpet_mmap_enabled ? "enabled" : "disabled");
 	return 1;
 }
-__setup("hpet_mmap", hpet_mmap_enable);
+__setup("hpet_mmap=", hpet_mmap_enable);
 
 static int hpet_mmap(struct file *file, struct vm_area_struct *vma)
 {
-- 
2.19.1



