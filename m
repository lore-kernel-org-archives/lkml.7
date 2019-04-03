Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC638C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E7E2146E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xr3NazJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfDCCiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:38:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34842 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfDCCiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 22:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RdLcKPz3xBk1pLLq8rOM9y9ug18OxzvutyVcuq7pPrY=; b=Xr3NazJ8BqLeP7wGJva5gnb+Ws
        xsb58+2nB+NeicGgHuu2DgQ7f2j6LHhpN+tK+jXHftxsZzqT8bGkq4ahPJn5oWG6KrNYt3MK5Aw4L
        KM0Xan6C/j8/YxX9oedmPZPcg7WNFUyPU2NMWNPZ5gtkzkSVVyhcig18RPBbbKdHNFCzl/pnQrlFM
        fq4HK76VrON/0kXKCWsB3sJmJywdBDsFWwmpg8to0xBvGNIN3YFbGEQx3zKmsp6cWAW2ZQAgA49sZ
        di0Hr7frrpJtnf2eWYesTd96G937VyQKXUVBMWXg/RtppO7EFTa+9FlpN7ba08Weucu/PcrRyM+Q6
        tzVD+20Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBVna-0007ic-9n; Wed, 03 Apr 2019 02:38:46 +0000
Subject: Re: drivers/infiniband/core/.tmp_gl_uverbs_main.o:undefined reference
 to `__user_bad'
To:     kbuild test robot <lkp@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Michal Simek <monstr@monstr.eu>
References: <201902281750.jbpT0s0R%fengguang.wu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <646013c8-5fcd-e7ab-0a87-3e0620563dfb@infradead.org>
Date:   Tue, 2 Apr 2019 19:38:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <201902281750.jbpT0s0R%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/19 1:03 AM, kbuild test robot wrote:
> Hi Jason,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7d762d69145a54d169f58e56d6dac57a5508debc
> commit: 3a6532c9af1a7836da2d597f1aaca73cb16c3b97 RDMA/uverbs: Use uverbs_attr_bundle to pass udata for write
> date:   3 months ago
> config: microblaze-allyesconfig (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 8.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 3a6532c9af1a7836da2d597f1aaca73cb16c3b97
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.2.0 make.cross ARCH=microblaze 
> 
> All errors (new ones prefixed by >>):
> 
>    `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
>    `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
>    drivers/infiniband/core/uverbs_main.o: In function `ib_uverbs_write':
>>> drivers/infiniband/core/.tmp_gl_uverbs_main.o:(.text+0x13a4): undefined reference to `__user_bad'
>    drivers/android/binder.o: In function `binder_thread_write':
>    drivers/android/.tmp_gl_binder.o:(.text+0xda6c): undefined reference to `__user_bad'
>    drivers/android/.tmp_gl_binder.o:(.text+0xda98): undefined reference to `__user_bad'
>    drivers/android/.tmp_gl_binder.o:(.text+0xdf10): undefined reference to `__user_bad'
>    drivers/android/.tmp_gl_binder.o:(.text+0xe498): undefined reference to `__user_bad'
>    drivers/android/binder.o:drivers/android/.tmp_gl_binder.o:(.text+0xea78): more undefined references to `__user_bad' follow
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Hi Michal,

Would you comment on this, please?

Jason has said more than once that these build errors are because
arch/microblaze does not support get_user() of size 8 (bytes),
although it does support a put_user() of size 8.


See a previous report & comment at
https://lore.kernel.org/lkml/20190101200742.GA5757@mellanox.com/


thanks.
-- 
~Randy
