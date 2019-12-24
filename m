Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB8FC2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446F820706
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="AQugnPU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfLXMEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 07:04:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36056 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfLXMEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 07:04:37 -0500
Received: by mail-pl1-f194.google.com with SMTP id a6so7668261plm.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 04:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=VHzH6WH6Y51Hv8qWhxgK6vx35XDhgJUQtiy7D9VMqAM=;
        b=AQugnPU1j3l+UliZJ1cFDWfn1gfoQcO/nzfL11rOcYeTLX/P87iqPaaJmBaMlSz7f1
         /DhGazm2NTR2ZIaiN+mUvEAnOZrI7Ge0Mg1zI2ZlVdeTi0aTgDWcWRqSCId8E113LX3m
         6HCYlixeRMc9TaLMlaAzwKbLAUzigX1Ncl8C866LmmeME3vMRc45SQjPLyr6MHX+L6Cw
         vv52P5dueRyUQBwwusD+tHpoqoHbOj8XjhE0q9U9hlqCHn27d/gBrcaQanBO29ITAp34
         bn7tzg79vFow2UHY2TlVVezhuLVq4rXQXKJzfTff9415HHT3maptkAcWgSZsizcHzud6
         8efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=VHzH6WH6Y51Hv8qWhxgK6vx35XDhgJUQtiy7D9VMqAM=;
        b=qZ6jw0fR2Jp8BINT1XgnIq9yXFJXpnI+a1IcBnhsmLXTuJr3xKIf0OsarH58A/ku3P
         mUSJOrO9toF45jlT/S8VVoT2pr22/Bdr5vaGfL9gBCszmFzt2zfM55fCv111E2IMy+/0
         slIXJM4fRHSdg+2/m+s/mr9Sk0kogzca4VCsb5QxFlvMXlMVVbExgM+5NhKUOClETcHs
         +bOmLmCAGNwQCR62l++0h/lJa8XjpnvVY+1ASmNEPDCV2yP3KO9YOvkrZCH8TLd+jF79
         b2ZVUqU0Z685TY0WShFfmeOtMk3vIyc4GW1yYOQ5E3lo+bTDjBvn7FSDitR3Ie9hx7qs
         /9Zg==
X-Gm-Message-State: APjAAAWmsDy2WUy+hT+RHGvpJ+fnUYJRU2JVlv2JqGV4eTg6PY+h/AQL
        Gn5kJsxN37DYjnfFv0WTBXzOsw==
X-Google-Smtp-Source: APXvYqyJXa2dY59EyR45IM7PX4/Dja/wo48oiNHNLhyt3TL1GWpIJ61wHLTCUZ3QRkI0SvFitogUkA==
X-Received: by 2002:a17:902:7288:: with SMTP id d8mr34182926pll.341.1577189076952;
        Tue, 24 Dec 2019 04:04:36 -0800 (PST)
Received: from [192.168.0.9] (111-255-104-19.dynamic-ip.hinet.net. [111.255.104.19])
        by smtp.gmail.com with ESMTPSA id k21sm14926039pfa.63.2019.12.24.04.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2019 04:04:36 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2 07/10] lib: vdso: don't use READ_ONCE() in __c_kernel_time()
Date:   Tue, 24 Dec 2019 20:04:33 +0800
Message-Id: <98C1F790-7647-4203-9B31-4B8FED8CCA12@amacapital.net>
References: <abc4b4a6-d355-4dfd-a207-603e877b2b23@c-s.fr>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        X86 ML <x86@kernel.org>
In-Reply-To: <abc4b4a6-d355-4dfd-a207-603e877b2b23@c-s.fr>
To:     christophe leroy <christophe.leroy@c-s.fr>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Dec 24, 2019, at 7:12 PM, christophe leroy <christophe.leroy@c-s.fr> wr=
ote:
>=20
> =EF=BB=BF
>=20
>> Le 24/12/2019 =C3=A0 02:58, Andy Lutomirski a =C3=A9crit :
>>> On Mon, Dec 23, 2019 at 6:31 AM Christophe Leroy
>>> <christophe.leroy@c-s.fr> wrote:
>>>=20
>>> READ_ONCE() forces the read of the 64 bit value of
>>> vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec allthough
>>> only the lower part is needed.
>> Seems reasonable and very unlikely to be harmful.  That being said,
>> this function really ought to be considered deprecated -- 32-bit
>> time_t is insufficient.
>> Do you get even better code if you move the read into the if statement?
>=20
> Euh ...
>=20
> How can you return t when time pointer is NULL if you read t only when tim=
e pointer is not NULL ?
>=20
>=20

Duh, never mind.

But this means your patch may be buggy: you need to make sure the compiler r=
eturns the *same* value it stores. Maybe you=E2=80=99re saved by the potenti=
al aliasing between the data page and the passed parameter and the value you=
 read, but that=E2=80=99sa bad thing to rely on.

Try barrier() after the read.=
