Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E964C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA22218D9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962291;
	bh=6wM28boM7DmkElAkYlnnMwuZhOlosHRCVJnaymUlxoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LkAzjRrpKQJ7fVYq1ijOQ0F2B22TfP5BdMHJmlY1J91Z0iCZ60/LtutRKjH1Fg80d
	 Xq5oVW2BFtImzbc/3TAJGIlxBsv0FtHZOasvOA5f8QmOiRLzlyvxMEio+NHsriV5vo
	 nLImmCbvEw+GTO2QlDrsTldAT2PnLlT6yGPp56sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfDVTou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729572AbfDVToo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:44:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2808204EC;
        Mon, 22 Apr 2019 19:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962283;
        bh=6wM28boM7DmkElAkYlnnMwuZhOlosHRCVJnaymUlxoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=asd87QxCKNPXMnBHeC2lEbaurCJ+2XuSIGY2BwTzCQ3p3NGXK2KqHfysdDBJVazmo
         0SIdKL7x7C0oDK32apS+1ayR4tZjvQH3JU8GmCtemXBxLNvk0h4MxepFDPPrsTzNkM
         K6C0ZHpqv45iIeunQbV4gHL2r2e1iUcRZ5NB6jaI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 85/98] KVM: selftests: disable stack protector for all KVM tests
Date:   Mon, 22 Apr 2019 15:41:52 -0400
Message-Id: <20190422194205.10404-85-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

[ Upstream commit ffac839d040619847217647434b2b02469926871 ]

Since 4.8.3, gcc has enabled -fstack-protector by default.  This is
problematic for the KVM selftests as they do not configure fs or gs
segments (the stack canary is pulled from fs:0x28).  With the default
behavior, gcc will insert a stack canary on any function that creates
buffers of 8 bytes or more.  As a result, ucall() will hit a triple
fault shutdown due to reading a bad fs segment when inserting its
stack canary, i.e. every test fails with an unexpected SHUTDOWN.

Fixes: 14c47b7530e2d ("kvm: selftests: introduce ucall")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 tools/testing/selftests/kvm/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 212b8f0032ae..cb4a992d6dd3 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -28,8 +28,8 @@ LIBKVM += $(LIBKVM_$(UNAME_M))
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
 LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
-CFLAGS += -O2 -g -std=gnu99 -no-pie -I$(LINUX_TOOL_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(UNAME_M) -I..
-LDFLAGS += -pthread
+CFLAGS += -O2 -g -std=gnu99 -fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(UNAME_M) -I..
+LDFLAGS += -pthread -no-pie
 
 # After inclusion, $(OUTPUT) is defined and
 # $(TEST_GEN_PROGS) starts with $(OUTPUT)/
-- 
2.19.1

