Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75408C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433B6206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893749;
	bh=5hngcFTxsbfc5fjmAjHazMNmqRY0AOYp4ApyDHXH/Cg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=n0m514oTxoyW4zRq6/T9p/cx8/UM6UGEF8ehn6Eh2VPFtY7IFJ12k4LjWW/uyt1Pp
	 7dzneZVT4qtng0FevDlRLNDpoyFLtAK9I9IMB8FaV/gGcSOVxK24kJOqIEr26BhoAQ
	 pdo4gcD9Q8zjnBczavje0wjDdPVcU6K/XdjKgNBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfH0IPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:15:48 -0400
Received: from foss.arm.com ([217.140.110.172]:40584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729575AbfH0IPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:15:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6A82337;
        Tue, 27 Aug 2019 01:15:45 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61C483F246;
        Tue, 27 Aug 2019 01:15:44 -0700 (PDT)
Subject: Re: [PATCH v1 0/6] Allow kexec reboot for GICv3 and device tree
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20190826190056.27854-1-pasha.tatashin@soleen.com>
 <20190826201313.246208e9@why>
 <CA+CK2bAS-jDwY-qKfZQD8TbvyAhS1+rBvcxGqkR4BHd5NR5BGQ@mail.gmail.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <d7461fb3-0f6d-8abf-084d-ce0be1f1a18d@kernel.org>
Date:   Tue, 27 Aug 2019 09:15:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bAS-jDwY-qKfZQD8TbvyAhS1+rBvcxGqkR4BHd5NR5BGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2019 22:25, Pavel Tatashin wrote:
> On Mon, Aug 26, 2019 at 3:13 PM Marc Zyngier <maz@kernel.org> wrote:
>>
>> On Mon, 26 Aug 2019 15:00:50 -0400
>> Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>>
>>> Marc Zyngier added the support for kexec and GICv3 for EFI based systems.
>>> However, it is still not possible todo on systems with device trees.
>>>
>>> Here is EFI fixes from Marc:
>>> https://lore.kernel.org/lkml/20180921195954.21574-1-marc.zyngier@arm.com
>>>
>>> For Device Tree variant: lets allow reserve a memory region in interrupt
>>> controller node, and use this property to allocate interrupt tables.
>>
>> There is no such thing as a "device tree variant". As long as your
>> bootloader implements EFI, everything will work correctly, whether
>> you're using DT, ACPI, or the anything else.
>>
>> This already works today, without any need to add anything to the
>> kernel (I have systems using EDK II and u-boot, both implementing EFI,
>> and I'm able to kexec without any issue). If your bootloader doesn't
>> support EFI, here's a good opportunity to implement it!
> 
> Hi Marc,
> 
> Thank you very much for looking at this work.
> 
> Running Linux without EFI is common, and there are scenarios which
> make it appropriate. As I understand most of embedded linux do not
> have EFI enabled, and thus I do not see a reason why we would not
> support a first class feature of Linux (kexec) on non-EFI bootloaders.

Define "most". All the arm64 systems I have around (and trust me, that's
quite a number of them) can either use u-boot, which has more than
enough EFI support to use this functionality, or use EDK-II natively.

> We (Microsoft) have a small highly secure device with a high uptime
> requirement. The device also has PCIe and thus GICv3. The update for

PCIe doesn't imply GICv3 at all.

> this device relies on kexec. For a number of reasons, it was decided
> to use U-Boot and Linux without EFI enabled. One of those reasons is
> to improve boot performance, enabling EFI in U-Boot alone reduces the
> boot performance by half a second. Our total reboot budget is under a
> second which makes that half a second unacceptable. Also, adding EFI
> support to kernel increases its size and there are security
> implications from enabling more code both in U-Boot and Linux.

You're are missing the point. kexec with EFI has 0 overhead (no
non-kernel EFI code gets executed), doesn't impact your time budget, and
only relies on a single in-memory table. This can be pretty trivially
provided by the dumbest EFI shim.

All you are describing above is a set of self imposed limitations in
your bootloader, which you are fully in control of. So instead of
reinventing a square wheel, I suggest you adopt the existing implementation.

Another reason not to do this is interoperability: I want to be able to
kexec whatever Linux kernel I want, without having to cope with all
flavours of the same functionality. Effectively, the EFI table is a
private ABI between two Linux kernels. We're not changing it.

	M.
-- 
Jazz is not dead, it just smells funny...
