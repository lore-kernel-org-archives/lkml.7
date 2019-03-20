Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6146FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C0E2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="b14RFkdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfCTOvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:51:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46145 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfCTOvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:51:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so1853636pfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 07:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Cux81Nb/mkGVNNBd664Ke7OVASRtYEGVnVz4ins3jKE=;
        b=b14RFkdiigwlHIF0ccPOgC+3FEXNAdhmPZMIqMc/djtnb4z6S9eYBQBLveAg/6SBiq
         50AnSpqkCtZNAhMsCSOk7ZckvGparXfTWUQxl2m5JQTNnuOZ/1UlchIsiK7QvlwxazzY
         N5gNeA3oJcE3aSJhRWNigEH8KWq6ykos+llYrftPae2vDvuhc13qB0eXEm7UBM3J4O+C
         DH5tx5kSYkIrtbY2iUfqwas4TNdHu7Oj3j5iWuHXWynAkwrHLZalfX1F3rZzfiT3NxVE
         ycgJANRk3kD2zJTuo7M88q8gywzNMAc27pxIbH1eE5Dl/OKOKELQRq9UQB90wF0XAUXl
         NAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Cux81Nb/mkGVNNBd664Ke7OVASRtYEGVnVz4ins3jKE=;
        b=mKX/1h7J/AucLECjOHZZoQDWeAI+7VT50Y5bfVi4gP52oqfDP6DSs7lIkhhkb5BDYg
         ltpFGibgqIDrPGb7Pbd0//DKSykU3FHXTNXHDlpJz9Ad0gKz5G5RO83QthteK3zTV0je
         +A6FzxVZxqmjg0ea61weT8tmQVzp8EP2gb9bElghHGaJS7o83n/c116whmO7lKUaEtL/
         gc9RAe690aIwgFD7z+EmnjefFzwFWjXhSgvzAuiQM0B77KCnHe0KFGeEr0OajMwSWOo1
         4OPCIhDsOoC7K6XkdFEXBkLhET7Vg7HDM6Wokx4mn9V3GSwN48zDXKozglMLEDzQoHg8
         EvHQ==
X-Gm-Message-State: APjAAAXEjlAxOfG4yPi3E2gYKpa+z0ftORiJtpq4iyRSrT6M1OfJZFzt
        rgm6Puh7NGjA0bKVUiordLdYGw==
X-Google-Smtp-Source: APXvYqyDvqly4ubx2cdqZXAlBXZY7Fe7z0wZvONdbfJHoA+AGuNBQPVGqaUpuYq89ESrv4QCzM/WGA==
X-Received: by 2002:a63:c149:: with SMTP id p9mr7778882pgi.362.1553093463901;
        Wed, 20 Mar 2019 07:51:03 -0700 (PDT)
Received: from ?IPv6:2600:1010:b01f:ea94:84dd:9ed8:80e7:caaa? ([2600:1010:b01f:ea94:84dd:9ed8:80e7:caaa])
        by smtp.gmail.com with ESMTPSA id g188sm4798970pfc.24.2019.03.20.07.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 07:51:02 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH] x86/entry/64: randomize kernel stack offset upon syscall
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <30998bcd55a34ed38b681f9bb3e3fb87@AcuMS.aculab.com>
Date:   Wed, 20 Mar 2019 07:51:01 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <25395187-837A-4689-9387-5ACCE78E4DF3@amacapital.net>
References: <20190318094128.1488-1-elena.reshetova@intel.com> <CALCETrUxhzHyUQCAjPQcPNWwAw5UTxUX4ZaeGxpbf9VSCDdcPg@mail.gmail.com> <30998bcd55a34ed38b681f9bb3e3fb87@AcuMS.aculab.com>
To:     David Laight <David.Laight@aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 20, 2019, at 4:12 AM, David Laight <David.Laight@aculab.com> wrote:=

>=20
> From: Andy Lutomirski
>> Sent: 18 March 2019 20:16
> ...
>>> As a result this patch introduces 8 bits of randomness
>>> (bits 4 - 11 are randomized, bits 0-3 must be zero due to stack alignmen=
t)
>>> after pt_regs location on the thread stack.
>>> The amount of randomness can be adjusted based on how much of the
>>> stack space we wish/can trade for security.
>>=20
>> Why do you need four zero bits at the bottom?  x86_64 Linux only
>> maintains 8 byte stack alignment.
>=20
> ISTR that the gcc developers arbitrarily changed the alignment
> a few years ago.
> If the stack is only 8 byte aligned and you allocate a variable that
> requires 16 byte alignment you need gcc to generate the extra stack
> frame to align the stack.
> I don't remember seeing the relevant gcc options on the linux
> gcc command lines.
>=20


On older gcc, you *can=E2=80=99t* set the relevant command line options beca=
use gcc was daft.  So we just crossed out fingers and hope led for the best.=
  On newer gcc, we set the options.  Fortunately, 32-byte stack variable ali=
gnment works regardless.

AFAIK x86_64 Linux has never aligned the stack to 16 bytes.=
