Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CC0C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C58621655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfLTPBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:01:11 -0500
Received: from foss.arm.com ([217.140.110.172]:52118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbfLTPBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:01:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13E3530E;
        Fri, 20 Dec 2019 07:01:10 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F18543F6CF;
        Fri, 20 Dec 2019 07:01:07 -0800 (PST)
Subject: Re: [RFC PATCH v1] devres: align devres.data strictly only for
 devm_kmalloc()
To:     Peter Zijlstra <peterz@infradead.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tejun Heo <tj@kernel.org>, Mark Brown <broonie@kernel.org>
References: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
 <bf020a68-00fd-2bb7-c3b6-00f5befa293a@free.fr>
 <20191220140655.GN2827@hirez.programming.kicks-ass.net>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9be1d523-e92c-836b-b79d-37e880d092a0@arm.com>
Date:   Fri, 20 Dec 2019 15:01:03 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191220140655.GN2827@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/me rouses from holiday mode...

On 2019-12-20 2:06 pm, Peter Zijlstra wrote:
> On Fri, Dec 20, 2019 at 11:19:27AM +0100, Marc Gonzalez wrote:
>> Would anyone else have any suggestions, comments, insights, recommendations,
>> improvements, guidance, or wisdom? :-)
> 
> Flip devres upside down!

Which doesn't really help :(

> **WARNING, wear protective glasses when reading the below**
> 
> 
> struct devres {
> 	struct devres_node	node;
> 	void			*data;
> };
> 
> /*
>   * We place struct devres at the tail of the memory allocation
>   * such that data retains the ARCH_KMALLOC_MINALIGN alignment.
>   * struct devres itself is just 4 pointers and should therefore
>   * only require trivial alignment.
>   */
> static inline struct devres *data2devres(void *data)
> {
> 	return (struct devres *)(data + ksize(data) - sizeof(struct devres));
> }
> 
> void *alloc_dr(...)
> {
> 	struct devres *dr;
> 	void *data;
> 
> 	data = kmalloc(size + sizeof(struct devres), GFP_KERNEL);

At this point, you'd still need to special-case devm_kmalloc() to ensure 
size is rounded up to the next ARCH_KMALLOC_MINALIGN granule, or you'd 
go back to the original problem of the struct devres fields potentially 
sharing a cache line with the data buffer. That needs to be avoided, 
because if the devres list is modified while the buffer is mapped for 
noncoherent DMA (which could legitimately happen as they are nominally 
distinct allocations with different owners) there's liable to be data 
corruption one way or the other.

No matter which way round you allocate devres and data, by necessity 
they're always going to consume the same total amount of memory.

Robin.

> 	dr = data2devres(data);
> 	WARN_ON((unsigned long)dr & __alignof(*dr)-1);
> 	INIT_LIST_HEAD(&dr->node.entry);
> 	dr->node.release = release;
> 	dr->data = data;
> 
> 	return dr;
> }
> 
> void devres_free(void *data)
> {
> 	if (data) {
> 		struct devres *dr = data2devres(data);
> 		BUG_ON(!list_empty(dr->node.entry));
> 		kfree(data);
> 	}
> }
> 
> static int release_nodes(...)
> {
> 	...
> 	list_for_each_entry_safe_reverse(dr, ...) {
> 		...
> 		kfree(dr->data);
> 	}
> }
> 
