Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FA7C282E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A754C217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="KD5N5gnu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfDSVPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:15:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36996 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfDSVPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:15:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so3092290ply.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WYpiZfRbbseRjJyVApEiFDNq4Hmmd0sUbCvSRw0KoEY=;
        b=KD5N5gnuj0qJHhdNK14Ng0i18NnELyUBJN4d20cMkiMehCQ+Ih8IiW57Sm7Ma3iHt2
         aep4wMeMz830Jd9n5XP8Pwb2AFKNZLF9bOZQIIZ6+fvZeqI65GZr4ou52YIzx0BgM7aA
         EhwV9wzl4lSWZrQSnEbz+46KKuAPsX4P223NxIkRLGhs735a4uVFL2moqhptyZB91/ka
         DEChuzJjoG033BJRhCCFAUYJr7tkKAsHaadZ59QBn6wSQttqM4zFSihCNLx4T2bl3ufn
         DW2/YWIfoEZkM7b4qrjhQkOFbwP1uGCLGv8/J8NiLp6HfksDeEkM+Yoc/6dF7Hzn848R
         7rsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WYpiZfRbbseRjJyVApEiFDNq4Hmmd0sUbCvSRw0KoEY=;
        b=LxtbwuB6HuQxGLuC3XRzt5NVufBNmJyJVCUAgQgEQGoYvHb2bn7uaWmSeK0MkaPygR
         YthT2Q5s2H4VGT1HOGA1TGbK4BMmKq9O3JB/SBcuNqXP0+yjBGWcG2Z+dIulM6WEw97Q
         5ooDrXQE2W5bAg1rjQHBdsH5ZW1UC8xknHriHFwNHarlvkEjZMqDq9iRUFlIQjMhkCFj
         uBhY81Hy3iVH0IgAKCaF38l0Ab94bNm6Pt5B7mX+J6I7T8RoyDF/sbv+unqRZkunQOqE
         0aNIB0a7+teA6pPMmlGbO812hKAbNqtdT9Exoh4TxoV49XXpibNaZHoKI6gNRyPRvA/0
         Ux/A==
X-Gm-Message-State: APjAAAWyYL67ttBCsgIeMLh62A1IlK6szJG9RZJB+Ot6q81OqI71dc4l
        Z6Or4miVypRQzMl9i0nXbwNOPpl/sN4=
X-Google-Smtp-Source: APXvYqx9toyhlJBTk/JwaJrOSdFz4el5eOfSPdi0RxJEEgV0RIKMcyp9tim3/YhMmB1lOkfr1NCrNQ==
X-Received: by 2002:a17:902:b713:: with SMTP id d19mr6155722pls.54.1555708512862;
        Fri, 19 Apr 2019 14:15:12 -0700 (PDT)
Received: from ?IPv6:2600:1010:b006:440c:5c39:392b:af18:8032? ([2600:1010:b006:440c:5c39:392b:af18:8032])
        by smtp.gmail.com with ESMTPSA id u62sm8636613pfa.124.2019.04.19.14.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 14:15:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v20 00/28] Intel SGX1 support
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <e1478f70-7e44-6e3e-2aaf-1b12a96328ed@fortanix.com>
Date:   Fri, 19 Apr 2019 14:15:08 -0700
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Dr. Greg" <greg@enjellic.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "npmccallum@redhat.com" <npmccallum@redhat.com>,
        "Ayoun, Serge" <serge.ayoun@intel.com>,
        "Katz-zamir, Shay" <shay.katz-zamir@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>, Borislav Petkov <bp@alien8.de>,
        Josh Triplett <josh@joshtriplett.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        David Rientjes <rientjes@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2AE80EA3-799E-4808-BBE4-3872F425BCF8@amacapital.net>
References: <20190417103938.7762-1-jarkko.sakkinen@linux.intel.com> <20190418171059.GA20819@wind.enjellic.com> <09ebfa1d-c03d-c1fe-ff0f-d99287b6ec3c@intel.com> <20190419141732.GA2269@wind.enjellic.com> <CALCETrV=wAsyWxtxQJ7y0xNrzkE863hTfU6Ysej48Gk9yPFJZw@mail.gmail.com> <43aa8fdd-e777-74cb-e3f0-d36805ffa18b@fortanix.com> <alpine.DEB.2.21.1904192233390.3174@nanos.tec.linutronix.de> <8c5133bc-1301-24ca-418d-7151a6eac0e2@fortanix.com> <alpine.DEB.2.21.1904192248550.3174@nanos.tec.linutronix.de> <e1478f70-7e44-6e3e-2aaf-1b12a96328ed@fortanix.com>
To:     Jethro Beekman <jethro@fortanix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org





> On Apr 19, 2019, at 1:54 PM, Jethro Beekman <jethro@fortanix.com> wrote:
>=20
>> On 2019-04-19 13:50, Thomas Gleixner wrote:
>>> On Fri, 19 Apr 2019, Jethro Beekman wrote:
>>>> On 2019-04-19 13:39, Thomas Gleixner wrote:
>>>>> On Fri, 19 Apr 2019, Jethro Beekman wrote:
>>>>>=20
>>>>>> On 2019-04-19 08:27, Andy Lutomirski wrote:
>>>>>> There are many,
>>>>>> many Linux systems that enforce a policy that *all* executable text
>>>>>> needs to come from a verified source.  On these systems, you can't
>>>>>> mmap some writable memory, write to it, and then change it to
>>>>>> executable.
>>>>>=20
>>>>> How is this implemented on those systems? AFAIK there's no kernel conf=
ig
>>>>> option that changes the semantics of mmap as you describe.
>>>>=20
>>>> That has nothing to do with mmap() semantics. You mmap() writeable memo=
ry
>>>> and then you change the permissions via mprotect(). mprotect() calls in=
to
>>>> LSM and depending on policy and security model this will reject the
>>>> request.
>>>>=20
>>>> Andy was pointing out that the SGX ioctl bypasses the LSM mechanics whi=
ch
>>>> is obviously a bad thing.
>>>=20
>>> We could modify the driver such that when you call ioctl EADD, the page
>>> table permissions need to be the PAGEINFO.SECINFO.FLAGS | PROT_WRITE,
>>> otherwise you get EPERM or so. After EADD, if you want, you can restrict=

>>> the page table permissions again using mprotect but the page table
>>> permissions don't really matter for SGX.
>>=20
>> And the point of that is? That you still can cirumvent LSM for feeding
>> executable code into SGX.
>=20
> How? LSM would see that you're trying to map a page RWX so you can do
> your ioctl?

With plain mmap() + mprotect(), the LSM will prevent you from making memory t=
hat *was* writable executable.  This is by design and SELinux supports it.  I=
 don=E2=80=99t remember the name of the associated SELinux permission off th=
e top of my head.

If we start enforcing equivalent rules on SGX, then the current API will sim=
ply not allow enclaves to be loaded =E2=80=94 no matter how you slice it, lo=
ading an enclave with the current API is indistinguishable from making arbit=
rary data executable.

Put another way, you can compile your enclave, ship it as a file, and get it=
 appropriately verified (by LSM attribute, IMA, dm-verity, whatever) and run=
 it, but, with the current API, the kernel has no way of knowing that the us=
erspace enclave loader is actually reading it from the file in question.

So I think we need to work on the API.

>=20
>> No, we are not making special cases and exceptions for SGX.
>=20
> Maybe I didn't express myself clearly? I don't think I was suggesting
> anything like that.
>=20
> --
> Jethro Beekman | Fortanix
