Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043AAC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 01:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FD920869
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 01:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfI1BlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 21:41:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbfI1BlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 21:41:00 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CAA4581F13
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 01:40:59 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id i187so3129576pfc.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 18:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ky42kKvEgu1tdZiOICEE1JQBSJf2IPpUikQsHQIbtbs=;
        b=J39/k0vofSqHbH9F5pUfgCFYjuzXe6UFrn1mJu0ZiwG2HVjoF//svJMc1B8qOey50D
         p2ScfbcUBlVqMBYS9EYIObIEQ6fH4BylYsSCh68tJpfM9CTX4A4qMGHWQoF9mjy70Ruf
         JoKjJc8gRankOd6nm1CjJQAKmazI6dPF/2ZQX5bqVS/JUWkuRiKzexPOuZaYeyq4YacK
         sdMwDP1SoRq8CHAQ26MG8lT2mCaji0Rzsn6BEbdfXZ4FIF8kwwL3jZLxxbcI5dN9Mtcc
         x/ZonjMISrsNQd8ip0KAMhq3TXdQ0u1MTFz77zB5tIW4bAWM8s1aB577VwH/uHXfMtPF
         VBfA==
X-Gm-Message-State: APjAAAV8EQ+WrbQrxGbW82tgUHW4FqsKhN/VPTpXO2b70+ybmlnhJUqt
        Y82EChy/+FmrjZ8X6Uz4w2KbvrKNk7GSOLsO83vxadrLDaLVwWtHwrvFt5pY+GKRKUBrmI/ZJI8
        IJ0At+YaJHfj+yKWkZ6cXTz0x
X-Received: by 2002:a17:902:6c:: with SMTP id 99mr8033101pla.89.1569634858862;
        Fri, 27 Sep 2019 18:40:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyBPMPLxsYGBRQQZkg2NdMe7+vlXq7pC8C3qOB86cmiFcfzkMiTyNDISkn8pQJFgJ8cCCb4FQ==
X-Received: by 2002:a17:902:6c:: with SMTP id 99mr8033093pla.89.1569634858663;
        Fri, 27 Sep 2019 18:40:58 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z12sm4196455pfj.41.2019.09.27.18.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 18:40:57 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH] KVM: Unlimit number of ioeventfd assignments for real
Date:   Sat, 28 Sep 2019 09:40:45 +0800
Message-Id: <20190928014045.10721-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously we've tried to unlimit ioeventfd creation (6ea34c9b78c1,
"kvm: exclude ioeventfd from counting kvm_io_range limit",
2013-06-04), because that can be easily done by fd limitations and
otherwise it can easily reach the current maximum of 1000 iodevices.
Meanwhile, we still use the counter to limit the maximum allowed kvm
io devices to be created besides ioeventfd.

6ea34c9b78c1 achieved that in most cases, however it'll still fali the
ioeventfd creation when non-ioeventfd io devices overflows to 1000.
Then the next ioeventfd creation will fail while logically it should
be the next non-ioeventfd iodevice creation to fail.

That's not really a big problem at all because when it happens it
probably means something has leaked in userspace (or even malicious
program) so it's a bug to fix there.  However the error message like
"ioeventfd creation failed" with an -ENOSPACE is really confusing and
may let people think about the fact that it's the ioeventfd that is
leaked (while in most cases it's not!).

Let's use this patch to unlimit the creation of ioeventfd for real
this time, assuming this is also a bugfix of 6ea34c9b78c1.  To me more
importantly, when with a bug in userspace this patch can probably give
us another more meaningful failure on what has overflowed/leaked
rather than "ioeventfd creation failure: -ENOSPC".

CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h |  3 +++
 virt/kvm/eventfd.c       |  4 ++--
 virt/kvm/kvm_main.c      | 23 ++++++++++++++++++++---
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index fcb46b3374c6..d8530e7d85d4 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -192,6 +192,9 @@ int kvm_io_bus_read(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx, gpa_t addr,
 		    int len, void *val);
 int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 			    int len, struct kvm_io_device *dev);
+int kvm_io_bus_register_dev_ioeventfd(struct kvm *kvm, enum kvm_bus bus_idx,
+				      gpa_t addr, int len,
+				      struct kvm_io_device *dev);
 void kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
 			       struct kvm_io_device *dev);
 struct kvm_io_device *kvm_io_bus_get_dev(struct kvm *kvm, enum kvm_bus bus_idx,
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 67b6fc153e9c..3cb0e1c3279b 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -823,8 +823,8 @@ static int kvm_assign_ioeventfd_idx(struct kvm *kvm,
 
 	kvm_iodevice_init(&p->dev, &ioeventfd_ops);
 
-	ret = kvm_io_bus_register_dev(kvm, bus_idx, p->addr, p->length,
-				      &p->dev);
+	ret = kvm_io_bus_register_dev_ioeventfd(kvm, bus_idx, p->addr,
+						p->length, &p->dev);
 	if (ret < 0)
 		goto unlock_fail;
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c6a91b044d8d..242cfcaa9a56 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3809,8 +3809,10 @@ int kvm_io_bus_read(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx, gpa_t addr,
 }
 
 /* Caller must hold slots_lock. */
-int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
-			    int len, struct kvm_io_device *dev)
+static int __kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx,
+				     gpa_t addr, int len,
+				     struct kvm_io_device *dev,
+				     bool check_limit)
 {
 	int i;
 	struct kvm_io_bus *new_bus, *bus;
@@ -3821,7 +3823,8 @@ int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 		return -ENOMEM;
 
 	/* exclude ioeventfd which is limited by maximum fd */
-	if (bus->dev_count - bus->ioeventfd_count > NR_IOBUS_DEVS - 1)
+	if (check_limit &&
+	    (bus->dev_count - bus->ioeventfd_count > NR_IOBUS_DEVS - 1))
 		return -ENOSPC;
 
 	new_bus = kmalloc(struct_size(bus, range, bus->dev_count + 1),
@@ -3851,6 +3854,20 @@ int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 	return 0;
 }
 
+int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
+			    int len, struct kvm_io_device *dev)
+{
+	return __kvm_io_bus_register_dev(kvm, bus_idx, addr, len, dev, true);
+}
+
+int kvm_io_bus_register_dev_ioeventfd(struct kvm *kvm, enum kvm_bus bus_idx,
+				      gpa_t addr, int len,
+				      struct kvm_io_device *dev)
+{
+	return __kvm_io_bus_register_dev(kvm, bus_idx, addr, len, dev, false);
+}
+
+
 /* Caller must hold slots_lock. */
 void kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
 			       struct kvm_io_device *dev)
-- 
2.21.0

