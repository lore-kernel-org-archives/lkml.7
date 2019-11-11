Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181C7C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19A5206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acgerPF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfKKTPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:15:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27637 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726949AbfKKTPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573499730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=MXbL31P0IYDtqcq6qHdukj+j63qKz90Nd8tCQFpdhYo=;
        b=acgerPF5RkzfENb3GI1cQze41lalopINVAf2FR8a19TcPpYcTGdEWaCCOK3880LKpnGZlY
        OsbjR6Ur9w1H7e+vFL1LoDtVdozenGWu7y7yXYk39zC21EkFX4unPSPItBt+BPaAH94Ky+
        3dZgrmcsp7J1khcBJc1UwI2fy2VSSco=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-iJAPnOwNNAOn_9Fnph2LcQ-1; Mon, 11 Nov 2019 14:15:29 -0500
Received: by mail-wr1-f71.google.com with SMTP id q12so2666044wrr.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 11:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MXbL31P0IYDtqcq6qHdukj+j63qKz90Nd8tCQFpdhYo=;
        b=izG0au6+kDJWeLDHMo1JgcKUzY2XhVnSSMBOL4n80bGqlSn3OrvyRBmV7bjzKK9q7p
         aM1fSnQbjMLqzP0Q+O5M69JJ80efbNC6sRVAPjfLmORMGCR7xSIFVPNKFkYkn+eqTU4V
         76TIHrK3jCuBCRpS4Cm7xJ1PNz6D0GHrF3LxvO0f0iPi3UOzWg9flf5jKtrLAcd/ebl/
         zNyCMEmxIStOJKbONPTHo+LNib9HTjX+y+5admR2TFDP4Zx39V4iG3JrCQG7X2k4zX4x
         9REJdTxPajVPmU2EV1F2cG4FNllmWGE3FtDZwDmrVrYwa7VyPsOEyGK9tdYyz+o+6IRO
         BxCA==
X-Gm-Message-State: APjAAAWxyzyUVNByuwAHZ0ZO3Z2tvZYg8FdVbRqREWD2hZKLLpQ/c1DD
        0S8eCrkYOJ0Qnm7blj1i0NEwrCICz1CcuiVt2aAb1Tdgh4IDSFMjOp3hUG19cUk6Um7kaCXA9qB
        J71Z3XrBJrw9FnERkOvaYflk2
X-Received: by 2002:adf:9786:: with SMTP id s6mr16010293wrb.188.1573499727513;
        Mon, 11 Nov 2019 11:15:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwMA0iXMYBtSAK6xNIx73LEz/q0H0IE8ruho9T5MZSF3Oq1lrSQVESW1HPGLguBk1ORuT4PRw==
X-Received: by 2002:adf:9786:: with SMTP id s6mr16010258wrb.188.1573499726976;
        Mon, 11 Nov 2019 11:15:26 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8c9d:1a6f:4730:367c? ([2001:b07:6468:f312:8c9d:1a6f:4730:367c])
        by smtp.gmail.com with ESMTPSA id b17sm17965088wru.36.2019.11.11.11.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 11:15:26 -0800 (PST)
Subject: Re: [PATCH 1/2] KVM: MMU: Do not treat ZONE_DEVICE pages as being
 reserved
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        David Hildenbrand <david@redhat.com>
References: <1cf71906-ba99-e637-650f-fc08ac4f3d5f@redhat.com>
 <CAPcyv4hMOxPDKAZtTvWKEMPBwE_kPrKPB_JxE2YfV5EKkKj_dQ@mail.gmail.com>
 <20191106233913.GC21617@linux.intel.com>
 <CAPcyv4jysxEu54XK2kUYnvTqUL7zf2fJvv7jWRR=P4Shy+3bOQ@mail.gmail.com>
 <CAPcyv4i3M18V9Gmx3x7Ad12VjXbq94NsaUG9o71j59mG9-6H9Q@mail.gmail.com>
 <0db7c328-1543-55db-bc02-c589deb3db22@redhat.com>
 <CAPcyv4gMu547patcROaqBqbwxut5au-WyE_M=XsKxyCLbLXHTg@mail.gmail.com>
 <20191107155846.GA7760@linux.intel.com>
 <20191109014323.GB8254@linux.intel.com>
 <CAPcyv4hAY_OfExNP+_067Syh9kZAapppNwKZemVROfxgbDLLYQ@mail.gmail.com>
 <20191111182750.GE11805@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <707ce7d4-7149-f4c4-c150-801962a3197d@redhat.com>
Date:   Mon, 11 Nov 2019 20:15:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191111182750.GE11805@linux.intel.com>
Content-Language: en-US
X-MC-Unique: iJAPnOwNNAOn_9Fnph2LcQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/19 19:27, Sean Christopherson wrote:
>> Thanks for this clarification. I do want to put out though that
>> ZONE_DEVICE pages go idle, they don't get freed. As long as KVM drops
>> its usage on invalidate it's perfectly fine for KVM to operate on idle
>> ZONE_DEVICE pages. The common case is that ZONE_DEVICE pages are
>> accessed and mapped while idle. Only direct-I/O temporarily marks them
>> busy to synchronize with invalidate. KVM obviates that need by
>> coordinating with mmu-notifiers instead.
> Only the KVM MMU, e.g. page fault handler, coordinates via mmu_notifier,
> the kvm_vcpu_map() case would continue using pages across an invalidate.

Yes, and it gets/puts the page correctly.

Paolo

