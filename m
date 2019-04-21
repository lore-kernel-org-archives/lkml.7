Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221FEC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 15:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC01320651
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 15:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YkyaWKy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfDUPY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 11:24:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59604 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfDUPY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 11:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9op1eYhFbJ9bjqJb16BhG3ik80oPMlMP4bm14U6cZdM=; b=YkyaWKy5g6a2/qgjt1qeWio4N
        O4OL1HXCtDpdqrQuupSyXk0skuJv1XiuLaqyPjV7U3jD6POU+qkM55wEDT4rWszfjZQ20oUA0+mWv
        Dsn+3uU9gUnMxofW7ueVl7mZVGXsp3Pp9xSg7K8ColR04ta3KSssfzw98wtU17GeE8YkdbFoBdLOE
        PUpfnvtmWSFkcTaK562to/jAXRQbUMynqFO+lkkih0ruMIP6bjH7xATY4Qbef2yiMXv7k/7uHvYCA
        YmiHLxbYkrzMwPXvm5ko/7Kx07UM3eviDVdYmWY5ENPU/wkBRNZSnbck9yBX6aUYbfjjSwI5llTuc
        DNtw/dt5A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIEKL-0003yr-Sh; Sun, 21 Apr 2019 15:24:26 +0000
Subject: Re: arch/sh/kernel/cpu/sh2/clock-sh7619.o:undefined reference to
 `followparent_recalc'
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        paul.mundt@gmail.com, Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <201904201516.DdPznV5M%lkp@intel.com>
 <fb6880d2-06a4-cec2-e12c-c526d3a4358a@infradead.org>
 <87sgubcvoj.wl-ysato@users.sourceforge.jp>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a7b17eb8-349f-298c-2e82-895a70b201ac@infradead.org>
Date:   Sun, 21 Apr 2019 08:24:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <87sgubcvoj.wl-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/19 6:52 AM, Yoshinori Sato wrote:
> On Sun, 21 Apr 2019 04:34:36 +0900,
> Randy Dunlap wrote:
>>
>> On 4/20/19 12:40 AM, kbuild test robot wrote:
>>> Hi Randy,
>>>
>>> It's probably a bug fix that unveils the link errors.
>>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   371dd432ab39f7bc55d6ec77d63b430285627e04
>>> commit: acaf892ecbf5be7710ae05a61fd43c668f68ad95 sh: fix multiple function definition build errors
>>> date:   2 weeks ago
>>> config: sh-allmodconfig (attached as .config)
>>> compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>>> reproduce:
>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         git checkout acaf892ecbf5be7710ae05a61fd43c668f68ad95
>>>         # save the attached .config to linux build tree
>>>         GCC_VERSION=7.2.0 make.cross ARCH=sh 
>>
>> Hi,
>>
>> Once again, the question is the validity of the SH2 .config file in this case
>> (that was attached).
>>
>> I don't believe that it is valid because CONFIG_SH_DEVICE_TREE=y,
>> which selects COMMON_CLK, and there is no followparent_recalc() in the
>> COMMON_CLK API.
>>
>> Also, while CONFIG_HAVE_CLK=y, drivers/sh/Makefile prevents that from
>> building clk/core.c, which could provide followparent_recalc():
>>
>> ifneq ($(CONFIG_COMMON_CLK),y)
>> obj-$(CONFIG_HAVE_CLK)			+= clk/
>> endif
>>
>> Hm, maybe that's where the problem is.  I'll look into that more.
>>
> 
> Yes.
> Selected target (CONFIG_SH_7619_SOLUTION_ENGINE) is non devicetree
> and used superh specific clk modules.
> So allyesconfig output is incorrect.
> 
> I fixed Kconfig to output the correct config.

Thanks for that.
The patch fixes this problem in my builds.

However, now I see these build errors:

ERROR: "__ashiftrt_r4_28" [fs/udf/udf.ko] undefined!
ERROR: "__ashiftrt_r4_26" [drivers/rtc/rtc-x1205.ko] undefined!
ERROR: "__ashiftrt_r4_25" [drivers/rtc/rtc-pcf2123.ko] undefined!
ERROR: "__ashiftrt_r4_28" [drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.ko] undefined!
ERROR: "__ashiftrt_r4_25" [drivers/input/tablet/gtco.ko] undefined!
ERROR: "__ashiftrt_r4_26" [drivers/input/mouse/psmouse.ko] undefined!
ERROR: "__ashiftrt_r4_28" [drivers/input/mouse/psmouse.ko] undefined!
ERROR: "__ashiftrt_r4_25" [drivers/iio/pressure/bmp280.ko] undefined!
ERROR: "__ashiftrt_r4_26" [drivers/iio/dac/ad5764.ko] undefined!
ERROR: "__ashiftrt_r4_26" [drivers/iio/accel/mma7660.ko] undefined!
ERROR: "__ashiftrt_r4_25" [drivers/iio/accel/dmard06.ko] undefined!
ERROR: "__ashiftrt_r4_26" [drivers/iio/accel/bma220_spi.ko] undefined!
ERROR: "__ashiftrt_r4_25" [drivers/crypto/hisilicon/sec/hisi_sec.ko] undefined!

Is this just a toolchain problem?

I am using the gcc 8.1.0 tools from
https://mirrors.edge.kernel.org/pub/tools/crosstool/


thanks.
-- 
~Randy
