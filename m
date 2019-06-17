Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47427C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF872070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806631;
	bh=y9xU1Vxcitkg//oxiKqJJWU15rcVRW0JaDrrJoaUWSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=heFNdPPBsXlpKpKszf5aKbJGBJrJf4FHm+97o5mIeWZg1WuOyDGzdOnUbM+OFOVdX
	 eLn5Ajtt4T4g2GOsLKPMNGtT+IFyMOjVniCvQeHdSu2EiOZgtcHjUumO3DcHClh1b2
	 lVJZJmAAIZsYCCaDUBGxphxILz9xck01UoHLzCCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfFQVXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729791AbfFQVXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:23:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EABF920673;
        Mon, 17 Jun 2019 21:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806626;
        bh=y9xU1Vxcitkg//oxiKqJJWU15rcVRW0JaDrrJoaUWSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PyXJTyBEW82lLMfiGIQ+U9zkBXsHASvSb0Xp8txy5XHHDPzvMUXwoI+4m1Kq1kcE8
         GIqlFdsnreTR6TketzJajsw+0GFmOkVQ2Tw+Qshojl4nd5smsjBacVOZ9Idnbor1yJ
         h0NCRrmWo6BmNZbgHTm0K7BaDyg90PA2cQn54aI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 093/115] kvm: selftests: aarch64: fix default vm mode
Date:   Mon, 17 Jun 2019 23:09:53 +0200
Message-Id: <20190617210804.672328154@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 55eda003f02f075bab0223a188e548dbf3ac8dfe ]

VM_MODE_P52V48_4K is not a valid mode for AArch64. Replace its
use in vm_create_default() with a mode that works and represents
a good AArch64 default. (We didn't ever see a problem with this
because we don't have any unit tests using vm_create_default(),
but it's good to get it fixed in advance.)

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/lib/aarch64/processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index e8c42506a09d..fa6cd340137c 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -226,7 +226,7 @@ struct kvm_vm *vm_create_default(uint32_t vcpuid, uint64_t extra_mem_pages,
 	uint64_t extra_pg_pages = (extra_mem_pages / ptrs_per_4k_pte) * 2;
 	struct kvm_vm *vm;
 
-	vm = vm_create(VM_MODE_P52V48_4K, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages, O_RDWR);
+	vm = vm_create(VM_MODE_P40V48_4K, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages, O_RDWR);
 
 	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
 	vm_vcpu_add_default(vm, vcpuid, guest_code);
-- 
2.20.1



