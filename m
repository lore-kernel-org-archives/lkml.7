Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B279C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C12320637
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfZHrNS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKUQIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:08:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51799 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726840AbfKUQIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574352495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=MeeOedOyzrBDgLHnAaEdYtdPw/Bnh3YjiRhbRgcresI=;
        b=cfZHrNS/3Nc916KzIK7CT8PNllp2cKy6QGr9BfTFKBvuLK4pGV/ij+oM3GM8b0f2HFtMVE
        QHBCacTA/PfQwo0VbqYT/VFWEIj+jmcOPHX1hmsdTccCq1Ez656dd+yclev0l+/ZR9Kxyo
        4/mYFmkxjNEul8Bx1t7YXytWO2BbW6o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-jA__YipqPpOEsQLAhIjmnQ-1; Thu, 21 Nov 2019 11:08:14 -0500
Received: by mail-wm1-f70.google.com with SMTP id x16so2060038wmk.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 08:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KMDjZkzrlqiVQ/Y8A6t0DAiUQ9UpMG4ktLorbVn8v3Q=;
        b=pm9K5DKk672Ttsio+MOm67gQJKuE8u97jkEDRNEsoDZIxTDEC1ndslUPQ2htk5Ly6Y
         jM2Yi8RwGx53qw2fYayhQMRgP/hxW6cfOqywnyQwrcng3eI5V3zddIIjQam8JE0cCmqh
         GxF/o6QjusXttxOSimSnE3QUAc62KEQt65GBHnWD4G2Qz9I9Kv+RTeNR2wFNQ/PpwahA
         uelRjQXuPXIK1ZGcwbUjQkpKX2qmpvJNcsJ5c4whtO5YTuH71WRBs3zbbVLAcP7zkyuC
         dFv32Re0fX+tiGdMgNTOcQRS+RwNG0UuNRau/VobQe/WzUiqq5sjacQK/8ARDeJjsbHd
         OsLw==
X-Gm-Message-State: APjAAAWuyHNlD8CgNoXLvLDboisdjMFhm1PtTjLnDzUsxK4MhrH59/t9
        PJtswhPx2OO93TTWgyzhBDami4JpQwedmHd7zJEOEXMoyA6U3yuNVELaUhUqfJVAra0EJPu80Qo
        bphLuN5nIQ4yU56AWHY+MiBI+
X-Received: by 2002:a1c:7f94:: with SMTP id a142mr10568872wmd.33.1574352489475;
        Thu, 21 Nov 2019 08:08:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqzDnhT3JBlp/jXfwl4CJh7SlIP82w3enQZE3lpWjhvdGmtTQ7g4eELgQdIiSIVuH65LYDfs1w==
X-Received: by 2002:a1c:7f94:: with SMTP id a142mr10568840wmd.33.1574352489181;
        Thu, 21 Nov 2019 08:08:09 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:71a5:6e:f854:d744? ([2001:b07:6468:f312:71a5:6e:f854:d744])
        by smtp.gmail.com with ESMTPSA id f19sm4087872wrf.23.2019.11.21.08.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 08:08:08 -0800 (PST)
Subject: Re: [PATCH v7 6/9] vmx: spp: Set up SPP paging table at
 vmentry/vmexit
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmattson@google.com, sean.j.christopherson@intel.com,
        yu.c.zhang@linux.intel.com, alazar@bitdefender.com,
        edwin.zhai@intel.com
References: <20191119084949.15471-1-weijiang.yang@intel.com>
 <20191119084949.15471-7-weijiang.yang@intel.com>
 <a7ce232b-0a54-0039-7009-8e92e8078791@redhat.com>
 <20191121152212.GG17169@local-michael-cet-test>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7cdcd2b2-ced8-4c08-82c7-b3a25ed8bb15@redhat.com>
Date:   Thu, 21 Nov 2019 17:08:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191121152212.GG17169@local-michael-cet-test>
Content-Language: en-US
X-MC-Unique: jA__YipqPpOEsQLAhIjmnQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/19 16:22, Yang Weijiang wrote:
> On Thu, Nov 21, 2019 at 11:18:48AM +0100, Paolo Bonzini wrote:
>> On 19/11/19 09:49, Yang Weijiang wrote:
>>> +=09=09=09if (spte & PT_SPP_MASK) {
>>> +=09=09=09=09fault_handled =3D true;
>>> +=09=09=09=09vcpu->run->exit_reason =3D KVM_EXIT_SPP;
>>> +=09=09=09=09vcpu->run->spp.addr =3D gva;
>>> +=09=09=09=09kvm_skip_emulated_instruction(vcpu);
>>
>> Do you really want to skip the current instruction?  Who will do the wri=
te?
>>
> If the destination memory is SPP protected, the target memory is
> expected unchanged on a "write op" in guest, so would like to skip curren=
t=20
> instruction.

This is how you are expecting SPP to be used, but another possibility is
to unprotect and reenter the guest.  In this case
kvm_skip_emulated_instruction would be wrong (and once this decision is
made, it would be very, very hard to change it).

However, you clearly need a way to skip the instruction, and for that
you could store the current instruction length in vcpu->run->spp.  Then
userspace can adjust RIP manually if desired.

Thanks,

Paolo

