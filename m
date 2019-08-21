Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773A0C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B5022D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfHUHzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:55:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfHUHzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:55:46 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7EBA07BDA7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:55:46 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id s18so830596wrt.21
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 00:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4vtDy+oYLccEJv8Sb5ysrn3Ll8TQTjQAuhILZtXY+9Y=;
        b=ke6SzsuRsJBuTCqmr1P610alFwd/Eu+QGheCEhHo2MPWVemx73zj08CT1W3PZn5hsZ
         CUILYAvPM5y/z7R0I5ItcgvvKZtmChsQ0PNrTETsNH80M5JYRVhvv9C892DonlBUgkDL
         GmoqDdVFyY58+Vg9kyozXCg4i5PQDk+6s3mmUYawfouYvhVVrR27f3tQhySiTktP3c8Q
         6QakmtH4AcRU4M2/rgNjAZblSgKugxKZ82zBOVoSK1/p78wl8JIzE/WrGBqk9bflYUwI
         IO4eB38Ppb7Hi5NlCRXqYpmbyQ+i5E24xGNc++tZWOIPuhqGg5HTquGZ5Qye4qq5aCaV
         p0Yw==
X-Gm-Message-State: APjAAAXwECo2b+/ue0uGCmsRDiXexbYizHAuTZQAgIJDwFfgjLmFL0Bl
        dpIxIV+bE+uFQRDyPc8t93M4EeMmDkL9+a6kMzfoqr9xfd0icbXbOUV6ssKqDn2SudHQjOD/c4t
        bJUTj2z3BnD3pYrY6uTADCv6j
X-Received: by 2002:a05:600c:2292:: with SMTP id 18mr4365234wmf.156.1566374145081;
        Wed, 21 Aug 2019 00:55:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxPOU17u3ZFYZ4bFYLjxyE5sHSLsZn1vvHBoeWKtl1lscdeLHgbtn5lCkRgGZUrPGmi4kuUpQ==
X-Received: by 2002:a05:600c:2292:: with SMTP id 18mr4365223wmf.156.1566374144777;
        Wed, 21 Aug 2019 00:55:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:56e1:adff:fed9:caf0? ([2001:b07:6468:f312:56e1:adff:fed9:caf0])
        by smtp.gmail.com with ESMTPSA id f10sm17994990wrm.31.2019.08.21.00.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2019 00:55:44 -0700 (PDT)
Subject: Re: [PATCH RESEND] i386/kvm: support guest access CORE cstate
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>
References: <1563154124-18579-1-git-send-email-wanpengli@tencent.com>
 <ba3ae595-7f82-d17b-e8ed-6e86e9195ce5@redhat.com>
 <CANRm+Cx1bEOXBx50K9gv08UWEGadKOCtCbAwVo0CFC-g1gS+Xg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <82a0eb75-5710-3b03-cf8e-a00b156ee275@redhat.com>
Date:   Wed, 21 Aug 2019 09:55:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANRm+Cx1bEOXBx50K9gv08UWEGadKOCtCbAwVo0CFC-g1gS+Xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/19 09:16, Wanpeng Li wrote:
> Kindly reminder, :)

It's already in my pull request from yesterday.

Palo

> On Mon, 15 Jul 2019 at 17:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 15/07/19 03:28, Wanpeng Li wrote:
>>> From: Wanpeng Li <wanpengli@tencent.com>
>>>
>>> Allow guest reads CORE cstate when exposing host CPU power management capabilities
>>> to the guest. PKG cstate is restricted to avoid a guest to get the whole package
>>> information in multi-tenant scenario.
>>>
>>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>>
>> Hi,
>>
>> QEMU is in hard freeze now.  This will be applied after the release.
>>
>> Thanks,
>>
>> Paolo
>>
>>> ---
>>>  linux-headers/linux/kvm.h | 4 +++-
>>>  target/i386/kvm.c         | 3 ++-
>>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
>>> index b53ee59..d648fde 100644
>>> --- a/linux-headers/linux/kvm.h
>>> +++ b/linux-headers/linux/kvm.h
>>> @@ -696,9 +696,11 @@ struct kvm_ioeventfd {
>>>  #define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
>>>  #define KVM_X86_DISABLE_EXITS_HLT            (1 << 1)
>>>  #define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
>>> +#define KVM_X86_DISABLE_EXITS_CSTATE         (1 << 3)
>>>  #define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT | \
>>>                                                KVM_X86_DISABLE_EXITS_HLT | \
>>> -                                              KVM_X86_DISABLE_EXITS_PAUSE)
>>> +                                              KVM_X86_DISABLE_EXITS_PAUSE | \
>>> +                                              KVM_X86_DISABLE_EXITS_CSTATE)
>>>
>>>  /* for KVM_ENABLE_CAP */
>>>  struct kvm_enable_cap {
>>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>>> index 3b29ce5..49a0cc1 100644
>>> --- a/target/i386/kvm.c
>>> +++ b/target/i386/kvm.c
>>> @@ -1645,7 +1645,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>>          if (disable_exits) {
>>>              disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
>>>                                KVM_X86_DISABLE_EXITS_HLT |
>>> -                              KVM_X86_DISABLE_EXITS_PAUSE);
>>> +                              KVM_X86_DISABLE_EXITS_PAUSE |
>>> +                              KVM_X86_DISABLE_EXITS_CSTATE);
>>>          }
>>>
>>>          ret = kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
>>>
>>

