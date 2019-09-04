Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F8FC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80EB122CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567601425;
	bh=NqvWXc7WBbc631nlVSRp46p7yaaJdmPan254VDAOftg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XMgncUlF4fyF54JTMwY25laNnJSp/1a4+AQlrcS0Bu/hlqb1nrExWYvrxFvJGhEue
	 PjRl0lLLeVCE8oQwo/WzhElCXycC8Uz21Ke9sDbi8L6379dcoCPUDW9YdOoXQY/5L9
	 uYhLxHQ7agckhd3isgcaJ0BZPWQmcKOScCNh+FTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfIDMuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbfIDMuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:50:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 307A221883;
        Wed,  4 Sep 2019 12:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567601420;
        bh=NqvWXc7WBbc631nlVSRp46p7yaaJdmPan254VDAOftg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lak71CtrpFaF/U1MfYuu4hFsVfnGlRlIBZcYjZLVL6zHJl5vcy7oRtmK9bY5CT9Mi
         FPiJicrH3WFYc8qLp7PkMqhaVVT1Gy4JCg9oczALF+QHU+Iom/9LCAPDmXtrOqBqmy
         hDts3R8n78tVuu5xNSoAtvyQwU1yXq1m70qAmgRU=
Date:   Wed, 4 Sep 2019 14:50:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, jonathan.cameron@huawei.com,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>
Subject: Re: [PATCH v3 2/2] uacce: add uacce driver
Message-ID: <20190904125018.GD5043@kroah.com>
References: <1567482778-5700-1-git-send-email-zhangfei.gao@linaro.org>
 <1567484087-8071-1-git-send-email-zhangfei.gao@linaro.org>
 <1567484087-8071-2-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567484087-8071-2-git-send-email-zhangfei.gao@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 12:14:47PM +0800, Zhangfei Gao wrote:
> +/**
> + * uacce_wake_up - Wake up the process who is waiting this queue
> + * @q the accelerator queue to wake up
> + */
> +void uacce_wake_up(struct uacce_queue *q)
> +{
> +	wake_up_interruptible(&q->wait);
> +}
> +EXPORT_SYMBOL_GPL(uacce_wake_up);

You are exporting things that have no in-kernel user, which is not
allowed.

Can you redo this patch series with an actual user of this new api you
are creating?  Otherwise we have no way of properly understanding just
what is going on here.

Also, do you really need a function to do the above?  Why?

> +static int uacce_dev_open_check(struct uacce_device *uacce)
> +{
> +	/*
> +	 * The device can be opened once if it dose not support pasid
> +	 */
> +	if (uacce->flags & UACCE_DEV_PASID)
> +		return 0;
> +
> +	if (atomic_cmpxchg(&uacce->state, UACCE_ST_INIT, UACCE_ST_OPENED) !=
> +	    UACCE_ST_INIT) {
> +		dev_info(&uacce->dev, "this device can be openned only once\n");

No, NEVER do this, it's wrong, an easy way to spam the syslog for no
good reason, and flat out does not work at all.

Just let userspace deal with something like this, if they want to open
multiple times, let it deal with the fallout.  Just like a tty device
node.



> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static int uacce_fops_open(struct inode *inode, struct file *filep)
> +{
> +	struct uacce_queue *q;
> +	struct iommu_sva *handle = NULL;
> +	struct uacce_device *uacce;
> +	int ret;
> +	int pasid = 0;
> +
> +	uacce = idr_find(&uacce_idr, iminor(inode));
> +	if (!uacce)
> +		return -ENODEV;
> +
> +	if (atomic_read(&uacce->state) == UACCE_ST_RST)
> +		return -EINVAL;

What happens if the state changes _right_ after this check?

> +
> +	if ((!uacce->ops->get_queue) || (!uacce->ops->start_queue))
> +		return -EINVAL;

How would these two functions ever not be NULL?

Why check for them in open()?  Why not when you register the operations?

> +	if (!try_module_get(uacce->pdev->driver->owner))
> +		return -ENODEV;
> +
> +	ret = uacce_dev_open_check(uacce);
> +	if (ret)
> +		goto open_err;
> +
> +#ifdef CONFIG_IOMMU_SVA
> +	if (uacce->flags & UACCE_DEV_PASID) {
> +		handle = iommu_sva_bind_device(uacce->pdev, current->mm, NULL);
> +		if (IS_ERR(handle))
> +			goto open_err;
> +		pasid = iommu_sva_get_pasid(handle);
> +	}
> +#endif
> +	ret = uacce->ops->get_queue(uacce, pasid, &q);
> +	if (ret < 0)
> +		goto open_err;
> +
> +	q->pasid = pasid;
> +	q->handle = handle;
> +	q->uacce = uacce;
> +	q->mm = current->mm;
> +	memset(q->qfrs, 0, sizeof(q->qfrs));
> +	INIT_LIST_HEAD(&q->list);
> +	init_waitqueue_head(&q->wait);
> +	filep->private_data = q;
> +	mutex_lock(&uacce->q_lock);
> +	list_add(&q->q_dev, &uacce->qs);
> +	mutex_unlock(&uacce->q_lock);
> +
> +	return 0;
> +
> +open_err:
> +	module_put(uacce->pdev->driver->owner);
> +	return ret;
> +}
> +
> +static int uacce_fops_release(struct inode *inode, struct file *filep)
> +{
> +	struct uacce_queue *q = filep->private_data;
> +	struct uacce_qfile_region *qfr;
> +	struct uacce_device *uacce = q->uacce;
> +	bool is_to_free_region;
> +	int free_pages = 0;
> +	int i;
> +
> +	mutex_lock(&uacce->q_lock);
> +	list_del(&q->q_dev);
> +	mutex_unlock(&uacce->q_lock);
> +
> +	if (atomic_read(&uacce->state) == UACCE_ST_STARTED &&
> +	    uacce->ops->stop_queue)
> +		uacce->ops->stop_queue(q);

Same question as before, what happens right after this check?

Do not use an atomic value thinking it is how to properly test for state
changes.  Use a "real" lock for this, otherwise it does not work at all.

> +
> +	mutex_lock(&uacce_mutex);
> +
> +	for (i = 0; i < UACCE_QFRT_MAX; i++) {
> +		qfr = q->qfrs[i];
> +		if (!qfr)
> +			continue;
> +
> +		is_to_free_region = false;
> +		uacce_queue_unmap_qfr(q, qfr);
> +		if (i == UACCE_QFRT_SS) {
> +			list_del(&q->list);
> +			if (list_empty(&qfr->qs))
> +				is_to_free_region = true;
> +		} else
> +			is_to_free_region = true;
> +
> +		if (is_to_free_region) {
> +			free_pages += qfr->nr_pages;
> +			uacce_destroy_region(q, qfr);
> +		}
> +
> +		qfr = NULL;
> +	}
> +
> +	mutex_unlock(&uacce_mutex);
> +
> +	if (current->mm == q->mm) {
> +		down_write(&q->mm->mmap_sem);
> +		q->mm->data_vm -= free_pages;
> +		up_write(&q->mm->mmap_sem);
> +	}
> +
> +#ifdef CONFIG_IOMMU_SVA
> +	if (uacce->flags & UACCE_DEV_PASID)
> +		iommu_sva_unbind_device(q->handle);
> +#endif
> +
> +	if (uacce->ops->put_queue)
> +		uacce->ops->put_queue(q);
> +
> +	atomic_set(&uacce->state, UACCE_ST_INIT);
> +	module_put(uacce->pdev->driver->owner);
> +
> +	return 0;
> +}
> +
> +static enum uacce_qfrt uacce_get_region_type(struct uacce_device *uacce,
> +					     struct vm_area_struct *vma)
> +{
> +	enum uacce_qfrt type = UACCE_QFRT_MAX;
> +	size_t next_start = UACCE_QFR_NA;
> +	int i;
> +
> +	for (i = UACCE_QFRT_MAX - 1; i >= 0; i--) {
> +		if (vma->vm_pgoff >= uacce->qf_pg_start[i]) {
> +			type = i;
> +			break;
> +		}
> +	}
> +
> +	switch (type) {
> +	case UACCE_QFRT_MMIO:
> +		if (!uacce->ops->mmap) {
> +			dev_err(&uacce->dev, "no driver mmap!\n");
> +			return UACCE_QFRT_MAX;

You not return an error?

> +		}
> +		break;
> +
> +	case UACCE_QFRT_DKO:
> +		if (uacce->flags & UACCE_DEV_PASID)
> +			return UACCE_QFRT_MAX;

Same here, no error?

> +		break;
> +
> +	case UACCE_QFRT_DUS:
> +		break;
> +
> +	case UACCE_QFRT_SS:
> +		/* todo: this can be valid to protect the process space */
> +		if (uacce->flags & UACCE_DEV_FAULT_FROM_DEV)
> +			return UACCE_QFRT_MAX;

error?

> +		break;
> +
> +	default:
> +		dev_err(&uacce->dev, "uacce bug (%d)!\n", type);

Are you now allowing userspace to spam the kernel log if you send it
random crud?

> +		return UACCE_QFRT_MAX;

Return a proper error here and lots of other places.

> +	}
> +
> +	/* make sure the mapping size is exactly the same as the region */
> +	if (type < UACCE_QFRT_SS) {
> +		for (i = type + 1; i < UACCE_QFRT_MAX; i++)
> +			if (uacce->qf_pg_start[i] != UACCE_QFR_NA) {
> +				next_start = uacce->qf_pg_start[i];
> +				break;
> +			}
> +
> +		if (next_start == UACCE_QFR_NA) {
> +			dev_err(&uacce->dev, "uacce config error: SS offset set improperly\n");
> +			return UACCE_QFRT_MAX;
> +		}
> +
> +		if (vma_pages(vma) !=
> +		    next_start - uacce->qf_pg_start[type]) {
> +			dev_err(&uacce->dev, "invalid mmap size (%ld vs %ld pages) for region %s.\n",
> +				vma_pages(vma),
> +				next_start - uacce->qf_pg_start[type],
> +				qfrt_str[type]);
> +			return UACCE_QFRT_MAX;
> +		}
> +	}
> +
> +	return type;
> +}
> +
> +static int uacce_fops_mmap(struct file *filep, struct vm_area_struct *vma)
> +{
> +	struct uacce_queue *q = filep->private_data;
> +	struct uacce_device *uacce = q->uacce;
> +	enum uacce_qfrt type = uacce_get_region_type(uacce, vma);
> +	struct uacce_qfile_region *qfr;
> +	unsigned int flags = 0;
> +	int ret;
> +
> +	if (type == UACCE_QFRT_MAX)
> +		return -EINVAL;
> +
> +	vma->vm_flags |= VM_DONTCOPY | VM_DONTEXPAND;
> +
> +	mutex_lock(&uacce_mutex);
> +
> +	/* fixme: if the region need no pages, we don't need to check it */
> +	if (q->mm->data_vm + vma_pages(vma) >
> +	    rlimit(RLIMIT_DATA) >> PAGE_SHIFT) {
> +		ret = -ENOMEM;
> +		goto out_with_lock;
> +	}
> +
> +	if (q->qfrs[type]) {
> +		ret = -EBUSY;
> +		goto out_with_lock;
> +	}
> +
> +	switch (type) {
> +	case UACCE_QFRT_MMIO:
> +		flags = UACCE_QFRF_SELFMT;
> +		break;
> +
> +	case UACCE_QFRT_SS:
> +		if (atomic_read(&uacce->state) != UACCE_ST_STARTED) {
> +			ret = -EINVAL;
> +			goto out_with_lock;
> +		}
> +
> +		flags = UACCE_QFRF_MAP | UACCE_QFRF_MMAP;
> +
> +		break;
> +
> +	case UACCE_QFRT_DKO:
> +		flags = UACCE_QFRF_MAP | UACCE_QFRF_KMAP;
> +
> +		break;
> +
> +	case UACCE_QFRT_DUS:
> +		if (uacce->flags & UACCE_DEV_PASID) {
> +			flags = UACCE_QFRF_SELFMT;
> +			break;
> +		}
> +
> +		flags = UACCE_QFRF_MAP | UACCE_QFRF_MMAP;
> +		break;
> +
> +	default:
> +		WARN_ON(&uacce->dev);
> +		break;
> +	}
> +
> +	qfr = uacce_create_region(q, vma, type, flags);
> +	if (IS_ERR(qfr)) {
> +		ret = PTR_ERR(qfr);
> +		goto out_with_lock;
> +	}
> +	q->qfrs[type] = qfr;
> +
> +	if (type == UACCE_QFRT_SS) {
> +		INIT_LIST_HEAD(&qfr->qs);
> +		list_add(&q->list, &q->qfrs[type]->qs);
> +	}
> +
> +	mutex_unlock(&uacce_mutex);
> +
> +	if (qfr->pages)
> +		q->mm->data_vm += qfr->nr_pages;
> +
> +	return 0;
> +
> +out_with_lock:
> +	mutex_unlock(&uacce_mutex);
> +	return ret;
> +}
> +
> +static __poll_t uacce_fops_poll(struct file *file, poll_table *wait)
> +{
> +	struct uacce_queue *q = file->private_data;
> +	struct uacce_device *uacce = q->uacce;
> +
> +	poll_wait(file, &q->wait, wait);
> +	if (uacce->ops->is_q_updated && uacce->ops->is_q_updated(q))
> +		return EPOLLIN | EPOLLRDNORM;
> +
> +	return 0;
> +}
> +
> +static const struct file_operations uacce_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= uacce_fops_open,
> +	.release	= uacce_fops_release,
> +	.unlocked_ioctl	= uacce_fops_unl_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl	= uacce_fops_compat_ioctl,
> +#endif
> +	.mmap		= uacce_fops_mmap,
> +	.poll		= uacce_fops_poll,
> +};
> +
> +#define UACCE_FROM_CDEV_ATTR(dev) container_of(dev, struct uacce_device, dev)
> +
> +static ssize_t id_show(struct device *dev,
> +		       struct device_attribute *attr, char *buf)
> +{
> +	struct uacce_device *uacce = UACCE_FROM_CDEV_ATTR(dev);

FROM_CDEV?  But that's not a cdev.  I'm confused.  Pick a better name
for your macro please.

> +
> +	return sprintf(buf, "%d\n", uacce->dev_id);
> +}
> +
> +static ssize_t api_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct uacce_device *uacce = UACCE_FROM_CDEV_ATTR(dev);
> +
> +	return sprintf(buf, "%s\n", uacce->api_ver);
> +}
> +
> +static ssize_t numa_distance_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct uacce_device *uacce = UACCE_FROM_CDEV_ATTR(dev);
> +	int distance;
> +
> +	distance = node_distance(smp_processor_id(), uacce->pdev->numa_node);
> +
> +	return sprintf(buf, "%d\n", abs(distance));
> +}
> +
> +static ssize_t node_id_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct uacce_device *uacce = UACCE_FROM_CDEV_ATTR(dev);
> +	int node_id;
> +
> +	node_id = dev_to_node(uacce->pdev);
> +
> +	return sprintf(buf, "%d\n", node_id);
> +}
> +
> +static ssize_t flags_show(struct device *dev,
> +			  struct device_attribute *attr, char *buf)
> +{
> +	struct uacce_device *uacce = UACCE_FROM_CDEV_ATTR(dev);
> +
> +	return sprintf(buf, "%d\n", uacce->flags);
> +}
> +
> +static ssize_t available_instances_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct uacce_device *uacce = UACCE_FROM_CDEV_ATTR(dev);
> +	int val = 0;
> +
> +	if (uacce->ops->get_available_instances)
> +		val = uacce->ops->get_available_instances(uacce);
> +
> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +static ssize_t algorithms_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct uacce_device *uacce = UACCE_FROM_CDEV_ATTR(dev);
> +
> +	return sprintf(buf, "%s", uacce->algs);
> +}
> +
> +static ssize_t qfrs_offset_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct uacce_device *uacce = UACCE_FROM_CDEV_ATTR(dev);
> +	int i, ret;
> +	unsigned long offset;
> +
> +	for (i = 0, ret = 0; i < UACCE_QFRT_MAX; i++) {
> +		offset = uacce->qf_pg_start[i];
> +		if (offset != UACCE_QFR_NA)
> +			offset = offset << PAGE_SHIFT;
> +		if (i == UACCE_QFRT_SS)
> +			break;
> +		ret += sprintf(buf + ret, "%lu\t", offset);
> +	}
> +	ret += sprintf(buf + ret, "%lu\n", offset);
> +
> +	return ret;
> +}
> +
> +static DEVICE_ATTR_RO(id);
> +static DEVICE_ATTR_RO(api);
> +static DEVICE_ATTR_RO(numa_distance);
> +static DEVICE_ATTR_RO(node_id);
> +static DEVICE_ATTR_RO(flags);
> +static DEVICE_ATTR_RO(available_instances);
> +static DEVICE_ATTR_RO(algorithms);
> +static DEVICE_ATTR_RO(qfrs_offset);
> +
> +static struct attribute *uacce_dev_attrs[] = {
> +	&dev_attr_id.attr,
> +	&dev_attr_api.attr,
> +	&dev_attr_node_id.attr,
> +	&dev_attr_numa_distance.attr,
> +	&dev_attr_flags.attr,
> +	&dev_attr_available_instances.attr,
> +	&dev_attr_algorithms.attr,
> +	&dev_attr_qfrs_offset.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group uacce_dev_attr_group = {
> +	.attrs	= uacce_dev_attrs,
> +};
> +
> +static const struct attribute_group *uacce_dev_attr_groups[] = {
> +	&uacce_dev_attr_group,
> +	NULL
> +};

ATTRIBUTE_GROUPS()?

> +
> +static void uacce_release(struct device *dev)
> +{
> +	struct uacce_device *uacce = UACCE_FROM_CDEV_ATTR(dev);
> +
> +	idr_remove(&uacce_idr, uacce->dev_id);
> +	kfree(uacce);
> +}
> +
> +static int uacce_create_chrdev(struct uacce_device *uacce)

You do more than just that here, you should rename the function.

> +{
> +	int ret;
> +
> +	ret = idr_alloc(&uacce_idr, uacce, 0, 0, GFP_KERNEL);
> +	if (ret < 0)
> +		return ret;
> +
> +	uacce->cdev = cdev_alloc();
> +	uacce->cdev->ops = &uacce_fops;
> +	uacce->dev_id = ret;
> +	uacce->cdev->owner = THIS_MODULE;
> +	device_initialize(&uacce->dev);
> +	uacce->dev.devt = MKDEV(MAJOR(uacce_devt), uacce->dev_id);
> +	uacce->dev.class = uacce_class;
> +	uacce->dev.groups = uacce_dev_attr_groups;
> +	uacce->dev.parent = uacce->pdev;
> +	uacce->dev.release = uacce_release;
> +	dev_set_name(&uacce->dev, "%s-%d", uacce->drv_name, uacce->dev_id);
> +	ret = cdev_device_add(uacce->cdev, &uacce->dev);
> +	if (ret)
> +		goto err_with_idr;
> +
> +	dev_dbg(&uacce->dev, "create uacce minior=%d\n", uacce->dev_id);
> +
> +	return 0;
> +
> +err_with_idr:
> +	idr_remove(&uacce_idr, uacce->dev_id);
> +	return ret;
> +}
> +
> +static void uacce_destroy_chrdev(struct uacce_device *uacce)
> +{
> +	cdev_device_del(uacce->cdev, &uacce->dev);
> +	put_device(&uacce->dev);

Again, drop the _chrdev in the function name.

> +}
> +
> +static int uacce_dev_match(struct device *dev, void *data)
> +{
> +	if (dev->parent == data)
> +		return -EBUSY;
> +
> +	return 0;

Do you really need this?

> +}
> +
> +/* Borrowed from VFIO to fix msi translation */
> +static bool uacce_iommu_has_sw_msi(struct iommu_group *group,
> +				   phys_addr_t *base)
> +{
> +	struct list_head group_resv_regions;
> +	struct iommu_resv_region *region, *next;
> +	bool ret = false;
> +
> +	INIT_LIST_HEAD(&group_resv_regions);
> +	iommu_get_group_resv_regions(group, &group_resv_regions);
> +	list_for_each_entry(region, &group_resv_regions, list) {
> +		pr_debug("uacce: find a resv region (%d) on %llx\n",
> +			 region->type, region->start);
> +
> +		/*
> +		 * The presence of any 'real' MSI regions should take
> +		 * precedence over the software-managed one if the
> +		 * IOMMU driver happens to advertise both types.
> +		 */
> +		if (region->type == IOMMU_RESV_MSI) {
> +			ret = false;
> +			break;
> +		}
> +
> +		if (region->type == IOMMU_RESV_SW_MSI) {
> +			*base = region->start;
> +			ret = true;
> +		}
> +	}
> +	list_for_each_entry_safe(region, next, &group_resv_regions, list)
> +		kfree(region);
> +
> +	return ret;
> +}
> +
> +static int uacce_set_iommu_domain(struct uacce_device *uacce)
> +{
> +	struct iommu_domain *domain;
> +	struct iommu_group *group;
> +	struct device *dev = uacce->pdev;
> +	bool resv_msi;
> +	phys_addr_t resv_msi_base = 0;
> +	int ret;
> +
> +	if (uacce->flags & UACCE_DEV_PASID)
> +		return 0;
> +
> +	/*
> +	 * We don't support multiple register for the same dev if no pasid
> +	 */
> +	ret = class_for_each_device(uacce_class, NULL, uacce->pdev,
> +				    uacce_dev_match);
> +	if (ret)
> +		return ret;
> +
> +	/* allocate and attach a unmanged domain */
> +	domain = iommu_domain_alloc(uacce->pdev->bus);
> +	if (!domain) {
> +		dev_err(&uacce->dev, "cannot get domain for iommu\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = iommu_attach_device(domain, uacce->pdev);
> +	if (ret)
> +		goto err_with_domain;
> +
> +	if (iommu_capable(dev->bus, IOMMU_CAP_CACHE_COHERENCY))
> +		uacce->prot |= IOMMU_CACHE;
> +
> +	group = iommu_group_get(dev);
> +	if (!group) {
> +		ret = -EINVAL;
> +		goto err_with_domain;
> +	}
> +
> +	resv_msi = uacce_iommu_has_sw_msi(group, &resv_msi_base);
> +	iommu_group_put(group);
> +
> +	if (resv_msi) {
> +		if (!irq_domain_check_msi_remap() &&
> +		    !iommu_capable(dev->bus, IOMMU_CAP_INTR_REMAP)) {
> +			dev_warn(dev, "No interrupt remapping support!");
> +			ret = -EPERM;
> +			goto err_with_domain;
> +		}
> +
> +		ret = iommu_get_msi_cookie(domain, resv_msi_base);
> +		if (ret)
> +			goto err_with_domain;
> +	}
> +
> +	return 0;
> +
> +err_with_domain:
> +	iommu_domain_free(domain);
> +	return ret;
> +}
> +
> +static void uacce_unset_iommu_domain(struct uacce_device *uacce)
> +{
> +	struct iommu_domain *domain;
> +
> +	if (uacce->flags & UACCE_DEV_PASID)
> +		return;
> +
> +	domain = iommu_get_domain_for_dev(uacce->pdev);
> +	if (!domain) {
> +		dev_err(&uacce->dev, "bug: no domain attached to device\n");
> +		return;
> +	}
> +
> +	iommu_detach_device(domain, uacce->pdev);
> +	iommu_domain_free(domain);
> +}
> +
> +/**
> + *	uacce_register - register an accelerator
> + *	@uacce: the accelerator structure
> + */
> +struct uacce_device *uacce_register(struct device *parent,
> +				    struct uacce_interface *interface)
> +{
> +	int ret, i;
> +	struct uacce_device *uacce;
> +	unsigned int flags = interface->flags;
> +
> +	/* if dev support fault-from-dev, it should support pasid */
> +	if ((flags & UACCE_DEV_FAULT_FROM_DEV) && !(flags & UACCE_DEV_PASID)) {
> +		dev_warn(parent, "SVM/SAV device should support PASID\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +#ifdef CONFIG_IOMMU_SVA
> +	if (flags & UACCE_DEV_PASID) {
> +		ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
> +		if (ret)
> +			flags &= ~(UACCE_DEV_FAULT_FROM_DEV |
> +				   UACCE_DEV_PASID);
> +	}
> +#endif
> +	uacce = kzalloc(sizeof(struct uacce_device), GFP_KERNEL);
> +	if (!uacce)
> +		return ERR_PTR(-ENOMEM);
> +
> +	uacce->pdev = parent;
> +	uacce->flags = flags;
> +	uacce->ops = interface->ops;
> +	uacce->drv_name = interface->name;
> +
> +	for (i = 0; i < UACCE_QFRT_MAX; i++)
> +		uacce->qf_pg_start[i] = UACCE_QFR_NA;
> +
> +	ret = uacce_set_iommu_domain(uacce);
> +	if (ret)
> +		goto err_free;
> +
> +	mutex_lock(&uacce_mutex);
> +
> +	ret = uacce_create_chrdev(uacce);
> +	if (ret)
> +		goto err_with_lock;
> +
> +	atomic_set(&uacce->state, UACCE_ST_INIT);
> +	INIT_LIST_HEAD(&uacce->qs);
> +	mutex_init(&uacce->q_lock);
> +
> +	mutex_unlock(&uacce_mutex);
> +
> +	return uacce;
> +
> +err_with_lock:
> +	mutex_unlock(&uacce_mutex);
> +err_free:
> +	kfree(uacce);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(uacce_register);
> +
> +/**
> + * uacce_unregister - unregisters a uacce
> + * @uacce: the accelerator to unregister
> + *
> + * Unregister an accelerator that wat previously successully registered with
> + * uacce_register().
> + */
> +void uacce_unregister(struct uacce_device *uacce)
> +{
> +	mutex_lock(&uacce_mutex);
> +
> +#ifdef CONFIG_IOMMU_SVA
> +	if (uacce->flags & UACCE_DEV_PASID)
> +		iommu_dev_disable_feature(uacce->pdev, IOMMU_DEV_FEAT_SVA);
> +#endif
> +	uacce_unset_iommu_domain(uacce);
> +	uacce_destroy_chrdev(uacce);
> +
> +	mutex_unlock(&uacce_mutex);
> +}
> +EXPORT_SYMBOL_GPL(uacce_unregister);
> +
> +static int __init uacce_init(void)
> +{
> +	int ret;
> +
> +	uacce_class = class_create(THIS_MODULE, UACCE_NAME);
> +	if (IS_ERR(uacce_class)) {
> +		ret = PTR_ERR(uacce_class);
> +		goto err;
> +	}
> +
> +	ret = alloc_chrdev_region(&uacce_devt, 0, MINORMASK, UACCE_NAME);
> +	if (ret)
> +		goto err_with_class;
> +
> +	pr_info("uacce init with major number:%d\n", MAJOR(uacce_devt));

When your code works properly, it is totally silent.  Do not spam the
kernel log for no good reason.  Stuff like this is debugging only, if
that as you can see it in the proper /proc/ file.

> +
> +	return 0;
> +
> +err_with_class:
> +	class_destroy(uacce_class);
> +err:
> +	return ret;
> +}
> +
> +static __exit void uacce_exit(void)
> +{
> +	unregister_chrdev_region(uacce_devt, MINORMASK);
> +	class_destroy(uacce_class);
> +	idr_destroy(&uacce_idr);
> +}
> +
> +subsys_initcall(uacce_init);
> +module_exit(uacce_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Hisilicon Tech. Co., Ltd.");
> +MODULE_DESCRIPTION("Accelerator interface for Userland applications");
> diff --git a/include/linux/uacce.h b/include/linux/uacce.h
> new file mode 100644
> index 0000000..b23a28b
> --- /dev/null
> +++ b/include/linux/uacce.h
> @@ -0,0 +1,172 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef __UACCE_H
> +#define __UACCE_H
> +
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/list.h>
> +#include <linux/iommu.h>
> +#include <uapi/misc/uacce.h>

Why are all of these needed in this .h file?  Are you sure?

> +
> +#define UACCE_NAME		"uacce"
> +
> +struct uacce_queue;
> +struct uacce_device;
> +
> +/* uacce mode of the driver */
> +#define UACCE_MODE_NOUACCE	0 /* don't use uacce */
> +#define UACCE_MODE_UACCE	1 /* use uacce exclusively */
> +
> +/* uacce queue file flag, requires different operation */
> +#define UACCE_QFRF_MAP		BIT(0)	/* map to current queue */
> +#define UACCE_QFRF_MMAP		BIT(1)	/* map to user space */
> +#define UACCE_QFRF_KMAP		BIT(2)	/* map to kernel space */
> +#define UACCE_QFRF_DMA		BIT(3)	/* use dma api for the region */
> +#define UACCE_QFRF_SELFMT	BIT(4)	/* self maintained qfr */
> +
> +/**
> + * struct uacce_qfile_region - structure of queue file region
> + * @type: type of the qfr
> + * @iova: iova share between user and device space
> + * @pages: pages pointer of the qfr memory
> + * @nr_pages: page numbers of the qfr memory
> + * @prot: qfr protection flag
> + * @flags: flags of qfr
> + * @qs: list sharing the same region, for ss region
> + * @kaddr: kernel addr of the qfr
> + * @dma: dma address, if created by dma api
> + */
> +struct uacce_qfile_region {
> +	enum uacce_qfrt type;
> +	unsigned long iova;
> +	struct page **pages;
> +	int nr_pages;
> +	int prot;
> +	unsigned int flags;
> +	struct list_head qs;
> +	void *kaddr;
> +	dma_addr_t dma;
> +};
> +
> +/**
> + * struct uacce_ops - uacce device operations
> + * @get_available_instances:  get available instances left of the device
> + * @get_queue: get a queue from the device
> + * @put_queue: free a queue to the device
> + * @start_queue: make the queue start work after get_queue
> + * @stop_queue: make the queue stop work before put_queue
> + * @is_q_updated: check whether the task is finished
> + * @mask_notify: mask the task irq of queue
> + * @mmap: mmap addresses of queue to user space
> + * @reset: reset the uacce device
> + * @reset_queue: reset the queue
> + * @ioctl: ioctl for user space users of the queue
> + */
> +struct uacce_ops {
> +	int (*get_available_instances)(struct uacce_device *uacce);
> +	int (*get_queue)(struct uacce_device *uacce, unsigned long arg,
> +			 struct uacce_queue **q);
> +	void (*put_queue)(struct uacce_queue *q);
> +	int (*start_queue)(struct uacce_queue *q);
> +	void (*stop_queue)(struct uacce_queue *q);
> +	int (*is_q_updated)(struct uacce_queue *q);
> +	void (*mask_notify)(struct uacce_queue *q, int event_mask);
> +	int (*mmap)(struct uacce_queue *q, struct vm_area_struct *vma,
> +		    struct uacce_qfile_region *qfr);
> +	int (*reset)(struct uacce_device *uacce);
> +	int (*reset_queue)(struct uacce_queue *q);
> +	long (*ioctl)(struct uacce_queue *q, unsigned int cmd,
> +		      unsigned long arg);
> +};
> +
> +/**
> + * struct uacce_interface
> + * @name: the uacce device name.  Will show up in sysfs
> + * @flags: uacce device attributes
> + * @ops: pointer to the struct uacce_ops
> + *
> + * This structure is used for the uacce_register()
> + */
> +struct uacce_interface {
> +	char name[32];
> +	unsigned int flags;
> +	struct uacce_ops *ops;
> +};
> +
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
> + * @q_dev: list for uacce->qs
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
> +	struct list_head q_dev;
> +};
> +
> +/* uacce state */
> +enum {
> +	UACCE_ST_INIT = 0,
> +	UACCE_ST_OPENED,
> +	UACCE_ST_STARTED,
> +	UACCE_ST_RST,
> +};
> +
> +/**
> + * struct uacce_device
> + * @drv_name: the uacce driver name.  Will show up in sysfs
> + * @algs: supported algorithms
> + * @api_ver: api version
> + * @flags: uacce attributes
> + * @qf_pg_start: page start of the queue file regions
> + * @ops: pointer to the struct uacce_ops
> + * @pdev: pointer to the parent device
> + * @is_vf: whether virtual function
> + * @dev_id: id of the uacce device
> + * @cdev: cdev of the uacce
> + * @dev: dev of the uacce
> + * @priv: private pointer of the uacce
> + * @state: uacce state
> + * @prot: uacce protection flag
> + * @q_lock: uacce mutex lock for queue
> + * @qs: uacce list head for share
> + */
> +struct uacce_device {
> +	const char *drv_name;

A driver is bound to a device, and you can get the name there.  No need
for it to be here.

> +	const char *algs;
> +	const char *api_ver;
> +	unsigned int flags;

u64?

> +	unsigned long qf_pg_start[UACCE_QFRT_MAX];
> +	struct uacce_ops *ops;
> +	struct device *pdev;
> +	bool is_vf;
> +	u32 dev_id;
> +	struct cdev *cdev;
> +	struct device dev;
> +	void *priv;
> +	atomic_t state;
> +	int prot;

u32?


> +	struct mutex q_lock;
> +	struct list_head qs;

What's wrong with the list in the device itself?

> +};
> +
> +struct uacce_device *uacce_register(struct device *parent,
> +				    struct uacce_interface *interface);
> +void uacce_unregister(struct uacce_device *uacce);
> +void uacce_wake_up(struct uacce_queue *q);
> +
> +#endif
> diff --git a/include/uapi/misc/uacce.h b/include/uapi/misc/uacce.h
> new file mode 100644
> index 0000000..685b4a1
> --- /dev/null
> +++ b/include/uapi/misc/uacce.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _UAPIUUACCE_H
> +#define _UAPIUUACCE_H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +#define UACCE_CMD_SHARE_SVAS	_IO('W', 0)
> +#define UACCE_CMD_START		_IO('W', 1)
> +
> +/**
> + * UACCE Device Attributes:
> + *
> + * SHARE_DOMAIN: no PASID, can shae sva only for one process and the kernel
> + * PASID: the device has IOMMU which support PASID setting
> + *	  can do share sva, mapped to dev per process
> + * FAULT_FROM_DEV: the device has IOMMU which can do page fault request
> + *		   no need for share sva, should be used with PASID
> + * SVA: full function device
> + */
> +
> +enum {
> +	UACCE_DEV_SHARE_DOMAIN = 0x0,
> +	UACCE_DEV_PASID = 0x1,
> +	UACCE_DEV_FAULT_FROM_DEV = 0x2,
> +	UACCE_DEV_SVA = UACCE_DEV_PASID | UACCE_DEV_FAULT_FROM_DEV,
> +};
> +
> +#define UACCE_QFR_NA ((unsigned long)-1)
> +
> +enum uacce_qfrt {
> +	UACCE_QFRT_MMIO = 0,	/* device mmio region */
> +	UACCE_QFRT_DKO = 1,	/* device kernel-only */
> +	UACCE_QFRT_DUS = 2,	/* device user share */
> +	UACCE_QFRT_SS = 3,	/* static share memory */
> +	UACCE_QFRT_MAX,

You should set this value too, and probably to a big number, otherwise
you just created an api that can never add a value of '4' to its list.

Why is this UACCE_QFRT_MAX even needed?

thanks,

greg k-h
