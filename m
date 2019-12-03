Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42FDC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CC120409
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGYrc/2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfLCN7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:59:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59885 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726474AbfLCN7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575381560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SoDHsKfGXaF4SVOK9FpzJoN4EZym00SZYVVw6Skh79M=;
        b=hGYrc/2xb8PqApvxJsbabXTiZ+EFkkPWaRLqQui+HFEzajW/JU9xhMlIGGawM64EZCQ1sr
        z/we5/2Vn6Vs8EHsa3QjrVoRa8+l10QZ3HSh8U+wlTN/kzC40jtqFudXUxfg920dfXYjV0
        pYqdgAsmBpcLT+iY6ymXfSZD7D4TBvk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-dwxPde5DMC6aGhwgd-5DCA-1; Tue, 03 Dec 2019 08:59:17 -0500
Received: by mail-wm1-f69.google.com with SMTP id l11so1455602wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 05:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SoDHsKfGXaF4SVOK9FpzJoN4EZym00SZYVVw6Skh79M=;
        b=hvSIKtDW1u1HvzAp26+c9/3TPnEyf2Fy5JPeGR3Qub8JFUWBn0M5lMH85RNqbalf0g
         eoWZtAapVL5oTR8PdJ+XOLF28Bqx89k1DfSoDL8Vygtk6XcLo37q06B2SWTTQPHiuADG
         JierjgcTcQNSI3auUqY7g2zOClkYijFRqew7XJ2U6Hk14NdV2wwdf0qjg/+CJ181T+BA
         QfqzEa6dfx5C85gMj/OtSTGOSpC+Lb6L2ulJf8h/Oph9jdQhf/5iu9SLEa3jllA3cK2F
         6L1V/tLAnpHm79xrlps60AWlckc5XB133WNmfoFkpHn7YraIEw4f3BO/gpPT3jBaezIs
         zDLA==
X-Gm-Message-State: APjAAAUHJzim02dX6gz6PlCQtG4JKXtChQYIpidYO11YOuy+4smEibfb
        ZbVG1dt+2MKrtRVqbWKfL5seYToLJKz5d2tc/qo7GLdBzfcQrNGUMk+O4N6a/jVMAwU7ERBGNVR
        p/USo/MMxLQ4l/7ccDzFsaHMv
X-Received: by 2002:a1c:9cce:: with SMTP id f197mr28970906wme.133.1575381556175;
        Tue, 03 Dec 2019 05:59:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqwNaGQEu1cfoctJHTQunT9pwM3nITR9w5ShT2vg8Npr4Cp5hfb8lnoJ1/v1m+J+ydgbO3E4VA==
X-Received: by 2002:a1c:9cce:: with SMTP id f197mr28970883wme.133.1575381555838;
        Tue, 03 Dec 2019 05:59:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a? ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
        by smtp.gmail.com with ESMTPSA id d12sm3629784wrp.62.2019.12.03.05.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 05:59:15 -0800 (PST)
Subject: Re: [PATCH RFC 00/15] KVM: Dirty ring interface
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
 <b8f28d8c-2486-2d66-04fd-a2674b598cfd@redhat.com>
 <20191202021337.GB18887@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b893745e-96c1-d8e4-85ec-9da257d0d44e@redhat.com>
Date:   Tue, 3 Dec 2019 14:59:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191202021337.GB18887@xz-x1>
Content-Language: en-US
X-MC-Unique: dwxPde5DMC6aGhwgd-5DCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/19 03:13, Peter Xu wrote:
>> This is not needed, it will just be a false negative (dirty page that
>> actually isn't dirty).  The dirty bit will be cleared when userspace
>> resets the ring buffer; then the instruction will be executed again and
>> mark the page dirty again.  Since ring full is not a common condition,
>> it's not a big deal.
> 
> Actually I added this only because it failed one of the unit tests
> when verifying the dirty bits..  But now after a second thought, I
> probably agree with you that we can change the userspace too to fix
> this.

I think there is already a similar case in dirty_log_test when a page is
dirty but we called KVM_GET_DIRTY_LOG just before it got written to.

> I think the steps of the failed test case could be simplified into
> something like this (assuming the QEMU migration context, might be
> easier to understand):
> 
>   1. page P has data P1
>   2. vcpu writes to page P, with date P2
>   3. vmexit (P is still with data P1)
>   4. mark P as dirty, ring full, user exit
>   5. collect dirty bit P, migrate P with data P1
>   6. vcpu run due to some reason, P was written with P2, user exit again
>      (because ring is already reaching soft limit)
>   7. do KVM_RESET_DIRTY_RINGS

Migration should only be done after KVM_RESET_DIRTY_RINGS (think of
KVM_RESET_DIRTY_RINGS as the equivalent of KVM_CLEAR_DIRTY_LOG).

>   dirty_log_test-29003 [001] 184503.384328: kvm_entry:            vcpu 1
>   dirty_log_test-29003 [001] 184503.384329: kvm_exit:             reason EPT_VIOLATION rip 0x40359f info 582 0
>   dirty_log_test-29003 [001] 184503.384329: kvm_page_fault:       address 7fc036d000 error_code 582
>   dirty_log_test-29003 [001] 184503.384331: kvm_entry:            vcpu 1
>   dirty_log_test-29003 [001] 184503.384332: kvm_exit: reason EPT_VIOLATION rip 0x40359f info 582 0
>   dirty_log_test-29003 [001] 184503.384332: kvm_page_fault:       address 7fc036d000 error_code 582
>   dirty_log_test-29003 [001] 184503.384332: kvm_dirty_ring_push:  ring 1: dirty 0x37f reset 0x1c0 slot 1 offset 0x37e ret 0 (used 447)
>   dirty_log_test-29003 [001] 184503.384333: kvm_entry:            vcpu 1
>   dirty_log_test-29003 [001] 184503.384334: kvm_exit:             reason EPT_VIOLATION rip 0x40359f info 582 0
>   dirty_log_test-29003 [001] 184503.384334: kvm_page_fault:       address 7fc036e000 error_code 582
>   dirty_log_test-29003 [001] 184503.384336: kvm_entry:            vcpu 1
>   dirty_log_test-29003 [001] 184503.384336: kvm_exit:             reason EPT_VIOLATION rip 0x40359f info 582 0
>   dirty_log_test-29003 [001] 184503.384336: kvm_page_fault:       address 7fc036e000 error_code 582
>   dirty_log_test-29003 [001] 184503.384337: kvm_dirty_ring_push:  ring 1: dirty 0x380 reset 0x1c0 slot 1 offset 0x37f ret 1 (used 448)
>   dirty_log_test-29003 [001] 184503.384337: kvm_dirty_ring_exit:  vcpu 1
>   dirty_log_test-29003 [001] 184503.384338: kvm_fpu:              unload
>   dirty_log_test-29003 [001] 184503.384340: kvm_userspace_exit:   reason 0x1d (29)
>   dirty_log_test-29000 [006] 184503.505103: kvm_dirty_ring_reset: ring 1: dirty 0x380 reset 0x380 (used 0)
>   dirty_log_test-29003 [001] 184503.505184: kvm_fpu:              load
>   dirty_log_test-29003 [001] 184503.505187: kvm_entry:            vcpu 1
>   dirty_log_test-29003 [001] 184503.505193: kvm_exit:             reason EPT_VIOLATION rip 0x40359f info 582 0
>   dirty_log_test-29003 [001] 184503.505194: kvm_page_fault:       address 7fc036f000 error_code 582              <-------- [1]
>   dirty_log_test-29003 [001] 184503.505206: kvm_entry:            vcpu 1
>   dirty_log_test-29003 [001] 184503.505207: kvm_exit:             reason EPT_VIOLATION rip 0x40359f info 582 0
>   dirty_log_test-29003 [001] 184503.505207: kvm_page_fault:       address 7fc036f000 error_code 582
>   dirty_log_test-29003 [001] 184503.505226: kvm_dirty_ring_push:  ring 1: dirty 0x381 reset 0x380 slot 1 offset 0x380 ret 0 (used 1)
>   dirty_log_test-29003 [001] 184503.505226: kvm_entry:            vcpu 1
>   dirty_log_test-29003 [001] 184503.505227: kvm_exit:             reason EPT_VIOLATION rip 0x40359f info 582 0
>   dirty_log_test-29003 [001] 184503.505228: kvm_page_fault:       address 7fc0370000 error_code 582
>   dirty_log_test-29003 [001] 184503.505231: kvm_entry:            vcpu 1
>   ...
> 
> The test was trying to continuously write to pages, from above log
> starting from 7fc036d000. The reason 0x1d (29) is the new dirty ring
> full exit reason.
> 
> So far I'm still unsure of two things:
> 
>   1. Why for each page we faulted twice rather than once.  Take the
>      example of page at 7fc036e000 above, the first fault didn't
>      trigger the marking dirty path, while only until the 2nd ept
>      violation did we trigger kvm_dirty_ring_push.

Not sure about that.  Try enabling kvmmmu tracepoints too, it will tell
you more of the path that was taken while processing the EPT violation.

If your machine has PML, what you're seeing is likely not-present
violation, not dirty-protect violation.  Try disabling pml and see if
the trace changes.

>   2. Why we didn't get the last page written again after
>      kvm_userspace_exit (last page was 7fc036e000, and the test failed
>      because 7fc036e000 detected change however dirty bit unset).  In
>      this case the first write after KVM_RESET_DIRTY_RINGS is the line
>      pointed by [1], I thought it should be a rewritten of page
>      7fc036e000 because when the user exit happens logically the write
>      should not happen yet and eip should keep.  However at [1] it's
>      already writting to a new page.

IIUC you should get, with PML enabled:

- guest writes to page
- PML marks dirty bit, causes vmexit
- host copies PML log to ring, causes userspace exit
- userspace calls KVM_RESET_DIRTY_RINGS
  - host marks page as clean
- userspace calls KVM_RUN
  - guest writes again to page

but the page won't be in the ring until after another vmexit happens.
Therefore, it's okay to reap the pages in the ring asynchronously, but
there must be a synchronization point in the testcase sooner or later,
where all CPUs are kicked out of KVM_RUN.  This synchronization point
corresponds to the migration downtime.

Thanks,

Paolo

