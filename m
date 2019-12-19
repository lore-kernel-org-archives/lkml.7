Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DDAC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3472053B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfLSOvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:51:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:10510 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbfLSOvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:51:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 06:51:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,332,1571727600"; 
   d="scan'208";a="417626039"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 19 Dec 2019 06:51:06 -0800
Received: from [10.249.231.98] (rsudarik-mobl.ccr.corp.intel.com [10.249.231.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5A4C458042B;
        Thu, 19 Dec 2019 06:51:01 -0800 (PST)
Subject: Re: [PATCH v3 0/2] perf x86: Exposing IO stack to IO PMON mapping
 through sysfs
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     alexander.antonov@intel.com
References: <20191212150440.11377-1-roman.sudarikov@linux.intel.com>
From:   "Sudarikov, Roman" <roman.sudarikov@linux.intel.com>
Message-ID: <317cf405-ae49-d39f-0a55-5f659ff62f17@linux.intel.com>
Date:   Thu, 19 Dec 2019 17:50:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212150440.11377-1-roman.sudarikov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

could you please take a look at the patch set.

Thanks,
Roman

On 12.12.2019 18:04, roman.sudarikov@linux.intel.com wrote:
> From: Roman Sudarikov <roman.sudarikov@linux.intel.com>
>
> The previous version can be found at:
> v2: https://lkml.org/lkml/2019/12/10/185
>
> Changes in this revision are:
> v2 -> v3:
> - Addressed comments from Peter and Kan
>
> The previous version can be found at:
> v1: https://lkml.org/lkml/2019/11/26/447
>
> Changes in this revision are:
> v1 -> v2:
> - Fixed process related issues;
> - This patch set includes kernel support for IIO stack to PMON mapping;
> - Stephane raised concerns regarding output format which may require
> code changes in the user space part of the feature only. We will continue
> output format discussion in the context of user space update.
>
> Intel® Xeon® Scalable processor family (code name Skylake-SP) makes
> significant changes in the integrated I/O (IIO) architecture. The new
> solution introduces IIO stacks which are responsible for managing traffic
> between the PCIe domain and the Mesh domain. Each IIO stack has its own
> PMON block and can handle either DMI port, x16 PCIe root port, MCP-Link
> or various built-in accelerators. IIO PMON blocks allow concurrent
> monitoring of I/O flows up to 4 x4 bifurcation within each IIO stack.
>
> Software is supposed to program required perf counters within each IIO
> stack and gather performance data. The tricky thing here is that IIO PMON
> reports data per IIO stack but users have no idea what IIO stacks are -
> they only know devices which are connected to the platform.
>
> Understanding IIO stack concept to find which IIO stack that particular
> IO device is connected to, or to identify an IIO PMON block to program
> for monitoring specific IIO stack assumes a lot of implicit knowledge
> about given Intel server platform architecture.
>
> This patch set introduces:
> 1. An infrastructure for exposing an Uncore unit to Uncore PMON mapping
>     through sysfs-backend;
> 2. A new --iiostat mode in perf stat to provide I/O performance metrics
>     per I/O device.
>
> Usage examples:
>
> 1. List all devices below IIO stacks
>    ./perf stat --iiostat=show
>
> Sample output w/o libpci:
>
>      S0-RootPort0-uncore_iio_0<00:00.0>
>      S1-RootPort0-uncore_iio_0<81:00.0>
>      S0-RootPort1-uncore_iio_1<18:00.0>
>      S1-RootPort1-uncore_iio_1<86:00.0>
>      S1-RootPort1-uncore_iio_1<88:00.0>
>      S0-RootPort2-uncore_iio_2<3d:00.0>
>      S1-RootPort2-uncore_iio_2<af:00.0>
>      S1-RootPort3-uncore_iio_3<da:00.0>
>
> Sample output with libpci:
>
>      S0-RootPort0-uncore_iio_0<00:00.0 Sky Lake-E DMI3 Registers>
>      S1-RootPort0-uncore_iio_0<81:00.0 Ethernet Controller X710 for 10GbE SFP+>
>      S0-RootPort1-uncore_iio_1<18:00.0 Omni-Path HFI Silicon 100 Series [discrete]>
>      S1-RootPort1-uncore_iio_1<86:00.0 Ethernet Controller XL710 for 40GbE QSFP+>
>      S1-RootPort1-uncore_iio_1<88:00.0 Ethernet Controller XL710 for 40GbE QSFP+>
>      S0-RootPort2-uncore_iio_2<3d:00.0 Ethernet Connection X722 for 10GBASE-T>
>      S1-RootPort2-uncore_iio_2<af:00.0 Omni-Path HFI Silicon 100 Series [discrete]>
>      S1-RootPort3-uncore_iio_3<da:00.0 NVMe Datacenter SSD [Optane]>
>
> 2. Collect metrics for all I/O devices below IIO stack
>
>    ./perf stat --iiostat -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
>      357708+0 records in
>      357707+0 records out
>      375083606016 bytes (375 GB, 349 GiB) copied, 215.381 s, 1.7 GB/s
>
>    Performance counter stats for 'system wide':
>
>       device             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
>      00:00.0                    0                    0                    0                    0
>      81:00.0                    0                    0                    0                    0
>      18:00.0                    0                    0                    0                    0
>      86:00.0                    0                    0                    0                    0
>      88:00.0                    0                    0                    0                    0
>      3b:00.0                    3                    0                    0                    0
>      3c:03.0                    3                    0                    0                    0
>      3d:00.0                    3                    0                    0                    0
>      af:00.0                    0                    0                    0                    0
>      da:00.0               358559                   44                    0                   22
>
>      215.383783574 seconds time elapsed
>
>
> 3. Collect metrics for comma separted list of I/O devices
>
>    ./perf stat --iiostat=da:00.0 -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
>      381555+0 records in
>      381554+0 records out
>      400088457216 bytes (400 GB, 373 GiB) copied, 374.044 s, 1.1 GB/s
>
>    Performance counter stats for 'system wide':
>
>       device             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
>      da:00.0               382462                   47                    0                   23
>
>      374.045775505 seconds time elapsed
>
>
> Roman Sudarikov (2):
>    perf x86: Infrastructure for exposing an Uncore unit to PMON mapping
>    perf x86: Exposing an Uncore unit to PMON for Intel Xeon® server
>      platform
>
>   arch/x86/events/intel/uncore.c       |  39 ++++++-
>   arch/x86/events/intel/uncore.h       |  10 +-
>   arch/x86/events/intel/uncore_snbep.c | 162 +++++++++++++++++++++++++++
>   3 files changed, 208 insertions(+), 3 deletions(-)
>
>
> base-commit: 219d54332a09e8d8741c1e1982f5eae56099de85


