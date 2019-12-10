Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FFDC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91722073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JeDe/GEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfLJRJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:09:09 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23104 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727482AbfLJRJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575997748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NXxho2+moB3q4emfPLCIy0aqQdPGESMV1WStV4dfJqw=;
        b=JeDe/GEgUJ5Aso0fDfvFMsjo/nfS4CJM7oqxGzGmPHicB1peM3L/HYmAPUy7lOJUhZBAVO
        FAFCuWuapa47bPUXRS5DNWzAu9sxvp/3SMWxXrULQVJAoueI/Bekj9r2bgqrF/KnJwndDv
        92sIrlNbP/lX7C4G3WiQX/gOb1wdEEc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-Ypvl_sQfNyCGYHpzn4i1pA-1; Tue, 10 Dec 2019 12:09:06 -0500
Received: by mail-wm1-f69.google.com with SMTP id z2so828758wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 09:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NXxho2+moB3q4emfPLCIy0aqQdPGESMV1WStV4dfJqw=;
        b=DPrQ9avORUvyxksM/a18DQroF0hxt30SBo5V5JiddTykheppJxPSQwNuhZw76axf/D
         3zTmTtxjzWsjtNHB43Y0qMUJUGePJMOUww4p7oGVQk1+rlwUKr8cMFWjY+PcHtZuG62Q
         W/zrPoXSvoD38UDyX5YY6TcSXLt6CP+PXRKMATyjOFXJJSsP+g0UdRT8pfQNYigsAI70
         6EQPRN9+qgLEnKjGPGDXi8T2Y+nVuC6VdWQiyAZrJWoyhKsfQbpQQuVpzgN/JqTJD7Vy
         s4skHLL1bCUT78WZs8QM+o280zDpQP4WX02MCtsHFhQtaTUCBgud8bSfWRDpvOwW54DZ
         vVrQ==
X-Gm-Message-State: APjAAAWWyR0w110qhx/H+QXFr+Rvi03pXRVyQXzDzbEGz4+YfQJW1+9t
        keXZAlAaIhd3Y/PdfZ/LjaJVGt1c2rzQ8gJ8w5MUL1VNCDdm6JU/J+vUKaZH+WP164P67e7b8Xa
        c/UVCBqoLOa2T0GauF6rWKDex
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr4374363wrx.145.1575997745409;
        Tue, 10 Dec 2019 09:09:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqy9nchDEcg45soiRcdejf+OOxAa804wXiUcBytrefwfUcCfNZpbSd7acrlluPxVsSWOCc39xA==
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr4374328wrx.145.1575997745044;
        Tue, 10 Dec 2019 09:09:05 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id z6sm3838566wmz.12.2019.12.10.09.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 09:09:04 -0800 (PST)
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
To:     Peter Xu <peterx@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <20191202201036.GJ4063@linux.intel.com> <20191202211640.GF31681@xz-x1>
 <20191202215049.GB8120@linux.intel.com>
 <fd882b9f-e510-ff0d-db43-eced75427fc6@redhat.com>
 <20191203184600.GB19877@linux.intel.com>
 <374f18f1-0592-9b70-adbb-0a72cc77d426@redhat.com>
 <20191209215400.GA3352@xz-x1>
 <affd9d84-1b84-0c25-c431-a075c58c33dc@redhat.com>
 <20191210155259.GD3352@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3e6cb5ec-66c0-00ab-b75e-ad2beb1d216d@redhat.com>
Date:   Tue, 10 Dec 2019 18:09:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191210155259.GD3352@xz-x1>
Content-Language: en-US
X-MC-Unique: Ypvl_sQfNyCGYHpzn4i1pA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/19 16:52, Peter Xu wrote:
> On Tue, Dec 10, 2019 at 11:07:31AM +0100, Paolo Bonzini wrote:
>>> I'm thinking whether I can start
>>> to use this information in the next post on solving an issue I
>>> encountered with the waitqueue.
>>>
>>> Current waitqueue is still problematic in that it could wait even with
>>> the mmu lock held when with vcpu context.
>>
>> I think the idea of the soft limit is that the waiting just cannot
>> happen.  That is, the number of dirtied pages _outside_ the guest (guest
>> accesses are taken care of by PML, and are subtracted from the soft
>> limit) cannot exceed hard_limit - (soft_limit + pml_size).
> 
> So the question go backs to, whether this is guaranteed somehow?  Or
> do you prefer us to keep the warn_on_once until it triggers then we
> can analyze (which I doubt..)?

Yes, I would like to keep the WARN_ON_ONCE just because you never know.

Of course it would be much better to audit the calls to kvm_write_guest
and figure out how many could trigger (e.g. two from the operands of an
emulated instruction, 5 from a nested EPT walk, 1 from a page walk, etc.).

> One thing to mention is that for with-vcpu cases, we probably can even
> stop KVM_RUN immediately as long as either the per-vm or per-vcpu ring
> reaches the softlimit, then for vcpu case it should be easier to
> guarantee that.  What I want to know is the rest of cases like ioctls
> or even something not from the userspace (which I think I should read
> more later..).

Which ioctls?  Most ioctls shouldn't dirty memory at all.

>>> And if we see if the mark_page_dirty_in_slot() is not with a vcpu
>>> context (e.g. kvm_mmu_page_fault) but with an ioctl context (those
>>> cases we'll use per-vm dirty ring) then it's probably fine.
>>>
>>> My planned solution:
>>>
>>> - When kvm_get_running_vcpu() != NULL, we postpone the waitqueue waits
>>>   until we finished handling this page fault, probably in somewhere
>>>   around vcpu_enter_guest, so that we can do wait_event() after the
>>>   mmu lock released
>>
>> I think this can cause a race:
>>
>> 	vCPU 1			vCPU 2		host
>> 	---------------------------------------------------------------
>> 	mark page dirty
>> 				write to page
>> 						treat page as not dirty
>> 	add page to ring
>>
>> where vCPU 2 skips the clean-page slow path entirely.
> 
> If we're still with the rule in userspace that we first do RESET then
> collect and send the pages (just like what we've discussed before),
> then IMHO it's fine to have vcpu2 to skip the slow path?  Because
> RESET happens at "treat page as not dirty", then if we are sure that
> we only collect and send pages after that point, then the latest
> "write to page" data from vcpu2 won't be lost even if vcpu2 is not
> blocked by vcpu1's ring full?

Good point, the race would become

 	vCPU 1			vCPU 2		host
 	---------------------------------------------------------------
 	mark page dirty
 				write to page
						reset rings
						  wait for mmu lock
 	add page to ring
	release mmu lock
						  ...do reset...
						  release mmu lock
						page is now dirty

> Maybe we can also consider to let mark_page_dirty_in_slot() return a
> value, then the upper layer could have a chance to skip the spte
> update if mark_page_dirty_in_slot() fails to mark the dirty bit, so it
> can return directly with RET_PF_RETRY.

I don't think that's possible, most writes won't come from a page fault
path and cannot retry.

Paolo

