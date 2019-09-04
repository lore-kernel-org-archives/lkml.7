Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D1EC41514
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C802923402
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567600687;
	bh=8RhsG85jcNMg6U4ayFkiWlCA5D7lmQsDEdfiybItXnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k91Nw7WcDngfv0JqIzowR4P5vfFS8tW6w/tWsYmzSKrpTzsdA6bhscuYIs1J5sqv/
	 PMEKtCk0s0zrzzmIeECzp/nUgM2+dRd6CNaoxrp1D6GRQk2FQvJHVJbChcxC6VGY5v
	 +ujGyRPvJEhHBhSr/1FmEzULVXyHfX8MWfaENbBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbfIDMiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfIDMiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:38:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45E1121883;
        Wed,  4 Sep 2019 12:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567600685;
        bh=8RhsG85jcNMg6U4ayFkiWlCA5D7lmQsDEdfiybItXnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qJAtL59U6k8VEX4++w4sf0SHJA6YrxPHa8H2pn290hOY3yKi7I/fQSdUNsl+ku+3l
         Io4ArL+dkwRZRkJq2caxjpvffEXmL35SAYmUCS2M1UwfhfyyKEAXOH1DbgGprgJFz9
         ygml1f1dtjWfXlSV6veFPfYiFxPvrcdpo1IJPLmU=
Date:   Wed, 4 Sep 2019 14:38:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, jonathan.cameron@huawei.com,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>
Subject: Re: [PATCH v3 2/2] uacce: add uacce driver
Message-ID: <20190904123803.GC5043@kroah.com>
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
> ---
>  Documentation/ABI/testing/sysfs-driver-uacce |   47 ++
>  drivers/misc/Kconfig                         |    1 +
>  drivers/misc/Makefile                        |    1 +
>  drivers/misc/uacce/Kconfig                   |   13 +
>  drivers/misc/uacce/Makefile                  |    2 +
>  drivers/misc/uacce/uacce.c                   | 1096 ++++++++++++++++++++++++++
>  include/linux/uacce.h                        |  172 ++++
>  include/uapi/misc/uacce.h                    |   39 +
>  8 files changed, 1371 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-uacce
>  create mode 100644 drivers/misc/uacce/Kconfig
>  create mode 100644 drivers/misc/uacce/Makefile
>  create mode 100644 drivers/misc/uacce/uacce.c
>  create mode 100644 include/linux/uacce.h
>  create mode 100644 include/uapi/misc/uacce.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
> new file mode 100644
> index 0000000..ee0a66e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-uacce
> @@ -0,0 +1,47 @@
> +What:           /sys/class/uacce/hisi_zip-<n>/id
> +Date:           Sep 2019
> +KernelVersion:  5.3

5.3 will be released in a week or so, without this file in it, so that's
not ok here :(

