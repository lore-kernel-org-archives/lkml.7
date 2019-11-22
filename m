Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9285FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66434204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="iihz00c2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfKVC5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 21:57:48 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36464 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKVC5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 21:57:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id k13so2649830pgh.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 18:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=biLVQ1AkvF5aueMS3h63jwqjzMqooy/ltImr9VK7zXA=;
        b=iihz00c2qO6qdKXF25QKRNnIzZ3qfhPH+FVj0sOPRn/AkAsMGEgMoJWHFhq1APm8e9
         mlY2bdkSMK3bfFqemMBu4IZwF8378ceynXZuw1qdbLvs0GdMreYxkyLx136jmSrfEHtv
         ML++5hzkuZpeOm77Z3Pbih3YgyLAWmPvtjyBFVdY9V7hSN4GAS7vWEEIB359GQn0G+NX
         IcsFhT8F7QqIKqymepUFuLMx3f9xzFesX+BqevZn07g7z0Dh9KQ0d546sfvl+2mUaOZ2
         YSUuItpMaVOTO5qIyt71P4r9ONIp87cRSFIP0gVAEMUYCvP7KEEhiuhVc1xwd37F8D53
         22dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=biLVQ1AkvF5aueMS3h63jwqjzMqooy/ltImr9VK7zXA=;
        b=lUoZ6RUw0pKep3qvCIpuP9FMpSHJNKfwDHWuX7qp7vGGQ4wiUpxNA0wlvfjc6BzHOL
         oLnOZGkKZRwcDLQtmIN0H0aIc7TG1U8Ld6InrLIsh9RHPQ7yFC8jsYwHwTGKALtTEpKS
         /mRv+eoEdRipfJ3Kg711jg0cvOmoTZibKbGosLu+N4ODpD4TjE2DmitAAlgMSG1TqGMX
         ek5yR1UIOnjojTHPEAx26U0ZEdiwYEZ1tsml6rEhioydAes5xdQFTNQgOsfjc2VLtSGO
         5SoVZ1gas/SGU7xTKXqUK9nxv7ewVA3hj0TnXA3zcaE9F3tEs7ILHM1UDo0xTP0VGadH
         72Fw==
X-Gm-Message-State: APjAAAXqBvvxr9krxTS7e5ab9hzyt5zF/aA/hKvnnnmoCl9lJkwccIlK
        zb2PnMzi/ZuLGq/UvRYZkEWxBA==
X-Google-Smtp-Source: APXvYqzA6XSQho+2rXXXt8WxNZbNv/OVvaYZ+jXMHILfYgKzs5VVQA1D0cOnmMAjOg+Stjruiy5+Zg==
X-Received: by 2002:a63:ed4a:: with SMTP id m10mr13154193pgk.255.1574391467192;
        Thu, 21 Nov 2019 18:57:47 -0800 (PST)
Received: from [100.111.14.2] (50.sub-174-194-197.myvzw.com. [174.194.197.50])
        by smtp.gmail.com with ESMTPSA id a6sm877767pja.30.2019.11.21.18.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 18:57:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by kernel parameter
Date:   Thu, 21 Nov 2019 18:57:44 -0800
Message-Id: <863BD058-5DB8-4C87-B799-29CCB5376FE2@amacapital.net>
References: <fee43477-337a-8de3-9788-e8c8d58d0116@intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
In-Reply-To: <fee43477-337a-8de3-9788-e8c8d58d0116@intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 21, 2019, at 6:39 PM, Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>=20
> =EF=BB=BFOn 11/22/2019 10:21 AM, Andy Lutomirski wrote:
>>>> On Nov 21, 2019, at 5:52 PM, Sean Christopherson <sean.j.christopherson=
@intel.com> wrote:
>>>=20
>>> =EF=BB=BFOn Thu, Nov 21, 2019 at 03:53:29PM -0800, Fenghua Yu wrote:
>>>>> On Thu, Nov 21, 2019 at 03:18:46PM -0800, Andy Lutomirski wrote:
>>>>>=20
>>>>>> On Nov 21, 2019, at 2:29 PM, Luck, Tony <tony.luck@intel.com> wrote:
>>>>>>=20
>>>>>>> It would be really, really nice if we could pass this feature throug=
h to a VM. Can we?
>>>>>>=20
>>>>>> It's hard because the MSR is core scoped rather than thread scoped.  S=
o on an HT
>>>>>> enabled system a pair of logical processors gets enabled/disabled tog=
ether.
>>>>>>=20
>>>>>=20
>>>>> Well that sucks.
>>>>>=20
>>>>> Could we pass it through if the host has no HT?  Debugging is *so* muc=
h
>>>>> easier in a VM.  And HT is a bit dubious these days anyway.
>>>>=20
>>>> I think it's doable to pass it through to KVM. The difficulty is to dis=
able
>>>> split lock detection in KVM because that will disable split lock on the=
 whole
>>>> core including threads for the host. Without disabling split lock in KV=
M,
>>>> it's doable to debug split lock in KVM.
>>>>=20
>>>> Sean and Xiaoyao are working on split lock for KVM (in separate patch s=
et).
>>>> They may have insight on how to do this.
>>>=20
>>> Yes, with SMT off KVM could allow the guest to enable split lock #AC, bu=
t
>>> for the initial implementation we'd want to allow it if and only if spli=
t
>>> lock #AC is disabled in the host kernel.  Otherwise we have to pull in t=
he
>>> logic to control whether or not a guest can disable split lock #AC, what=

>>> to do if a split lock #AC happens when it's enabled by the host but
>>> disabled by the guest, etc...
>> What=E2=80=99s the actual issue?  There=E2=80=99s a window around entry a=
nd exit when a split lock in the host might not give #AC, but as long as no u=
ser code is run, this doesn=E2=80=99t seem like a big problem.
> The problem is that guest can trigger split locked memory access just by d=
isabling split lock #AC even when host has it enabled. In this situation, th=
ere is bus lock held on the hardware without #AC triggered, which is conflic=
t with the purpose that host enables split lock #AC

Fair enough. You need some way to get this enabled in guests eventually, tho=
ugh.=
