Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E603C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A812208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388181AbfGaNOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:14:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55382 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfGaNON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:14:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so60765464wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 06:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gz31ZtEBBBh4AY8YF3Nce0ldeOIawCcKF5dsmgirTKo=;
        b=iP7e6M3XWr6VcLq/xz/esLQV6MjZ5S8068ajcJkAR0GPkQEXgtJf3zpiZzkEvWymE4
         iodMGtGqhRbDTii/Btt8L2VFaM03DBITsf43RkZivWu5OImbjSq1qkEcrc4JU9EE+Jox
         odeCXcEvIR+INQHT70yaqWbpyBsWlXwT0CDINYUd2eEXwFY7Y4gsY3uzxMcgQBtXrSKy
         IWSeG40u9CsVJXg2BUg3Vx5tDpanCIsw7BZg7a8RNgVxn/2fpjN8X53odSyW0RFxjiUB
         /NW0WbvehDtjmLEc6cUMHVUHJcD9ex9X/sfM2womG0x8T5EqEKfRQGcpv+b9tkcbAOlz
         Zfyw==
X-Gm-Message-State: APjAAAVssZhFiOo91PWgaE45RpKEGPFqhSPXNOlGpDgLnfTZ1gLH8MzF
        leBOTgzpFbJ5oYHVpTH0544nQw==
X-Google-Smtp-Source: APXvYqzxyOAmJaEAf18YC/3zT9FnwwJPz0gNcTInqH52EdUefytW35XXucNbuuGattNqfWtufLo2xQ==
X-Received: by 2002:a1c:cb43:: with SMTP id b64mr6120739wmg.135.1564578851424;
        Wed, 31 Jul 2019 06:14:11 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b8sm62215395wrr.43.2019.07.31.06.14.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 06:14:10 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 1/3] KVM: Don't need to wakeup vCPU twice afer timer fire
In-Reply-To: <ab8f8b07-e3f9-4831-c386-0bfa0314f9c3@redhat.com>
References: <1564572438-15518-1-git-send-email-wanpengli@tencent.com> <ab8f8b07-e3f9-4831-c386-0bfa0314f9c3@redhat.com>
Date:   Wed, 31 Jul 2019 15:14:10 +0200
Message-ID: <87imri73dp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 31/07/19 13:27, Wanpeng Li wrote:
>> From: Wanpeng Li <wanpengli@tencent.com>
>> 
>> kvm_set_pending_timer() will take care to wake up the sleeping vCPU which 
>> has pending timer, don't need to check this in apic_timer_expired() again.
>
> No, it doesn't.  kvm_make_request never kicks the vCPU.
>

Hm, but kvm_set_pending_timer() currently looks like:

void kvm_set_pending_timer(struct kvm_vcpu *vcpu)
{
	kvm_make_request(KVM_REQ_PENDING_TIMER, vcpu);
	kvm_vcpu_kick(vcpu);
}

-- 
Vitaly
