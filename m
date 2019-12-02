Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA5BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5312070B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qaYV4IDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLBOBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:01:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLBOBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 09:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=93Mq4hGdwdZNtTVNb7h07FqV5Mx6ZBkun/PInhPUvK4=; b=qaYV4IDkSUmBBTbEa4wLLu5/Fo
        OJsXD57aGELBrcxhoAXSne5BvxwEZatEnO6wELplNpLRJceBEgXrLqUdwk33crjIoaauEv3QndcDz
        IiLZvn+IMAmSMiNQEB/Pvzbt6UQygwx5m6k+v4PCIPxVeM3D66dPRd1MmuyKPmgzxwi5Sc7YcUy4l
        RWAHelsytXAs80uW6C0sq+myEhjnnJTXouudhPqqsoHqC0WwtQEdDTpW9j3T+PjZ7BB1lKQ0CA5BB
        aDZ9f3f3y031J4P8+4vhRPXrCbyTHcK6nteiWTdgux+BeR+38yFSWIJKz1JmYY4ESAYI8EYk8kYsn
        ovEbaKIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ibmG7-0005BI-Go; Mon, 02 Dec 2019 14:01:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4D04C3006E3;
        Mon,  2 Dec 2019 14:59:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0CC89201A401D; Mon,  2 Dec 2019 15:01:00 +0100 (CET)
Date:   Mon, 2 Dec 2019 15:00:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     roman.sudarikov@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, alexander.antonov@intel.com
Subject: Re: [PATCH 1/6] perf x86: Infrastructure for exposing an Uncore unit
 to PMON mapping
Message-ID: <20191202140059.GL2844@hirez.programming.kicks-ass.net>
References: <20191126163630.17300-1-roman.sudarikov@linux.intel.com>
 <20191126163630.17300-2-roman.sudarikov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191126163630.17300-2-roman.sudarikov@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 07:36:25PM +0300, roman.sudarikov@linux.intel.com wrote:
> From: Roman Sudarikov <roman.sudarikov@linux.intel.com>
> 
> Intel® Xeon® Scalable processor family (code name Skylake-SP) makes significant
> changes in the integrated I/O (IIO) architecture. The new solution introduces
> IIO stacks which are responsible for managing traffic between the PCIe domain
> and the Mesh domain. Each IIO stack has its own PMON block and can handle either
> DMI port, x16 PCIe root port, MCP-Link or various built-in accelerators.
> IIO PMON blocks allow concurrent monitoring of I/O flows up to 4 x4 bifurcation
> within each IIO stack.
> 
> Software is supposed to program required perf counters within each IIO stack
> and gather performance data. The tricky thing here is that IIO PMON reports data
> per IIO stack but users have no idea what IIO stacks are - they only know devices
> which are connected to the platform.
> 
> Understanding IIO stack concept to find which IIO stack that particular IO device
> is connected to, or to identify an IIO PMON block to program for monitoring
> specific IIO stack assumes a lot of implicit knowledge about given Intel server
> platform architecture.
> 
> This patch set introduces:
>     An infrastructure for exposing an Uncore unit to Uncore PMON mapping through sysfs-backend
>     A new --iiostat mode in perf stat to provide I/O performance metrics per I/O device
> 
> Current version supports a server line starting Intel® Xeon® Processor Scalable
> Family and introduces mapping for IIO Uncore units only.
> Other units can be added on demand.
> 
> Usage example:
>     /sys/devices/uncore_<type>_<pmu_idx>/platform_mapping
> 
> Each Uncore unit type, by its nature, can be mapped to its own context, for example:
>     CHA - each uncore_cha_<pmu_idx> is assigned to manage a distinct slice of LLC capacity
>     UPI - each uncore_upi_<pmu_idx> is assigned to manage one link of Intel UPI Subsystem
>     IIO - each uncore_iio_<pmu_idx> is assigned to manage one stack of the IIO module
>     IMC - each uncore_imc_<pmu_idx> is assigned to manage one channel of Memory Controller
> 
> Implementation details:
>     Two callbacks added to struct intel_uncore_type to discover and map Uncore units to PMONs:
>         int (*get_topology)(struct intel_uncore_type *type)
>         int (*set_mapping)(struct intel_uncore_type *type)
> 
>     IIO stack to PMON mapping is exposed through
>         /sys/devices/uncore_iio_<pmu_idx>/platform_mapping
>         in the following format: domain:bus
> 
> Details of IIO Uncore unit mapping to IIO PMON:
> Each IIO stack is either a DMI port, x16 PCIe root port, MCP-Link or various
> built-in accelerators. For Uncore IIO Unit type, the platform_mapping file
> holds bus numbers of devices, which can be monitored by that IIO PMON block
> on each die.
> 
> For example, on a 4-die Intel Xeon® server platform:
>     $ cat /sys/devices/uncore_iio_0/platform_mapping
>     0000:00,0000:40,0000:80,0000:c0
> 
> Which means:
> IIO PMON block 0 on die 0 belongs to IIO stack located on bus 0x00, domain 0x0000
> IIO PMON block 0 on die 1 belongs to IIO stack located on bus 0x40, domain 0x0000
> IIO PMON block 0 on die 2 belongs to IIO stack located on bus 0x80, domain 0x0000
> IIO PMON block 0 on die 3 belongs to IIO stack located on bus 0xc0, domain 0x0000
> 
> Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
> Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
> Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>

Kan, can you help these people? There's a ton of process fail with this
submission. From SoB chain to CodingStyle to git-sendmail threading.
