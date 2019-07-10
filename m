Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AD6C74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8545B2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfGJPTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:19:13 -0400
Received: from foss.arm.com ([217.140.110.172]:35200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfGJPTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:19:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CE0F2B;
        Wed, 10 Jul 2019 08:19:11 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 078203F246;
        Wed, 10 Jul 2019 08:19:08 -0700 (PDT)
Subject: Re: [v1 0/5] allow to reserve memory for normal kexec kernel
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Bhupesh Sharma <bhsharma@redhat.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20190708211528.12392-1-pasha.tatashin@soleen.com>
 <CACi5LpNGWhTnXyM8gB0Tn=682+08s-ppfDpX2SawfxMvue1GTQ@mail.gmail.com>
 <CA+CK2bBrwBHhD-PFO_gVnDYoFi0Su6t456WNdtBWpOe4qM+oww@mail.gmail.com>
 <2d60f302-5161-638a-76cd-d7d79e5631fe@arm.com>
 <CA+CK2bA40wQvX=KieE5Qg2Ny5ZyiDAAjAb9W7Phu2Ou_9r6bOA@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <f9bea5bd-370a-47b5-8ad1-a30bd43d6cca@arm.com>
Date:   Wed, 10 Jul 2019 16:19:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bA40wQvX=KieE5Qg2Ny5ZyiDAAjAb9W7Phu2Ou_9r6bOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pasha,

On 09/07/2019 14:07, Pavel Tatashin wrote:
>>> Enabling MMU and D-Cache for relocation  would essentially require the
>>> same changes in kernel. Could you please share exactly why these were
>>> not accepted upstream into kexec-tools?
>>
>> Because '--no-checks' is a much simpler alternative.
>>
>> More of the discussion:
>> https://lore.kernel.org/linux-arm-kernel/5599813d-f83c-d154-287a-c131c48292ca@arm.com/
>>
>> While you can make purgatory a fully-fledged operating system, it doesn't really need to
>> do anything on arm64. Errata-workarounds alone are a reason not do start down this path.
> 
> Thank you James. I will summaries the information gathered from the
> yesterday's/today's discussion and add it to the cover letter together
> with ARM64 tag. I think, the patch series makes sense for ARM64 only,
> unless there are other platforms that disable caching/MMU during
> relocation.

I'd prefer not to reserve additional memory for regular kexec just to avoid the relocation.
If the kernel's relocation work is so painful we can investigate doing it while the MMU is
enabled. If you can compare regular-kexec with kexec_file_load() you eliminate the
purgatory part of the work.


Thanks,

James
