Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33642C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F095220866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559834498;
	bh=mLdxV+RudsCb8mYr7BWKmOmkMo1rkI6oaKHldh70dBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xs3koiVWt0ee4AEE8gV6DWKYgWp+zMyCrcaDha+IGHbhKtuOv2Z32qdc0hmDbFglv
	 xeIUxuKta/vXyCTUF+nueVp3w/dM2fCD9m/TnH15mksKJ96C3Ko8PBnSHvVcs97ac0
	 /3e27SbRyCXRP2kDNObCwvHmdGEL18/E6pyXTdtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbfFFPVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbfFFPVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:21:36 -0400
Received: from linux-8ccs (ip5f5ade8c.dynamic.kabel-deutschland.de [95.90.222.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04BB620673;
        Thu,  6 Jun 2019 15:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559834496;
        bh=mLdxV+RudsCb8mYr7BWKmOmkMo1rkI6oaKHldh70dBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WXkkQoMB08AdfjyhCVRCQWQK02WMFqgmrVf8sccWUDOBYEl1wbdCpwyj01MITAJCK
         FUBd9MjAsy7bpv2HUF0UZNYm0a8rx2DCvKFl/k+2uqqfqYXvECShDsV/E6UI+yh4wI
         zEJGEpXilEp9ARxc0/YIA0DKNxtViD+snItNjCls=
Date:   Thu, 6 Jun 2019 17:21:31 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH modules 0/2] Fix handling of exit unwinding sections (on
 ARM)
Message-ID: <20190606152131.GB27669@linux-8ccs>
References: <20190603105726.22436-1-matthias.schiffer@ew.tq-group.com>
 <61f233518ba863f9d5783dd10e468ee5bf22b69a.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <61f233518ba863f9d5783dd10e468ee5bf22b69a.camel@ew.tq-group.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Matthias Schiffer [06/06/19 10:14 +0200]:
>On Mon, 2019-06-03 at 12:57 +0200, Matthias Schiffer wrote:
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
>>
>> Kind regards,
>> Matthias
>
>
>Hi,
>any comments on these patches? If not, who is going to take them in
>their tree?

I don't mind either way. I can take the patches through my tree if
Russell ack's the second one (after comments have been addressed).

Thanks!

Jessica
