Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2ECC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF5A2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576075579;
	bh=XUPg0jKEJbOe5bostq1S7exSkK2zO+9rqUlma2uNRcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z4PxtD22fTkd8o2fhFFT6mjKjCVxGvxFcG6DZjGvm/BusalmDX/lMadRbHNaMMiwp
	 Hek73Y3KIR1XgtFDvnwdEiMl5kCKDhfBiuKAXTEBLDd/WEBHEP5xvQQ3brfANwijhC
	 vFmlp/JKxyaoaH20TgUNAm+b5xec0jdx46rnLbjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbfLKOqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:46:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729689AbfLKOqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:46:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A2BD208C3;
        Wed, 11 Dec 2019 14:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576075577;
        bh=XUPg0jKEJbOe5bostq1S7exSkK2zO+9rqUlma2uNRcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2VBTltrES4sUwFNPERJVMiY/DKSZlenMMgpcxjxDdM1Tmbz5J/w4HyvjWPCnpAl3z
         FiDvTwNQ/UWLO69RVIKyOsbMYNfkgTmnCeYKt2DzN9a/1h+l6TQkjF0k/YiZtDB0gY
         yFstLUgP12iqfq8U9/xH3i8pNeIycO8ekT3RKpu0=
Date:   Wed, 11 Dec 2019 15:46:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        cl@linux.com, mgalbraith@suse.de, mhocko@suse.com,
        torvalds@linux-foundation.org, umgwanakikbuti@gmail.com,
        wagi@monom.org, stable-commits@vger.kernel.org,
        "Wangkefeng (Maro)" <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>
Subject: Re: Patch "mm, vmstat: make quiet_vmstat lighter" has been added to
 the 4.4-stable tree
Message-ID: <20191211144614.GA637714@kroah.com>
References: <156442332854185@kroah.com>
 <e4bd396a-1a10-1387-aa3f-4d61d31ab7b6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4bd396a-1a10-1387-aa3f-4d61d31ab7b6@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 10:32:49PM +0800, zhangyi (F) wrote:
> Hi, all
> 
> We find a performance degradation under lmbench af_unix[1] test case after
> mergeing this patch on my x86 qemu 4.4 machine. The test result is basically
> stable for each teses.
> 
> Host machine: CPU: Intel(R) Xeon(R) CPU E5-2690 v3
>               CPU(s): 48
>               MEM: 193047 MB
> 
> Guest machine:  CPU: QEMU Virtual CPU version 2.5+
>                 CPU(s): 8
>                 MEM: 26065 MB
> 
>   Before this patch:
>   [root@localhost ~]# lmbench-3.0-a9/bin/x86_64-linux-gnu/lat_unix -P 1
>   AF_UNIX sock stream latency: 133.7073 microseconds
> 
>   After this patch:
>   [root@localhost ~]# lmbench-3.0-a9/bin/x86_64-linux-gnu/lat_unix -P 1
>   AF_UNIX sock stream latency: 156.4722 microseconds
> 
> If we set task to a constant cpu, the degradation does not appear.
> 
>   Before this patch:
>   [root@localhost ~]# lmbench-3.0-a9/bin/x86_64-linux-gnu/lat_unix -P 1
>   AF_UNIX sock stream latency: 17.9296 microseconds
> 
>   After this patch:
>   [root@localhost ~]# lmbench-3.0-a9/bin/x86_64-linux-gnu/lat_unix -P 1
>   AF_UNIX sock stream latency: 17.7500 microseconds
> 
> We also test it on the aarch64 hi1215 machine with 8 cpu cores.
> 
>   Before this patch:
>   [root@localhost ~]# ./lat_unix -P 1
>   AF_UNIX sock stream latency: 30.7 microseconds
> 
>   After this patch:
>   [root@localhost ~]# ./lat_unix -P 1
>   AF_UNIX sock stream latency: 37.5 microseconds
> 
> Accessories included my reproduce config for x86 qemu. Any thoughts?

This fixes a bug, as reported by Daniel Wagner.  So it's probably better
to have a stable system instead of a broken one, right?  :)

Daniel can provide more information if needed.

What about when you run your tests on a 4.9 or newer kernel that already
has this integrated?

thanks,

greg k-h
