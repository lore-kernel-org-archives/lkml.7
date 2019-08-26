Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E9AC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 04:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824272190F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 04:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566793755;
	bh=EQP40mviagoanbkf4TmOFcFWN9aA6tPpZUAKg/ROjCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rfOrJWQ+DJJiJ22+K11Q7ZTLzw7t+XMdmO1i7AN8ODoI25SDJ3rKIKavXHwS9H1AW
	 sdHMELT9TiiUuzOosL3ZXvIqbgv/WABRlmldL8PqMgm0wHGZGv5Icz65Nrk3bDp31t
	 62mLaR2RWva7S2rXIRglCxboieOJOFWcGUWxVfQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfHZE3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 00:29:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfHZE3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 00:29:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 983C62173E;
        Mon, 26 Aug 2019 04:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566793753;
        bh=EQP40mviagoanbkf4TmOFcFWN9aA6tPpZUAKg/ROjCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NIs8t17yyjsbbIibwB+K02pUYQzsJk6jGL8BVROx9lG4gVQjJIjTcZ6QtocWM0nwC
         H/ex1aWHhkwrpImxcXmlx4dhsGC2yQmWXKUrLCxHuA6UFqX1eXUrxAt6l5xjpL39dr
         ET9eiJLj/9UjLW8101iJrFygcQHOe7gyLtK6+pew=
Date:   Mon, 26 Aug 2019 06:29:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kenneth Lee <liguozhu@hisilicon.com>
Cc:     zhangfei <zhangfei.gao@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH 2/2] uacce: add uacce module
Message-ID: <20190826042910.GA26547@kroah.com>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
 <20190815141351.GD23267@kroah.com>
 <6daab785-a8f9-684e-eb71-7a81604d3bb0@linaro.org>
 <20190820165947.GC3736@kroah.com>
 <5d5cf0fc.1c69fb81.ec57f.b853SMTPIN_ADDED_BROKEN@mx.google.com>
 <20190821091709.GA22914@kroah.com>
 <b88abb8d-50a9-b29e-d3e5-96cc585ecac4@linaro.org>
 <20190821160542.GA14760@kroah.com>
 <20190826041042.GB27955@Turing-Arch-b>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190826041042.GB27955@Turing-Arch-b>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 12:10:42PM +0800, Kenneth Lee wrote:
> On Wed, Aug 21, 2019 at 09:05:42AM -0700, Greg Kroah-Hartman wrote:
> > Date: Wed, 21 Aug 2019 09:05:42 -0700
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > To: zhangfei <zhangfei.gao@linaro.org>
> > CC: Arnd Bergmann <arnd@arndb.de>, linux-accelerators@lists.ozlabs.org,
> >  linux-kernel@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>, Zaibo
> >  Xu <xuzaibo@huawei.com>, Zhou Wang <wangzhou1@hisilicon.com>
> > Subject: Re: [PATCH 2/2] uacce: add uacce module
> > User-Agent: Mutt/1.12.1 (2019-06-15)
> > Message-ID: <20190821160542.GA14760@kroah.com>
> > 
> > On Wed, Aug 21, 2019 at 10:30:22PM +0800, zhangfei wrote:
> > > 
> > > 
> > > On 2019/8/21 下午5:17, Greg Kroah-Hartman wrote:
> > > > On Wed, Aug 21, 2019 at 03:21:18PM +0800, zhangfei.gao@foxmail.com wrote:
> > > > > Hi, Greg
> > > > > 
> > > > > On 2019/8/21 上午12:59, Greg Kroah-Hartman wrote:
> > > > > > On Tue, Aug 20, 2019 at 09:08:55PM +0800, zhangfei wrote:
> > > > > > > On 2019/8/15 下午10:13, Greg Kroah-Hartman wrote:
> > > > > > > > On Wed, Aug 14, 2019 at 05:34:25PM +0800, Zhangfei Gao wrote:
> > > > > > > > > +int uacce_register(struct uacce *uacce)
> > > > > > > > > +{
> > > > > > > > > +	int ret;
> > > > > > > > > +
> > > > > > > > > +	if (!uacce->pdev) {
> > > > > > > > > +		pr_debug("uacce parent device not set\n");
> > > > > > > > > +		return -ENODEV;
> > > > > > > > > +	}
> > > > > > > > > +
> > > > > > > > > +	if (uacce->flags & UACCE_DEV_NOIOMMU) {
> > > > > > > > > +		add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
> > > > > > > > > +		dev_warn(uacce->pdev,
> > > > > > > > > +			 "Register to noiommu mode, which export kernel data to user space and may vulnerable to attack");
> > > > > > > > > +	}
> > > > > > > > THat is odd, why even offer this feature then if it is a major issue?
> > > > > > > UACCE_DEV_NOIOMMU maybe confusing here.
> > > > > > > 
> > > > > > > In this mode, app use ioctl to get dma_handle from dma_alloc_coherent.
> > > > > > That's odd, why not use the other default apis to do that?
> > > > > > 
> > > > > > > It does not matter iommu is enabled or not.
> > > > > > > In case iommu is disabled, it maybe dangerous to kernel, so we added warning here, is it required?
> > > > > > You should use the other documentated apis for this, don't create your
> > > > > > own.
> > > > > I am sorry, not understand here.
> > > > > Do you mean there is a standard ioctl or standard api in user space, it can
> > > > > get dma_handle from dma_alloc_coherent from kernel?
> > > > There should be a standard way to get such a handle from userspace
> > > > today.  Isn't that what the ion interface does?  DRM also does this, as
> > > > does UIO I think.
> > > Thanks Greg,
> > > Still not find it, will do more search.
> > > But this may introduce dependency in our lib, like depend on ion?
> > > > Do you have a spec somewhere that shows exactly what you are trying to
> > > > do here, along with example userspace code?  It's hard to determine it
> > > > given you only have one "half" of the code here and no users of the apis
> > > > you are creating.
> > > > 
> > > The purpose is doing dma in user space.
> > 
> > Oh no, please no.  Are you _SURE_ you want to do this?
> > 
> > Again, look at how ION does this and how the DMAbuff stuff is replacing
> > it.  Use that api please instead, otherwise you will get it wrong and we
> > don't want to duplicate efforts.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Dear Greg. I wrote a blog to explain the intention of WarpDrive here:
> https://zhuanlan.zhihu.com/p/79680889.

Putting that information into the changelog and kernel documentation is
a much better idea than putting it there.

> Sharing data is not our intention, Sharing address is. NOIOMMU mode is just a
> temporary solution to let some hardware which does not care the security issue
> to try WarpDrive for the first step. Some user do not care this much in embedded
> scenario. We saw VFIO use the same model so we also want to make a try. If you
> insist this is risky, we can remove it.

Why not just use vfio then?

And yes, for now, please remove it, if you are not requiring it.

thanks,

greg k-h
