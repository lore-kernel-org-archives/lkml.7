Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F4FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CD620706
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCjXXwZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKNPol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:44:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55753 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726567AbfKNPol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573746281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=srX8+tu6jTJ3Sc27i2QajGzqsOPbIfI99SC2CHnPWac=;
        b=eCjXXwZw81czXlHH6DHH6/zkg9HlAgNhFF/XQRNhk4sMAe9VwrUB9FzkDQS6iUFzUYicl2
        zG4Zr+LKMebzgTz1nPgvMn6KnxyeAiAEcqskTFJhZumB5vQ2XU9zMrETzaaaNFlsP1o1ga
        INhAqAw0hyw0PB1qc1LcAETEcP1sHiA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-vMS-c5_JNwaoCMaoh2H-dw-1; Thu, 14 Nov 2019 10:44:37 -0500
Received: by mail-wm1-f70.google.com with SMTP id f191so4151590wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 07:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EPJfk7cvgsr/qwib5eUrDTdAdQF5Fzm3xB/co9XZ6Ds=;
        b=d+ek8/BO85n3ZwM7AFdCDj39P+nyHwKuHs+ADbPPEDfFDAEVUSicMij8YHJskSi6F2
         goUUUiUhKZK3q1LkmYKDXtLQicJZYmuy2CU85jd+8bL8PwM6mBHmAphTFOzHiGwKWXcr
         dPz3rvFKtrXGfbsTeyJZURDUeiSACacvL/0H0MnNHq6AaxhbvUIQPN8/JgQyBt+jPu8P
         M31f8+zUEs0bk1dvrMLNTiQ3UlDLwFAr5tgT+qhB+SbNVhLGAenSO7kMCKURMAImUzoy
         1w9+YaMkBrpi00b83K+0rC74dto5U9MJkN5Yrl55BffVXYDyL999v37bblokUBzTDF19
         8rdw==
X-Gm-Message-State: APjAAAXeky5pNegp7x1qJ/jv+cWmt3y82d0bXNj4TDcHUcHdD+YUP/lP
        f6sZ/46LZ/7yvB5shi7YWwF5rMVvjOu3vgwiXzZ3w2r/rLYVMyzg9VQkcN/NVNahgVX1ucFD5P1
        6Mk4oQXlYOty43eT8iW15iPL1
X-Received: by 2002:a5d:6ac9:: with SMTP id u9mr8438286wrw.383.1573746276770;
        Thu, 14 Nov 2019 07:44:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqzqMn3KSNJtDpV0zpZnG0zQCePVxFOYVe2ZQbsb9HJAFswSYMqJVTNWAMHK7HVpYXG9Bm0l8g==
X-Received: by 2002:a5d:6ac9:: with SMTP id u9mr8438260wrw.383.1573746276484;
        Thu, 14 Nov 2019 07:44:36 -0800 (PST)
Received: from [192.168.43.81] (mob-109-112-119-76.net.vodafone.it. [109.112.119.76])
        by smtp.gmail.com with ESMTPSA id u16sm7942375wrr.65.2019.11.14.07.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 07:44:35 -0800 (PST)
Subject: Re: [PATCH 1/2] KVM: X86: Single target IPI fastpath
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1573283135-5502-1-git-send-email-wanpengli@tencent.com>
 <6c2c7bbb-39f4-2a77-632e-7730e9887fc5@redhat.com>
 <20191114152235.GC24045@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <857e6494-4ed8-be4a-c21a-577ab99a5711@redhat.com>
Date:   Thu, 14 Nov 2019 16:44:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191114152235.GC24045@linux.intel.com>
Content-Language: en-US
X-MC-Unique: vMS-c5_JNwaoCMaoh2H-dw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/19 16:22, Sean Christopherson wrote:
>> Instead of a separate vcpu->fast_vmexit, perhaps you can set exit_reason
>> to vmx->exit_reason to -1 if the fast path succeeds.
>=20
> Actually, rather than make this super special case, what about moving the
> handling into vmx_handle_exit_irqoff()?  Practically speaking that would
> only add ~50 cycles (two VMREADs) relative to the code being run right
> after kvm_put_guest_xcr0().  It has the advantage of restoring the host's
> hardware breakpoints, preserving a semi-accurate last_guest_tsc, and
> running with vcpu->mode set back to OUTSIDE_GUEST_MODE.  Hopefully it'd
> also be more intuitive for people unfamiliar with the code.

Yes, that's a good idea.  The expensive bit between handle_exit_irqoff
and handle_exit is srcu_read_lock, which has two memory barriers in it.


>>> +=09=09=09if (ret =3D=3D 0)
>>> +=09=09=09=09ret =3D kvm_skip_emulated_instruction(vcpu);
>> Please move the "kvm_skip_emulated_instruction(vcpu)" to
>> vmx_handle_exit, so that this basically is
>>
>> #define EXIT_REASON_NEED_SKIP_EMULATED_INSN -1
>>
>> =09if (ret =3D=3D 0)
>> =09=09vcpu->exit_reason =3D EXIT_REASON_NEED_SKIP_EMULATED_INSN;
>>
>> and handle_ipi_fastpath can return void.
>
> I'd rather we add a dedicated variable to say the exit has already been
> handled.  Overloading exit_reason is bound to cause confusion, and that's
> probably a best case scenario.

I proposed the fake exit reason to avoid a ternary return code from
handle_ipi_fastpath (return to guest, return to userspace, call
kvm_x86_ops->handle_exit), which Wanpeng's patch was mishandling.

To ensure confusion does not become the best case scenario, perhaps it
is worth trying to push exit_reason into vcpu_enter_guest's stack.
vcpu_enter_guest can pass a pointer to it, and then it can be passed
back into kvm_x86_ops->handle_exit{,_irqoff}.  It could be a struct too,
instead of just a bare u32.

This would ensure at compile-time that exit_reason is not accessed
outside the short path from vmexit to kvm_x86_ops->handle_exit.

Paolo

