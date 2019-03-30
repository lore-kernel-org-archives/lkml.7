Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F85C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB93217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909805;
	bh=eZNLlmvij2VlqzvKd7YlKXa23vF+hS8ShTOqJZQ/jFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MoZwS+P6fUHQ78Gom3K8/3rWtr8gbNLI0ZHzaboHaZLag5iP2Gg7JpeiLyJzhNnAh
	 BHN+H6MCmzpxq7hiv9fTdmFMKkPiRJPLUaxYf26MsHk1maZjnwPftEHw2D5SKm8plo
	 D1r2lSATTyAJhzyYV1QQAQB3NwbAyfDcGqsGv1/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbfC3Bgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:36:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731861AbfC3BbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:31:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5171218D3;
        Sat, 30 Mar 2019 01:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909465;
        bh=eZNLlmvij2VlqzvKd7YlKXa23vF+hS8ShTOqJZQ/jFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRCGYJa+NAcXkSJGYUyichQ1l/n6ET892ar+BccNv1OFi8Ty/iW5+ZR+1sqUJNGln
         E/cjj57uzmrihWBCFSdF41qyAGjx8SI/tyv2YTvjBappH0R5hA8T5tLKJrXzYUJWVW
         7noYUV2ytnY0Sh8QzhitiJchQZ/Kkdmd3LHZGvYA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 23/37] kvm: properly check debugfs dentry before using it
Date:   Fri, 29 Mar 2019 21:30:06 -0400
Message-Id: <20190330013020.379-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330013020.379-1-sashal@kernel.org>
References: <20190330013020.379-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 8ed0579c12b2fe56a1fac2f712f58fc26c1dc49b ]

debugfs can now report an error code if something went wrong instead of
just NULL.  So if the return value is to be used as a "real" dentry, it
needs to be checked if it is an error before dereferencing it.

This is now happening because of ff9fb72bc077 ("debugfs: return error
values, not NULL").  syzbot has found a way to trigger multiple debugfs
files attempting to be created, which fails, and then the error code
gets passed to dentry_path_raw() which obviously does not like it.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Reported-and-tested-by: syzbot+7857962b4d45e602b8ad@syzkaller.appspotmail.com
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 66cc315efa6d..cf6a86631267 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3911,7 +3911,7 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
 	}
 	add_uevent_var(env, "PID=%d", kvm->userspace_pid);
 
-	if (kvm->debugfs_dentry) {
+	if (!IS_ERR_OR_NULL(kvm->debugfs_dentry)) {
 		char *tmp, *p = kmalloc(PATH_MAX, GFP_KERNEL);
 
 		if (p) {
-- 
2.19.1

