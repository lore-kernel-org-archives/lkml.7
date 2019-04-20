Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E382C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374EB20651
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mzwZvj05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfDTTet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 15:34:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59614 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfDTTet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 15:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yBGAB8b1n3dFt3YiVQiw88D3yeUo9coqXwfyseTVuP8=; b=mzwZvj05wmRaDLh4JLHUh9hDwF
        s8L8iA3qot/dFziw+9hvQXQwPfastAs0EqxYFVKDs6NBq0z7nHKRCZVkUi2Sa2eYZngi6Op4SkFZv
        NqrB0fDDreHKatH9VA9DR/fRDYFA+z9GnN3XijRaant9BZ8vgFT6FDuV0RYux+kuss+CoyiSLjeKm
        uQU+jRzxBFEn3oDnmDXHTxepOk7cMPLn/97W3hxQVRCfO0W2xO6O5vuu9ts4vMphbUDYH5JQ7b+fK
        if1GHX4UxMYE5l4f0fmjWIhkdJieSYWDuwHIQjmm4N1SvF0yRQZhyUkg8qmOoQn9c9MBdKuseBXDE
        hwoRTgyw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHvl2-00026T-6j; Sat, 20 Apr 2019 19:34:40 +0000
Subject: Re: arch/sh/kernel/cpu/sh2/clock-sh7619.o:undefined reference to
 `followparent_recalc'
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        paul.mundt@gmail.com, Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <201904201516.DdPznV5M%lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fb6880d2-06a4-cec2-e12c-c526d3a4358a@infradead.org>
Date:   Sat, 20 Apr 2019 12:34:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <201904201516.DdPznV5M%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/19 12:40 AM, kbuild test robot wrote:
> Hi Randy,
> 
> It's probably a bug fix that unveils the link errors.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   371dd432ab39f7bc55d6ec77d63b430285627e04
> commit: acaf892ecbf5be7710ae05a61fd43c668f68ad95 sh: fix multiple function definition build errors
> date:   2 weeks ago
> config: sh-allmodconfig (attached as .config)
> compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout acaf892ecbf5be7710ae05a61fd43c668f68ad95
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=sh 

Hi,

Once again, the question is the validity of the SH2 .config file in this case
(that was attached).

I don't believe that it is valid because CONFIG_SH_DEVICE_TREE=y,
which selects COMMON_CLK, and there is no followparent_recalc() in the
COMMON_CLK API.

Also, while CONFIG_HAVE_CLK=y, drivers/sh/Makefile prevents that from
building clk/core.c, which could provide followparent_recalc():

ifneq ($(CONFIG_COMMON_CLK),y)
obj-$(CONFIG_HAVE_CLK)			+= clk/
endif

Hm, maybe that's where the problem is.  I'll look into that more.



It would be Good if someone from the SuperH area could/would comment.

Thanks.


> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> 
> All errors (new ones prefixed by >>):
> 
>>> arch/sh/kernel/cpu/sh2/clock-sh7619.o:(.data+0x1c): undefined reference to `followparent_recalc'
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 


-- 
~Randy
