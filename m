Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACB6C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8207D24672
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WpvSEkDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfLPVgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:36:17 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35284 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfLPVgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 16:36:08 -0500
Received: by mail-pf1-f201.google.com with SMTP id r2so7728544pfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 13:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uVc2axwkCnCZhi+X312ppAdnVSbc0L4toMqGqZnNMKw=;
        b=WpvSEkDZ3zGJQkjjyek7brDRW8CLSSj/z+kyUghXynSz0CIPG/Pkh7uHpylMv+lsCV
         TBEOmtduByp41X120yvyW+L8fCIYUmgUBI2aEGCvxzdYsI003XS4/mLtP0CVM1msY+Hk
         5WO1bpSwfIZ7uZQCdxwxrvfo2tA7Ek7XaxrYgUxw9C2BdjXTgXH9m8uVA2BgZNxcZJ5S
         /NOeN4RMYprVaCR06rF4KVOnuh8Dj7m4BetXNrBKpZt0L7wLeuagWrJS0QyOcKe/dODK
         sID4umEhHdU1D/KEoA6ciVgckNKpatKM3u+B/Qu76ggC+9Fw1kJa86qkXsaUrnSxE8kA
         XBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uVc2axwkCnCZhi+X312ppAdnVSbc0L4toMqGqZnNMKw=;
        b=oDgDfuQzC2Yqeun89BllLEdL2JjVJq01QP5aaU1cA8W4BSDk+1Osfh07I6zIowPAru
         BWYgyRQaOoO2DycaRm3JPbGXx0hY+EoOCGpcAj2v7vt7T67A4vxg8B1h6v1eZJSi7iFK
         OWgTUpEgRPDP/TLpiWzdMedAM1G7+VGuFe3KCyY+zZL+8ZLwT2vrOfT072UhTzTLx3h6
         oc/9+TNzCvIfDJIcBw+H7+EPyU9lM+BnMKvgxxMd9jCT5UPZKZp1zRrHa2J/po6AT3w3
         2EUvecuS3w3SjwgV5LxiJTglqqUFFXhnxBmB8D+kkVynYTR4JBID2igCBaSjVKDnWBJh
         /NyA==
X-Gm-Message-State: APjAAAXeZTZm4VuLqPrg0ZDzliDymbr+68SccJCCaciS/+TpoOwFkN2X
        0JU+yoSl0OrGqCZHUkzIjcYDs1F15IihY5znpp41rQIzP7ScKqKdSOS4gTN8a4DSnclDlbnax1k
        jqYUM5vLjQCVFbXcR3r0iIwCkrIZDodJbLBpoDw3o3MVgfeOf47VYKuajhAhe+GB6ZnsidqRA
X-Google-Smtp-Source: APXvYqxAvjI7NezKNIRCnRAWCElstJUl5eVy0r8/FtYh7zCfXc8erNLof+lG3knmkBtIjjVxutbT4Tg4gE8y
X-Received: by 2002:a63:1662:: with SMTP id 34mr20427182pgw.77.1576532166453;
 Mon, 16 Dec 2019 13:36:06 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:35:31 -0800
In-Reply-To: <20191216213532.91237-1-bgardon@google.com>
Message-Id: <20191216213532.91237-9-bgardon@google.com>
Mime-Version: 1.0
References: <20191216213532.91237-1-bgardon@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 8/8] KVM: selftests: Add parameter to _vm_create for
 memslot 0 base paddr
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
memslots an causes vCPU creation to fail. Add a paddr parameter for
memslot 0 so that tests which support large VMs can relocate memslot 0
above 4 GiB.

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

