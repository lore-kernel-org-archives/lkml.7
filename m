Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFB3C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F65206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6YcPugo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfLWRqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 12:46:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31659 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726754AbfLWRqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 12:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577123164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NyxEGXEk4VTpodZFpXSFYVpF4fMlWUtWZMOhYuzQAMg=;
        b=H6YcPugoPc5I8Ua5GS0EdWVcg3H4gSEfyb3npKn+kN92hR3WV6cl1J1/pH4CkAYGnYSvpi
        m4c9enjYVZdzCWajJzac7SMxDw0kfD6JP0qXCQYc6J8IRAEHo82ppwkFULi/TSO/2Ja5hp
        mMlQrFYrK1NSJMbVXuW640KZFRUIbCo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-_cGaeSlrMemfSCO1gM3Kwg-1; Mon, 23 Dec 2019 12:46:03 -0500
X-MC-Unique: _cGaeSlrMemfSCO1gM3Kwg-1
Received: by mail-wr1-f71.google.com with SMTP id w6so7152285wrm.16
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 09:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NyxEGXEk4VTpodZFpXSFYVpF4fMlWUtWZMOhYuzQAMg=;
        b=MlwbWg/HbJgkipoDhzjPicjq9DEC8IXBQhcz/euzY0drS8W36uuIVGNAQCwRrUWAUy
         /paw3OkIq0FLrf2TS/6HeVCCLAX4Du/jPj+G5GXxUrjdFaVFKWKTLhXxr1g9cYDEEuiX
         p+4eSmsRJRtHTsqVtpWwCw1vZQQSI9JZILFm/KgB5cV9HYRnllcF4ZNYfH3l0QW3JrBt
         zNfZglqZa3yJH9x3K9xiEN4ysPgGuWbPF8uCAJQdaXX7sNMtsxK99JjXDslckdPaeGkB
         RusqM8ag/G+FYp/A7+vTDY2A57Ox8O0dIGtbkcuL0mIFiqiyqFS//tcAIf2PtXaZgsgf
         flbg==
X-Gm-Message-State: APjAAAUFNvXVQBU9A9aZiHXXyyUVORPpFR581BR2Z/zX2GD6RdR127rS
        WCT9Q34Dlk63c7mMf75rbynPSEV3sMLp+MP289c7kQm0KpVlZJfUT37mClwPZYVphRUJM9slH8G
        LrTTvRZteXOklKTqiQUCyvtVG
X-Received: by 2002:adf:81e3:: with SMTP id 90mr30839591wra.23.1577123162145;
        Mon, 23 Dec 2019 09:46:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZUjyHS0g/ecWSSGHeVn7Xac4ocH5nlnwcKETpadWsN+v9wPYW7uWyeK4z2lEr812dsaBq4A==
X-Received: by 2002:adf:81e3:: with SMTP id 90mr30839577wra.23.1577123161885;
        Mon, 23 Dec 2019 09:46:01 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ac09:bce1:1c26:264c? ([2001:b07:6468:f312:ac09:bce1:1c26:264c])
        by smtp.gmail.com with ESMTPSA id u24sm124844wml.10.2019.12.23.09.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2019 09:46:01 -0800 (PST)
Subject: Re: [RESEND RFC 0/2] Paravirtualized Control Register pinning
To:     Liran Alon <liran.alon@oracle.com>
Cc:     John Andersen <john.s.andersen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20191220192701.23415-1-john.s.andersen@intel.com>
 <1EBCD42E-9109-47A1-B959-6363A509D48D@oracle.com>
 <15b57d6b-0f46-01f5-1f75-b9b55db0611a@redhat.com>
 <03F5FE31-E769-4497-922B-C8613F0951FA@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f4d3d392-8edf-54b2-1b90-417447240e22@redhat.com>
Date:   Mon, 23 Dec 2019 18:46:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <03F5FE31-E769-4497-922B-C8613F0951FA@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/19 18:28, Liran Alon wrote:
>>> Why reset CR pinned MSRs by userspace instead of KVM INIT
>>> handling?
>> Most MSRs are not reset by INIT, are they?
>> 
>> Paolo
>> 
> MSR_KVM_SYSTEM_TIME saved in vcpu->arch.time is reset at
> kvmclock_reset() which is called by kvm_vcpu_reset() (KVM INIT
> handler). In addition, vmx_vcpu_reset(), called from
> kvm_vcpu_reset(), also resets multiple MSRs such as:
> MSR_IA32_SPEC_CTRL (vmx->spec_ctrl) and MSR_IA32_UMWAIT_CONTROL
> (msr_ia32_umwait_control).

These probably can be removed, since they are zero at startup and at
least SPEC_CTRL is documented[1] to be unaffected by INIT.  However, I
couldn't find information about UMWAIT_CONTROL.

> Having said that, I see indeed that most of MSRs are being set by
> QEMU in kvm_put_msrs() when level >= KVM_PUT_RESET_STATE. When is
> triggered by qemu_system_reset() -> cpu_synchronize_all_post_reset ->
> cpu_synchronize_post_reset() -> kvm_cpu_synchronize_post_reset().
> 
> So given current design, OK I agree with you that CR pinned MSRs
> should be zeroed by userspace VMM.
> 
> It does though seems kinda weird to me that part of CPU state is
> initialised on KVM INIT handler and part of it in userspace VMM. It
> could lead to inconsistent (i.e. diverging from spec) CPU behaviour.

The reason for that is the even on real hardware INIT does not touch
most MSRs:

  9.1 Initialization overview

  Asserting the INIT# pin on the processor invokes a similar response to
  a hardware reset. The major difference is that during an INIT, the
  internal caches, MSRs, MTRRs, and x87 FPU state are left unchanged
  (although, the TLBs and BTB are invalidated as with a hardware reset).
  An INIT provides a method for switching from protected to real-address
  mode while maintaining the contents of the internal caches.

Paolo

[1]
https://software.intel.com/security-software-guidance/api-app/sites/default/files/336996-Speculative-Execution-Side-Channel-Mitigations.pdf

