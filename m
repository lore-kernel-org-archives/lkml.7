Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C9AC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89A6214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570710785;
	bh=QQuI/HtU7JQ5P/P+YFgxZHiWEkZ1bQRUlcfBi244Tf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dH0gmuj3y0qHFdhvP0mspY7cDz5ccy7yAQPQSk/3nveZ6DrzdiUyZvgtzljEhF3yN
	 kQ/Ezhl8oLmX77qfSbE5JH4AZy1QrJQgDiMJuoXClBBBrzvGmjTwCq8FqDXrqFpKdX
	 77fXfKrVm8saAeXzycIVj88WggCF4Rf1HRQjfM5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbfJJMdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 08:33:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfJJMdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:33:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5543120B7C;
        Thu, 10 Oct 2019 12:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570710782;
        bh=QQuI/HtU7JQ5P/P+YFgxZHiWEkZ1bQRUlcfBi244Tf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b17VOrZXBIUY2jMy/zCZMuXLACb95NdVlFoDe693SRI8/DJu8IwHFQQrREjwHPC2P
         w+EhEo26rexSmBj8w5rulBy4arT7o2aInmo3CHJcrHeQ1QrnV+4BF2ACQQ5lY5ZBIJ
         w19nLC4Jz1jXq2xO8M09lRllfEoejQmywKe4kprk=
Date:   Thu, 10 Oct 2019 14:33:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, jonathan.cameron@huawei.com,
        grant.likely@arm.com, jean-philippe <jean-philippe@linaro.org>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>
Subject: Re: [RESEND PATCH v4 2/2] uacce: add uacce driver
Message-ID: <20191010123300.GA730639@kroah.com>
References: <1570634502-20923-1-git-send-email-zhangfei.gao@linaro.org>
 <1570634502-20923-3-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570634502-20923-3-git-send-email-zhangfei.gao@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 11:21:42PM +0800, Zhangfei Gao wrote:
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

No one is using these new apis you are creating, so we can not judge if
they are correct or not.  Please submit this as a patch series with a
driver that is actually going to use this api.

thanks,

greg k-h
