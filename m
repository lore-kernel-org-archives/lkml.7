Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE2EC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD092173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT1Icl5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbfDQRpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:45:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36141 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfDQRpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:45:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so12388099plb.3;
        Wed, 17 Apr 2019 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iiKewh/rfSv9TET3jU6nkn7AWCBEz5+mb4Gwkj8mwj8=;
        b=OT1Icl5ug+NAclWFwwjy4encfGqF8h6cQ+Sluh8LzmcZ7PDJwN1EgFXlFIUgiOWhv3
         CdyxbET3pK6vk3eVE6CuZMYXEDZBkDGGS0j/EPXB7PkGD/NOQuXKFupb6p+NcuweE25U
         zSQgwg5NjcZJ6sJtwNWHBhcXJCP2pmcgCP9PRguBY4GjSzejO9PQXa/vMmQ7Pc7yKdS6
         tduovyaAMGBZQaLuQngghondFXL+EQQVleQZ++7KcWxjU8TgbrwM37zs5xY/S5QIMxhe
         58nzwPq5oTgFA4zTqspejrXFnGO1J+TMkYisCWw26t7w22hh5emAce2dBtovssrt//Df
         d0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iiKewh/rfSv9TET3jU6nkn7AWCBEz5+mb4Gwkj8mwj8=;
        b=OQeDrafRyPKzMHumxh69tP0+/Ygb/gQdpiPFvhcvfe0gq/CS5tQEQmOzQ/AhvUD6j5
         GUnnJbYi39Zbv3EpbSWhr9tcpqF6t332IuFgSPAHBgjIgNrcLKGp1k/iP4TicgrR9Yhl
         ueN/RT47Vt0P18fT/1A0Y9QFlSXT1cjnma4emSZT59Eo4f3DrYw8lA5yhEzx0d4fYJrg
         89EWRgMULgkscJjCiycWRaeYUQJRbWp+gFmvViX2yyvOxzrwgMqHqpTVkYRJLvt8pfio
         gUayhgdgpfLaBN0j5kaZ7UNdYsqzt9j9L2APTxU7DDRHvWJAWA1LBxfqXxdTorn9bqLb
         OXFg==
X-Gm-Message-State: APjAAAUyHRq9N2bgCXydFHGKvQfMZEa0zvg/EPe+es3KBRnUZA7NnzD+
        TB+Sa6rrylMIMagh3w/RChs=
X-Google-Smtp-Source: APXvYqzfMmBcNUH3fJFzGd3r9yH7kGevsQ52l1TqCRzwV4eMJos/uHwMz4Wl+hkhnB1q+aRwaHSPBg==
X-Received: by 2002:a17:902:6bc7:: with SMTP id m7mr42510170plt.146.1555523101228;
        Wed, 17 Apr 2019 10:45:01 -0700 (PDT)
Received: from [10.33.115.113] ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id v188sm81987353pgb.7.2019.04.17.10.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:44:58 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20190417172632.GA95485@gmail.com>
Date:   Wed, 17 Apr 2019 10:44:56 -0700
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, juergh@gmail.com,
        Tycho Andersen <tycho@tycho.ws>, jsteckli@amazon.de,
        keescook@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, David Woodhouse <dwmw@amazon.co.uk>,
        Andrew Cooper <andrew.cooper3@citrix.com>, jcm@redhat.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        iommu <iommu@lists.linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-arm-kernel@lists.infradead.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Dave Hansen <dave@sr71.net>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <063753CC-5D83-4789-B594-019048DE22D9@gmail.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
 <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com>
 <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
 <20190417170918.GA68678@gmail.com>
 <56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
 <20190417172632.GA95485@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 17, 2019, at 10:26 AM, Ingo Molnar <mingo@kernel.org> wrote:
>=20
>=20
> * Nadav Amit <nadav.amit@gmail.com> wrote:
>=20
>>> On Apr 17, 2019, at 10:09 AM, Ingo Molnar <mingo@kernel.org> wrote:
>>>=20
>>>=20
>>> * Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>>=20
>>>>> I.e. the original motivation of the XPFO patches was to prevent =
execution=20
>>>>> of direct kernel mappings. Is this motivation still present if =
those=20
>>>>> mappings are non-executable?
>>>>>=20
>>>>> (Sorry if this has been asked and answered in previous =
discussions.)
>>>>=20
>>>> Hi Ingo,
>>>>=20
>>>> That is a good question. Because of the cost of XPFO, we have to be =
very
>>>> sure we need this protection. The paper from Vasileios, Michalis =
and
>>>> Angelos - =
<http://www.cs.columbia.edu/~vpk/papers/ret2dir.sec14.pdf>,
>>>> does go into how ret2dir attacks can bypass SMAP/SMEP in sections =
6.1
>>>> and 6.2.
>>>=20
>>> So it would be nice if you could generally summarize external =
arguments=20
>>> when defending a patchset, instead of me having to dig through a PDF=20=

>>> which not only causes me to spend time that you probably already =
spent=20
>>> reading that PDF, but I might also interpret it incorrectly. ;-)
>>>=20
>>> The PDF you cited says this:
>>>=20
>>> "Unfortunately, as shown in Table 1, the W^X prop-erty is not =
enforced=20
>>>  in many platforms, including x86-64.  In our example, the content =
of=20
>>>  user address 0xBEEF000 is also accessible through kernel address=20
>>>  0xFFFF87FF9F080000 as plain, executable code."
>>>=20
>>> Is this actually true of modern x86-64 kernels? We've locked down =
W^X=20
>>> protections in general.
>>=20
>> As I was curious, I looked at the paper. Here is a quote from it:
>>=20
>> "In x86-64, however, the permissions of physmap are not in sane =
state.
>> Kernels up to v3.8.13 violate the W^X property by mapping the entire =
region
>> as =E2=80=9Creadable, writeable, and executable=E2=80=9D (RWX)=E2=80=94=
only very recent kernels
>> (=E2=89=A5v3.9) use the more conservative RW mapping.=E2=80=9D
>=20
> But v3.8.13 is a 5+ years old kernel, it doesn't count as a "modern"=20=

> kernel in any sense of the word. For any proposed patchset with=20
> significant complexity and non-trivial costs the benchmark version=20
> threshold is the "current upstream kernel".
>=20
> So does that quote address my followup questions:
>=20
>> Is this actually true of modern x86-64 kernels? We've locked down W^X
>> protections in general.
>>=20
>> I.e. this conclusion:
>>=20
>>  "Therefore, by simply overwriting kfptr with 0xFFFF87FF9F080000 and
>>   triggering the kernel to dereference it, an attacker can directly
>>   execute shell code with kernel privileges."
>>=20
>> ... appears to be predicated on imperfect W^X protections on the =
x86-64
>> kernel.
>>=20
>> Do such holes exist on the latest x86-64 kernel? If yes, is there a
>> reason to believe that these W^X holes cannot be fixed, or that any =
fix
>> would be more expensive than XPFO?
>=20
> ?
>=20
> What you are proposing here is a XPFO patch-set against recent kernels=20=

> with significant runtime overhead, so my questions about the W^X holes=20=

> are warranted.
>=20

Just to clarify - I am an innocent bystander and have no part in this =
work.
I was just looking (again) at the paper, as I was curious due to the =
recent
patches that I sent that improve W^X protection.

