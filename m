Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F378C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441D220672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Y0KBxnvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKUTBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:01:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36733 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfKUTBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 14:01:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id k13so2086029pgh.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 11:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=HsAyezn4NTj/SPx6Qh9c2H7K5cVNh7JQA3rXW5kOjAA=;
        b=Y0KBxnvkWdleqS0LtZsX/EmN5e7j9KkMvoFQXqsMzJa/0LhJKMvH6++eHDuadnPeWc
         MZM5qAooDhvPIPyZcNwnLw1e4cANCbzxypeT/kPvugL2/cf9bMcMOhShauyz4kjDXDGj
         7dTkp5BX7xKmErkLiQUcteL+MI2fuplzoEOeo+Q8Bs6l9PX1sCpP1PQ/7lbCz6ckPvvs
         bXEK4oX5Upztj9S1F46C3obetEA1fNS7TZH8Kc82Ojj623vOgqQ4HOevtZIhZePMFeFY
         V7eQm8xq5vtTYrYYW1he4sQ6E7AKVl3Cy630l3IJaKG0zcTg3WbACBfeVRGBbg2MMjC5
         qUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=HsAyezn4NTj/SPx6Qh9c2H7K5cVNh7JQA3rXW5kOjAA=;
        b=d2+fHlq8p8qsHmevFC2LGSh5idMndV1Bvk83GuMJb1A1mVJedUvph3zUeIAx0qn1md
         kqf8RoTySO/m/3w7pRUpgkNgRZyXkplJBBXErFeJr993gTry5mbGG3HjaK2jRgA7oyRi
         9Q0bD9BrJO8sXsWQP6TxuR8wzjJ0x0r0zJ6zYd93bigSWWdyFmX1Qk1R7TlWVejobccH
         g8x0e17oLHa4V9wnQpKxGtAD6Pi7ilt47vEMbyNQ/y43nhi7+368EW5S0I6Gq/t4sypa
         bqJIeHEUt6HI7NwCfGm7Tye0y5XH4KbaCoR8oGKYe2hvzP2rTId34WxSwcu9dsW5gncb
         4QLQ==
X-Gm-Message-State: APjAAAV80gTNT0imyIcaI1ApSXtOp8lBqUBQ91khhRelqulTTmK0eXdD
        4t1oAQcZSK5O16TJUM9Nn6NLPw==
X-Google-Smtp-Source: APXvYqzlxmolRqPIZZkpOYTVMkE+fkIpqak56g/krWqKWT754wqM5ae95dJAgQBaL3iPl/VOdw0ZlA==
X-Received: by 2002:a63:ba1c:: with SMTP id k28mr11026315pgf.244.1574362901886;
        Thu, 21 Nov 2019 11:01:41 -0800 (PST)
Received: from ?IPv6:2600:1010:b062:827f:f4a7:a1e:b790:5671? ([2600:1010:b062:827f:f4a7:a1e:b790:5671])
        by smtp.gmail.com with ESMTPSA id 1sm3927505pgp.88.2019.11.21.11.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 11:01:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by kernel parameter
Date:   Thu, 21 Nov 2019 11:01:39 -0800
Message-Id: <4BB1CB74-887B-4F40-B3B2-F0147B264C34@amacapital.net>
References: <20191121185303.GB199273@romley-ivt3.sc.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
In-Reply-To: <20191121185303.GB199273@romley-ivt3.sc.intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 21, 2019, at 10:40 AM, Fenghua Yu <fenghua.yu@intel.com> wrote:
>=20
> =EF=BB=BFOn Thu, Nov 21, 2019 at 09:51:03AM -0800, Andy Lutomirski wrote:
>>> On Thu, Nov 21, 2019 at 9:43 AM David Laight <David.Laight@aculab.com> w=
rote:
>>>=20
>>> From: Ingo Molnar
>>>> Sent: 21 November 2019 17:12
>>>> * Peter Zijlstra <peterz@infradead.org> wrote:
>>> ...
>>>>> This feature MUST be default enabled, otherwise everything will
>>>>> be/remain broken and we'll end up in the situation where you can't use=

>>>>> it even if you wanted to.
>>>>=20
>>>> Agreed.
>>>=20
>>> Before it can be enabled by default someone needs to go through the
>>> kernel and fix all the code that abuses the 'bit' functions by using the=
m
>>> on int[] instead of long[].
>>>=20
>>> I've only seen one fix go through for one use case of one piece of code
>>> that repeatedly uses potentially misaligned int[] arrays for bitmasks.
>>>=20
>>=20
>> Can we really not just change the lock asm to use 32-bit accesses for
>> set_bit(), etc?  Sure, it will fail if the bit index is greater than
>> 2^32, but that seems nuts.
>>=20
>> (Why the *hell* do the bitops use long anyway?  They're *bit masks*
>> for crying out loud.  As in, users generally want to operate on fixed
>> numbers of bits.)
>=20
> We are working on a separate patch set to fix all split lock issues
> in atomic bitops. Per Peter Anvin and Tony Luck suggestions:
> 1. Still keep the byte optimization if nr is constant. No split lock.
> 2. If type of *addr is unsigned long, do quadword atomic instruction
>   on addr. No split lock.
> 3. If type of *addr is unsigned int, do word atomic instruction
>   on addr. No split lock.
> 4. Otherwise, re-calculate addr to point the 32-bit address which contains=

>   the bit and operate on the bit. No split lock.
>=20
> Only small percentage of atomic bitops calls are in case 4 (e.g. 3%
> for set_bit()) which need a few extra instructions to re-calculate
> address but can avoid big split lock overhead.
>=20
> To get real type of *addr instead of type cast type "unsigned long",
> the atomic bitops APIs are changed to macros from functions. This change
> need to touch all architectures.
>=20

Isn=E2=80=99t the kernel full of casts to long* to match the signature?  Doi=
ng this based on type seems silly to me. I think it=E2=80=99s better to just=
 to a 32-bit operation unconditionally and to try to optimize it using b*l w=
hen safe.=
