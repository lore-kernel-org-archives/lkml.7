Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E7BC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5EC21726
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436802AbfHWQg2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 12:36:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5649 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391229AbfHWQg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:36:28 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6A6D7791BB853EF10449;
        Sat, 24 Aug 2019 00:36:25 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sat, 24 Aug 2019
 00:36:14 +0800
Date:   Fri, 23 Aug 2019 17:36:03 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     zhangfei <zhangfei.gao@linaro.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Zaibo Xu <xuzaibo@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "Kenneth Lee" <liguozhu@hisilicon.com>,
        <linux-accelerators@lists.ozlabs.org>
Subject: Re: [PATCH 2/2] uacce: add uacce module
Message-ID: <20190823173603.00001b3d@huawei.com>
In-Reply-To: <b5d9fe84-abfd-c8ca-d059-e186e1609e06@linaro.org>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
        <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
        <20190815175424.00002256@huawei.com>
        <b5d9fe84-abfd-c8ca-d059-e186e1609e06@linaro.org>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019 17:21:33 +0800
zhangfei <zhangfei.gao@linaro.org> wrote:

> Hi, Jonathan
Hi zhangfei,

> 
> Thanks for your careful review and good suggestion.
> Sorry for late response, I am checking one detail.

I have reviews on patches from years ago that I still haven't replied to ;)

> 
> On 2019/8/16 上午12:54, Jonathan Cameron wrote:
> > On Wed, 14 Aug 2019 17:34:25 +0800
> > Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
> >  
> >> From: Kenneth Lee <liguozhu@hisilicon.com>
> >>
> >> Uacce is the kernel component to support WarpDrive accelerator
> >> framework. It provides register/unregister interface for device drivers
> >> to expose their hardware resource to the user space. The resource is
> >> taken as "queue" in WarpDrive.  
> > It's a bit confusing to have both the term UACCE and WarpDrive in here.
> > I'd just use the uacce name in all comments etc.  
> Yes, make sense
> >  
> >> Uacce create a chrdev for every registration, the queue is allocated to
> >> the process when the chrdev is opened. Then the process can access the
> >> hardware resource by interact with the queue file. By mmap the queue
> >> file space to user space, the process can directly put requests to the
> >> hardware without syscall to the kernel space.
> >>
> >> Uacce also manages unify addresses between the hardware and user space
> >> of the process. So they can share the same virtual address in the
> >> communication.
> >>
> >> Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
> >> Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
> >> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> >> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>  
> > I would strip this back to which ever case is of most interest (SVA I guess?)
> > and only think about adding support for the others if necessary at a later date.
> > (or in later patches).  
> Do you mean split the patch and send sva part first?

Either:
1) SVA only in the first series, second series can do other options.
2) Patch N for SVA only, N+1... for other features.

I don't mind which, but I want to be able to see just one case and
review that before taking into account the affect of the more complex cases.


> >> +
> >> +static int uacce_qfr_alloc_pages(struct uacce_qfile_region *qfr)
> >> +{
> >> +	int gfp_mask = GFP_ATOMIC | __GFP_ZERO;  
> > More readable to just have this inline.  
> Yes, all right.
> >  
> >> +	int i, j;
> >> +
...

> >> +static int uacce_set_iommu_domain(struct uacce *uacce)
> >> +{
> >> +	struct iommu_domain *domain;
> >> +	struct iommu_group *group;
> >> +	struct device *dev = uacce->pdev;
> >> +	bool resv_msi;
> >> +	phys_addr_t resv_msi_base = 0;
> >> +	int ret;
> >> +
> >> +	if ((uacce->flags & UACCE_DEV_NOIOMMU) ||
> >> +	    (uacce->flags & UACCE_DEV_PASID))
> >> +		return 0;
> >> +
> >> +	/*
> >> +	 * We don't support multiple register for the same dev in RFC version ,
> >> +	 * will add it in formal version  
> > So this effectively multiple complete uacce interfaces for one device.
> > Is there a known usecase for that?  
> Here is preventing one device with multiple algorithm and register 
> multi-times,
> and without sva, they can not be distinguished.

Isn't that a bug in the device driver?

> >> +	 */
> >> +	ret = class_for_each_device(uacce_class, NULL, uacce->pdev,
> >> +				    uacce_dev_match);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* allocate and attach a unmanged domain */

...


