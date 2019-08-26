Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348F8C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 04:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DBF216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 04:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfHZEM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 00:12:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59334 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729555AbfHZEM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 00:12:56 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7AEAFC773479A9CCBB4A;
        Mon, 26 Aug 2019 12:12:54 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 26 Aug
 2019 12:12:47 +0800
Date:   Mon, 26 Aug 2019 12:10:42 +0800
From:   Kenneth Lee <liguozhu@hisilicon.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     zhangfei <zhangfei.gao@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, "Zaibo Xu" <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH 2/2] uacce: add uacce module
Message-ID: <20190826041042.GB27955@Turing-Arch-b>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
 <20190815141351.GD23267@kroah.com>
 <6daab785-a8f9-684e-eb71-7a81604d3bb0@linaro.org>
 <20190820165947.GC3736@kroah.com>
 <5d5cf0fc.1c69fb81.ec57f.b853SMTPIN_ADDED_BROKEN@mx.google.com>
 <20190821091709.GA22914@kroah.com>
 <b88abb8d-50a9-b29e-d3e5-96cc585ecac4@linaro.org>
 <20190821160542.GA14760@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190821160542.GA14760@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:05:42AM -0700, Greg Kroah-Hartman wrote:
> Date: Wed, 21 Aug 2019 09:05:42 -0700
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> To: zhangfei <zhangfei.gao@linaro.org>
> CC: Arnd Bergmann <arnd@arndb.de>, linux-accelerators@lists.ozlabs.org,
>  linux-kernel@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>, Zaibo
>  Xu <xuzaibo@huawei.com>, Zhou Wang <wangzhou1@hisilicon.com>
> Subject: Re: [PATCH 2/2] uacce: add uacce module
> User-Agent: Mutt/1.12.1 (2019-06-15)
> Message-ID: <20190821160542.GA14760@kroah.com>
> 
> On Wed, Aug 21, 2019 at 10:30:22PM +0800, zhangfei wrote:
> > 
> > 
> > On 2019/8/21 下午5:17, Greg Kroah-Hartman wrote:
> > > On Wed, Aug 21, 2019 at 03:21:18PM +0800, zhangfei.gao@foxmail.com wrote:
> > > > Hi, Greg
> > > > 
> > > > On 2019/8/21 上午12:59, Greg Kroah-Hartman wrote:
> > > > > On Tue, Aug 20, 2019 at 09:08:55PM +0800, zhangfei wrote:
> > > > > > On 2019/8/15 下午10:13, Greg Kroah-Hartman wrote:
> > > > > > > On Wed, Aug 14, 2019 at 05:34:25PM +0800, Zhangfei Gao wrote:
> > > > > > > > +int uacce_register(struct uacce *uacce)
> > > > > > > > +{
> > > > > > > > +	int ret;
> > > > > > > > +
> > > > > > > > +	if (!uacce->pdev) {
> > > > > > > > +		pr_debug("uacce parent device not set\n");
> > > > > > > > +		return -ENODEV;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	if (uacce->flags & UACCE_DEV_NOIOMMU) {
> > > > > > > > +		add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
> > > > > > > > +		dev_warn(uacce->pdev,
> > > > > > > > +			 "Register to noiommu mode, which export kernel data to user space and may vulnerable to attack");
> > > > > > > > +	}
> > > > > > > THat is odd, why even offer this feature then if it is a major issue?
> > > > > > UACCE_DEV_NOIOMMU maybe confusing here.
> > > > > > 
> > > > > > In this mode, app use ioctl to get dma_handle from dma_alloc_coherent.
> > > > > That's odd, why not use the other default apis to do that?
> > > > > 
> > > > > > It does not matter iommu is enabled or not.
> > > > > > In case iommu is disabled, it maybe dangerous to kernel, so we added warning here, is it required?
> > > > > You should use the other documentated apis for this, don't create your
> > > > > own.
> > > > I am sorry, not understand here.
> > > > Do you mean there is a standard ioctl or standard api in user space, it can
> > > > get dma_handle from dma_alloc_coherent from kernel?
> > > There should be a standard way to get such a handle from userspace
> > > today.  Isn't that what the ion interface does?  DRM also does this, as
> > > does UIO I think.
> > Thanks Greg,
> > Still not find it, will do more search.
> > But this may introduce dependency in our lib, like depend on ion?
> > > Do you have a spec somewhere that shows exactly what you are trying to
> > > do here, along with example userspace code?  It's hard to determine it
> > > given you only have one "half" of the code here and no users of the apis
> > > you are creating.
> > > 
> > The purpose is doing dma in user space.
> 
> Oh no, please no.  Are you _SURE_ you want to do this?
> 
> Again, look at how ION does this and how the DMAbuff stuff is replacing
> it.  Use that api please instead, otherwise you will get it wrong and we
> don't want to duplicate efforts.
> 
> thanks,
> 
> greg k-h

Dear Greg. I wrote a blog to explain the intention of WarpDrive here:
https://zhuanlan.zhihu.com/p/79680889.

Sharing data is not our intention, Sharing address is. NOIOMMU mode is just a
temporary solution to let some hardware which does not care the security issue
to try WarpDrive for the first step. Some user do not care this much in embedded
scenario. We saw VFIO use the same model so we also want to make a try. If you
insist this is risky, we can remove it.

Thanks.

-- 
			-Kenneth(Hisilicon)

