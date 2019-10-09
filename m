Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7CCECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94909218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbfJIQLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:11:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:1714 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730503AbfJIQLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:11:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 09:11:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,276,1566889200"; 
   d="scan'208";a="198052928"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006.jf.intel.com with ESMTP; 09 Oct 2019 09:11:38 -0700
Subject: Re: [RESEND PATCH v4 1/2] uacce: Add documents for uacce
To:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, jonathan.cameron@huawei.com,
        grant.likely@arm.com, jean-philippe <jean-philippe@linaro.org>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     Zaibo Xu <xuzaibo@huawei.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-accelerators@lists.ozlabs.org
References: <1570634502-20923-1-git-send-email-zhangfei.gao@linaro.org>
 <1570634502-20923-2-git-send-email-zhangfei.gao@linaro.org>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <0d339fc4-9a15-9f7f-4f19-89bf8baf1301@intel.com>
Date:   Wed, 9 Oct 2019 09:11:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1570634502-20923-2-git-send-email-zhangfei.gao@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/19 8:21 AM, Zhangfei Gao wrote:
> From: Kenneth Lee <liguozhu@hisilicon.com>
> 
> Uacce (Unified/User-space-access-intended Accelerator Framework) is
> a kernel module targets to provide Shared Virtual Addressing (SVA)
> between the accelerator and process.
> 
> This patch add document to explain how it works.
> 
> Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
> Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>   Documentation/misc-devices/uacce.rst | 297 +++++++++++++++++++++++++++++++++++
>   1 file changed, 297 insertions(+)
>   create mode 100644 Documentation/misc-devices/uacce.rst
> 
> diff --git a/Documentation/misc-devices/uacce.rst b/Documentation/misc-devices/uacce.rst
> new file mode 100644
> index 0000000..b3cf0d5
> --- /dev/null
> +++ b/Documentation/misc-devices/uacce.rst
> @@ -0,0 +1,297 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Introduction of Uacce
> +=========================
> +
> +Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
> +provide Shared Virtual Addressing (SVA) between accelerators and processes.
> +So accelerator can access any data structure of the main cpu.
> +This differs from the data sharing between cpu and io device, which share
> +data content rather than address.
> +Because of the unified address, hardware and user space of process can
> +share the same virtual address in the communication.
> +Uacce takes the hardware accelerator as a heterogeneous processor, while
> +IOMMU share the same CPU page tables and as a result the same translation
> +from va to pa.
> +
> +	 __________________________       __________________________
> +	|                          |     |                          |
> +	|  User application (CPU)  |     |   Hardware Accelerator   |
> +	|__________________________|     |__________________________|
> +
> +	             |                                 |
> +	             | va                              | va
> +	             V                                 V
> +                 __________                        __________
> +                |          |                      |          |
> +                |   MMU    |                      |  IOMMU   |
> +                |__________|                      |__________|
> +		     |                                 |
> +	             |                                 |
> +	             V pa                              V pa
> +		 _______________________________________
> +		|                                       |
> +		|              Memory                   |
> +		|_______________________________________|
> +
> +
> +
> +Architecture
> +------------
> +
> +Uacce is the kernel module, taking charge of iommu and address sharing.
> +The user drivers and libraries are called WarpDrive.
> +
> +A virtual concept, queue, is used for the communication. It provides a
> +FIFO-like interface. And it maintains a unified address space between the
> +application and all involved hardware.
> +
> +                             ___________________                  ________________
> +                            |                   |   user API     |                |
> +                            | WarpDrive library | ------------>  |  user driver   |
> +                            |___________________|                |________________|
> +                                     |                                    |
> +                                     |                                    |
> +                                     | queue fd                           |
> +                                     |                                    |
> +                                     |                                    |
> +                                     v                                    |
> +     ___________________         _________                                |
> +    |                   |       |         |                               | mmap memory
> +    | Other framework   |       |  uacce  |                               | r/w interface
> +    | crypto/nic/others |       |_________|                               |
> +    |___________________|                                                 |
> +             |                       |                                    |
> +             | register              | register                           |
> +             |                       |                                    |
> +             |                       |                                    |
> +             |                _________________       __________          |
> +             |               |                 |     |          |         |
> +              -------------  |  Device Driver  |     |  IOMMU   |         |
> +                             |_________________|     |__________|         |
> +                                     |                                    |
> +                                     |                                    V
> +                                     |                            ___________________
> +                                     |                           |                   |
> +                                     --------------------------  |  Device(Hardware) |
> +                                                                 |___________________|
> +
> +
> +How does it work
> +================
> +
> +Uacce uses mmap and IOMMU to play the trick.
> +
> +Uacce create a chrdev for every device registered to it. New queue is
> +created when user application open the chrdev. The file descriptor is used
> +as the user handle of the queue.
> +The accelerator device present itself as an Uacce object, which exports as
> +chrdev to the user space. The user application communicates with the
> +hardware by ioctl (as control path) or share memory (as data path).
> +
> +The control path to the hardware is via file operation, while data path is
> +via mmap space of the queue fd.
> +
> +The queue file address space:
> +
> +enum uacce_qfrt {
> +	UACCE_QFRT_MMIO = 0,	/* device mmio region */
> +	UACCE_QFRT_DKO = 1,	/* device kernel-only region */
> +	UACCE_QFRT_DUS = 2,	/* device user share region */
> +	UACCE_QFRT_SS = 3,	/* static shared memory (for non-sva devices) */
> +	UACCE_QFRT_MAX = 16,
> +};
> +
> +All regions are optional and differ from device type to type. The
> +communication protocol is wrapped by the user driver.
> +
> +The device mmio region is mapped to the hardware mmio space. It is generally
> +used for doorbell or other notification to the hardware. It is not fast enough
> +as data channel.
> +
> +The device kernel-only region is necessary only if the device IOMMU has no
> +PASID support or it cannot send kernel-only address request. In this case, if
> +kernel need to share memory with the device, kernel has to share iova address
> +space with the user process via mmap, to prevent iova conflict.
> +
> +The device user share region is used for share data buffer between user process
> +and device. It can be merged into other regions. But a separated region can help
> +on device state management. For example, the device can be started when this
> +region is mapped.
> +
> +The static share virtual memory region is used for share data buffer with the
> +device and can be shared among queues / devices.
> +Its size is set according to the application requirement.
> +
> +
> +The user API
> +------------
> +
> +We adopt a polling style interface in the user space: ::
> +
> +	int wd_request_queue(struct wd_queue *q);
> +	void wd_release_queue(struct wd_queue *q);
> +	int wd_send(struct wd_queue *q, void *req);
> +	int wd_recv(struct wd_queue *q, void **req);
> +	int wd_recv_sync(struct wd_queue *q, void **req);
> +	void wd_flush(struct wd_queue *q);
> +
> +wd_recv_sync() is a wrapper to its non-sync version. It will trap into
> +kernel and wait until the queue become available.
> +
> +If the queue do not support SVA/SVM. The following helper functions
> +can be used to create Static Virtual Share Memory: ::
> +
> +	void *wd_reserve_memory(struct wd_queue *q, size_t size);
> +	int wd_share_reserved_memory(struct wd_queue *q,
> +				     struct wd_queue *target_q);
> +
> +The user API is not mandatory. It is simply a suggestion and hint what the
> +kernel interface is supposed to be.
> +
> +
> +The user driver
> +---------------
> +
> +The queue file mmap space will need a user driver to wrap the communication
> +protocol. Uacce provides some attributes in sysfs for the user driver to
> +match the right accelerator accordingly.
> +More details in Documentation/ABI/testing/sysfs-driver-uacce.
> +
> +
> +The Uacce register API
> +-----------------------
> +The register API is defined in uacce.h.
> +
> +struct uacce_interface {
> +	char name[32];
> +	unsigned int flags;
> +	struct uacce_ops *ops;
> +};
> +
> +According to the IOMMU capability, uacce_interface flags can be:
> +
> +UACCE_DEV_SVA (0x1)
> +	Support shared virtual address
> +
> +UACCE_DEV_SHARE_DOMAIN (0)
> +	This is used for device which does not support pasid.
> +
> +struct uacce_device *uacce_register(struct device *parent,
> +				    struct uacce_interface *interface);
> +void uacce_unregister(struct uacce_device *uacce);
> +
> +uacce_register resultes can be:
> +a. If uacce module is not compiled, ERR_PTR(-ENODEV)
> +b. Succeed with the desired flags
> +c. Succeed with the negotiated flags, for example
> +   uacce_interface.flags = UACCE_DEV_SVA but uacce->flags = ~UACCE_DEV_SVA
> +So user driver need check return value as well as the negotiated uacce->flags.
> +
> +
> +The Memory Sharing Model
> +------------------------
> +The perfect form of a Uacce device is to support SVM/SVA. We built this upon
> +Jean Philippe Brucker's SVA patches. [1]
> +
> +If the hardware support UACCE_DEV_SVA, the user process's page table is
> +shared to the opened queue. So the device can access any address in the
> +process address space.
> +And it can raise a page fault if the physical page is not available yet.
> +It can also access the address in the kernel space, which is referred by
> +another page table particular to the kernel. Most of IOMMU implementation can
> +handle this by a tag on the address request of the device. For example, ARM
> +SMMU uses SSV bit to indicate that the address request is for kernel or user
> +space.
> +Queue file regions can be used:
> +UACCE_QFRT_MMIO: device mmio region (map to user)
> +UACCE_QFRT_DUS: device user share (map to dev and user)
> +
> +If the device does not support UACCE_DEV_SVA, Uacce allow only one process at
> +the same time. DMA API cannot be used as well, since Uacce will create an
> +unmanaged iommu_domain for the device.
> +Queue file regions can be used:
> +UACCE_QFRT_MMIO: device mmio region (map to user)
> +UACCE_QFRT_DKO: device kernel-only (map to dev, no user)
> +UACCE_QFRT_DUS: device user share (map to dev and user)
> +UACCE_QFRT_SS:  static share memory (map to devs and user)
> +
> +
> +The Folk Scenario
> +=================

s/Folk/Fork/

> +For a process with allocated queues and shared memory, what happen if it forks
> +a child?
> +
> +The fd of the queue will be duplicated on folk, so the child can send request
> +to the same queue as its parent. But the requests which is sent from processes
> +except for the one who opens the queue will be blocked.
> +
> +It is recommended to add O_CLOEXEC to the queue file.
> +
> +The queue mmap space has a VM_DONTCOPY in its VMA. So the child will lose all
> +those VMAs.
> +
> +This is a reason why Uacce does not adopt the mode used in VFIO and
> +InfiniBand.  Both solutions can set any user pointer for hardware sharing.
> +But they cannot support fork when the dma is in process. Or the
> +"Copy-On-Write" procedure will make the parent process lost its physical
> +pages.
> +
> +
> +Difference to the VFIO and IB framework
> +---------------------------------------
> +The essential function of Uacce is to let the device access the user
> +address directly. There are many device drivers doing the same in the kernel.
> +And both VFIO and IB can provide similar function in framework level.
> +
> +But Uacce has a different goal: "share address space". It is
> +not taken the request to the accelerator as an enclosure data structure. It
> +takes the accelerator as another thread of the same process. So the
> +accelerator can refer to any address used by the process.
> +
> +Both VFIO and IB are taken this as "memory sharing", not "address sharing".
> +They care more on sharing the block of memory. But if there is an address
> +stored in the block and referring to another memory region. The address may
> +not be valid.
> +
> +By adding more constraints to the VFIO and IB framework, in some sense, we may
> +achieve a similar goal. But we gave it up finally. Both VFIO and IB have extra
> +assumption which is unnecessary to Uacce. They may hurt each other if we
> +try to merge them together.
> +
> +VFIO manages resource of a hardware as a "virtual device". If a device need to
> +serve a separated application. It must isolate the resource as a separate
> +virtual device.  And the life cycle of the application and virtual device are
> +unnecessary unrelated. And most concepts, such as bus, driver, probe and
> +so on, to make it as a "device" is unnecessary either. And the logic added to
> +VFIO to make address sharing do no help on "creating a virtual device".
> +
> +IB creates a "verbs" standard for sharing memory region to another remote
> +entity.  Most of these verbs are to make memory region between entities to be
> +synchronized.  This is not what accelerator need. Accelerator is in the same
> +memory system with the CPU. It refers to the same memory system among CPU and
> +devices. So the local memory terms/verbs are good enough for it. Extra "verbs"
> +are not necessary. And its queue (like queue pair in IB) is the communication
> +channel direct to the accelerator hardware. There is nothing about memory
> +itself.
> +
> +Further, both VFIO and IB use the "pin" (get_user_page) way to lock local
> +memory in place.  This is flexible. But it can cause other problems. For
> +example, if the user process fork a child process. The COW procedure may make
> +the parent process lost its pages which are sharing with the device. These may
> +be fixed in the future. But is not going to be easy. (There is a discussion
> +about this on Linux Plumbers Conference 2018 [2])
> +
> +So we choose to build the solution directly on top of IOMMU interface. IOMMU
> +is the essential way for device and process to share their page mapping from
> +the hardware perspective. It will be safe to create a software solution on
> +this assumption.  Uacce manages the IOMMU interface for the accelerator
> +device, so the device driver can export some of the resources to the user
> +space. Uacce than can make sure the device and the process have the same
> +address space.
> +
> +
> +References
> +==========
> +.. [1] http://jpbrucker.net/sva/
> +.. [2] https://lwn.net/Articles/774411/
> 
