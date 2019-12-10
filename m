Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E6DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E400E206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uwUf65Dt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfLJCnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:43:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38148 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfLJCnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:43:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id a33so7899503pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 18:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+pVRv0zmwM6r6qh3u7jefx+roN9IpRfJikQs29Fs7Mc=;
        b=uwUf65DtxepoaHGo4O1l3eRw7LX0FXVzucUtAwwuLkcVjQsqdGxJD9cMJLM3nuxt4J
         etcJjflqicP0aEqaF9T0mrVMdUzRjrsOc2W9D1SN+k2VoeOlPGsRtdsv0sKEtSjUCyX7
         lbr3bTGxNh6VVe6bsLgKqdVUaqgeK2IH7WEp13jtZayc88doNqd1tyqwQn9FF71k1g8f
         ds1XNZVb96EMb7mSGq4cYsAA40g3HW9oHxI72pOcoR2X4xireKpY1GkZ4zSW/b0XF39r
         BLvCXgssR3l9lvlzi7vtpOoVHsaTGYXgbOfozM7Bh4NRkEbPnNPue9YdVQZq/PH6l+9Q
         O0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+pVRv0zmwM6r6qh3u7jefx+roN9IpRfJikQs29Fs7Mc=;
        b=XdVNAYgwYM3zYqgmRlKD0DAO+1K3yqzrWni78+9uhnUM+66Vazc11qujHryvlXrQzU
         LgWvJfa1YMBPeS5xZAtEufY+Pxcp6RCZ5CHQ1OIs+CmJxJmxViamAoevVaJZW+w895Sf
         yCkI9RZ8hP2UqmslKnX/F1z76L06nggYLqQt1I9ViLC05MNdxdl3yGZir94BiEr7YNgl
         Sti8KWf9AF0UXRSBlbxbLWXmG0si42iiKRfBTGdKf7+e1+lBY7sLtEuxQoyVmKblxp/6
         5xZ/zEK7H/jQ9QrXg3zHSrrZ9jzaLz6NhRcbWPbQJwD/bigxsCucf2HcstVFKn6ae1sE
         EfLA==
X-Gm-Message-State: APjAAAUSvQmAo5DDJ7mw2sTbm8NHO8YyJCm3rmfNzvHrJZGNiK/TxZyR
        Vr0ObW+BCgGMYTSbYg5kdVnvgA==
X-Google-Smtp-Source: APXvYqzMKJNjBhRBPDcrkkes2iin/sH2CGOoYy8Yji3QEs2l5nJTTLxLWlg03FQisfLHcm0v16ysHw==
X-Received: by 2002:aa7:9118:: with SMTP id 24mr34122975pfh.182.1575945800496;
        Mon, 09 Dec 2019 18:43:20 -0800 (PST)
Received: from localhost.localdomain ([240e:362:417:e00:ed89:9d55:8cd5:6d38])
        by smtp.gmail.com with ESMTPSA id r6sm826422pfh.91.2019.12.09.18.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 18:43:20 -0800 (PST)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan.cameron@huawei.com, grant.likely@arm.com,
        jean-philippe <jean-philippe@linaro.org>,
        Jerome Glisse <jglisse@redhat.com>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        guodong.xu@linaro.org
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [RESEND PATCH v9 1/4] uacce: Add documents for uacce
Date:   Tue, 10 Dec 2019 10:42:32 +0800
Message-Id: <1575945755-27380-2-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575945755-27380-1-git-send-email-zhangfei.gao@linaro.org>
References: <1575945755-27380-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kenneth Lee <liguozhu@hisilicon.com>

Uacce (Unified/User-space-access-intended Accelerator Framework) is
a kernel module targets to provide Shared Virtual Addressing (SVA)
between the accelerator and process.

This patch add document to explain how it works.

Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 Documentation/misc-devices/uacce.rst | 176 +++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 Documentation/misc-devices/uacce.rst

diff --git a/Documentation/misc-devices/uacce.rst b/Documentation/misc-devices/uacce.rst
new file mode 100644
index 0000000..1db412e
--- /dev/null
+++ b/Documentation/misc-devices/uacce.rst
@@ -0,0 +1,176 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Introduction of Uacce
+---------------------
+
+Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
+provide Shared Virtual Addressing (SVA) between accelerators and processes.
+So accelerator can access any data structure of the main cpu.
+This differs from the data sharing between cpu and io device, which share
+only data content rather than address.
+Because of the unified address, hardware and user space of process can
+share the same virtual address in the communication.
+Uacce takes the hardware accelerator as a heterogeneous processor, while
+IOMMU share the same CPU page tables and as a result the same translation
+from va to pa.
+
+::
+
+         __________________________       __________________________
+        |                          |     |                          |
+        |  User application (CPU)  |     |   Hardware Accelerator   |
+        |__________________________|     |__________________________|
+
+                     |                                 |
+                     | va                              | va
+                     V                                 V
+                 __________                        __________
+                |          |                      |          |
+                |   MMU    |                      |  IOMMU   |
+                |__________|                      |__________|
+                     |                                 |
+                     |                                 |
+                     V pa                              V pa
+                 _______________________________________
+                |                                       |
+                |              Memory                   |
+                |_______________________________________|
+
+
+
+Architecture
+------------
+
+Uacce is the kernel module, taking charge of iommu and address sharing.
+The user drivers and libraries are called WarpDrive.
+
+The uacce device, built around the IOMMU SVA API, can access multiple
+address spaces, including the one without PASID.
+
+A virtual concept, queue, is used for the communication. It provides a
+FIFO-like interface. And it maintains a unified address space between the
+application and all involved hardware.
+
+::
+
+                             ___________________                  ________________
+                            |                   |   user API     |                |
+                            | WarpDrive library | ------------>  |  user driver   |
+                            |___________________|                |________________|
+                                     |                                    |
+                                     |                                    |
+                                     | queue fd                           |
+                                     |                                    |
+                                     |                                    |
+                                     v                                    |
+     ___________________         _________                                |
+    |                   |       |         |                               | mmap memory
+    | Other framework   |       |  uacce  |                               | r/w interface
+    | crypto/nic/others |       |_________|                               |
+    |___________________|                                                 |
+             |                       |                                    |
+             | register              | register                           |
+             |                       |                                    |
+             |                       |                                    |
+             |                _________________       __________          |
+             |               |                 |     |          |         |
+              -------------  |  Device Driver  |     |  IOMMU   |         |
+                             |_________________|     |__________|         |
+                                     |                                    |
+                                     |                                    V
+                                     |                            ___________________
+                                     |                           |                   |
+                                     --------------------------  |  Device(Hardware) |
+                                                                 |___________________|
+
+
+How does it work
+----------------
+
+Uacce uses mmap and IOMMU to play the trick.
+
+Uacce creates a chrdev for every device registered to it. New queue is
+created when user application open the chrdev. The file descriptor is used
+as the user handle of the queue.
+The accelerator device present itself as an Uacce object, which exports as
+a chrdev to the user space. The user application communicates with the
+hardware by ioctl (as control path) or share memory (as data path).
+
+The control path to the hardware is via file operation, while data path is
+via mmap space of the queue fd.
+
+The queue file address space:
+
+::
+
+   /**
+   * enum uacce_qfrt: qfrt type
+   * @UACCE_QFRT_MMIO: device mmio region
+   * @UACCE_QFRT_DUS: device user share region
+   */
+  enum uacce_qfrt {
+          UACCE_QFRT_MMIO = 0,
+          UACCE_QFRT_DUS = 1,
+  };
+
+All regions are optional and differ from device type to type.
+Each region can be mmapped only once, otherwise -EEXIST returns.
+
+The device mmio region is mapped to the hardware mmio space. It is generally
+used for doorbell or other notification to the hardware. It is not fast enough
+as data channel.
+
+The device user share region is used for share data buffer between user process
+and device.
+
+
+The Uacce register API
+----------------------
+
+The register API is defined in uacce.h.
+
+::
+
+  struct uacce_interface {
+    char name[UACCE_MAX_NAME_SIZE];
+    unsigned int flags;
+    const struct uacce_ops *ops;
+  };
+
+According to the IOMMU capability, uacce_interface flags can be:
+
+::
+
+  /**
+   * UACCE Device flags:
+   * UACCE_DEV_SVA: Shared Virtual Addresses
+   *              Support PASID
+   *              Support device page faults (PCI PRI or SMMU Stall)
+   */
+  #define UACCE_DEV_SVA               BIT(0)
+
+  struct uacce_device *uacce_alloc(struct device *parent,
+                                   struct uacce_interface *interface);
+  int uacce_register(struct uacce_device *uacce);
+  void uacce_remove(struct uacce_device *uacce);
+
+uacce_register results can be:
+
+a. If uacce module is not compiled, ERR_PTR(-ENODEV)
+
+b. Succeed with the desired flags
+
+c. Succeed with the negotiated flags, for example
+
+  uacce_interface.flags = UACCE_DEV_SVA but uacce->flags = ~UACCE_DEV_SVA
+
+  So user driver need check return value as well as the negotiated uacce->flags.
+
+
+The user driver
+---------------
+
+The queue file mmap space will need a user driver to wrap the communication
+protocol. Uacce provides some attributes in sysfs for the user driver to
+match the right accelerator accordingly.
+More details in Documentation/ABI/testing/sysfs-driver-uacce.
-- 
2.7.4

