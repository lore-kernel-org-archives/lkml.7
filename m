Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF95C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B301920708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419071;
	bh=JdrTXh+ixgefAJIjHzB9L7T40uj7SjS+wb8WCtZ8x34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JQWruBVTspQFGY8q5oZq9wYeoOOopcR2lZyK7fFuYm0k6Og5FSVmELNGDDzsYSgI+
	 TGgVHnEIWuxw5kL9gNP2lwbI3++BmZ909CdLt7NsdlWF4BxaCQQ/V/l+mT9ODBlzFY
	 1pW7R8QDSQHdpS9aO0NDUUPT5cAqpezp6LL7dbMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfKVKhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:37:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbfKVKhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:37:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8E4120707;
        Fri, 22 Nov 2019 10:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419065;
        bh=JdrTXh+ixgefAJIjHzB9L7T40uj7SjS+wb8WCtZ8x34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xDwmPflU1+PNN1aCkxW3pm9yslSCaAAqgNl9HxKw+eUlwZZxeBGAZwvhH8Mh8Emf+
         rMUe/Wy6dpE/fjIjlNTCSVYEgDqaYk/i1mylxJjeb7Ix2O/aJaJVAePSqf2wbUS1N6
         U0EUa2NA0hQ/r82yskgBaFoWhhVdEZLVP3Du66q4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lianbo Jiang <lijiang@redhat.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 145/159] proc/vmcore: Fix i386 build error of missing copy_oldmem_page_encrypted()
Date:   Fri, 22 Nov 2019 11:28:56 +0100
Message-Id: <20191122100839.810388716@linuxfoundation.org>
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



