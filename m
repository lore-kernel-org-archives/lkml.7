Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D8AC48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C42C2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561379527;
	bh=a3K3DY7Vl1R9i4uY3YJgDprYWQNpO5K3lg8iFltccQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zgF3Lc7P9CMyS9V6oyjy2AQl1zwiG0Ct/s7+9WFfHFt4D/UmakQwNLpIIZ9uBuKAq
	 ZQ82u/dKm4V5yaNSbpmkmBMthGjFkxavTu1f7r+kzEKK5PstGLLoJdHmFCzisN0m2l
	 W8CYU98am8QFL5ryYGU+hRUb9c7Yy79hG6oU2QFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfFXMcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfFXMcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:32:05 -0400
Received: from linux-8ccs (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F2E8205C9;
        Mon, 24 Jun 2019 12:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561379524;
        bh=a3K3DY7Vl1R9i4uY3YJgDprYWQNpO5K3lg8iFltccQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLycqTq+aNbxd3gjPjNE9eolP7uheTaiE+2YXket8RcX0W8qyre9yJudYBufPfpKm
         jUvfAJJrJXmZeGmgaflV39AQzCx0zIiY52gWJ3gnVpF8VcEWbtYqYnKXHsBz1END0/
         P3jMzy4V3tkHZRmIVZqd5LCLKdT6/vx5oRoZkvgM=
Date:   Mon, 24 Jun 2019 14:32:00 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH modules v2 0/2] Fix handling of exit unwinding sections
 (on ARM)
Message-ID: <20190624123200.GB22519@linux-8ccs>
References: <20190607104912.6252-1-matthias.schiffer@ew.tq-group.com>
 <c52edcd84b01970113fc046d11c38276d51886e0.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c52edcd84b01970113fc046d11c38276d51886e0.camel@ew.tq-group.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Matthias Schiffer [21/06/19 14:35 +0200]:
>On Fri, 2019-06-07 at 12:49 +0200, Matthias Schiffer wrote:
>> For some time (050d18d1c651 "ARM: 8650/1: module: handle negative
>> R_ARM_PREL31 addends correctly", v4.11+), building a kernel without
>> CONFIG_MODULE_UNLOAD would lead to module loads failing on ARM
>> systems with
>> certain memory layouts, with messages like:
>>
>>   imx_sdma: section 16 reloc 0 sym '': relocation 42 out of range
>>   (0x7f015260 -> 0xc0f5a5e8)
>>
>> (0x7f015260 is in the module load area, 0xc0f5a5e8 a regular vmalloc
>> address; relocation 42 is R_ARM_PREL31)
>>
>> This is caused by relocatiosn in the .ARM.extab.exit.text and
>> .ARM.exidx.exit.text sections referencing the .exit.text section. As
>> the
>> module loader will omit loading .exit.text without
>> CONFIG_MODULE_UNLOAD,
>> there will be relocations from loaded to unloaded sections; the
>> resulting
>> huge offsets trigger the sanity checks added in 050d18d1c651.
>>
>> IA64 might be affected by a similar issue - sections with names like
>> .IA_64.unwind.exit.text and .IA_64.unwind_info.exit.text appear in
>> the ld
>> script - but I don't know much about that arch.
>>
>> Also, I'm not sure if this is stable-worthy - just enabling
>> CONFIG_MODULE_UNLOAD should be a viable workaround on affected
>> kernels.
>>
>> v2: Use __weak function as suggested by Jessica
>
>Hi Russell,
>
>this patch series is still waiting for your thoughts - in reponse to
>v1, Jessica already offered to take it through her tree if you give
>your Acked-by.
>
>Thanks,
>
>Matthias

Hi Matthias,

There doesn't seem to be any complaints and I think the patchset looks
good, so I've taken it up the modules-next tree. Thanks!

Jessica
