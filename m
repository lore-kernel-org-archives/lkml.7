Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5414C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4726229F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfGXLII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:08:08 -0400
Received: from foss.arm.com ([217.140.110.172]:39012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbfGXLII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:08:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC335337;
        Wed, 24 Jul 2019 04:08:07 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDCE33F71A;
        Wed, 24 Jul 2019 04:08:06 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm/arm64: Properly check for MMIO regions
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu
References: <1562919728-642-1-git-send-email-karahmed@amazon.de>
From:   James Morse <james.morse@arm.com>
Message-ID: <653177b8-7e74-aef3-3a4c-a45df5bcdab2@arm.com>
Date:   Wed, 24 Jul 2019 12:08:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1562919728-642-1-git-send-email-karahmed@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi KarimAllah,

On 12/07/2019 09:22, KarimAllah Ahmed wrote:
> Valid RAM can live outside kernel control (e.g. using "mem=" command-line
> parameter). This memory can still be used as valid guest memory for KVM. So
> ensure that we validate that this memory is definitely not "RAM" before
> assuming that it is an MMIO region.
> 
> One way to use memory outside kernel control is:
> 
> 1- Pass 'mem=' in the kernel command-line to limit the amount of memory managed
>    by the kernel.

"mem=" is a debug option, we ignore it if we need something located outside the 'mem=' region.


> 2- Map this physical memory you want to give to the guest with:
>    mmap("/dev/mem", physical_address_offset, ..)

/dev/mem is an egregious hack! If you need to use it, you probably didn't want an
operating-system in the first place.


> 3- Use the user-space virtual address as the "userspace_addr" field in
>    KVM_SET_USER_MEMORY_REGION ioctl.


... What do you want to do this for?

At a guess: this is to save all that annoying 'memory allocation' overhead at guest
startup. If you get your VMM to use hugetlbfs, you can reserve the memory during boot. I
do this with "hugepagesz=2M hugepages=512" on the kernel command-line.

(if you get a RAS error affecting memory that the kernel doesn't know about, it will
ignore it. Using hugetlbfs instead gives you all the good things: hugepage-splitting,
signals to your VMM, stage2 unmapping etc.)


Thanks,

James
