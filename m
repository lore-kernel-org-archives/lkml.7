Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA6CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7C120850
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DY9yiP7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfHWJVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:21:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40429 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfHWJVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:21:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id h3so5246159pls.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 02:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=x8NM7sMwHRNE9GeOYYiT+VZPzmEne+C1MhXzM3O003k=;
        b=DY9yiP7CdKISUrYL9AsgBWC5a2k1jxWeH/zZChpb3dL84JcgMJFukg6qVqyl8/geWJ
         iEPPhAgqOeUQ8lI218frUi17l2z3mn8Z1OG31CtsZfPctSFWTEYcOQAkXlmRPWldArZm
         y8OyLxD4gNEmk5qiOgEdj/rGOaFoWOUPE367b0n7KboJFPbAAM84MeWW+rvNAC8Xcgle
         ou58VcoBSBwN3SqTQbEofoxp5KWRXnw0MxB6auTs+Klm995ushN0UafBoH9v2MR82+l2
         jizb1XFYN3GLeOZemkb/XFcu2Ho7yOaxwROtsOOfR9E6NfkrwLvXywkW0Vmda7ACtYz/
         pxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=x8NM7sMwHRNE9GeOYYiT+VZPzmEne+C1MhXzM3O003k=;
        b=lUbVanIilk/viAz0xA7TVjgPLCzETO385q2TyeGLA6IM0TSRpPRh1fPFLhk0oVBYd4
         MXC/NUT7XcAqlGgEcZ1Rq45Pld0EOACQA+OQF0adwACwewRCj4qpmP90vuy3RfLRR2yO
         d0nYDyz5I8ljhTxtgn8gJLdV/CO1AaJoUbNGfrA/Dea6RAUmS211S0u9iDEK5jdZdeb7
         ywJFn9d8EGjQH/FjlH1xOXk7w6oVrY7TmpQHrBCW9+kYuWqCbWhefT4/nRzu2fDBgmd0
         GjO8A4/1Qjf75NRByhW+sfuvNQKP7gxgXDmVY/AGTyn21B/DmBK2Ih9dF8JMfpM1P4WS
         ep0w==
X-Gm-Message-State: APjAAAXQYq0KucHYOdAWLfpzSHBzGQ1+VfqkMUYUiMgsM/tErgo7uYLJ
        VsSD57wnfeCSpwM3r19Q6+HfsQ==
X-Google-Smtp-Source: APXvYqzWV+TKD0b1d76K9Xk7ZHbO7h1rE8qhm1UEU1kgG9N/N3AMS5OkxdpjtK5h9GWdlbcVhlj69Q==
X-Received: by 2002:a17:902:6b81:: with SMTP id p1mr3589461plk.91.1566552105124;
        Fri, 23 Aug 2019 02:21:45 -0700 (PDT)
Received: from ?IPv6:240e:362:4ae:f300:563:66fc:1629:b25b? ([240e:362:4ae:f300:563:66fc:1629:b25b])
        by smtp.gmail.com with ESMTPSA id j5sm1392450pgp.59.2019.08.23.02.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 02:21:44 -0700 (PDT)
Subject: Re: [PATCH 2/2] uacce: add uacce module
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Zaibo Xu <xuzaibo@huawei.com>,
        linux-kernel@vger.kernel.org, Zhou Wang <wangzhou1@hisilicon.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        linux-accelerators@lists.ozlabs.org
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
 <20190815175424.00002256@huawei.com>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <b5d9fe84-abfd-c8ca-d059-e186e1609e06@linaro.org>
Date:   Fri, 23 Aug 2019 17:21:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815175424.00002256@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jonathan

Thanks for your careful review and good suggestion.
Sorry for late response, I am checking one detail.

On 2019/8/16 上午12:54, Jonathan Cameron wrote:
> On Wed, 14 Aug 2019 17:34:25 +0800
> Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
>> From: Kenneth Lee <liguozhu@hisilicon.com>
>>
>> Uacce is the kernel component to support WarpDrive accelerator
>> framework. It provides register/unregister interface for device drivers
>> to expose their hardware resource to the user space. The resource is
>> taken as "queue" in WarpDrive.
> It's a bit confusing to have both the term UACCE and WarpDrive in here.
> I'd just use the uacce name in all comments etc.
Yes, make sense
>
>> Uacce create a chrdev for every registration, the queue is allocated to
>> the process when the chrdev is opened. Then the process can access the
>> hardware resource by interact with the queue file. By mmap the queue
>> file space to user space, the process can directly put requests to the
>> hardware without syscall to the kernel space.
>>
>> Uacce also manages unify addresses between the hardware and user space
>> of the process. So they can share the same virtual address in the
>> communication.
>>
>> Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
>> Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> I would strip this back to which ever case is of most interest (SVA I guess?)
> and only think about adding support for the others if necessary at a later date.
> (or in later patches).
Do you mean split the patch and send sva part first?
>> +
>> +static int uacce_qfr_alloc_pages(struct uacce_qfile_region *qfr)
>> +{
>> +	int gfp_mask = GFP_ATOMIC | __GFP_ZERO;
> More readable to just have this inline.
Yes, all right.
>
>> +	int i, j;
>> +
>> +	qfr->pages = kcalloc(qfr->nr_pages, sizeof(*qfr->pages), gfp_mask);
> kcalloc is always set to zero anyway.
OK
>
>> +
>> +static struct uacce_qfile_region *
>> +uacce_create_region(struct uacce_queue *q, struct vm_area_struct *vma,
>> +		    enum uacce_qfrt type, unsigned int flags)
>> +{
>> +	struct uacce_qfile_region *qfr;
>> +	struct uacce *uacce = q->uacce;
>> +	unsigned long vm_pgoff;
>> +	int ret = -ENOMEM;
>> +
>> +	dev_dbg(uacce->pdev, "create qfr (type=%x, flags=%x)\n", type, flags);
>> +	qfr = kzalloc(sizeof(*qfr), GFP_ATOMIC);
>> +	if (!qfr)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	qfr->type = type;
>> +	qfr->flags = flags;
>> +	qfr->iova = vma->vm_start;
>> +	qfr->nr_pages = vma_pages(vma);
>> +
>> +	if (vma->vm_flags & VM_READ)
>> +		qfr->prot |= IOMMU_READ;
>> +
>> +	if (vma->vm_flags & VM_WRITE)
>> +		qfr->prot |= IOMMU_WRITE;
>> +
>> +	if (flags & UACCE_QFRF_SELFMT) {
>> +		ret = uacce->ops->mmap(q, vma, qfr);
>> +		if (ret)
>> +			goto err_with_qfr;
>> +		return qfr;
>> +	}
>> +
>> +	/* allocate memory */
>> +	if (flags & UACCE_QFRF_DMA) {
>> +		dev_dbg(uacce->pdev, "allocate dma %d pages\n", qfr->nr_pages);
>> +		qfr->kaddr = dma_alloc_coherent(uacce->pdev, qfr->nr_pages <<
>> +						PAGE_SHIFT, &qfr->dma,
>> +						GFP_KERNEL);
>> +		if (!qfr->kaddr) {
>> +			ret = -ENOMEM;
>> +			goto err_with_qfr;
>> +		}
>> +	} else {
>> +		dev_dbg(uacce->pdev, "allocate %d pages\n", qfr->nr_pages);
>> +		ret = uacce_qfr_alloc_pages(qfr);
>> +		if (ret)
>> +			goto err_with_qfr;
>> +	}
>> +
>> +	/* map to device */
>> +	ret = uacce_queue_map_qfr(q, qfr);
>> +	if (ret)
>> +		goto err_with_pages;
>> +
>> +	/* mmap to user space */
>> +	if (flags & UACCE_QFRF_MMAP) {
>> +		if (flags & UACCE_QFRF_DMA) {
>> +
>> +			/* dma_mmap_coherent() requires vm_pgoff as 0
>> +			 * restore vm_pfoff to initial value for mmap()
>> +			 */
>> +			dev_dbg(uacce->pdev, "mmap dma qfr\n");
>> +			vm_pgoff = vma->vm_pgoff;
>> +			vma->vm_pgoff = 0;
>> +			ret = dma_mmap_coherent(uacce->pdev, vma, qfr->kaddr,
>> +						qfr->dma,
>> +						qfr->nr_pages << PAGE_SHIFT);
> Does setting vm_pgoff if (ret) make sense?
Since we need restore the environment, so restore vm_pgoff no matter 
succeed or not.
>> +			vma->vm_pgoff = vm_pgoff;
>> +		} else {
>> +			ret = uacce_queue_mmap_qfr(q, qfr, vma);
>> +		}
>> +
>> +		if (ret)
>> +			goto err_with_mapped_qfr;
>> +	}
>> +
>> +	return qfr;
>> +
>> +err_with_mapped_qfr:
>> +	uacce_queue_unmap_qfr(q, qfr);
>> +err_with_pages:
>> +	if (flags & UACCE_QFRF_DMA)
>> +		dma_free_coherent(uacce->pdev, qfr->nr_pages << PAGE_SHIFT,
>> +				  qfr->kaddr, qfr->dma);
>> +	else
>> +		uacce_qfr_free_pages(qfr);
>> +err_with_qfr:
>> +	kfree(qfr);
>> +
>> +	return ERR_PTR(ret);
>> +}
>> +
>> +/* we assume you have uacce_queue_unmap_qfr(q, qfr) from all related queues */
>> +static void uacce_destroy_region(struct uacce_queue *q,
>> +				 struct uacce_qfile_region *qfr)
>> +{
>> +	struct uacce *uacce = q->uacce;
>> +
>> +	if (qfr->flags & UACCE_QFRF_DMA) {
>> +		dev_dbg(uacce->pdev, "free dma qfr %s (kaddr=%lx, dma=%llx)\n",
>> +			uacce_qfrt_str(qfr), (unsigned long)qfr->kaddr,
>> +			qfr->dma);
>> +		dma_free_coherent(uacce->pdev, qfr->nr_pages << PAGE_SHIFT,
>> +				  qfr->kaddr, qfr->dma);
>> +	} else if (qfr->pages) {
>> +		if (qfr->flags & UACCE_QFRF_KMAP && qfr->kaddr) {
>> +			dev_dbg(uacce->pdev, "vunmap qfr %s\n",
>> +				uacce_qfrt_str(qfr));
>> +			vunmap(qfr->kaddr);
>> +			qfr->kaddr = NULL;
>> +		}
>> +
>> +		uacce_qfr_free_pages(qfr);
>> +	}
>> +	kfree(qfr);
>> +}
>> +
>> +static long uacce_cmd_share_qfr(struct uacce_queue *tgt, int fd)
>> +{
>> +	struct file *filep = fget(fd);
> That's not a trivial assignment so I would not have it up here.
>
>> +	struct uacce_queue *src;
>> +	int ret = -EINVAL;
>> +
> 	filep = fget(fd);
Yes, make sense.
>> +	if (!filep)
>> +		return ret;
>> +
>> +	if (filep->f_op != &uacce_fops)
>> +		goto out_with_fd;
>> +
>> +	src = filep->private_data;
>> +	if (!src)
>> +		goto out_with_fd;
>> +
>> +	/* no share sva is needed if the dev can do fault-from-dev */
>> +	if (tgt->uacce->flags & UACCE_DEV_FAULT_FROM_DEV)
>> +		goto out_with_fd;
>> +
>> +	dev_dbg(&src->uacce->dev, "share ss with %s\n",
>> +		dev_name(&tgt->uacce->dev));
>> +
>> +	uacce_qs_wlock();
>> +	if (!src->qfrs[UACCE_QFRT_SS] || tgt->qfrs[UACCE_QFRT_SS])
>> +		goto out_with_lock;
>> +
>> +	ret = uacce_queue_map_qfr(tgt, src->qfrs[UACCE_QFRT_SS]);
>> +	if (ret)
>> +		goto out_with_lock;
>> +
>> +	tgt->qfrs[UACCE_QFRT_SS] = src->qfrs[UACCE_QFRT_SS];
>> +	list_add(&tgt->list, &src->qfrs[UACCE_QFRT_SS]->qs);
>> +	ret = 0;
>> +
>> +out_with_lock:
>> +	uacce_qs_wunlock();
>> +out_with_fd:
>> +	fput(filep);
>> +	return ret;
>> +}
>> +
>> +static int uacce_start_queue(struct uacce_queue *q)
>> +{
>> +	int ret, i, j;
>> +	struct uacce_qfile_region *qfr;
>> +	struct device *dev = &q->uacce->dev;
>> +
>> +	/*
>> +	 * map KMAP qfr to kernel
>> +	 * vmap should be done in non-spinlocked context!
>> +	 */
>> +	for (i = 0; i < UACCE_QFRT_MAX; i++) {
>> +		qfr = q->qfrs[i];
>> +		if (qfr && (qfr->flags & UACCE_QFRF_KMAP) && !qfr->kaddr) {
>> +			qfr->kaddr = vmap(qfr->pages, qfr->nr_pages, VM_MAP,
>> +					  PAGE_KERNEL);
>> +			if (!qfr->kaddr) {
>> +				ret = -ENOMEM;
>> +				dev_dbg(dev, "fail to kmap %s qfr(%d pages)\n",
>> +					uacce_qfrt_str(qfr), qfr->nr_pages);
> If it's useful, dev_err.
OK
>> +static long uacce_fops_unl_ioctl(struct file *filep,
>> +				 unsigned int cmd, unsigned long arg)
>> +{
>> +	struct uacce_queue *q = filep->private_data;
>> +	struct uacce *uacce = q->uacce;
>> +
>> +	switch (cmd) {
>> +	case UACCE_CMD_SHARE_SVAS:
>> +		return uacce_cmd_share_qfr(q, arg);
>> +
>> +	case UACCE_CMD_START:
>> +		return uacce_start_queue(q);
>> +
>> +	case UACCE_CMD_GET_SS_DMA:
>> +		return uacce_get_ss_dma(q, (void __user *)arg);
>> +
>> +	default:
>> +		if (uacce->ops->ioctl)
>> +			return uacce->ops->ioctl(q, cmd, arg);
>> +
>> +		dev_err(&uacce->dev, "ioctl cmd (%d) is not supported!\n", cmd);
>> +		return -EINVAL;
> Flip the logic so the error is the indented path.
> 		if (!uacce->ops->ioctl) ...
>
> Fits better with typical coding model in a kernel reviewers head
> - well mine anyway ;)
OK, make sense.
>> +
>> +static int uacce_fops_open(struct inode *inode, struct file *filep)
>> +{
>> +	struct uacce_queue *q;
>> +	struct iommu_sva *handle = NULL;
>> +	struct uacce *uacce;
>> +	int ret;
>> +	int pasid = 0;
>> +
>> +	uacce = idr_find(&uacce_idr, iminor(inode));
>> +	if (!uacce)
>> +		return -ENODEV;
>> +
>> +	if (atomic_read(&uacce->state) == UACCE_ST_RST)
>> +		return -EINVAL;
>> +
>> +	if (!uacce->ops->get_queue)
>> +		return -EINVAL;
>> +
>> +	if (!try_module_get(uacce->pdev->driver->owner))
>> +		return -ENODEV;
>> +
>> +	ret = uacce_dev_open_check(uacce);
>> +	if (ret)
>> +		goto open_err;
>> +
>> +#ifdef CONFIG_IOMMU_SVA
>> +	if (uacce->flags & UACCE_DEV_PASID) {
>> +		handle = iommu_sva_bind_device(uacce->pdev, current->mm, NULL);
>> +		if (IS_ERR(handle))
>> +			goto open_err;
>> +		pasid = iommu_sva_get_pasid(handle);
>> +	}
>> +#endif
>> +	ret = uacce->ops->get_queue(uacce, pasid, &q);
>> +	if (ret < 0)
>> +		goto open_err;
>> +
>> +	q->pasid = pasid;
>> +	q->handle = handle;
>> +	q->uacce = uacce;
>> +	q->mm = current->mm;
>> +	memset(q->qfrs, 0, sizeof(q->qfrs));
>> +	INIT_LIST_HEAD(&q->list);
>> +	init_waitqueue_head(&q->wait);
>> +	filep->private_data = q;
>> +	mutex_lock(&uacce->q_lock);
>> +	list_add(&q->q_dev, &uacce->qs);
>> +	mutex_unlock(&uacce->q_lock);
>> +
>> +	return 0;
> blank line
OK.
>> +open_err:
>> +	module_put(uacce->pdev->driver->owner);
>> +	return ret;
>> +}
>> +
>> +static int uacce_fops_release(struct inode *inode, struct file *filep)
>> +{
>> +	struct uacce_queue *q = (struct uacce_queue *)filep->private_data;
>> +	struct uacce_qfile_region *qfr;
>> +	struct uacce *uacce = q->uacce;
>> +	int i;
>> +	bool is_to_free_region;
>> +	int free_pages = 0;
>> +
>> +	mutex_lock(&uacce->q_lock);
>> +	list_del(&q->q_dev);
>> +	mutex_unlock(&uacce->q_lock);
>> +
>> +	if (atomic_read(&uacce->state) == UACCE_ST_STARTED &&
>> +	    uacce->ops->stop_queue)
>> +		uacce->ops->stop_queue(q);
>> +
>> +	uacce_qs_wlock();
>> +
>> +	for (i = 0; i < UACCE_QFRT_MAX; i++) {
>> +		qfr = q->qfrs[i];
>> +		if (!qfr)
>> +			continue;
>> +
>> +		is_to_free_region = false;
>> +		uacce_queue_unmap_qfr(q, qfr);
>> +		if (i == UACCE_QFRT_SS) {
>> +			list_del(&q->list);
>> +			if (list_empty(&qfr->qs))
>> +				is_to_free_region = true;
>> +		} else
>> +			is_to_free_region = true;
>> +
>> +		if (is_to_free_region) {
>> +			free_pages += qfr->nr_pages;
>> +			uacce_destroy_region(q, qfr);
>> +		}
>> +
>> +		qfr = NULL;
>> +	}
>> +
>> +	uacce_qs_wunlock();
>> +
>> +	if (current->mm == q->mm) {
>> +		down_write(&q->mm->mmap_sem);
>> +		q->mm->data_vm -= free_pages;
>> +		up_write(&q->mm->mmap_sem);
>> +	}
>> +
>> +#ifdef CONFIG_IOMMU_SVA
>> +	if (uacce->flags & UACCE_DEV_PASID)
>> +		iommu_sva_unbind_device(q->handle);
>> +#endif
>> +
>> +	if (uacce->ops->put_queue)
>> +		uacce->ops->put_queue(q);
>> +
>> +	dev_dbg(&uacce->dev, "uacce state switch to INIT\n");
>> +	atomic_set(&uacce->state, UACCE_ST_INIT);
>> +	module_put(uacce->pdev->driver->owner);
> blank line here.
>
>> +	return 0;
>> +}
>> +
>> +static enum uacce_qfrt uacce_get_region_type(struct uacce *uacce,
>> +					     struct vm_area_struct *vma)
>> +{
>> +	enum uacce_qfrt type = UACCE_QFRT_MAX;
>> +	int i;
>> +	size_t next_start = UACCE_QFR_NA;
>> +
>> +	for (i = UACCE_QFRT_MAX - 1; i >= 0; i--) {
>> +		if (vma->vm_pgoff >= uacce->qf_pg_start[i]) {
>> +			type = i;
>> +			break;
>> +		}
>> +	}
>> +
>> +	switch (type) {
>> +	case UACCE_QFRT_MMIO:
>> +		if (!uacce->ops->mmap) {
>> +			dev_err(&uacce->dev, "no driver mmap!\n");
>> +			return UACCE_QFRT_INVALID;
>> +		}
>> +		break;
>> +
>> +	case UACCE_QFRT_DKO:
>> +		if ((uacce->flags & UACCE_DEV_PASID) ||
>> +		    (uacce->flags & UACCE_DEV_NOIOMMU))
>> +			return UACCE_QFRT_INVALID;
>> +		break;
>> +
>> +	case UACCE_QFRT_DUS:
>> +		break;
>> +
>> +	case UACCE_QFRT_SS:
>> +		/* todo: this can be valid to protect the process space */
>> +		if (uacce->flags & UACCE_DEV_FAULT_FROM_DEV)
>> +			return UACCE_QFRT_INVALID;
>> +		break;
>> +
>> +	default:
>> +		dev_err(&uacce->dev, "uacce bug (%d)!\n", type);
>> +		return UACCE_QFRT_INVALID;
>> +	}
>> +
>> +	/* make sure the mapping size is exactly the same as the region */
>> +	if (type < UACCE_QFRT_SS) {
>> +		for (i = type + 1; i < UACCE_QFRT_MAX; i++)
>> +			if (uacce->qf_pg_start[i] != UACCE_QFR_NA) {
>> +				next_start = uacce->qf_pg_start[i];
>> +				break;
>> +			}
>> +
>> +		if (next_start == UACCE_QFR_NA) {
>> +			dev_err(&uacce->dev, "uacce config error: SS offset set improperly\n");
>> +			return UACCE_QFRT_INVALID;
>> +		}
>> +
>> +		if (vma_pages(vma) !=
>> +		    next_start - uacce->qf_pg_start[type]) {
>> +			dev_err(&uacce->dev, "invalid mmap size (%ld vs %ld pages) for region %s.\n",
>> +				vma_pages(vma),
>> +				next_start - uacce->qf_pg_start[type],
>> +				qfrt_str[type]);
>> +			return UACCE_QFRT_INVALID;
>> +		}
>> +	}
>> +
>> +	return type;
>> +}
>> +
>> +static int uacce_fops_mmap(struct file *filep, struct vm_area_struct *vma)
>> +{
>> +	struct uacce_queue *q = (struct uacce_queue *)filep->private_data;
> As below, cast not needed.
OK, thanks
>
>> +	struct uacce *uacce = q->uacce;
>> +	enum uacce_qfrt type = uacce_get_region_type(uacce, vma);
>> +	struct uacce_qfile_region *qfr;
>> +	unsigned int flags = 0;
>> +	int ret;
>> +
>> +	dev_dbg(&uacce->dev, "mmap q file(t=%s, off=%lx, start=%lx, end=%lx)\n",
>> +		 qfrt_str[type], vma->vm_pgoff, vma->vm_start, vma->vm_end);
>> +
>> +	if (type == UACCE_QFRT_INVALID)
>> +		return -EINVAL;
>> +
>> +	vma->vm_flags |= VM_DONTCOPY | VM_DONTEXPAND;
>> +
>> +	uacce_qs_wlock();
>> +
>> +	/* fixme: if the region need no pages, we don't need to check it */
>> +	if (q->mm->data_vm + vma_pages(vma) >
>> +	    rlimit(RLIMIT_DATA) >> PAGE_SHIFT) {
>> +		ret = -ENOMEM;
>> +		goto out_with_lock;
>> +	}
>> +
>> +	if (q->qfrs[type]) {
>> +		ret = -EBUSY;
>> +		goto out_with_lock;
>> +	}
>> +
>> +	switch (type) {
>> +	case UACCE_QFRT_MMIO:
>> +		flags = UACCE_QFRF_SELFMT;
>> +		break;
>> +
>> +	case UACCE_QFRT_SS:
>> +		if (atomic_read(&uacce->state) != UACCE_ST_STARTED) {
>> +			ret = -EINVAL;
>> +			goto out_with_lock;
>> +		}
>> +
>> +		flags = UACCE_QFRF_MAP | UACCE_QFRF_MMAP;
>> +
>> +		if (uacce->flags & UACCE_DEV_NOIOMMU)
>> +			flags |= UACCE_QFRF_DMA;
>> +		break;
>> +
>> +	case UACCE_QFRT_DKO:
>> +		flags = UACCE_QFRF_MAP | UACCE_QFRF_KMAP;
>> +
>> +		if (uacce->flags & UACCE_DEV_NOIOMMU)
>> +			flags |= UACCE_QFRF_DMA;
>> +		break;
>> +
>> +	case UACCE_QFRT_DUS:
>> +		if ((uacce->flags & UACCE_DEV_NOIOMMU) ||
>> +		    (uacce->flags & UACCE_DEV_PASID)) {
>> +			flags = UACCE_QFRF_SELFMT;
>> +			break;
>> +		}
>> +
>> +		flags = UACCE_QFRF_MAP | UACCE_QFRF_MMAP;
>> +		break;
>> +
>> +	default:
>> +		WARN_ON(&uacce->dev);
>> +		break;
>> +	}
>> +
>> +	qfr = uacce_create_region(q, vma, type, flags);
>> +	if (IS_ERR(qfr)) {
>> +		ret = PTR_ERR(qfr);
>> +		goto out_with_lock;
>> +	}
>> +	q->qfrs[type] = qfr;
>> +
>> +	if (type == UACCE_QFRT_SS) {
>> +		INIT_LIST_HEAD(&qfr->qs);
>> +		list_add(&q->list, &q->qfrs[type]->qs);
>> +	}
>> +
>> +	uacce_qs_wunlock();
>> +
>> +	if (qfr->pages)
>> +		q->mm->data_vm += qfr->nr_pages;
>> +
>> +	return 0;
>> +
>> +out_with_lock:
>> +	uacce_qs_wunlock();
>> +	return ret;
>> +}
>> +
>> +static __poll_t uacce_fops_poll(struct file *file, poll_table *wait)
>> +{
>> +	struct uacce_queue *q = (struct uacce_queue *)file->private_data;
> Private data is a void * so no need to cast explicitly.
>
> 	struct uacce_queue *q = file->private_data;
OK
>> +static ssize_t api_show(struct device *dev,
>> +				  struct device_attribute *attr, char *buf)
>> +{
>> +	struct uacce *uacce = UACCE_FROM_CDEV_ATTR(dev);
>> +
>> +	return sprintf(buf, "%s\n", uacce->api_ver);
>> +}
>> +
>> +static ssize_t numa_distance_show(struct device *dev,
>> +					    struct device_attribute *attr,
>> +					    char *buf)
>> +{
>> +	struct uacce *uacce = UACCE_FROM_CDEV_ATTR(dev);
>> +	int distance = 0;
>> +
>> +#ifdef CONFIG_NUMA
>> +	distance = cpu_to_node(smp_processor_id()) - uacce->pdev->numa_node;
> What is this function supposed to return?
> It currently returns the absolute difference in node number.
> I suppose if that is 0, then it means local node, but all other values
> have no sensible meaning.
>
> Perhaps use node_distance()? That should give you the SLIT distance
> so 10 for local and bigger for everything else.
Yes, node_distance is better and consider #ifdef CONFIG_NUMA
>> +#endif
>> +	return sprintf(buf, "%d\n", abs(distance));
>> +}
>> +
>> +static ssize_t node_id_show(struct device *dev,
>> +				      struct device_attribute *attr,
>> +				      char *buf)
>> +{
>> +	struct uacce *uacce = UACCE_FROM_CDEV_ATTR(dev);
>> +	int node_id = -1;
>> +
>> +#ifdef CONFIG_NUMA
>> +	node_id = uacce->pdev->numa_node;
> use dev_to_node(uacce->pdev) which already does this protection for you.
Yes, dev_to_node is better
>> +#endif
>> +	return sprintf(buf, "%d\n", node_id);
>> +}
>> +
>> +static ssize_t flags_show(struct device *dev,
>> +				       struct device_attribute *attr,
>> +				       char *buf)
>> +{
>> +	struct uacce *uacce = UACCE_FROM_CDEV_ATTR(dev);
>> +
>> +	return sprintf(buf, "%d\n", uacce->flags);
>> +}
>> +
>> +static ssize_t available_instances_show(struct device *dev,
>> +					  struct device_attribute *attr,
>> +						  char *buf)
>> +{
>> +	struct uacce *uacce = UACCE_FROM_CDEV_ATTR(dev);
>> +
>> +	return sprintf(buf, "%d\n", uacce->ops->get_available_instances(uacce));
>> +}
>> +
>> +static ssize_t algorithms_show(struct device *dev,
>> +					 struct device_attribute *attr,
>> +					 char *buf)
>> +{
>> +	struct uacce *uacce = UACCE_FROM_CDEV_ATTR(dev);
>> +
>> +	return sprintf(buf, "%s", uacce->algs);
>> +}
>> +
>> +static ssize_t qfrs_offset_show(struct device *dev,
>> +					  struct device_attribute *attr,
>> +					  char *buf)
>> +{
>> +	struct uacce *uacce = UACCE_FROM_CDEV_ATTR(dev);
>> +	int i, ret;
>> +	unsigned long offset;
>> +
>> +	for (i = 0, ret = 0; i < UACCE_QFRT_MAX; i++) {
>> +		offset = uacce->qf_pg_start[i];
>> +		if (offset != UACCE_QFR_NA)
>> +			offset = offset << PAGE_SHIFT;
>> +		if (i == UACCE_QFRT_SS)
>> +			break;
>> +		ret += sprintf(buf + ret, "%lu\t", offset);
>> +	}
>> +	ret += sprintf(buf + ret, "%lu\n", offset);
>> +
>> +	return ret;
>> +}
>> +
>> +static DEVICE_ATTR_RO(id);
>> +static DEVICE_ATTR_RO(api);
>> +static DEVICE_ATTR_RO(numa_distance);
>> +static DEVICE_ATTR_RO(node_id);
>> +static DEVICE_ATTR_RO(flags);
>> +static DEVICE_ATTR_RO(available_instances);
>> +static DEVICE_ATTR_RO(algorithms);
>> +static DEVICE_ATTR_RO(qfrs_offset);
>> +
>> +static struct attribute *uacce_dev_attrs[] = {
> New ABI. All needs documenting in
>
> Documentation/ABI/
ok
>
>> +	&dev_attr_id.attr,
>> +	&dev_attr_api.attr,
>> +	&dev_attr_node_id.attr,
>> +	&dev_attr_numa_distance.attr,
>> +	&dev_attr_flags.attr,
>> +	&dev_attr_available_instances.attr,
>> +	&dev_attr_algorithms.attr,
>> +	&dev_attr_qfrs_offset.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group uacce_dev_attr_group = {
>> +	.name	= UACCE_DEV_ATTRS,
>> +	.attrs	= uacce_dev_attrs,
>> +};
>> +
>> +static const struct attribute_group *uacce_dev_attr_groups[] = {
>> +	&uacce_dev_attr_group,
>> +	NULL
>> +};
>> +
>> +static int uacce_create_chrdev(struct uacce *uacce)
>> +{
>> +	int ret;
>> +
>> +	ret = idr_alloc(&uacce_idr, uacce, 0, 0, GFP_KERNEL);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	cdev_init(&uacce->cdev, &uacce_fops);
>> +	uacce->dev_id = ret;
>> +	uacce->cdev.owner = THIS_MODULE;
>> +	device_initialize(&uacce->dev);
>> +	uacce->dev.devt = MKDEV(MAJOR(uacce_devt), uacce->dev_id);
>> +	uacce->dev.class = uacce_class;
>> +	uacce->dev.groups = uacce_dev_attr_groups;
>> +	uacce->dev.parent = uacce->pdev;
>> +	dev_set_name(&uacce->dev, "%s-%d", uacce->drv_name, uacce->dev_id);
>> +	ret = cdev_device_add(&uacce->cdev, &uacce->dev);
>> +	if (ret)
>> +		goto err_with_idr;
>> +
>> +	dev_dbg(&uacce->dev, "create uacce minior=%d\n", uacce->dev_id);
>> +	return 0;
>> +
>> +err_with_idr:
>> +	idr_remove(&uacce_idr, uacce->dev_id);
>> +	return ret;
>> +}
>> +
>> +static void uacce_destroy_chrdev(struct uacce *uacce)
>> +{
>> +	cdev_device_del(&uacce->cdev, &uacce->dev);
>> +	idr_remove(&uacce_idr, uacce->dev_id);
>> +}
>> +
>> +static int uacce_default_get_available_instances(struct uacce *uacce)
>> +{
> Does this one ever make sense for a real device?
>
>> +	return -1;
>> +}
>> +
>> +static int uacce_default_start_queue(struct uacce_queue *q)
>> +{
>> +	dev_dbg(&q->uacce->dev, "fake start queue");
> Does this ever make sense on a real device?
Will remove these two default funcs.
>
>> +	return 0;
>> +}
>> +
>> +static int uacce_dev_match(struct device *dev, void *data)
>> +{
>> +	if (dev->parent == data)
>> +		return -EBUSY;
>> +
>> +	return 0;
>> +}
>> +
>> +/* Borrowed from VFIO to fix msi translation */
>> +static bool uacce_iommu_has_sw_msi(struct iommu_group *group,
>> +				   phys_addr_t *base)
>> +{
>> +	struct list_head group_resv_regions;
>> +	struct iommu_resv_region *region, *next;
>> +	bool ret = false;
>> +
>> +	INIT_LIST_HEAD(&group_resv_regions);
>> +	iommu_get_group_resv_regions(group, &group_resv_regions);
>> +	list_for_each_entry(region, &group_resv_regions, list) {
>> +		pr_debug("uacce: find a resv region (%d) on %llx\n",
>> +			 region->type, region->start);
>> +
>> +		/*
>> +		 * The presence of any 'real' MSI regions should take
>> +		 * precedence over the software-managed one if the
>> +		 * IOMMU driver happens to advertise both types.
>> +		 */
>> +		if (region->type == IOMMU_RESV_MSI) {
>> +			ret = false;
>> +			break;
>> +		}
>> +
>> +		if (region->type == IOMMU_RESV_SW_MSI) {
>> +			*base = region->start;
>> +			ret = true;
>> +		}
>> +	}
>> +	list_for_each_entry_safe(region, next, &group_resv_regions, list)
>> +		kfree(region);
>> +	return ret;
>> +}
>> +
>> +static int uacce_set_iommu_domain(struct uacce *uacce)
>> +{
>> +	struct iommu_domain *domain;
>> +	struct iommu_group *group;
>> +	struct device *dev = uacce->pdev;
>> +	bool resv_msi;
>> +	phys_addr_t resv_msi_base = 0;
>> +	int ret;
>> +
>> +	if ((uacce->flags & UACCE_DEV_NOIOMMU) ||
>> +	    (uacce->flags & UACCE_DEV_PASID))
>> +		return 0;
>> +
>> +	/*
>> +	 * We don't support multiple register for the same dev in RFC version ,
>> +	 * will add it in formal version
> So this effectively multiple complete uacce interfaces for one device.
> Is there a known usecase for that?
Here is preventing one device with multiple algorithm and register 
multi-times,
and without sva, they can not be distinguished.
>> +	 */
>> +	ret = class_for_each_device(uacce_class, NULL, uacce->pdev,
>> +				    uacce_dev_match);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* allocate and attach a unmanged domain */
>> +	domain = iommu_domain_alloc(uacce->pdev->bus);
>> +	if (!domain) {
>> +		dev_dbg(&uacce->dev, "cannot get domain for iommu\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret = iommu_attach_device(domain, uacce->pdev);
>> +	if (ret)
>> +		goto err_with_domain;
>> +
>> +	if (iommu_capable(dev->bus, IOMMU_CAP_CACHE_COHERENCY)) {
>> +		uacce->prot |= IOMMU_CACHE;
>> +		dev_dbg(dev, "Enable uacce with c-coherent capa\n");
>> +	} else
>> +		dev_dbg(dev, "Enable uacce without c-coherent capa\n");
> Do those debug statements add anything?  I'd also like a comment to explain
> why we care here.
OK,
>> +
>> +	group = iommu_group_get(dev);
>> +	if (!group) {
>> +		ret = -EINVAL;
>> +		goto err_with_domain;
>> +	}
>> +
>> +	resv_msi = uacce_iommu_has_sw_msi(group, &resv_msi_base);
>> +	iommu_group_put(group);
>> +
>> +	if (resv_msi) {
>> +		if (!irq_domain_check_msi_remap() &&
>> +		    !iommu_capable(dev->bus, IOMMU_CAP_INTR_REMAP)) {
>> +			dev_warn(dev, "No interrupt remapping support!");
>> +			ret = -EPERM;
>> +			goto err_with_domain;
>> +		}
>> +
>> +		dev_dbg(dev, "Set resv msi %llx on iommu domain\n",
>> +			(u64)resv_msi_base);
>> +		ret = iommu_get_msi_cookie(domain, resv_msi_base);
>> +		if (ret)
>> +			goto err_with_domain;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_with_domain:
>> +	iommu_domain_free(domain);
>> +	return ret;
>> +}
>> +
>> +static void uacce_unset_iommu_domain(struct uacce *uacce)
>> +{
>> +	struct iommu_domain *domain;
>> +
>> +	if ((uacce->flags & UACCE_DEV_NOIOMMU) ||
>> +	    (uacce->flags & UACCE_DEV_PASID))
>> +		return;
>> +
>> +	domain = iommu_get_domain_for_dev(uacce->pdev);
>> +	if (domain) {
>> +		iommu_detach_device(domain, uacce->pdev);
>> +		iommu_domain_free(domain);
>> +	} else
>> +		dev_err(&uacce->dev, "bug: no domain attached to device\n");
> Given this is an error path, perhaps the following flow is easier to read (slightly)
>
> 	if (!domain) {
> 		dev_err(&uacce->dev, "bug: no domain attached to device\n");
> 		return;
> 	}
>
> 	iommu_detach_device(domain, uacce->pdev);
> 	iommu_domain_free(domain);
> }
Yes, this is much better.
>> +}
>> +
>> +/**
>> + *	uacce_register - register an accelerator
>> + *	@uacce: the accelerator structure
>> + */
>> +int uacce_register(struct uacce *uacce)
>> +{
>> +	int ret;
>> +
>> +	if (!uacce->pdev) {
>> +		pr_debug("uacce parent device not set\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (uacce->flags & UACCE_DEV_NOIOMMU) {
>> +		add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
>> +		dev_warn(uacce->pdev,
>> +			 "Register to noiommu mode, which export kernel data to user space and may vulnerable to attack");
> Greg already covered this one ;)
>
>> +	}
>> +
>> +	/* if dev support fault-from-dev, it should support pasid */
>> +	if ((uacce->flags & UACCE_DEV_FAULT_FROM_DEV) &&
>> +	    !(uacce->flags & UACCE_DEV_PASID)) {
>> +		dev_warn(&uacce->dev, "SVM/SAV device should support PASID\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!uacce->ops->start_queue)
>> +		uacce->ops->start_queue = uacce_default_start_queue;
>> +
>> +	if (!uacce->ops->get_available_instances)
>> +		uacce->ops->get_available_instances =
>> +			uacce_default_get_available_instances;
>> +
>> +#ifdef CONFIG_IOMMU_SVA
>> +	if (uacce->flags & UACCE_DEV_PASID) {
>> +		ret = iommu_dev_enable_feature(uacce->pdev, IOMMU_DEV_FEAT_SVA);
>> +		if (ret)
>> +			uacce->flags &= ~(UACCE_DEV_FAULT_FROM_DEV |
>> +					  UACCE_DEV_PASID);
>> +	}
>> +#endif
>> +
>> +	ret = uacce_set_iommu_domain(uacce);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mutex_lock(&uacce_mutex);
>> +
>> +	ret = uacce_create_chrdev(uacce);
>> +	if (ret)
>> +		goto err_with_lock;
>> +
>> +	dev_dbg(&uacce->dev, "uacce state initialized to INIT");
> Not sure that tells us much of interest.  Probably clean out most of the
> dev_dbg statements. Useful when developing but once it works they
> add lines of code that don't do anything useful.
Will remove most dev_dbg.
>
>> +	atomic_set(&uacce->state, UACCE_ST_INIT);
>> +	INIT_LIST_HEAD(&uacce->qs);
>> +	mutex_init(&uacce->q_lock);
>> +	mutex_unlock(&uacce_mutex);
>> +
> One blank line is almost always enough.
>
>> +
>> +	return 0;
>> +
>> +err_with_lock:
>> +	mutex_unlock(&uacce_mutex);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(uacce_register);
>> +
>> +/**
>> + * uacce_unregister - unregisters a uacce
>> + * @uacce: the accelerator to unregister
>> + *
>> + * Unregister an accelerator that wat previously successully registered with
>> + * uacce_register().
>> + */
>> +void uacce_unregister(struct uacce *uacce)
>> +{
>> +	mutex_lock(&uacce_mutex);
>> +
>> +#ifdef CONFIG_IOMMU_SVA
>> +	if (uacce->flags & UACCE_DEV_PASID)
>> +		iommu_dev_disable_feature(uacce->pdev, IOMMU_DEV_FEAT_SVA);
>> +#endif
>> +	uacce_unset_iommu_domain(uacce);
>> +
>> +	uacce_destroy_chrdev(uacce);
>> +
>> +	mutex_unlock(&uacce_mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(uacce_unregister);
>> +
>> +static int __init uacce_init(void)
>> +{
>> +	int ret;
>> +
>> +	uacce_class = class_create(THIS_MODULE, UACCE_CLASS_NAME);
>> +	if (IS_ERR(uacce_class)) {
>> +		ret = PTR_ERR(uacce_class);
>> +		goto err;
>> +	}
>> +
>> +	ret = alloc_chrdev_region(&uacce_devt, 0, MINORMASK, "uacce");
>> +	if (ret)
>> +		goto err_with_class;
>> +
>> +	pr_info("uacce init with major number:%d\n", MAJOR(uacce_devt));
>> +
>> +	return 0;
>> +
>> +err_with_class:
>> +	class_destroy(uacce_class);
>> +err:
>> +	return ret;
>> +}
>> +
>> +static __exit void uacce_exit(void)
>> +{
>> +	unregister_chrdev_region(uacce_devt, MINORMASK);
>> +	class_destroy(uacce_class);
>> +	idr_destroy(&uacce_idr);
>> +}
>> +
>> +subsys_initcall(uacce_init);
>> +module_exit(uacce_exit);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Hisilicon Tech. Co., Ltd.");
>> +MODULE_DESCRIPTION("Accelerator interface for Userland applications");
>> diff --git a/include/linux/uacce.h b/include/linux/uacce.h
>> new file mode 100644
>> index 0000000..fe2f6f4
>> --- /dev/null
>> +++ b/include/linux/uacce.h
>> @@ -0,0 +1,109 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +#ifndef __UACCE_H
>> +#define __UACCE_H
>> +
>> +#include <linux/cdev.h>
>> +#include <linux/device.h>
>> +#include <linux/fs.h>
>> +#include <linux/list.h>
>> +#include <linux/iommu.h>
>> +#include <uapi/misc/uacce.h>
>> +
>> +struct uacce_queue;
>> +struct uacce;
>> +
>> +/* uacce mode of the driver */
>> +#define UACCE_MODE_NOUACCE	0 /* don't use uacce */
>> +#define UACCE_MODE_UACCE	1 /* use uacce exclusively */
>> +#define UACCE_MODE_NOIOMMU	2 /* use uacce noiommu mode */
>> +
>> +#define UACCE_QFRF_MAP		BIT(0)	/* map to current queue */
>> +#define UACCE_QFRF_MMAP		BIT(1)	/* map to user space */
>> +#define UACCE_QFRF_KMAP		BIT(2)	/* map to kernel space */
>> +#define UACCE_QFRF_DMA		BIT(3)	/* use dma api for the region */
>> +#define UACCE_QFRF_SELFMT	BIT(4)	/* self maintained qfr */
>> +
>> +struct uacce_qfile_region {
> I'd like to see kernel doc for all the structures in here.
Will add description of each member above this structure in this file.
>> +	enum uacce_qfrt type;
>> +	unsigned long iova;	/* iova share between user and device space */
>> +	struct page **pages;
>> +	int nr_pages;
>> +	int prot;
>> +	unsigned int flags;
>> +	struct list_head qs;	/* qs sharing the same region, for ss */
>> +	void *kaddr;		/* kernel addr */
>> +	dma_addr_t dma;		/* dma address, if created by dma api */
>> +};
>> +
>> +/**
>> + * struct uacce_ops - WD device operations
> Make sure you don't miss out elements in the docs.
>
> get_available_instances.
>
> Easy to check, just build the kernel doc.
>
>> + * @get_queue: get a queue from the device according to algorithm
> Not obvious in this case what 'according to algorithm' is referring to as
> the function takes simply "unsigned long arg"
Yes, a bit confusing, will remove it.
>
>> + * @put_queue: free a queue to the device
>> + * @start_queue: make the queue start work after get_queue
>> + * @stop_queue: make the queue stop work before put_queue
>> + * @is_q_updated: check whether the task is finished
>> + * @mask_notify: mask the task irq of queue
>> + * @mmap: mmap addresses of queue to user space
>> + * @reset: reset the WD device
> uacce device?
>
>> + * @reset_queue: reset the queue
>> + * @ioctl:   ioctl for user space users of the queue
> Extra spaces after : compared to other entries.
>
>> + */
>> +struct uacce_ops {
>> +	int (*get_available_instances)(struct uacce *uacce);
>> +	int (*get_queue)(struct uacce *uacce, unsigned long arg,
>> +	     struct uacce_queue **q);
>> +	void (*put_queue)(struct uacce_queue *q);
>> +	int (*start_queue)(struct uacce_queue *q);
>> +	void (*stop_queue)(struct uacce_queue *q);
>> +	int (*is_q_updated)(struct uacce_queue *q);
>> +	void (*mask_notify)(struct uacce_queue *q, int event_mask);
>> +	int (*mmap)(struct uacce_queue *q, struct vm_area_struct *vma,
>> +		    struct uacce_qfile_region *qfr);
>> +	int (*reset)(struct uacce *uacce);
>> +	int (*reset_queue)(struct uacce_queue *q);
>> +	long (*ioctl)(struct uacce_queue *q, unsigned int cmd,
>> +		      unsigned long arg);
>> +};
>> +
>> +struct uacce_queue {
>> +	struct uacce *uacce;
>> +	void *priv;
>> +	wait_queue_head_t wait;
>> +	int pasid;
>> +	struct iommu_sva *handle;
>> +	struct list_head list; /* share list for qfr->qs */
>> +	struct mm_struct *mm;
>> +	struct uacce_qfile_region *qfrs[UACCE_QFRT_MAX];
>> +	struct list_head q_dev;
>> +};
>> +
>> +#define UACCE_ST_INIT		0
>> +#define UACCE_ST_OPENED		1
>> +#define UACCE_ST_STARTED	2
>> +#define UACCE_ST_RST		3
> These seem to be states in a state machine, perhaps an enum
> is more suited as their actual values don't matter (I think!)
Yes, enum is  better.

Thanks

