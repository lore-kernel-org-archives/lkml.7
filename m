Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA93C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A246E218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962286;
	bh=ZkZruAEHTjuDFMoh4a6n1g6cC6OPvWYubrXhMAS/G9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EWvQGEofcmEa8lakxwBf0idW/laP947loiKd/NzvZfspOn03V3Z0pRLLCMdoY5gvY
	 9p5uiwViA1NtshyHGW4SLL2FXdXDAkdpMx8vN9AkvwEaQims4D6Wg6L71I4VNYEacQ
	 moATj4+aTX5kLhanSP7Ec9HDUPOO+6ZEhJvokyzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfDVTop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:44:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729532AbfDVTon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:44:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E719217D4;
        Mon, 22 Apr 2019 19:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962282;
        bh=ZkZruAEHTjuDFMoh4a6n1g6cC6OPvWYubrXhMAS/G9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aeblzOs8Vv972BlN8MieFVaEWDPlxeAHp4ucKW8KVweSyJyrRUdmQGyZHO+Euk5lW
         qQfxG7s504DHOAI4KoeW5fFkHW7fKzxTtOf+WlQysfoDN46dZFQTRNHazvaopkHqbr
         n7//aY0gF7QQBWT5MYJikl5jzmHvnSzHkQUDCNRk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 84/98] KVM: selftests: explicitly disable PIE for tests
Date:   Mon, 22 Apr 2019 15:41:51 -0400
Message-Id: <20190422194205.10404-84-sashal@kernel.org>
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

[ Upstream commit 0a3f29b5a77d6c27796d7a7adabafd199dc066d5 ]

KVM selftests embed the guest "image" as a function in the test itself
and extract the guest code at runtime by manually parsing the elf
headers.  The parsing is very simple and doesn't supporting fancy things
like position independent executables.  Recent versions of gcc enable
pie by default, which results in triple fault shutdowns in the guest due
to the virtual address in the headers not matching up with the virtual
address retrieved from the function pointer.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 tools/testing/selftests/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index f9a0e9938480..212b8f0032ae 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -28,7 +28,7 @@ LIBKVM += $(LIBKVM_$(UNAME_M))
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
 LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
-CFLAGS += -O2 -g -std=gnu99 -I$(LINUX_TOOL_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(UNAME_M) -I..
+CFLAGS += -O2 -g -std=gnu99 -no-pie -I$(LINUX_TOOL_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(UNAME_M) -I..
 LDFLAGS += -pthread
 
 # After inclusion, $(OUTPUT) is defined and
-- 
2.19.1

