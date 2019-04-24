Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAC5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B769C218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbfDXQUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:20:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48182 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbfDXQUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:20:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2ED4A78;
        Wed, 24 Apr 2019 09:20:39 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33E3E3F557;
        Wed, 24 Apr 2019 09:20:38 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] Enable kprobe to monitor sdei event handler
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     huawei.libin@huawei.com, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1555070699-3685-1-git-send-email-wangxiongfeng2@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <d197785a-9e3b-2c88-d882-b59075a38264@arm.com>
Date:   Wed, 24 Apr 2019 17:20:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1555070699-3685-1-git-send-email-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiongfeng Wang,

On 12/04/2019 13:04, Xiongfeng Wang wrote:
> When I use kprobe to monitor a sdei event handler,

Don't do this! SDEI is like an NMI, it isn't safe to kprobe it as it can interrupt the
kprobe code, causing it become re-entrant.


> the CPU will hang. It's
> because when I probe the event handler, the instruction will be replaced with 
> brk instruction and brk exception is unmaskable. But 'vbar_el1' contains 
> 'tramp_vectors' in '_sdei_handler' when SDEI events interrupt userspace, so
> we will go to the wrong place if brk exception happens.

This was lucky! Its even more fun if the SDEI event interrupted a guest: the kvm vectors
will give you a hyp-panic.

The __kprobes and NOKPROBE_SYMBOL() litter should stop you doing this.


> I notice that 'ghes_sdei_normal_callback' call several funtions that are not
> marked as 'nokprobe'.

Bother. We should probably blacklist those too, its not safe.


> So I was wondering if we can enable kprobe in '_sdei_handler'.

I don't think this can be done safely.


If you need to monitor your SDEI event handler you can just use printk(). Once nmi_enter()
has been called these are safe as they stash data in a per-cpu buffer. The SDEI handler
will exit via the IRQ vector if it can, which will cause this buffer to be flushed to the
console in a timely manner.


Why do you need to kprobe an NMI handler?



Thanks!

James
