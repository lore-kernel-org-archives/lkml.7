Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE75C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4470921883
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566931709;
	bh=ZiCAIffTdsF1bgCrGidfjVki+oHlbaJt6PVAuhhR8cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=107CESiAmT9ts4Mi2vY1KOq6uG8ED9f8bZZqYuxp1m3Bm6bsjvjYjrYvONOkyqd6Z
	 T9rE/NHpTm4MUiTejaiMfLlRZu1S4McRz8ufQE54bKbyoI7y4xyu3nBOvNgIqUmpTQ
	 uQTexR+J2JBlgdKd47en6RdyATop14MX5uD7TtPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbfH0Ss2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 14:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729903AbfH0Ss1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 14:48:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D621720644;
        Tue, 27 Aug 2019 18:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566931706;
        bh=ZiCAIffTdsF1bgCrGidfjVki+oHlbaJt6PVAuhhR8cY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CZi2h0edM4wr9EPiY0R5BM8VzmhFkHaiLiRzetS0zchYepWLldK/VEo3BPuK/gfE0
         wDya2tEpSrWQVMv07h8S0uxjBLGHT9+epEYWnlDfpt4isX813Bq9MgKZ4q4UPXPteZ
         FBJxeaoHjnaqMifwWE27dsKIXrrRndSRvOI3waDg=
Date:   Tue, 27 Aug 2019 20:48:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kenneth Lee <liguozhu@hisilicon.com>
Cc:     zhangfei <zhangfei.gao@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH 2/2] uacce: add uacce module
Message-ID: <20190827184823.GC2987@kroah.com>
References: <20190815141351.GD23267@kroah.com>
 <6daab785-a8f9-684e-eb71-7a81604d3bb0@linaro.org>
 <20190820165947.GC3736@kroah.com>
 <5d5cf0fc.1c69fb81.ec57f.b853SMTPIN_ADDED_BROKEN@mx.google.com>
 <20190821091709.GA22914@kroah.com>
 <b88abb8d-50a9-b29e-d3e5-96cc585ecac4@linaro.org>
 <20190821160542.GA14760@kroah.com>
 <20190826041042.GB27955@Turing-Arch-b>
 <20190826042910.GA26547@kroah.com>
 <20190827114208.GB116872@Turing-Arch-b>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190827114208.GB116872@Turing-Arch-b>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 07:42:08PM +0800, Kenneth Lee wrote:
> On Mon, Aug 26, 2019 at 06:29:10AM +0200, Greg Kroah-Hartman wrote:
> > Date: Mon, 26 Aug 2019 06:29:10 +0200
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > To: Kenneth Lee <liguozhu@hisilicon.com>
> > CC: zhangfei <zhangfei.gao@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
> >  linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org, Zaibo
> >  Xu <xuzaibo@huawei.com>, Zhou Wang <wangzhou1@hisilicon.com>
> > Subject: Re: [PATCH 2/2] uacce: add uacce module
> > User-Agent: Mutt/1.12.1 (2019-06-15)
> > Message-ID: <20190826042910.GA26547@kroah.com>
> > 
> > On Mon, Aug 26, 2019 at 12:10:42PM +0800, Kenneth Lee wrote:
> > > On Wed, Aug 21, 2019 at 09:05:42AM -0700, Greg Kroah-Hartman wrote:
> > > > Date: Wed, 21 Aug 2019 09:05:42 -0700
> > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > To: zhangfei <zhangfei.gao@linaro.org>
> > > > CC: Arnd Bergmann <arnd@arndb.de>, linux-accelerators@lists.ozlabs.org,
> > > >  linux-kernel@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>, Zaibo
> > > >  Xu <xuzaibo@huawei.com>, Zhou Wang <wangzhou1@hisilicon.com>
> > > > Subject: Re: [PATCH 2/2] uacce: add uacce module
> > > > User-Agent: Mutt/1.12.1 (2019-06-15)
> > > > Message-ID: <20190821160542.GA14760@kroah.com>
> > > > 
> > > > On Wed, Aug 21, 2019 at 10:30:22PM +0800, zhangfei wrote:
> > > > > 
> > > > > 
> > > > > On 2019/8/21 下午5:17, Greg Kroah-Hartman wrote:
> > > > > > On Wed, Aug 21, 2019 at 03:21:18PM +0800, zhangfei.gao@foxmail.com wrote:
> > > > > > > Hi, Greg
> > > > > > > 
> > > > > > > On 2019/8/21 上午12:59, Greg Kroah-Hartman wrote:
> > > > > > > > On Tue, Aug 20, 2019 at 09:08:55PM +0800, zhangfei wrote:
> > > > > > > > > On 2019/8/15 下午10:13, Greg Kroah-Hartman wrote:
> > > > > > > > > > On Wed, Aug 14, 2019 at 05:34:25PM +0800, Zhangfei Gao wrote:
> > > > > > > > > > > +int uacce_register(struct uacce *uacce)
> > > > > > > > > > > +{
> > > > > > > > > > > +	int ret;
> > > > > > > > > > > +
> > > > > > > > > > > +	if (!uacce->pdev) {
> > > > > > > > > > > +		pr_debug("uacce parent device not set\n");
> > > > > > > > > > > +		return -ENODEV;
> > > > > > > > > > > +	}
> > > > > > > > > > > +
> > > > > > > > > > > +	if (uacce->flags & UACCE_DEV_NOIOMMU) {
> > > > > > > > > > > +		add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
> > > > > > > > > > > +		dev_warn(uacce->pdev,
> > > > > > > > > > > +			 "Register to noiommu mode, which export kernel data to user space and may vulnerable to attack");
> > > > > > > > > > > +	}
> > > > > > > > > > THat is odd, why even offer this feature then if it is a major issue?
> > > > > > > > > UACCE_DEV_NOIOMMU maybe confusing here.
> > > > > > > > > 
> > > > > > > > > In this mode, app use ioctl to get dma_handle from dma_alloc_coherent.
> > > > > > > > That's odd, why not use the other default apis to do that?
> > > > > > > > 
> > > > > > > > > It does not matter iommu is enabled or not.
> > > > > > > > > In case iommu is disabled, it maybe dangerous to kernel, so we added warning here, is it required?
> > > > > > > > You should use the other documentated apis for this, don't create your
> > > > > > > > own.
> > > > > > > I am sorry, not understand here.
> > > > > > > Do you mean there is a standard ioctl or standard api in user space, it can
> > > > > > > get dma_handle from dma_alloc_coherent from kernel?
> > > > > > There should be a standard way to get such a handle from userspace
> > > > > > today.  Isn't that what the ion interface does?  DRM also does this, as
> > > > > > does UIO I think.
> > > > > Thanks Greg,
> > > > > Still not find it, will do more search.
> > > > > But this may introduce dependency in our lib, like depend on ion?
> > > > > > Do you have a spec somewhere that shows exactly what you are trying to
> > > > > > do here, along with example userspace code?  It's hard to determine it
> > > > > > given you only have one "half" of the code here and no users of the apis
> > > > > > you are creating.
> > > > > > 
> > > > > The purpose is doing dma in user space.
> > > > 
> > > > Oh no, please no.  Are you _SURE_ you want to do this?
> > > > 
> > > > Again, look at how ION does this and how the DMAbuff stuff is replacing
> > > > it.  Use that api please instead, otherwise you will get it wrong and we
> > > > don't want to duplicate efforts.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > Dear Greg. I wrote a blog to explain the intention of WarpDrive here:
> > > https://zhuanlan.zhihu.com/p/79680889.
> > 
> > Putting that information into the changelog and kernel documentation is
> > a much better idea than putting it there.
> 
> Yes, will do. Thank you.
> 
> > 
> > > Sharing data is not our intention, Sharing address is. NOIOMMU mode is just a
> > > temporary solution to let some hardware which does not care the security issue
> > > to try WarpDrive for the first step. Some user do not care this much in embedded
> > > scenario. We saw VFIO use the same model so we also want to make a try. If you
> > > insist this is risky, we can remove it.
> > 
> > Why not just use vfio then?
> 
> We tried that in previous patches. But it needs to create unnecessary mdev to
> fulfill the requirement. So we discard it after the discussion in lkml.

Any pointers to that discussion?

thanks,

greg k-h
