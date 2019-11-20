Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE925C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31D822310
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGETTphF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfKTMVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:21:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31650 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728611AbfKTMVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574252500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0y+Va4NBLdVxptKCFSjrSqw/jstEexITDbBbQwJO4B4=;
        b=KGETTphFxIk9KLvcppqsxEH/0BCMm0Fr0n4wkhLgD5G1t8g+Rk3eb9FTd8j7qWc+4cyIQF
        5lMNDTThZTnJH5EBLgLuf4prJV4/67kMA2Mfqm6OLe5aRSVi6BZctyNINF+IkFsjo1cfsZ
        QObUhIEwOwbRaJ18iHi8mLeqfEqgv2s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-ZI7HMh2TPMyq1suL5LJojQ-1; Wed, 20 Nov 2019 07:21:39 -0500
Received: by mail-wr1-f70.google.com with SMTP id w9so21109530wrn.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 04:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3CRYoC+FXuRRRB1nkQ2UTEB7lD0/kwekRSpLwkYD6lI=;
        b=ZSIPbCvfzw/My5VkrK5a/9KsPdsyG6jMNVsN2TudRH+DiDw9chkmPKZ1A1A2JIIGqt
         Umn+mF647mIR9tl2sJ4FJ9DCgqNncpUIqgfkM73iGzBB2wkWGc8wGa5rWRtLrzM/cqaj
         3PgXXpd6AVvKgbENWfSOwH1i0oej1NEuGrup60wMS46VUKlveSb1jlYINL8SkN/eNCAm
         6Og+e7QmxJIW/oaBYlkLUJpB+wBYuC7cMt+GmTFVH7+DGOfTtSbnpDs38oqbWUg8fQZk
         EISOFktixPEkSxjLYrA2LoUgZQ4NvLyVn6Sg7pN1yQtDXjmj5YLccM2miQlY6lb/dpVY
         Eoww==
X-Gm-Message-State: APjAAAWLkqm94cp09kGaqOLVMDiZknSMIPf3GLXRDfEGM8D37XmDaz18
        RE0q7AHEF8zUOWJbzHp+TEzqySec5bhL7xUixgTc35AzoCZWVAKEGpwVK9qSZRN7sjXId/FAb5A
        MjqxomsRWlLgGgwGIKqYx2/ci
X-Received: by 2002:adf:dc81:: with SMTP id r1mr3153630wrj.84.1574252497878;
        Wed, 20 Nov 2019 04:21:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqyKPOrrwukpzYwVmy5KkrfH43kXkleuhypNH0euma/SjTaLdY4e1rCrLeWxMJWnK4K36Jyv+Q==
X-Received: by 2002:adf:dc81:: with SMTP id r1mr3153590wrj.84.1574252497590;
        Wed, 20 Nov 2019 04:21:37 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:dc24:9a59:da87:5724? ([2001:b07:6468:f312:dc24:9a59:da87:5724])
        by smtp.gmail.com with ESMTPSA id u16sm31686955wrr.65.2019.11.20.04.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 04:21:36 -0800 (PST)
Subject: Re: [PATCH 4/5] KVM: vmx: implement MSR_IA32_TSX_CTRL disable RTM
 functionality
To:     Jim Mattson <jmattson@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <1574101067-5638-1-git-send-email-pbonzini@redhat.com>
 <1574101067-5638-5-git-send-email-pbonzini@redhat.com>
 <CALMp9eQ=QXD5sFCADtFY0Bc9wWcn2nhq7XdahD-g4DBSgARYJw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <656c0af1-6c56-8a08-ff86-745409f6968c@redhat.com>
Date:   Wed, 20 Nov 2019 13:21:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eQ=QXD5sFCADtFY0Bc9wWcn2nhq7XdahD-g4DBSgARYJw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: ZI7HMh2TPMyq1suL5LJojQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/19 22:06, Jim Mattson wrote:
>> +               switch (index) {
>> +               case MSR_IA32_TSX_CTRL:
>> +                       /* No need to pass TSX_CTRL_CPUID_CLEAR through.=
  */
>> +                       vmx->guest_msrs[j].mask =3D ~(u64)TSX_CTRL_CPUID=
_CLEAR;
>> +                       break;
> Why even bother with the special case here? Does this make the wrmsr fast=
er?
>=20

No, but it can avoid the wrmsr altogether if the guest uses the same
DISABLE_RTM setting but a different value for CPUID_CLEAR.

More important, while I am confident re-enabling TSX while in the kernel
and only restoring MSR_IA32_TSX_CTRL on return to userspace, I'm more
wary of changing CPUID bits while the kernel is running.  I will update
the comment.

Paolo

