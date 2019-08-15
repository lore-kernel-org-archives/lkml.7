Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F95C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D249B206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfHORE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:04:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfHORE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:04:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC48D51EE1;
        Thu, 15 Aug 2019 17:04:26 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 512EF43FD5;
        Thu, 15 Aug 2019 17:04:26 +0000 (UTC)
Date:   Thu, 15 Aug 2019 13:04:24 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org
Subject: Re: [PATCH 0/2] A General Accelerator Framework, WarpDrive
Message-ID: <20190815170424.GA30916@redhat.com>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 15 Aug 2019 17:04:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 05:34:23PM +0800, Zhangfei Gao wrote:
> *WarpDrive* is a general accelerator framework for the user application to
> access the hardware without going through the kernel in data path.
> 
> WarpDrive is the name for the whole framework. The component in kernel
> is called uacce, meaning "Unified/User-space-access-intended Accelerator
> Framework". It makes use of the capability of IOMMU to maintain a
> unified virtual address space between the hardware and the process.
> 
> WarpDrive is intended to be used with Jean Philippe Brucker's SVA
> patchset[1], which enables IO side page fault and PASID support. 
> We have keep verifying with Jean's sva/current [2]
> We also keep verifying with Eric's SMMUv3 Nested Stage patch [3]
> 
> This series and related zip & qm driver as well as dummy driver for qemu test:
> https://github.com/Linaro/linux-kernel-warpdrive/tree/5.3-rc1-warpdrive-v1
> zip driver already been upstreamed.
> zip supporting uacce will be the next step.
> 
> The library and user application:
> https://github.com/Linaro/warpdrive/tree/wdprd-v1-current

Do we want a new framework ? I think that is the first question that
should be answer here. Accelerator are in many forms and so far they
never have been enough commonality to create a framework, even GPUs
with the drm is an example of that, drm only offer share framework
for the modesetting part of the GPU (as thankfully monitor connector
are not specific to GPU brands :))

FPGA is another example the only common code expose to userspace is
about bitstream management AFAIK.

I would argue that a framework should only be created once there is
enough devices with same userspace API. Meanwhile you can provide
in kernel helper that allow driver to expose same API. If after a
while we have enough device driver which all use that same in kernel
helpers API then it will a good time to introduce a new framework.
Meanwhile this will allow individual device driver to tinker with
their API and maybe get to something useful to more devices in the
end.

Note that what i propose also allow userspace code sharing for all
driver that use the same in kernel helper.

Cheers,
Jérôme
