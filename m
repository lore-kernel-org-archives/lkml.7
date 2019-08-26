Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF3CC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 04:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F4521848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 04:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfHZEQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 00:16:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34590 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbfHZEQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 00:16:13 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 46C9D5B8E7D3174811CD;
        Mon, 26 Aug 2019 12:16:12 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 26 Aug
 2019 12:16:10 +0800
Date:   Mon, 26 Aug 2019 12:14:04 +0800
From:   Kenneth Lee <liguozhu@hisilicon.com>
To:     Jerome Glisse <jglisse@redhat.com>
CC:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        <linux-accelerators@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/2] A General Accelerator Framework, WarpDrive
Message-ID: <20190826041404.GC27955@Turing-Arch-b>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <20190815170424.GA30916@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190815170424.GA30916@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 01:04:24PM -0400, Jerome Glisse wrote:
> Date: Thu, 15 Aug 2019 13:04:24 -0400
> From: Jerome Glisse <jglisse@redhat.com>
> To: Zhangfei Gao <zhangfei.gao@linaro.org>
> CC: linux-accelerators@lists.ozlabs.org, Greg Kroah-Hartman
>  <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann
>  <arnd@arndb.de>
> Subject: Re: [PATCH 0/2] A General Accelerator Framework, WarpDrive
> User-Agent: Mutt/1.11.3 (2019-02-01)
> Message-ID: <20190815170424.GA30916@redhat.com>
> 
> On Wed, Aug 14, 2019 at 05:34:23PM +0800, Zhangfei Gao wrote:
> > *WarpDrive* is a general accelerator framework for the user application to
> > access the hardware without going through the kernel in data path.
> > 
> > WarpDrive is the name for the whole framework. The component in kernel
> > is called uacce, meaning "Unified/User-space-access-intended Accelerator
> > Framework". It makes use of the capability of IOMMU to maintain a
> > unified virtual address space between the hardware and the process.
> > 
> > WarpDrive is intended to be used with Jean Philippe Brucker's SVA
> > patchset[1], which enables IO side page fault and PASID support. 
> > We have keep verifying with Jean's sva/current [2]
> > We also keep verifying with Eric's SMMUv3 Nested Stage patch [3]
> > 
> > This series and related zip & qm driver as well as dummy driver for qemu test:
> > https://github.com/Linaro/linux-kernel-warpdrive/tree/5.3-rc1-warpdrive-v1
> > zip driver already been upstreamed.
> > zip supporting uacce will be the next step.
> > 
> > The library and user application:
> > https://github.com/Linaro/warpdrive/tree/wdprd-v1-current
> 
> Do we want a new framework ? I think that is the first question that
> should be answer here. Accelerator are in many forms and so far they
> never have been enough commonality to create a framework, even GPUs
> with the drm is an example of that, drm only offer share framework
> for the modesetting part of the GPU (as thankfully monitor connector
> are not specific to GPU brands :))
> 
> FPGA is another example the only common code expose to userspace is
> about bitstream management AFAIK.
> 
> I would argue that a framework should only be created once there is
> enough devices with same userspace API. Meanwhile you can provide
> in kernel helper that allow driver to expose same API. If after a
> while we have enough device driver which all use that same in kernel
> helpers API then it will a good time to introduce a new framework.
> Meanwhile this will allow individual device driver to tinker with
> their API and maybe get to something useful to more devices in the
> end.
> 
> Note that what i propose also allow userspace code sharing for all
> driver that use the same in kernel helper.
> 
> Cheers,
> Jérôme

Hi, Jerome, I explain the idea here: https://zhuanlan.zhihu.com/p/79680889. We
think this is a comment requirement for eveybody. Hope this can help the
discussion. Thanks

-- 
			-Kenneth(Hisilicon)

