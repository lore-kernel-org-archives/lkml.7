Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AD8C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 04:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802DA22CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 04:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YmyGpSQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfICEPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 00:15:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33949 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfICEPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 00:15:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so8391612pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 21:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wBu8LFEP9WzuBiGQRRgysD0yQ1ZZ9IsFsKKNcHDj3Xk=;
        b=YmyGpSQGMYpEzFt7Jswe6Bu0KvdV/F0o6YxB5sRurjFiksmnUuFPkmYoVjJ1d4p9et
         93rRIzFGG3nITvWJzMamysQrUPQqTTCWya1RyG7awyXBvNww/UkzxQKys9NKmJ5cBmOJ
         JkR+K0fuV/VHBAgQNQJsiyOcQ/3TPLrfqQLHbDGEsyOb3hlLfdM9fWA405Ci0Kqjcv9z
         Z1ZSTz0eIrBeveMUQBtxxOySzNqPKB2EOt3PK0QwN8qNwogWzWbxztUykTnnIFcaCd4T
         usPw6sSakN3KsuJIxxDJLinU18JUPbrSVr13pADquuDJGfTRKE+1kSbh4af0C9odc6H6
         jCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wBu8LFEP9WzuBiGQRRgysD0yQ1ZZ9IsFsKKNcHDj3Xk=;
        b=sJKFM0c8r4Ka1n4qWYCz52nDess15WQqNy2w6BjjBE6bHhfrjWXDj+fLOGjUPE064w
         D5XHWxp8TAKbbNsLGFIM6TaEkcXRil2XS7D6EjQuODk5cBOmINWIr6xYKl7PfQtpM9V0
         jeMn/n+j1emoghITHfzT5PXKvbMvKt9luQjW5K+zQgQVYpvSv82XHvbQpEtuQVqAbtYC
         zxNf0JZaoqecfWzg0yAfOqaE6+PVg+FSXBXqGGwWnMeBYNssRQaR33mFmOIFlHu2nCe4
         7gIyWLOU+w9tPIaRPhTLBJjBke/gAyeWCzvDgRjOOlrCxYqs57eWlVNQCIPULk9qZAAg
         5R4g==
X-Gm-Message-State: APjAAAU+SgyHm2i6AdhcmW9Ae96h46ZaAggBce3Ay4dkE+5RAa4Bh8Hb
        jDcosjT/SYuYtNSOuuMIeClT7g==
X-Google-Smtp-Source: APXvYqwZRZWzOeH0bQHj5RBYU3HI8wr7Xp0Kg9w+gZq7K34UFUygpNpuo7WSjIITO+qgQHIzLc+zhQ==
X-Received: by 2002:a63:1f03:: with SMTP id f3mr27807778pgf.249.1567484117174;
        Mon, 02 Sep 2019 21:15:17 -0700 (PDT)
Received: from localhost.localdomain ([240e:362:47f:ba00:a424:c9b7:932a:4fc2])
        by smtp.gmail.com with ESMTPSA id k8sm13442608pgm.14.2019.09.02.21.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Sep 2019 21:15:16 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, jonathan.cameron@huawei.com,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v3 1/2] uacce: Add documents for uacce
Date:   Tue,  3 Sep 2019 12:14:46 +0800
Message-Id: <1567484087-8071-1-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567482778-5700-1-git-send-email-zhangfei.gao@linaro.org>
References: <1567482778-5700-1-git-send-email-zhangfei.gao@linaro.org>
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
 Documentation/misc-devices/uacce.rst | 309 +++++++++++++++++++++++++++++++++++
 1 file changed, 309 insertions(+)
 create mode 100644 Documentation/misc-devices/uacce.rst

diff --git a/Documentation/misc-devices/uacce.rst b/Documentation/misc-devices/uacce.rst
new file mode 100644
index 0000000..211f796
--- /dev/null
+++ b/Documentation/misc-devices/uacce.rst
@@ -0,0 +1,309 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Introduction of Uacce
+=========================
+
+Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
+provide Shared Virtual Addressing (SVA) between accelerators and processes.
+So accelerator can access any data structure of the main cpu.
+This differs from the data sharing between cpu and io device, which share
+data content rather than address.
+Because of the unified address, hardware and user space of process can
+share the same virtual address in the communication.
+Uacce takes the hardware accelerator as a heterogeneous processor, while
+IOMMU share the same CPU page tables and as a result the same translation
+from va to pa.
+
+	 __________________________       __________________________
+	|                          |     |                          |
+	|  User application (CPU)  |     |   Hardware Accelerator   |
+	|__________________________|     |__________________________|
+
+	             |                                 |
+	             | va                              | va
+	             V                                 V
+                 __________                        __________
+                |          |                      |          |
+                |   MMU    |                      |  IOMMU   |
+                |__________|                      |__________|
+		     |                                 |
+	             |                                 |
+	             V pa                              V pa
+		 _______________________________________
+		|                                       |
+		|              Memory                   |
+		|_______________________________________|
+
+
+
+Architecture
+------------
+
+Uacce is the kernel module, taking charge of iommu and address sharing.
+The user drivers and libraries are called WarpDrive.
+
+A virtual concept, queue, is used for the communication. It provides a
+FIFO-like interface. And it maintains a unified address space between the
+application and all involved hardware.
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
+================
+
+Uacce uses mmap and IOMMU to play the trick.
+
+Uacce create a chrdev for every device registered to it. New queue is
+created when user application open the chrdev. The file descriptor is used
+as the user handle of the queue.
+The accelerator device present itself as an Uacce object, which exports as
+chrdev to the user space. The user application communicates with the
+hardware by ioctl (as control path) or share memory (as data path).
+
+The control path to the hardware is via file operation, while data path is
+via mmap space of the queue fd.
+
+The queue file address space:
+
+enum uacce_qfrt {
+	UACCE_QFRT_MMIO = 0,	/* device mmio region */
+	UACCE_QFRT_DKO = 1,	/* device kernel-only region */
+	UACCE_QFRT_DUS = 2,	/* device user share region */
+	UACCE_QFRT_SS = 3,	/* static shared memory (for non-sva devices) */
+	UACCE_QFRT_MAX,
+};
+
+All regions are optional and differ from device type to type. The
+communication protocol is wrapped by the user driver.
+
+The device mmio region is mapped to the hardware mmio space. It is generally
+used for doorbell or other notification to the hardware. It is not fast enough
+as data channel.
+
+The device kernel-only region is necessary only if the device IOMMU has no
+PASID support or it cannot send kernel-only address request. In this case, if
+kernel need to share memory with the device, kernel has to share iova address
+space with the user process via mmap, to prevent iova conflict.
+
+The device user share region is used for share data buffer between user process
+and device. It can be merged into other regions. But a separated region can help
+on device state management. For example, the device can be started when this
+region is mapped.
+
+The static share virtual memory region is used for share data buffer with the
+device and can be shared among queues / devices.
+Its size is set according to the application requirement.
+
+
+The user API
+------------
+
+We adopt a polling style interface in the user space: ::
+
+	int wd_request_queue(struct wd_queue *q);
+	void wd_release_queue(struct wd_queue *q);
+	int wd_send(struct wd_queue *q, void *req);
+	int wd_recv(struct wd_queue *q, void **req);
+	int wd_recv_sync(struct wd_queue *q, void **req);
+	void wd_flush(struct wd_queue *q);
+
+wd_recv_sync() is a wrapper to its non-sync version. It will trap into
+kernel and wait until the queue become available.
+
+If the queue do not support SVA/SVM. The following helper functions
+can be used to create Static Virtual Share Memory: ::
+
+	void *wd_reserve_memory(struct wd_queue *q, size_t size);
+	int wd_share_reserved_memory(struct wd_queue *q,
+				     struct wd_queue *target_q);
+
+The user API is not mandatory. It is simply a suggestion and hint what the
+kernel interface is supposed to be.
+
+
+The user driver
+---------------
+
+The queue file mmap space will need a user driver to wrap the communication
+protocol. Uacce provides some attributes in sysfs for the user driver to
+match the right accelerator accordingly.
+More details in Documentation/ABI/testing/sysfs-driver-uacce.
+
+
+The Uacce register API
+-----------------------
+The register API is defined in uacce.h.
+
+struct uacce_interface {
+	char name[32];
+	unsigned int flags;
+	struct uacce_ops *ops;
+};
+
+struct uacce_device *uacce_register(struct device *parent,
+				    struct uacce_interface *interface);
+void uacce_unregister(struct uacce_device *uacce);
+void uacce_wake_up(struct uacce_queue *q);
+
+
+According to the IOMMU capability, Uacce categories the devices as below:
+
+UACCE_DEV_SVA (UACCE_DEV_PASID | UACCE_DEV_FAULT_FROM_DEV)
+	The device has IOMMU which can share the same page table with user
+	process
+
+UACCE_DEV_SHARE_DOMAIN
+	This is used for device which does not support pasid.
+
+
+The Memory Sharing Model
+------------------------
+The perfect form of a Uacce device is to support SVM/SVA. We built this upon
+Jean Philippe Brucker's SVA patches. [1]
+
+If the hardware support SVA, the user process's page table is shared to the
+opened queue. So the device can access any address in the process address
+space. And it can raise a page fault if the physical page is not available
+yet. It can also access the address in the kernel space, which is referred by
+another page table particular to the kernel. Most of IOMMU implementation can
+handle this by a tag on the address request of the device. For example, ARM
+SMMU uses SSV bit to indicate that the address request is for kernel or user
+space.
+
+The device_attr UACCE_DEV_SVA is used to indicate this capability of the
+device. It is a combination of UACCE_DEV_FAULT_FROM_DEV and UACCE_DEV_PASID.
+
+If the device does not support UACCE_DEV_FAULT_FROM_DEV but UACCE_DEV_PASID.
+Uacce will create an unmanaged iommu_domain for the device. So it can be
+bound to multiple processes. In this case, the device cannot share the user
+page table directly. The user process must map the Static Share Queue File
+Region to create the connection. The Uacce kernel module will allocate
+physical memory to the region for both the device and the user process.
+
+If the device does not support UACCE_DEV_PASID either. There is no way for
+Uacce to support multiple process. Every Uacce allow only one process at
+the same time. In this case, DMA API cannot be used in this device. If the
+device driver need to share memory with the device, it should use QFRT_KO
+queue file region instead. This region is mmaped from the user space but
+valid only for kernel.
+
+We suggest the driver use uacce_mode module parameter to choose the working
+mode of the device. It can be:
+
+UACCE_MODE_NOUACCE (0)
+	Do not register to uacce. In this mode, the driver can register to
+	other kernel framework, such as crypto
+
+UACCE_MODE_UACCE (1)
+	Register to uacce. In this mode, the driver register to uacce. It can
+	register to other kernel framework according to whether it supports
+	PASID.
+
+
+The Folk Scenario
+=================
+For a process with allocated queues and shared memory, what happen if it forks
+a child?
+
+The fd of the queue will be duplicated on folk, so the child can send request
+to the same queue as its parent. But the requests which is sent from processes
+except for the one who opens the queue will be blocked.
+
+It is recommended to add O_CLOEXEC to the queue file.
+
+The queue mmap space has a VM_DONTCOPY in its VMA. So the child will lose all
+those VMAs.
+
+This is a reason why Uacce does not adopt the mode used in VFIO and
+InfiniBand.  Both solutions can set any user pointer for hardware sharing.
+But they cannot support fork when the dma is in process. Or the
+"Copy-On-Write" procedure will make the parent process lost its physical
+pages.
+
+
+Difference to the VFIO and IB framework
+---------------------------------------
+The essential function of Uacce is to let the device access the user
+address directly. There are many device drivers doing the same in the kernel.
+And both VFIO and IB can provide similar function in framework level.
+
+But Uacce has a different goal: "share address space". It is
+not taken the request to the accelerator as an enclosure data structure. It
+takes the accelerator as another thread of the same process. So the
+accelerator can refer to any address used by the process.
+
+Both VFIO and IB are taken this as "memory sharing", not "address sharing".
+They care more on sharing the block of memory. But if there is an address
+stored in the block and referring to another memory region. The address may
+not be valid.
+
+By adding more constraints to the VFIO and IB framework, in some sense, we may
+achieve a similar goal. But we gave it up finally. Both VFIO and IB have extra
+assumption which is unnecessary to Uacce. They may hurt each other if we
+try to merge them together.
+
+VFIO manages resource of a hardware as a "virtual device". If a device need to
+serve a separated application. It must isolate the resource as separate
+virtual device.  And the life cycle of the application and virtual device are
+unnecessary unrelated. And most concepts, such as bus, driver, probe and
+so on, to make it as a "device" is unnecessary either. And the logic added to
+VFIO to make address sharing do no help on "creating a virtual device".
+
+IB creates a "verbs" standard for sharing memory region to another remote
+entity.  Most of these verbs are to make memory region between entities to be
+synchronized.  This is not what accelerator need. Accelerator is in the same
+memory system with the CPU. It refers to the same memory system among CPU and
+devices. So the local memory terms/verbs are good enough for it. Extra "verbs"
+are not necessary. And its queue (like queue pair in IB) is the communication
+channel direct to the accelerator hardware. There is nothing about memory
+itself.
+
+Further, both VFIO and IB use the "pin" (get_user_page) way to lock local
+memory in place.  This is flexible. But it can cause other problems. For
+example, if the user process fork a child process. The COW procedure may make
+the parent process lost its pages which are sharing with the device. These may
+be fixed in the future. But is not going to be easy. (There is a discussion
+about this on Linux Plumbers Conference 2018 [2])
+
+So we choose to build the solution directly on top of IOMMU interface. IOMMU
+is the essential way for device and process to share their page mapping from
+the hardware perspective. It will be safe to create a software solution on
+this assumption.  Uacce manages the IOMMU interface for the accelerator
+device, so the device driver can export some of the resources to the user
+space. Uacce than can make sure the device and the process have the same
+address space.
+
+
+References
+==========
+.. [1] http://jpbrucker.net/sva/
+.. [2] https://lwn.net/Articles/774411/
-- 
2.7.4

