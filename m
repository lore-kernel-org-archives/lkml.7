Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAA3CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F24320679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571924499;
	bh=4TprOBfp3nt4WQaU8avCLK9lNHnnYpamtR1pBfkpNNw=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=yIIzin21Ctb6XDej3eA1SEasYXKACiyD1V7bNXMqeHf5U8VFwqmeF+3/8T8qjTjBm
	 ohDGMLGJBzfh9lqEznDGCW+AjuNLKOBVV1sftnEihDbt7X2JrmS0f8hAvCz0J693IR
	 P4hxenCbct+VVv8PT2jI4xIx3iMrn0qb3d6ECDKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393678AbfJXNli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:41:38 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:53014 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387547AbfJXNli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:41:38 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iNdMr-0000ve-QZ; Thu, 24 Oct 2019 15:41:33 +0200
To:     James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC 0/7] Support KVM being compiled as a kernel module  on arm64
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Oct 2019 14:41:33 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     Shannon Zhao <shannon.zhao@linux.alibaba.com>,
        <kvmarm@lists.cs.columbia.edu>, <suzuki.poulose@arm.com>,
        <christoffer.dall@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <8cbd81d6-4ab8-9d2a-5162-8782201cd13d@arm.com>
References: <1571912870-18471-1-git-send-email-shannon.zhao@linux.alibaba.com>
 <8cbd81d6-4ab8-9d2a-5162-8782201cd13d@arm.com>
Message-ID: <c17e8b0f32902a0811cc6a4ed71e607e@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: james.morse@arm.com, shannon.zhao@linux.alibaba.com, kvmarm@lists.cs.columbia.edu, suzuki.poulose@arm.com, christoffer.dall@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-24 11:58, James Morse wrote:
> Hi Shannon,
>
> On 24/10/2019 11:27, Shannon Zhao wrote:
>> Curently KVM ARM64 doesn't support to compile as a kernel module. 
>> It's
>> useful to compile KVM as a module.
>
>> For example, it could reload kvm without rebooting host machine.
>
> What problem does this solve?
>
> KVM has some funny requirements that aren't normal for a module. On
> v8.0 hardware it must
> have an idmap. Modules don't usually expect their code to be
> physically contiguous, but
> KVM does. KVM influences they way some of the irqchip stuff is set up
> during early boot
> (EOI mode ... not that I understand it).

We change the EOImode solely based on how we were booted (EL2 or not).
KVM doesn't directly influences that (it comes in the picture much
later).

> (I think KVM-as-a-module on x86 is an artifact of how it was 
> developed)
>
>
>> This patchset support this feature while there are some limitations
>> to be solved. But I just send it out as RFC to get more suggestion 
>> and
>> comments.
>
>> Curently it only supports for VHE system due to the hyp code section
>> address variables like __hyp_text_start.
>
> We still need to support !VHE systems, and we need to do it with a
> single image.
>
>
>> Also it can't call
>> kvm_update_va_mask when loading kvm module and kernel panic with 
>> below
>> errors. So I make kern_hyp_va into a nop funtion.
>
> Making this work for the single-Image on v8.0 is going to be a
> tremendous amount of work.
> What is the payoff?

I can only agree. !VHE is something we're going to support for the 
foreseeable
future (which is roughly equivalent to "forever"), and modules have 
properties
that are fundamentally incompatible with the way KVM works with !VHE.

If the only purpose of this work is to be able to swap KVM 
implementations
in a development environment, then it really isn't worth the effort.

         M.
-- 
Jazz is not dead. It just smells funny...
