Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1537BC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E122F20679
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/mYD8FU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389916AbfJAQ2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:28:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37307 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfJAQ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:28:49 -0400
Received: by mail-io1-f65.google.com with SMTP id b19so21458025iob.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 09:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UuSvIeEi8G20VLcW5Ido12eQq9cZKtBnUP6W2ckvkM0=;
        b=q/mYD8FUxD+U042+JO6vPaG+9STDLSueo96mUhMwNjNiAOEf+/9FjDhmcf0lvNeDyo
         ZlssgVG8+Sj9PB+DCB1RZDRAVyhsLkoW0LRz0zGfJL4OZGO6RjcYnWiCthKtga5Q6rMM
         5Ylygng9dVxGxXV53b0ZHgEIn7mYCkCcMrQ6z2HUPlDcYiVCgiCs3DDJFVcMjKPToxBh
         sA6qXsV/9qVGqkScjkpH2hnonQUw2Dg6hdgJ2Bhiemod0jd9pG0DklXhcURT91cuDtug
         gcntbWDAkaHS1oAQCwYy/KVLcATYtMqPofPNRg8L4/UIJEenRB7Br36HRkgiW/+6N0Ig
         BGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UuSvIeEi8G20VLcW5Ido12eQq9cZKtBnUP6W2ckvkM0=;
        b=UTfiJg9izKhH9aWHiN6jzL+fj5PyIWH4TN1Hm7RzhUFZsXKHhbKGEgtSXpRu++fXXT
         kIJlJ9jEZZgBAp3ocX4y33Sk4hbma98wxxM31uxTJSDLkq7jDDFm4B5WUoZulVfDnHQr
         sUwqYIcVm/Hmi8lrlXjS7Z76XNSUeAatwnsVWCQ7TTxNWccyX5vkJuyvYh2aB5v4t+Kc
         d9U/oliTEtuhxCfs6XVZdVY3HzwDKd7O9xLOr4AKyzzqwJXYWLKuiCiiMAa6Kjo82zCh
         vu5RRIEZ4NSlmacJ++5L0MeGA/uJARHKuQ01KLnzWNS6bKOb3W85KfGKmUfI0usQ4HjX
         JNfA==
X-Gm-Message-State: APjAAAXrww9MMohuZG2ipYGeGR8gonVKpExVaGp7mRkaloTaESU/Ntrn
        pteEDV85aqa+GD6ADnYoOFYNXt7K0Ig1VYB2YaDz+g==
X-Google-Smtp-Source: APXvYqx7oohTB0nR7IB9oZL2Nl6qSGUU3K3j39VIdFW99cCivWQmR8DtaLDroXZSXCwBvDHTq/pp2UDsEzLx+NEWADE=
X-Received: by 2002:a92:4a0d:: with SMTP id m13mr25937997ilf.119.1569947328519;
 Tue, 01 Oct 2019 09:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191001162123.26992-1-sean.j.christopherson@intel.com>
In-Reply-To: <20191001162123.26992-1-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 1 Oct 2019 09:28:37 -0700
Message-ID: <CALMp9eT+kkdrDhHW4QHaSHQOeXnpcE2Quhd=kOhZq_y6ydjdJA@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Fix consistency check on injected exception
 error code
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 9:21 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Current versions of Intel's SDM incorrectly state that "bits 31:15 of
> the VM-Entry exception error-code field" must be zero.  In reality, bits
> 31:16 must be zero, i.e. error codes are 16-bit values.
>
> The bogus error code check manifests as an unexpected VM-Entry failure
> due to an invalid code field (error number 7) in L1, e.g. when injecting
> a #GP with error_code=0x9f00.
>
> Nadav previously reported the bug[*], both to KVM and Intel, and fixed
> the associated kvm-unit-test.
>
> [*] https://patchwork.kernel.org/patch/11124749/
>
> Reported-by: Nadav Amit <namit@vmware.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
