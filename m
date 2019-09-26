Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C770C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A5F2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfIZMIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:08:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:10523 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfIZMIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:08:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 05:08:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,551,1559545200"; 
   d="scan'208";a="341225012"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by orsmga004.jf.intel.com with ESMTP; 26 Sep 2019 05:08:41 -0700
Subject: Re: [PATCH v3 0/3] Add MMC software queue support
To:     Baolin Wang <baolin.wang@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1568864712.git.baolin.wang@linaro.org>
 <CAMz4kuKFYCcY_Wh4mntwoSNgk5=QQvkV7zC-RpAWgdJpM2-4HA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <f6f147df-510b-f1ec-0745-a9c7eed67b84@intel.com>
Date:   Thu, 26 Sep 2019 15:07:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMz4kuKFYCcY_Wh4mntwoSNgk5=QQvkV7zC-RpAWgdJpM2-4HA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/19 12:43 PM, Baolin Wang wrote:
> Hi Adrian and Ulf,
> 
> On Thu, 19 Sep 2019 at 13:59, Baolin Wang <baolin.wang@linaro.org> wrote:
>>
>> Hi All,
>>
>> Now the MMC read/write stack will always wait for previous request is
>> completed by mmc_blk_rw_wait(), before sending a new request to hardware,
>> or queue a work to complete request, that will bring context switching
>> overhead, especially for high I/O per second rates, to affect the IO
>> performance.
>>
>> Thus this patch set will introduce the MMC software command queue support
>> based on command queue engine's interfaces, and set the queue depth as 2,
>> that means we do not need wait for previous request is completed and can
>> queue 2 requests in flight. It is enough to let the irq handler always
>> trigger the next request without a context switch and then ask the blk_mq
>> layer for the next one to get queued, as well as avoiding a long latency.
>>
>> Moreover we can expand the MMC software queue interface to support
>> MMC packed request or packed command instead of adding new interfaces,
>> according to previosus discussion.
>>
>> Below are some comparison data with fio tool. The fio command I used
>> is like below with changing the '--rw' parameter and enabling the direct
>> IO flag to measure the actual hardware transfer speed in 4K block size.
>>
>> ./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=512M --group_reporting --numjobs=20 --name=test_read
>>
>> My eMMC card working at HS400 Enhanced strobe mode:
>> [    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
>> [    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB
>> [    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
>> [    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
>> [    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)
>>
>> 1. Without MMC software queue
>> I tested 3 times for each case and output a average speed.
>>
>> 1) Sequential read:
>> Speed: 28.9MiB/s, 26.4MiB/s, 30.9MiB/s
>> Average speed: 28.7MiB/s
>>
>> 2) Random read:
>> Speed: 18.2MiB/s, 8.9MiB/s, 15.8MiB/s
>> Average speed: 14.3MiB/s
>>
>> 3) Sequential write:
>> Speed: 21.1MiB/s, 27.9MiB/s, 25MiB/s
>> Average speed: 24.7MiB/s
>>
>> 4) Random write:
>> Speed: 21.5MiB/s, 18.1MiB/s, 18.1MiB/s
>> Average speed: 19.2MiB/s
>>
>> 2. With MMC software queue
>> I tested 3 times for each case and output a average speed.
>>
>> 1) Sequential read:
>> Speed: 44.1MiB/s, 42.3MiB/s, 44.4MiB/s
>> Average speed: 43.6MiB/s
>>
>> 2) Random read:
>> Speed: 30.6MiB/s, 30.9MiB/s, 30.5MiB/s
>> Average speed: 30.6MiB/s
>>
>> 3) Sequential write:
>> Speed: 44.1MiB/s, 45.9MiB/s, 44.2MiB/s
>> Average speed: 44.7MiB/s
>>
>> 4) Random write:
>> Speed: 45.1MiB/s, 43.3MiB/s, 42.4MiB/s
>> Average speed: 43.6MiB/s
>>
>> Form above data, we can see the MMC software queue can help to improve the
>> performance obviously.
>>
>> Any comments are welcome. Thanks a lot.
>>
>> Changes from v2:
>>  - Remove reference to 'struct cqhci_host' and 'struct cqhci_slot',
>>  instead adding 'struct sqhci_host', which is only used by software queue.
>>
>> Changes from v1:
>>  - Add request_done ops for sdhci_ops.
>>  - Replace virtual command queue with software queue for functions and
>>  variables.
>>  - Rename the software queue file and add sqhci.h header file.
> 
> Do you have any comments for this patch set except the random config
> building issue that will be fixed in the next version? Thanks.

Pedantically, swhci is not a host controller interface, so the name still
seems inappropriate. Otherwise I haven't had time to look at it, sorry.

> 
>>
>> Baolin Wang (3):
>>   mmc: Add MMC software queue support
>>   mmc: host: sdhci: Add request_done ops for struct sdhci_ops
>>   mmc: host: sdhci-sprd: Add software queue support
>>
>>  drivers/mmc/core/block.c      |   61 ++++++++
>>  drivers/mmc/core/mmc.c        |   13 +-
>>  drivers/mmc/core/queue.c      |   25 ++-
>>  drivers/mmc/host/Kconfig      |    9 ++
>>  drivers/mmc/host/Makefile     |    1 +
>>  drivers/mmc/host/sdhci-sprd.c |   26 ++++
>>  drivers/mmc/host/sdhci.c      |   12 +-
>>  drivers/mmc/host/sdhci.h      |    2 +
>>  drivers/mmc/host/sqhci.c      |  344 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/mmc/host/sqhci.h      |   53 +++++++
>>  include/linux/mmc/host.h      |    3 +
>>  11 files changed, 537 insertions(+), 12 deletions(-)
>>  create mode 100644 drivers/mmc/host/sqhci.c
>>  create mode 100644 drivers/mmc/host/sqhci.h
>>
>> --
>> 1.7.9.5
>>
> 
> 

