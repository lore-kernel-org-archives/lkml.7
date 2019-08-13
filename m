Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC941C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9893120679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfHMOWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:22:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:63366 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729151AbfHMOWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:22:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 07:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,381,1559545200"; 
   d="scan'208";a="260138342"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 13 Aug 2019 07:22:10 -0700
Received: from dalyrusx-mobl.amr.corp.intel.com (unknown [10.251.3.205])
        by linux.intel.com (Postfix) with ESMTP id 7A825580238;
        Tue, 13 Aug 2019 07:22:10 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] soundwire: Don't build sound.o without
 CONFIG_ACPI
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Cc:     clang-built-linux@googlegroups.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190813061014.45015-1-natechancellor@gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <445d16e1-6b00-6797-82df-42a49a5e79e3@linux.intel.com>
Date:   Tue, 13 Aug 2019 09:22:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813061014.45015-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/19 1:10 AM, Nathan Chancellor wrote:
> clang warns when CONFIG_ACPI is unset:
> 
> ../drivers/soundwire/slave.c:16:12: warning: unused function
> 'sdw_slave_add' [-Wunused-function]
> static int sdw_slave_add(struct sdw_bus *bus,
>             ^
> 1 warning generated.
> 
> Before commit 8676b3ca4673 ("soundwire: fix regmap dependencies and
> align with other serial links"), this code would only be compiled when
> ACPI was set because it was only selected by SOUNDWIRE_INTEL, which
> depends on ACPI.
> 
> Now, this code can be compiled without CONFIG_ACPI, which causes the
> above warning. The IS_ENABLED(CONFIG_ACPI) guard could be moved to avoid
> compiling the function; however, slave.c only contains three functions,
> two of which are static. Only compile slave.o when CONFIG_ACPI is set,
> where it will actually be used. bus.h contains a stub for
> sdw_acpi_find_slaves so there will be no issues with an undefined
> function.
> 
> This has been build tested with CONFIG_ACPI set and unset in combination
> with CONFIG_SOUNDWIRE unset, built in, and a module.

Thanks for the patch. Do you have a .config you can share offline so 
that we add it to our tests?

> 
> Fixes: 8676b3ca4673 ("soundwire: fix regmap dependencies and align with other serial links")
> Link: https://github.com/ClangBuiltLinux/linux/issues/637
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>   drivers/soundwire/Makefile | 6 +++++-
>   drivers/soundwire/slave.c  | 3 ---
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> index 45b7e5001653..226090902716 100644
> --- a/drivers/soundwire/Makefile
> +++ b/drivers/soundwire/Makefile
> @@ -4,9 +4,13 @@
>   #
>   
>   #Bus Objs
> -soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
> +soundwire-bus-objs := bus_type.o bus.o mipi_disco.o stream.o
>   obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
>   
> +ifdef CONFIG_ACPI
> +soundwire-bus-objs += slave.o
> +endif

I am fine with the change, but we might as well rename the file 
acpi_slave.c then?

> +
>   #Cadence Objs
>   soundwire-cadence-objs := cadence_master.o
>   obj-$(CONFIG_SOUNDWIRE_CADENCE) += soundwire-cadence.o
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index f39a5815e25d..0dc188e6873b 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -60,7 +60,6 @@ static int sdw_slave_add(struct sdw_bus *bus,
>   	return ret;
>   }
>   
> -#if IS_ENABLED(CONFIG_ACPI)
>   /*
>    * sdw_acpi_find_slaves() - Find Slave devices in Master ACPI node
>    * @bus: SDW bus instance
> @@ -110,5 +109,3 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
>   
>   	return 0;
>   }
> -
> -#endif
> 

