Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EDEC742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A92521019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="y+5Jhhgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfGLQpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 12:45:11 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42262 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfGLQpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 12:45:10 -0400
Received: by mail-oi1-f195.google.com with SMTP id s184so7739104oie.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6LnAzjOasKxUwXGzTNC0/064h+/s+kUgeRd8GGr+dNc=;
        b=y+5JhhgmNMeM1wyuwj/XzOeYCh3l6ziC7Q771WlrgOuxNGzdruLij0Bd0bIoG5jM3d
         Db3yFOQe9oJ72rqInCLv5IT5U/tzZ44PeQK0oBMW4m+IauKOslZy7IC+GgteBJcQrXLS
         w3h9o5dlT/8wb9rL46HzQKkWKfxY+n/JIPNZ9G2FZIINBpDbDTRFNRtcHxKDRJVpwEqH
         nipdZSzIaSUQBX0DYu19v+AM+C3QxQZUmy1qXgyaytK38F3Sv+yUnmfjmLiB7/oZYGXu
         73n0iYnMYyaID7e2Y6q3kyCjzXOYqsuihAlcYX+2cpr0DFcDvSj1C1ys/nJkkUVByenh
         Fn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6LnAzjOasKxUwXGzTNC0/064h+/s+kUgeRd8GGr+dNc=;
        b=ouKyA1pAyS5hBHfvW2RuIKLwB9/DN0L2UeQoXBN/jkiobJqmZAQv7KnDslNY4nfwFZ
         BPVpluDmBUgXF4I22PPGwF6u20yWIRFTtQowsK3WqF2KBeF+ydv0pzXNqYGZrxVuobPZ
         tB6YZ1FGBVnVOywED6POcNvuCrm3XQuywC6iyep/5CIBRKoG0de40sONTphszMEcvkvk
         QB0OQNqi/5qoqR5teTol9nKvCG5X8kDqxcgNB1jeOkXTI7zwxG8amnObP3SUOOVIClTV
         1IV9N5uuFB6n8oyLcrjKQlaThhGoYq4AkOwrHEJxGOrl08GowSDzOmEIkTuGOytUae4S
         2lOA==
X-Gm-Message-State: APjAAAX29QdMt0Ld5eHKzn7g87GjmT2WE9IY7wDCorhiwdXHAhHwaubX
        NGZCf1eG1sHd7qBRhNm3KkrqFg==
X-Google-Smtp-Source: APXvYqz43gvQBuChWBqcRDiu2PX0SnPMLctG+UPHeFtjNbnJ7Bi0dOA9Iyg8NVe3bAqg2MsnU8zG+w==
X-Received: by 2002:aca:cfd0:: with SMTP id f199mr6026297oig.50.1562949909275;
        Fri, 12 Jul 2019 09:45:09 -0700 (PDT)
Received: from ?IPv6:2600:100e:b03e:b:3dba:7fb8:8988:ae37? ([2600:100e:b03e:b:3dba:7fb8:8988:ae37])
        by smtp.gmail.com with ESMTPSA id l5sm3141381otf.53.2019.07.12.09.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 09:45:08 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC v2 00/27] Kernel Address Space Isolation
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <3ca70237-bf8e-57d9-bed5-bc2329d17177@oracle.com>
Date:   Fri, 12 Jul 2019 10:45:06 -0600
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, kvm@vger.kernel.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        liran.alon@oracle.com, jwadams@google.com, graf@amazon.de,
        rppt@linux.vnet.ibm.com, Paul Turner <pjt@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7FDF08CB-A429-441B-872D-FAE7293858F5@amacapital.net>
References: <1562855138-19507-1-git-send-email-alexandre.chartre@oracle.com> <5cab2a0e-1034-8748-fcbe-a17cf4fa2cd4@intel.com> <alpine.DEB.2.21.1907120911160.11639@nanos.tec.linutronix.de> <61d5851e-a8bf-e25c-e673-b71c8b83042c@oracle.com> <20190712125059.GP3419@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1907121459180.1788@nanos.tec.linutronix.de> <3ca70237-bf8e-57d9-bed5-bc2329d17177@oracle.com>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 12, 2019, at 10:37 AM, Alexandre Chartre <alexandre.chartre@oracle.=
com> wrote:
>=20
>=20
>=20
>> On 7/12/19 5:16 PM, Thomas Gleixner wrote:
>>> On Fri, 12 Jul 2019, Peter Zijlstra wrote:
>>>> On Fri, Jul 12, 2019 at 01:56:44PM +0200, Alexandre Chartre wrote:
>>>>=20
>>>> I think that's precisely what makes ASI and PTI different and independe=
nt.
>>>> PTI is just about switching between userland and kernel page-tables, wh=
ile
>>>> ASI is about switching page-table inside the kernel. You can have ASI w=
ithout
>>>> having PTI. You can also use ASI for kernel threads so for code that wo=
n't
>>>> be triggered from userland and so which won't involve PTI.
>>>=20
>>> PTI is not mapping         kernel space to avoid             speculation=
 crap (meltdown).
>>> ASI is not mapping part of kernel space to avoid (different) speculation=
 crap (MDS).
>>>=20
>>> See how very similar they are?
>>>=20
>>> Furthermore, to recover SMT for userspace (under MDS) we not only need
>>> core-scheduling but core-scheduling per address space. And ASI was
>>> specifically designed to help mitigate the trainwreck just described.
>>>=20
>>> By explicitly exposing (hopefully harmless) part of the kernel to MDS,
>>> we reduce the part that needs core-scheduling and thus reduce the rate
>>> the SMT siblngs need to sync up/schedule.
>>>=20
>>> But looking at it that way, it makes no sense to retain 3 address
>>> spaces, namely:
>>>=20
>>>   user / kernel exposed / kernel private.
>>>=20
>>> Specifically, it makes no sense to expose part of the kernel through MDS=

>>> but not through Meltdow. Therefore we can merge the user and kernel
>>> exposed address spaces.
>>>=20
>>> And then we've fully replaced PTI.
>>>=20
>>> So no, they're not orthogonal.
>> Right. If we decide to expose more parts of the kernel mappings then that=
's
>> just adding more stuff to the existing user (PTI) map mechanics.
>=20
> If we expose more parts of the kernel mapping by adding them to the existi=
ng
> user (PTI) map, then we only control the mapping of kernel sensitive data b=
ut
> we don't control user mapping (with ASI, we exclude all user mappings).
>=20
> How would you control the mapping of userland sensitive data and exclude t=
hem
> from the user map?

As I see it, if we think part of the kernel is okay to leak to VM guests, th=
en it should think it=E2=80=99s okay to leak to userspace and versa. At the e=
nd of the day, this may just have to come down to an administrator=E2=80=99s=
 choice of how careful the mitigations need to be.

> Would you have the application explicitly identify sensitive
> data (like Andy suggested with a /dev/xpfo device)?

That=E2=80=99s not really the intent of my suggestion. I was suggesting that=
 maybe we don=E2=80=99t need ASI at all if we allow VMs to exclude their mem=
ory from the kernel mapping entirely.  Heck, in a setup like this, we can ma=
ybe even get away with turning PTI off under very, very controlled circumsta=
nces.  I=E2=80=99m not quite sure what to do about the kernel random pools, t=
hough.=
