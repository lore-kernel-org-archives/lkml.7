Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE6DC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E395D206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZpObk7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKNRPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:15:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26373 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726410AbfKNRPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573751741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=gbTdjtPW0MKQv7Yl30zpGVmoWK5fxqvC+dh3W0bxxkg=;
        b=dZpObk7slTJptKcEM6/twMH0MUVKRww9vvglVA8lf5vVoEZpBgNGmCRz/qMG+FhVpLn1bD
        XCbRUUsptZpIhxP2shoysPLv/605z1OsBdb/eX47YjKbpaslrq1F6hjl9Vv1mjO5Bpe9Xa
        Qp/7lTsnSYs7k56BP6uh2f10hnVSdgk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-YHmy6cM1OVa-smqFjLkBdA-1; Thu, 14 Nov 2019 12:15:39 -0500
Received: by mail-wr1-f69.google.com with SMTP id m17so4730257wrn.23
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 09:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jpEt4kcWqvPkXm7gNvgLa7mz6uUYuQ+o9Pau2fsorwc=;
        b=dKoEXJOOnmGhy8EGihJBVeeDkj/n2KybAbDT5vN45LMwyXMhFYtBAopNJCyxgRAat5
         anuBRlPVWby7YcNCtoOFunF7Z+EnQXtYMfiraiwTYhLRBEx4rm9BAzfgDYV7cLSJY4sS
         O5zRwaAt8e53fAIsj6vfZpJoPvDpWV6Ugdn4olbs6fc8CiLznMXHi53S2l6lV0emijEL
         9TsZsBRqxpMNyU9g+lW28braRDQskZl/DrIRwSFA6DkCMWbHPeLCNwImD1TeygcMLfcp
         wNBqeafHGsq//L06K2U6qDfCb4wbLbQHF6xEyokVHRQM/mU4xArH6Z9CQ0QlmPN+UeV8
         LP1Q==
X-Gm-Message-State: APjAAAXMPPaacHByOYLw62Tcy5G3YbC2nPlOfj4htQWjgMx9003zdRu+
        9A/Mn9agAb0gvQaHSwTMjw4/K7Hk1OBHmzxx8/iwXawRni0slkVpLXkNwopd2dESG7kErtX80zW
        Nu+7Ezt74PgqAutbOPMM7um0S
X-Received: by 2002:a1c:98c5:: with SMTP id a188mr8945117wme.133.1573751738553;
        Thu, 14 Nov 2019 09:15:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqzHamP9QriNwl6Ugw+S5huM16LiGTkmJeWuW/47AoXKLopL+QzkB/RXwKrqbj48LRbRjH6EPA==
X-Received: by 2002:a1c:98c5:: with SMTP id a188mr8945087wme.133.1573751738265;
        Thu, 14 Nov 2019 09:15:38 -0800 (PST)
Received: from [192.168.43.81] (mob-109-112-119-76.net.vodafone.it. [109.112.119.76])
        by smtp.gmail.com with ESMTPSA id w18sm7973435wrp.31.2019.11.14.09.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 09:15:37 -0800 (PST)
Subject: Re: [PATCH] KVM: x86/mmu: Take slots_lock when using
 kvm_mmu_zap_all_fast()
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191113193032.12912-1-sean.j.christopherson@intel.com>
 <1b46d531-6423-3ccc-fc5f-df6fbaa02557@redhat.com>
 <20191114151051.GB24045@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7f710a08-b207-e9a8-bc42-cb67113a7c8a@redhat.com>
Date:   Thu, 14 Nov 2019 18:15:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191114151051.GB24045@linux.intel.com>
Content-Language: en-US
X-MC-Unique: YHmy6cM1OVa-smqFjLkBdA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/19 16:10, Sean Christopherson wrote:
> On Thu, Nov 14, 2019 at 01:16:21PM +0100, Paolo Bonzini wrote:
>> On 13/11/19 20:30, Sean Christopherson wrote:
>>> Failing to take slots_lock when toggling nx_huge_pages allows multiple
>>> instances of kvm_mmu_zap_all_fast() to run concurrently, as the other
>>> user, KVM_SET_USER_MEMORY_REGION, does not take the global kvm_lock.
>>> Concurrent fast zap instances causes obsolete shadow pages to be
>>> incorrectly identified as valid due to the single bit generation number
>>> wrapping, which results in stale shadow pages being left in KVM's MMU
>>> and leads to all sorts of undesirable behavior.
>>
>> Indeed the current code fails lockdep miserably, but isn't the whole
>> body of kvm_mmu_zap_all_fast() covered by kvm->mmu_lock?  What kind of
>> badness can happen if kvm->slots_lock isn't taken?
>=20
> kvm_zap_obsolete_pages() temporarily drops mmu_lock and reschedules so
> that it doesn't block other vCPUS from inserting shadow pages into the ne=
w
> generation of the mmu.

Oh, of course.  I've worked on all this on the pre-5.4 MMU and that does
not have commit ca333add693 ("KVM: x86/mmu: Explicitly track only a
single invalid mmu generation").

I queued this patch with a small tweak to the commit message, to explain
why it doesn't need a stable backport.

Paolo

