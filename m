Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923FDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64561217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566897852;
	bh=VzCOZqtAlz+GUkyOEEKNv1LAO6m4MPFMmBZMsh1yqL8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=1AjcbxMHeExwBI8aCZb9Eo/9bFQ+oVtNttI6u4BX9AxBBXVN7MonaVt1Vdiw6T/k9
	 Ke8c/1fx0QMFaN+m5qypxQbCcyJC6Sp/ojYK0LOhmF8/bC7GvCPozkuzEkmpekNUE/
	 N2bq2zaOR7PxYXGRsK0zo6XWnH2IYNGIE+UyImBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfH0JYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:24:11 -0400
Received: from foss.arm.com ([217.140.110.172]:41474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728711AbfH0JYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:24:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FFB3337;
        Tue, 27 Aug 2019 02:24:10 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 508D93F718;
        Tue, 27 Aug 2019 02:24:09 -0700 (PDT)
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
 <d7461fb3-0f6d-8abf-084d-ce0be1f1a18d@kernel.org>
 <CA+CK2bAk4Xb_hxh2KLxWKa8ogM-jO1MpREmc02TmUMpdJ2ZbSA@mail.gmail.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <86282c48-bc69-f745-92c2-9df2b92ad6bd@kernel.org>
Date:   Tue, 27 Aug 2019 10:24:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bAk4Xb_hxh2KLxWKa8ogM-jO1MpREmc02TmUMpdJ2ZbSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/2019 09:53, Pavel Tatashin wrote:
>>> Running Linux without EFI is common, and there are scenarios which
>>> make it appropriate. As I understand most of embedded linux do not
>>> have EFI enabled, and thus I do not see a reason why we would not
>>> support a first class feature of Linux (kexec) on non-EFI bootloaders.
>>
>> Define "most". All the arm64 systems I have around (and trust me, that's
>> quite a number of them) can either use u-boot, which has more than
>> enough EFI support to use this functionality, or use EDK-II natively.
> 
> OK. Is this the most common configuration in the embedded ARM64
> devices currently deployed: phones, cameras, consoles, players, etc?

Which one of these has kexec as a requirement?

>>> We (Microsoft) have a small highly secure device with a high uptime
>>> requirement. The device also has PCIe and thus GICv3. The update for
>>
>> PCIe doesn't imply GICv3 at all.
> 
> My impression was that without PCIe GICv3 is rarely used, and this
> could be the reason why this problem is not seen outside of larger
> machines which normally have EFI enabled.

Wong impression. All the combinations exist and are wildly deployed.

>>> this device relies on kexec. For a number of reasons, it was decided
>>> to use U-Boot and Linux without EFI enabled. One of those reasons is
>>> to improve boot performance, enabling EFI in U-Boot alone reduces the
>>> boot performance by half a second. Our total reboot budget is under a
>>> second which makes that half a second unacceptable. Also, adding EFI
>>> support to kernel increases its size and there are security
>>> implications from enabling more code both in U-Boot and Linux.
>>
>> You're are missing the point. kexec with EFI has 0 overhead (no
>> non-kernel EFI code gets executed), doesn't impact your time budget, and
>> only relies on a single in-memory table. This can be pretty trivially
>> provided by the dumbest EFI shim.
> 
> Thanks, this makes sense that the Linux boot time won't be affected. I
> have not tested how u-boot was affected, but was told 0.5 second
> longer to start.

So you haven't even tried? :-(

> 
>> All you are describing above is a set of self imposed limitations in
>> your bootloader, which you are fully in control of. So instead of
>> reinventing a square wheel, I suggest you adopt the existing implementation.
> 
> I am not sure this analogy is correct, I do not think that non-EFI
> enabled kernels became legacy.

non-EFI systems always had reduced functionality, such as not being able
to use runtime services.

> 
>> Another reason not to do this is interoperability: I want to be able to
>> kexec whatever Linux kernel I want, without having to cope with all
>> flavours of the same functionality. Effectively, the EFI table is a
>> private ABI between two Linux kernels. We're not changing it.
> 
> This is exactly the problem: by having this region defined in signed
> DTB file we reduce the amount of communication between the kernels.
> Passing modified EFI Table causes us to pass more information from the
> first kernel indefinitely through updates. Thus, increases a chance
> for a security compromise.

Nothing says that it has to be modified. For what it's worth, you could
perform the allocation in your bootloader once and for all, configure
the GIC redistributors and enable LPIs there, and pass the EFI
reservation to the first kernel. The security argument is a fallacy.

> We are not changing EFI ABI between
> kernels, it will stay as is. All this code does is enables kernels
> that do not have EFI table communication between them a way to do
> kexec updates with reduced amount of data exchange.

And to do that, you're adding yet another ABI we have to support, and
creating havoc in the kexec chain (kernel 1 knows about the DT hack,
kernel 2 doesn't, panic follows). My answer to this is *no*. We already
have a flexible interface that allows you to do what you want, and I'm
not adding another one.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
