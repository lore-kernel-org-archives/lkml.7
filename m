Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B55ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4454F20854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbfJNKc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:32:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51700 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731519AbfJNKc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:32:56 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1BCE92ADD03FD824A3F2;
        Mon, 14 Oct 2019 18:32:52 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 14 Oct 2019
 18:32:43 +0800
Date:   Mon, 14 Oct 2019 11:32:31 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
CC:     reg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, <grant.likely@arm.com>,
        jean-philippe <jean-philippe@linaro.org>,
        <ilias.apalodimas@linaro.org>, <francois.ozog@linaro.org>,
        <kenneth-lee-2012@foxmail.com>, Wangzhou <wangzhou1@hisilicon.com>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        "Zaibo Xu" <xuzaibo@huawei.com>
Subject: Re: [PATCH v5 2/3] uacce: add uacce driver
Message-ID: <20191014113231.00002967@huawei.com>
In-Reply-To: <1571035735-31882-3-git-send-email-zhangfei.gao@linaro.org>
References: <1571035735-31882-1-git-send-email-zhangfei.gao@linaro.org>
        <1571035735-31882-3-git-send-email-zhangfei.gao@linaro.org>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2019 14:48:54 +0800
Zhangfei Gao <zhangfei.gao@linaro.org> wrote:

> From: Kenneth Lee <liguozhu@hisilicon.com>
> 
> Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
> provide Shared Virtual Addressing (SVA) between accelerators and processes.
> So accelerator can access any data structure of the main cpu.
> This differs from the data sharing between cpu and io device, which share
> data content rather than address.
> Since unified address, hardware and user space of process can share the
> same virtual address in the communication.
> 
> Uacce create a chrdev for every registration, the queue is allocated to
> the process when the chrdev is opened. Then the process can access the
> hardware resource by interact with the queue file. By mmap the queue
> file space to user space, the process can directly put requests to the
> hardware without syscall to the kernel space.
> 
> Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
> Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Hi,

Some superficial comments from me.

Thanks,

Jonathan


...

> +/*
> + * While user space releases a queue, all the relatives on the queue
> + * should be released immediately by this putting.

This one needs rewording but I'm not quite sure what
relatives are in this case.
 
> + */
> +static long uacce_put_queue(struct uacce_queue *q)
> +{
> +	struct uacce_device *uacce = q->uacce;
> +
> +	mutex_lock(&uacce_mutex);
> +
> +	if ((q->state == UACCE_Q_STARTED) && uacce->ops->stop_queue)
> +		uacce->ops->stop_queue(q);
> +
> +	if ((q->state == UACCE_Q_INIT || q->state == UACCE_Q_STARTED) &&
> +	     uacce->ops->put_queue)
> +		uacce->ops->put_queue(q);
> +
> +	q->state = UACCE_Q_ZOMBIE;
> +	mutex_unlock(&uacce_mutex);
> +
> +	return 0;
> +}
> +
..

> +
> +static ssize_t qfrs_size_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct uacce_device *uacce = to_uacce_device(dev);
> +	unsigned long size;
> +	int i, ret;
> +
> +	for (i = 0, ret = 0; i < UACCE_QFRT_MAX; i++) {
> +		size = uacce->qf_pg_size[i] << PAGE_SHIFT;
> +		if (i == UACCE_QFRT_SS)
> +			break;
> +		ret += sprintf(buf + ret, "%lu\t", size);
> +	}
> +	ret += sprintf(buf + ret, "%lu\n", size);
> +
> +	return ret;
> +}

This may break the sysfs rule of one thing per file.  If you have
multiple regions, they should probably each have their own file
to give their size.

> +
> +static DEVICE_ATTR_RO(id);
> +static DEVICE_ATTR_RO(api);
> +static DEVICE_ATTR_RO(numa_distance);
> +static DEVICE_ATTR_RO(node_id);
> +static DEVICE_ATTR_RO(flags);
> +static DEVICE_ATTR_RO(available_instances);
> +static DEVICE_ATTR_RO(algorithms);
> +static DEVICE_ATTR_RO(qfrs_size);
> +
> +static struct attribute *uacce_dev_attrs[] = {
> +	&dev_attr_id.attr,
> +	&dev_attr_api.attr,
> +	&dev_attr_node_id.attr,
> +	&dev_attr_numa_distance.attr,
> +	&dev_attr_flags.attr,
> +	&dev_attr_available_instances.attr,
> +	&dev_attr_algorithms.attr,
> +	&dev_attr_qfrs_size.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(uacce_dev);
> +
...

> +
> +/**
> + * uacce_unregister - unregisters a uacce
> + * @uacce: the accelerator to unregister
> + *
> + * Unregister an accelerator that wat previously successully registered with

wat -> was
successully -> successfully


> + * uacce_register().
> + */
> +void uacce_unregister(struct uacce_device *uacce)
> +{
> +	mutex_lock(&uacce_mutex);
> +
> +	if (uacce->flags & UACCE_DEV_SVA)
> +		iommu_dev_disable_feature(uacce->pdev, IOMMU_DEV_FEAT_SVA);
> +
> +	uacce_unset_iommu_domain(uacce);
> +	cdev_device_del(uacce->cdev, &uacce->dev);
> +	idr_remove(&uacce_idr, uacce->dev_id);
> +	put_device(&uacce->dev);
> +
> +	mutex_unlock(&uacce_mutex);
> +}
> +EXPORT_SYMBOL_GPL(uacce_unregister);
> +
...
> diff --git a/include/linux/uacce.h b/include/linux/uacce.h
> new file mode 100644
> index 0000000..9137f3d
> --- /dev/null
> +++ b/include/linux/uacce.h
> @@ -0,0 +1,167 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _LINUX_UACCE_H
> +#define _LINUX_UACCE_H
> +
> +#include <linux/cdev.h>
> +#include <uapi/misc/uacce/uacce.h>
> +
> +#define UACCE_NAME		"uacce"
> +
> +struct uacce_queue;
> +struct uacce_device;
> +
> +/* uacce queue file flag, requires different operation */
> +#define UACCE_QFRF_MAP		BIT(0)	/* map to current queue */
> +#define UACCE_QFRF_MMAP		BIT(1)	/* map to user space */
> +#define UACCE_QFRF_KMAP		BIT(2)	/* map to kernel space */
> +#define UACCE_QFRF_DMA		BIT(3)	/* use dma api for the region */
> +#define UACCE_QFRF_SELFMT	BIT(4)	/* self maintained qfr */
> +

...

> +/**
> + * struct uacce_queue
> + * @uacce: pointer to uacce
> + * @priv: private pointer
> + * @wait: wait queue head
> + * @pasid: pasid of the queue
> + * @handle: iommu_sva handle return from iommu_sva_bind_device
> + * @list: share list for qfr->qs
> + * @mm: current->mm
> + * @qfrs: pointer of qfr regions

Missing state.  Make sure to run
./scripts/kernel-doc FILENAME > /dev/null and
fix any errors that show up.

> + */
> +struct uacce_queue {
> +	struct uacce_device *uacce;
> +	void *priv;
> +	wait_queue_head_t wait;
> +	int pasid;
> +	struct iommu_sva *handle;
> +	struct list_head list;
> +	struct mm_struct *mm;
> +	struct uacce_qfile_region *qfrs[UACCE_QFRT_MAX];
> +	enum uacce_q_state state;
> +};
...

Thanks,

Jonathan

