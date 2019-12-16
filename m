Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CF3C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74C724673
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MuHMhVLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfLPVjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:39:25 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:33745 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbfLPVjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 16:39:23 -0500
Received: by mail-pg1-f202.google.com with SMTP id x24so3992775pgl.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 13:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rowy0fulnWlicWAYnRVZ1Dd1A8eU5tnc0eErNEZ+z80=;
        b=MuHMhVLT/JPmloUwrLfNYvZW2n4et7Jp6otDiIOqsAgsXxhPw0pD+sf+K2Wz1bcwcE
         umHcmexYa3XVrNTFitMJMBYyqjDaET0ivXVKpA1RqVyD8V4224NfFmieT+WL8wxCP9Uf
         TeyVGVkrZUBRPuOJOeUyhrRYRParc+bz/foA7OITtQlAv8YjLXySbTVB+rFX/btl5eqr
         XV2jZIQBXqTrzmvmmJ11xow6XVm8OAB0UlReGxO9v7l0id98TbLh6QDJoZETRv2fkiPo
         RwZ+5HAYVciPWg/rBIsxuRno1YegprlFb+LVfcvaBjDfj2oNEeKU+ibtPCaeMIQ0tu6z
         r+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rowy0fulnWlicWAYnRVZ1Dd1A8eU5tnc0eErNEZ+z80=;
        b=I8WTdpxKQ3uUPYoFN/Nm37pXQWq1UiiELYaCDbfuJ5d5Y0AM0oTZVH2zijO8nCyip1
         8RIQx/M1L4g/4qbE5ucRx+2XErsKdh4DQX+Xm2p9hRkoNRkKL1dUGwcLMG3oIh7R9oxt
         vGFbxpJpMIZnG/VMJn3ckT6ORMqEiaGAWllBnGImfSquw+MgwAWtj9F2DQWQpiblTfif
         6TcY0DtoX11FxMXcatHYWv2D2rc4qnumLQ8GIyKYoj5JB+qWx/imrbJVVCCOaSX/9mUd
         r4UX6q4hDoNDX5HDA6/nKY8+3pEQtzTV+d64w5cFOUHdcYJ6gLj7obVYpHSOzBDSUkPr
         sXmQ==
X-Gm-Message-State: APjAAAW0CKab05scL1KqcMnJlEaK5nXmdaeyaGUUoPxSgg7heU1E+2e/
        QJXs90J22SW6LZkdBQ2MTFNhZptb8g4kNN3eyGBfHlvHvCea3nqrgGmTZKR1UaCVgiTjrxfmqcZ
        M31vn7HZRoImeEaMy3dodgBGHaxSVtU+za14b80wmcbNfq+AZwc6UnUBByVz1mN4YliS1v/fC
X-Google-Smtp-Source: APXvYqzpGDXOtRuYa0WgsWK7wz+wgL2YlTBvmIVTv2h8YGbeupjQc/AMbR9FD0fpw5V/MIPOI8j2lg0uDdbH
X-Received: by 2002:a63:1c13:: with SMTP id c19mr21194582pgc.450.1576532362335;
 Mon, 16 Dec 2019 13:39:22 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:39:01 -0800
In-Reply-To: <20191216213901.106941-1-bgardon@google.com>
Message-Id: <20191216213901.106941-9-bgardon@google.com>
Mime-Version: 1.0
References: <20191216213901.106941-1-bgardon@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 8/8] KVM: selftests: Move large memslots above KVM internal
 memslots in _vm_create
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM creates internal memslots between 3 and 4 GiB paddrs on the first
vCPU creation. If memslot 0 is large enough it collides with these
memslots an causes vCPU creation to fail. When requesting more than 3G,
start memslot 0 at 4G in _vm_create.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 41cf45416060f..886d58e6cac39 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -113,6 +113,8 @@ const char * const vm_guest_mode_string[] = {
 _Static_assert(sizeof(vm_guest_mode_string)/sizeof(char *) == NUM_VM_MODES,
 	       "Missing new mode strings?");
 
+#define KVM_INTERNAL_MEMSLOTS_START_PADDR (3UL << 30)
+#define KVM_INTERNAL_MEMSLOTS_END_PADDR (4UL << 30)
 /*
  * VM Create
  *
@@ -128,13 +130,16 @@ _Static_assert(sizeof(vm_guest_mode_string)/sizeof(char *) == NUM_VM_MODES,
  *
  * Creates a VM with the mode specified by mode (e.g. VM_MODE_P52V48_4K).
  * When phy_pages is non-zero, a memory region of phy_pages physical pages
- * is created and mapped starting at guest physical address 0.  The file
- * descriptor to control the created VM is created with the permissions
- * given by perm (e.g. O_RDWR).
+ * is created. If phy_pages is less that 3G, it is mapped starting at guest
+ * physical address 0. If phy_pages is greater than 3G it is mapped starting
+ * 4G into the guest physical address space to avoid KVM internal memslots
+ * which map the region between 3G and 4G. The file descriptor to control the
+ * created VM is created with the permissions given by perm (e.g. O_RDWR).
  */
 struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
 {
 	struct kvm_vm *vm;
+	uint64_t guest_paddr = 0;
 
 	DEBUG("Testing guest mode: %s\n", vm_guest_mode_string(mode));
 
@@ -227,9 +232,11 @@ struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
 
 	/* Allocate and setup memory for guest. */
 	vm->vpages_mapped = sparsebit_alloc();
+	if (guest_paddr + phy_pages > KVM_INTERNAL_MEMSLOTS_START_PADDR)
+		guest_paddr = KVM_INTERNAL_MEMSLOTS_END_PADDR;
 	if (phy_pages != 0)
 		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
-					    0, 0, phy_pages, 0);
+					    guest_paddr, 0, phy_pages, 0);
 
 	return vm;
 }
-- 
2.24.1.735.g03f4e72817-goog

