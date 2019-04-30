Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C17C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA8920835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jX+ZXQx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfD3Fi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 01:38:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60610 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfD3Fi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 01:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0VaZ99/42myj1FUXHKYXX+Rl3OaCNMwGJa9NC9KEQIY=; b=jX+ZXQx4dWZoDeduDfZkC/43LY
        pnP4zwze/rk3LT9LdIFmFSdAYV2zOyHnohbIB70XW6LnH/5FPnccRkK74lJujftuXeATCYFX/d3p1
        ezFFKCmqupvSru6eiN7DnCZJ3D5EP1SnBSKUfNC5JRViDCN8ei4/DEO0Uo8Mq+NJR3mYyteYCbrN4
        iUhFUg/fR2qTSntctNJwQUsGU6GPZzt3Oj+22T5oaG3Dt2AbfeenySG2SQxHjuXHspXU67zofaduQ
        fWmsQXjuEsQz76NWb9BoQuUAPdkshZcN52oNlcpbOqq0sCD6j+9ku5j/zdN6ZJvXKpm6YdGxAOD3h
        ulnKa5Uw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLLT5-0006Uu-WC; Tue, 30 Apr 2019 05:38:16 +0000
Subject: Re: sh4-linux-gnu-ld: arch/sh/kernel/cpu/sh2/clock-sh7619.o:undefined
 reference to `followparent_recalc'
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <201904301231.JpYYMMcK%lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f5370e99-f5a5-8296-25dd-d6685bfedfe3@infradead.org>
Date:   Mon, 29 Apr 2019 22:38:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201904301231.JpYYMMcK%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/19 9:48 PM, kbuild test robot wrote:
> Hi Randy,
> 
> It's probably a bug fix that unveils the link errors.

Yoshinori Sato (cc-ed) has a patch for this.  I guess that it's not in the arch/sh
git tree yet ???  or wherever arch/sh changes come from.



> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   83a50840e72a5a964b4704fcdc2fbb2d771015ab
> commit: acaf892ecbf5be7710ae05a61fd43c668f68ad95 sh: fix multiple function definition build errors
> date:   3 weeks ago
> config: sh-allmodconfig (attached as .config)
> compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout acaf892ecbf5be7710ae05a61fd43c668f68ad95
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=sh 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> sh4-linux-gnu-ld: arch/sh/kernel/cpu/sh2/clock-sh7619.o:(.data+0x1c): undefined reference to `followparent_recalc'
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 


-- 
~Randy
