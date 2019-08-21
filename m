Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B6FC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1441A22D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfHUJb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:31:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:11739 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfHUJb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:31:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 02:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="195961705"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2019 02:31:24 -0700
Received: from [10.226.38.83] (rtanwar-mobl.gar.corp.intel.com [10.226.38.83])
        by linux.intel.com (Postfix) with ESMTP id 970E85803FA;
        Wed, 21 Aug 2019 02:31:21 -0700 (PDT)
Subject: Re: [PATCH] x86/apic: Update virtual irq base for DT/OF based system
 as well
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tony.luck@intel.com,
        x86@kernel.org, andriy.shevchenko@intel.com, alan@linux.intel.com,
        rppt@linux.ibm.com, linux-kernel@vger.kernel.org,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com
References: <20190821081330.1187-1-rahul.tanwar@linux.intel.com>
 <alpine.DEB.2.21.1908211028030.2223@nanos.tec.linutronix.de>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <7b4db9f3-21da-5b5e-e219-0170e812a015@linux.intel.com>
Date:   Wed, 21 Aug 2019 17:31:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908211028030.2223@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/8/2019 4:34 PM, Thomas Gleixner wrote:

> Secondly, this link is irrelevant. ioapic_dynirq_base has nothing to do
> with virtual IRQ number 0. It's a boundary for the dynamic allocation of
> virtual interrupt numbers so that the core allocator does not pick
> interrupts out of the IOAPIC's fixed interrupt number space.
>
> This can be legitimately 0 when IOAPIC is not enabled at all.
>
> Can you please explain what kind of problem you were seing and what this
> really fixes?

The problem is that device tree infrastructure considers 0 IRQ value as 
invalid/error

value whereas for ACPI, 0 is a valid value. Without this change, the 
problem that we

see is that the first driver using of_irq_get_xx() or its variants fails 
because of 0 IRQ

number. With this change, allocated IRQ number is never 0 so it works ok.


