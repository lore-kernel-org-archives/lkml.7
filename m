Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFF8C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF8620674
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610563;
	bh=JdrTXh+ixgefAJIjHzB9L7T40uj7SjS+wb8WCtZ8x34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zfT7VuXUGpvGWq0IZf7DjDjveeOoA00R3dLPFWcMCUeFdN27sVMmZH45k4OaRzxjv
	 TdFVnDOuE8vhNBSGN9c9TQ7AZDkmh0PXCGhibgcdY7IN5C7bNEvYjd1yJLg0XveFuw
	 9xoRa7JhcnJZIc6f2sKkYDIsFcw4jFAKi4dqDpfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfKMCCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:02:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731035AbfKMCCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:02:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52357204EC;
        Wed, 13 Nov 2019 02:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610552;
        bh=JdrTXh+ixgefAJIjHzB9L7T40uj7SjS+wb8WCtZ8x34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ni4YZxlwU1oUPKzkaS8b3i8nu1+kVr2D6UQFqU8Icyp06SjNdnRKhXIttc21E+Qng
         Celjxynpsro+MifHLktpY4H6SXLvQwWWqFSG9fc5K21XwT/IjDc3aCgJ1eV3mLBYGh
         etTpcVXY3bsCxxupBsDrw9MQpUFXyycqMeqSiU74=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Borislav Petkov <bp@suse.de>, Lianbo Jiang <lijiang@redhat.com>,
        x86@kernel.org, Sasha Levin <sashal@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 35/48] proc/vmcore: Fix i386 build error of missing copy_oldmem_page_encrypted()
Date:   Tue, 12 Nov 2019 21:01:18 -0500
Message-Id: <20191113020131.13356-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113020131.13356-1-sashal@kernel.org>
References: <20191113020131.13356-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

[ Upstream commit cf089611f4c446285046fcd426d90c18f37d2905 ]

Lianbo reported a build error with a particular 32-bit config, see Link
below for details.

Provide a weak copy_oldmem_page_encrypted() function which architectures
can override, in the same manner other functionality in that file is
supplied.

Reported-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: x86@kernel.org
Link: http://lkml.kernel.org/r/710b9d95-2f70-eadf-c4a1-c3dc80ee4ebb@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/vmcore.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 4e61388ec03d2..08143139b65a7 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -164,6 +164,16 @@ int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
 	return remap_pfn_range(vma, from, pfn, size, prot);
 }
 
+/*
+ * Architectures which support memory encryption override this.
+ */
+ssize_t __weak
+copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
+			   unsigned long offset, int userbuf)
+{
+	return copy_oldmem_page(pfn, buf, csize, offset, userbuf);
+}
+
 /*
  * Copy to either kernel or user space
  */
-- 
2.20.1

