Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9272BC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723F0206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfHLMlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:41:50 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:64791 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfHLMlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:41:47 -0400
IronPort-SDR: 826mzmceumwPFScYSCPm+eF20YPkNW/ySU1RHPZC1SQDSh5FQz8EImeqFU/3OwHZIwSA4bO1W9
 XqOs6N2oXU7d3Ppp8VKiChB9Bqivo7hmDqTdopFYXzfBqabro+Od6mcTEwx8dnED5AVKHzLgmf
 6OeQLEO/xyRO82NNiMYxWf2mrPC0oyYUVbZei55w8o4AoZuaIRFiKTmdfb6xqQ7DBmMicwFXK4
 idX0OCsk4T7VIypFoZBzTYwwplx688aaeuRaZHRaP2kvr19GXC39XAC4TarO5Iv8TFHjUZhIn/
 I2s=
X-IronPort-AV: E=Sophos;i="5.64,377,1559509200"; 
   d="scan'208";a="228268207"
Subject: Re: drivers/power/reset/nvmem-reboot-mode.c:27:42: error: passing
 argument 2 of 'nvmem_cell_write' from incompatible pointer type
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
References: <201908110745.3Zksfatm%lkp@intel.com>
From:   Nandor Han <nandor.han@vaisala.com>
Message-ID: <03e59e9b-8647-c9b2-b60a-99817af5313d@vaisala.com>
Date:   Mon, 12 Aug 2019 15:41:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <201908110745.3Zksfatm%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Aug 2019 12:41:42.0313 (UTC) FILETIME=[4B100990:01D5510B]
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/19 2:43 AM, kbuild test robot wrote:
> Hi Han,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dcbb4a153971ff8646af0c963f5698bf21bfbfdc
> commit: 7a78a7f7695bf9ef9cef3c06fbc5fa4573fd0eef power: reset: nvmem-reboot-mode: use NVMEM as reboot mode write interface
> date:   7 weeks ago
> config: x86_64-randconfig-d003-201932 (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
> reproduce:
>          git checkout 7a78a7f7695bf9ef9cef3c06fbc5fa4573fd0eef
>          # save the attached .config to linux build tree
>          make ARCH=x86_64
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/power/reset/nvmem-reboot-mode.c: In function 'nvmem_reboot_mode_write':
>>> drivers/power/reset/nvmem-reboot-mode.c:27:42: error: passing argument 2 of 'nvmem_cell_write' from incompatible pointer type [-Werror=incompatible-pointer-types]
>       ret = nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
>                                               ^
>     In file included from drivers/power/reset/nvmem-reboot-mode.c:10:0:
>     include/linux/nvmem-consumer.h:120:19: note: expected 'const char *' but argument is of type 'unsigned int *'
>      static inline int nvmem_cell_write(struct nvmem_cell *cell,
>                        ^~~~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors
> 
> vim +/nvmem_cell_write +27 drivers/power/reset/nvmem-reboot-mode.c
> 
>      18	
>      19	static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
>      20					    unsigned int magic)
>      21	{
>      22		int ret;
>      23		struct nvmem_reboot_mode *nvmem_rbm;
>      24	
>      25		nvmem_rbm = container_of(reboot, struct nvmem_reboot_mode, reboot);
>      26	
>    > 27		ret = nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
>      28		if (ret < 0)
>      29			dev_err(reboot->dev, "update reboot mode bits failed\n");
>      30	
>      31		return ret;
>      32	}
>      33	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

Hi,

Seems that `nvmem-consumer.h` declares a different signature for 
`nvmem_cell_write` method depending on `CONFIG_NVMEM` configuration:

#if IS_ENABLED(CONFIG_NVMEM)

...

int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len);

...

#else

...
static inline int nvmem_cell_write(struct nvmem_cell *cell,
                                     const char *buf, size_t len)
{
         return -EOPNOTSUPP;
}

...

#endif /* CONFIG_NVMEM *

What's the best approach here?

Nandor
