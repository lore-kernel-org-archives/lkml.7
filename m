Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FBBC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C8B206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbfGaQkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:40:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39996 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbfGaQkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:40:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so70396108wrl.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 09:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XI06jTjz4+2NKP2BFSy4p2nkfAb+YDjyBM/JZqjZVIM=;
        b=ACw1s+I6MMWbiYCIdzWbj0ERGB890ivnzAf36UbHkJVbXZHAlHsvjMZ8MhnB30kZud
         FR5P+W4X5oQx9c9ChRQyXMwXXN1dbOGImJTJNWlzORKZFRHThTeKqFVaISk9LWvXK+8U
         pfNQg5/A2Vmo9ovLV69nkyXXYMB9D/DAbjPRzQJJDWNOJu2xd8ek6/khjCtw6RwfWMju
         vNKvOcgvEyC6oqMDnN2vMlV0gVGaDcYDF6RSQphsCLZyfU4hNZC0xHZubqrVVeh3BGPT
         Dzva5zl8Dyk7vVmV9G6OifNJ/lFY+Zr9ITTCOOzI0wJBwmV3MEVOCT2CIEUTn+63761Q
         J8Fg==
X-Gm-Message-State: APjAAAX+avgmIjuH/AWTKA7OBgj3b/5KghN3MSlyqv23/os+Hm6GYdGy
        ZS83Xd04hbGr6Qc59ZR3kw2veQ==
X-Google-Smtp-Source: APXvYqzGvsX8Ui9AnwLJ1T6O1kIB86uHMLmhVL+oWhIIY1U3ZwpCTgm/bsOd5xhk8P++HgN8/F2sNw==
X-Received: by 2002:adf:edd1:: with SMTP id v17mr50892863wro.348.1564591200457;
        Wed, 31 Jul 2019 09:40:00 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id b19sm48840224wmj.13.2019.07.31.09.39.59
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 09:39:59 -0700 (PDT)
Subject: Re: [PATCH 1/3] KVM: Don't need to wakeup vCPU twice afer timer fire
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1564572438-15518-1-git-send-email-wanpengli@tencent.com>
 <ab8f8b07-e3f9-4831-c386-0bfa0314f9c3@redhat.com>
 <87imri73dp.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a3c6d25e-8ede-695d-8f2d-632799c5fb1c@redhat.com>
Date:   Wed, 31 Jul 2019 18:39:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87imri73dp.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/19 15:14, Vitaly Kuznetsov wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 31/07/19 13:27, Wanpeng Li wrote:
>>> From: Wanpeng Li <wanpengli@tencent.com>
>>>
>>> kvm_set_pending_timer() will take care to wake up the sleeping vCPU which 
>>> has pending timer, don't need to check this in apic_timer_expired() again.
>>
>> No, it doesn't.  kvm_make_request never kicks the vCPU.
>>
> 
> Hm, but kvm_set_pending_timer() currently looks like:
> 
> void kvm_set_pending_timer(struct kvm_vcpu *vcpu)
> {
> 	kvm_make_request(KVM_REQ_PENDING_TIMER, vcpu);
> 	kvm_vcpu_kick(vcpu);
> }

Doing "git fetch" could have helped indeed.

Paolo

