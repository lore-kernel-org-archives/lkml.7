Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBF4C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4432077C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389193AbfGRDsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:48:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:57868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732313AbfGRDsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:48:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 996B6AFED;
        Thu, 18 Jul 2019 03:48:36 +0000 (UTC)
Subject: Re: [PATCH v8 4/5] x86/paravirt: Remove const mark from
 x86_hyper_xen_hvm variable
To:     Joe Perches <joe@perches.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, sstabellini@kernel.org, x86@kernel.org,
        tglx@linutronix.de, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, mingo@redhat.com
References: <1563251169-30740-1-git-send-email-zhenzhong.duan@oracle.com>
 <9791d12717bba784f24f35c29ddfaab9ccb78965.camel@perches.com>
 <d4be507a-aa31-9ba3-9bf0-c8b60ec3f93a@suse.com>
 <18469f4c80f3dbf04eda5415f4bcf1c8fa655370.camel@perches.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <3d74b1f6-37ae-dcb0-fa8a-6f02e183bbd7@suse.com>
Date:   Thu, 18 Jul 2019 05:48:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <18469f4c80f3dbf04eda5415f4bcf1c8fa655370.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.07.19 19:22, Joe Perches wrote:
> On Wed, 2019-07-17 at 08:49 +0200, Juergen Gross wrote:
>> On 17.07.19 08:46, Joe Perches wrote:
>>> On Tue, 2019-07-16 at 12:26 +0800, Zhenzhong Duan wrote:
>>>> .. as "nopv" support needs it to be changeable at boot up stage.
>>>>
>>>> Checkpatch reports warning, so move variable declarations from
>>>> hypervisor.c to hypervisor.h
>>> []
>>>> diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
>>> []
>>>> @@ -259,7 +259,7 @@ static __init void xen_hvm_guest_late_init(void)
>>>>    #endif
>>>>    }
>>>>    
>>>> -const __initconst struct hypervisor_x86 x86_hyper_xen_hvm = {
>>>> +struct hypervisor_x86 x86_hyper_xen_hvm __initdata = {
>>>
>>> static?
>>
>> It is being referenced from arch/x86/kernel/cpu/hypervisor.c
> 
> But wasn't it also removed from the list of externs?
> 
> Rereading the .h file, no it wasn't.  I missed that.
> 
> Perhaps the extern list could be reordered to move this
> x86_hyper_xen_hvm to be next to x86_hyper_type.
> 
> I also suggest that "extern bool nopv" might be a bit
> non-specific and could use a longer identifier.

You are a little bit late. It has been this way since V5 of the series
posted on July 3rd.

I have pushed the series to my tree already and I'm about to send the
pull request.

Followup patches welcome. :-)


Juergen
