Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBCEC76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB89C21985
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563806509;
	bh=SP7OsDfXdAA6oWhBIIdiF7L1RDF3S0q8SAbBwEQqBTU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=PwVNG0DPoL5n2wE52u4Xsnd+kxDk/p92QwaLxQhvFTie9FYIUfqLcLeDGcENYugiL
	 unK05F7hyzwUo8J5gC5gQ/GO/MGxkN4+IjDSMXOo+m/9D7GdIOSg8BHfsfyu/usbsI
	 B8Bk9xdR9dcarVAurbYPRd7LoBdttSd52sGP2C0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfGVOls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 10:41:48 -0400
Received: from foss.arm.com ([217.140.110.172]:38908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfGVOls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:41:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C6C8344;
        Mon, 22 Jul 2019 07:41:47 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D84D3F694;
        Mon, 22 Jul 2019 07:41:46 -0700 (PDT)
Subject: Re: About threaded interrupt handler CPU affinity
To:     John Garry <john.garry@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     bigeasy@linutronix.de, chenxiang <chenxiang66@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <e0e9478e-62a5-ca24-3b12-58f7d056383e@huawei.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <a98ba3d0-5596-664a-a1ee-5777cff0ddd9@kernel.org>
Date:   Mon, 22 Jul 2019 15:41:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e0e9478e-62a5-ca24-3b12-58f7d056383e@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 22/07/2019 15:14, John Garry wrote:
> Hi Thomas,
> 
> I have a question on commit cbf8699996a6 ("genirq: Let irq thread follow 
> the effective hard irq affinity"), if you could kindly check:
> 
> Here we set the thread affinity to be the same as the hard interrupt 
> affinity. For an arm64 system with GIC ITS, this will be a single CPU, 
> the lowest in the interrupt affinity mask. So, in this case, effectively 
> the thread will be bound to a single CPU. I think APIC is the same for this.
> 
> The commit message describes the problem that we solve here is that the 
> thread may become affine to a different CPU to the hard interrupt - does 
> it mean that the thread CPU mask could not cover that of the hard 
> interrupt? I couldn't follow the reason.

Assume a 4 CPU system. If the interrupt affinity is on CPU0-1, you could
end up with the effective interrupt affinity on CPU0 (which would be
typical of the ITS), and the thread running on CPU1. Not great.

The change you mentions ensures that the thread affinity is strictly
equal to the *effective affinity* of the interrupt (or at least that's
the way I read it).

> We have experimented with fixing the thread mask to be the same as the 
> interrupt mask (we're using managed interrupts), like before, and get a 
> significant performance boost at high IO datarates on our storage 
> controller - like ~11%.

My understanding is that this patch does exactly that. Does it result in
a regression?

Thanks,
	
	M.
-- 
Jazz is not dead, it just smells funny...
