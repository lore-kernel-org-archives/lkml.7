Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98886C2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4B3205ED
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xq8xOvhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfLEKQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:16:24 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32849 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbfLEKQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575540982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oCu+v7Ov3efBPpGgrHHDYgqYZqM3nvcg/fPq5Gsmc/Q=;
        b=Xq8xOvhEcG/FdupFrm+IsiGvo/9PTAzfT017avaqWGwdR0EchTRDM2WRv1xIYUuGsB1C9H
        K2H91v8bA2XQnkBHczKJUpxZo3IsAGkV08rCGUdRBaiP72s7mr00WxkCFzT/MRRfxTXBvf
        pGWcddb2HdrYMReq47aj7ycNxrgI/Uo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-ShB98dJGMjC8RdAxzr9idg-1; Thu, 05 Dec 2019 05:16:19 -0500
Received: by mail-wr1-f70.google.com with SMTP id w6so1303992wrm.16
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 02:16:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oCu+v7Ov3efBPpGgrHHDYgqYZqM3nvcg/fPq5Gsmc/Q=;
        b=Sm2HT93C/o9p+lEQM20LgfMxufjcX3RYw8oNryxY+TGZyMvlqnQQC6g47t/EU2OC6E
         mmhUpql9Hze7fA2dnH7BPsHzLF1kIIkcKZogt+XKYVIoZ7afOkDzNjXRQVvjdngHMCC3
         CJVt+DSzix5YdLRe0BRdzDJ4Y1LrjLxS24Hyv+HNrw5Sc1Fdgl2pjsOa9CJN8m1kUlj6
         N3ffHVro7FFCXEZyJi6eevFCkAjE+fc3nXMjbazymHC//JknfbVsxbffBclkL66Sk1M/
         zeD2hIW0sUCVOCzWfGwtOGGsksWs6RMoaOp+6a6AEbmxpsPqjKSyio7f2/cmNXGrh1bC
         2xvg==
X-Gm-Message-State: APjAAAVk7h8n2fT+TsUpmBcdu+q8ap/SYhn4vKYbcc68HlBY3BStU4Og
        v462i2ExjBsVJLacAMGgN8Dpw5aiI7OcS1BvxXbwov04M+z5QMDxf1T5IZTJiQBn0FaOb6ezHIP
        P70+Q6bDb1SWz2Avvw9czqoCA
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr9807360wrq.232.1575540977651;
        Thu, 05 Dec 2019 02:16:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6dzszP8w8p/bgdrENDTQp3RYlrXCG812A+kw447RAi90Njay97UlqFJCBmx5nQMLIEbcfZw==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr9807334wrq.232.1575540977425;
        Thu, 05 Dec 2019 02:16:17 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:541f:a977:4b60:6802? ([2001:b07:6468:f312:541f:a977:4b60:6802])
        by smtp.gmail.com with ESMTPSA id a64sm10949477wmc.18.2019.12.05.02.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 02:16:16 -0800 (PST)
Subject: Re: [PATCH 4/5] KVM: vmx: implement MSR_IA32_TSX_CTRL disable RTM
 functionality
To:     Jim Mattson <jmattson@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <1574101067-5638-1-git-send-email-pbonzini@redhat.com>
 <1574101067-5638-5-git-send-email-pbonzini@redhat.com>
 <CALMp9eTKMzg2pNEZxhqAejAquFg8NxKRrBzzNUKRY78JLGjS5A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0653777-55c6-ebb9-7be7-5bdd259b66fa@redhat.com>
Date:   Thu, 5 Dec 2019 11:16:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CALMp9eTKMzg2pNEZxhqAejAquFg8NxKRrBzzNUKRY78JLGjS5A@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: ShB98dJGMjC8RdAxzr9idg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/19 00:49, Jim Mattson wrote:
>>         if (!boot_cpu_has(X86_FEATURE_RTM))
>> -               data &= ~ARCH_CAP_TAA_NO;
>> +               data &= ~(ARCH_CAP_TAA_NO | ARCH_CAP_TSX_CTRL_MSR);
>>         else if (!boot_cpu_has_bug(X86_BUG_TAA))
>>                 data |= ARCH_CAP_TAA_NO;
>> -       else if (data & ARCH_CAP_TSX_CTRL_MSR)
>> -               data &= ~ARCH_CAP_MDS_NO;
>>
>> -       /* KVM does not emulate MSR_IA32_TSX_CTRL.  */
>> -       data &= ~ARCH_CAP_TSX_CTRL_MSR;
> Shouldn't kvm be masking off any bits that it doesn't know about here?
> Who knows what future features we may claim to support?

Good question, in the past the ARCH_CAPABILITIES were just "we don't
have this bug" so it made sense to pass everything through.  Now we have
TSX_CTRL that is of a different kind and arguably should have been a
CPUID bit, so we should indeed mask unknown capabilties.

Paolo

