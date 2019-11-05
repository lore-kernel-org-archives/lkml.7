Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D51C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63ED621929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="VGc5idT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbfKEWB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:01:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41632 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730083AbfKEWBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 17:01:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id l3so15498227pgr.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 14:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=A7ntIP7Pv94+JyCxBKyO+PR3oB2uhF7aSLknMJuGR54=;
        b=VGc5idT9oHFqNsyfeJQtiLGXaEfzZs+LnizeeHBN1hf2vJvDrjEssRXM+KqyPON/w4
         XnbKdYccr81lAD6e/iN+6l/Dq4tPu19pl0UnJ7fciIZ9/6AONcHVukjFewb4PchiDh17
         7ZPZihF1wJOMYKdIhjYSl5xVnwOnB1EbvZ1sv1e3OAKgQ5U7yKAERlW6szd40jmA1zkn
         AdFoPGkYJ3soBf432/rLYCS2v3QEXbCMHLpbH+eSaEQajYxFxt/RFcs7NZkkeYCP0Mmz
         kSc179mn0fGmgKGYJOb0sxsR7zgDRZPjOIBYL/0etkwTHLQn3m8fO5gAB5AGU8D5TsRQ
         sfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=A7ntIP7Pv94+JyCxBKyO+PR3oB2uhF7aSLknMJuGR54=;
        b=B4AN2fg9fOUtQrjWLn3y5bA1UxpOevBtRXorRU9Ftfjc3NQFKMg7OlCr2amEpXZRSu
         5wFJIchSCHIgGC/W+U53YslC3GCDUFszc7cuJYTVACWrQSNVqGuz2q7UIbaG0D1VVAj8
         Zgdu4jzsdiX3K1YUwbeqIpckxuIcV9anhRWkqy5K9xGoNsnTWXglXq1u9WNbxBXAfsYi
         Orn0rGnVZJiuToE7AQ++fYysyZvT2FbAu3MUd3XmYJtqm0oHmh1ppObImjkeuhGBeit6
         qexAoulOp/n1/+X7o2RZgx6PWtTWOnD5pVTY3WFiHJABRCSLgOGhsWRvzcWuwtrrSqxL
         8pfw==
X-Gm-Message-State: APjAAAVQAHF77x9UJmdd/ZArGQ5NSS1CfcmzqGV/mVqnvN4a3VffF2ix
        aexHyLUr4Pa/13Rvr2eXGt7K9g==
X-Google-Smtp-Source: APXvYqwUsPTDc+K+TskpjrNDhdQDKgpFn5VDt8mFWt45sM9wmJoBE2TnjPt+6qS429LWFbbmYiLhVA==
X-Received: by 2002:a65:49cf:: with SMTP id t15mr33651193pgs.144.1572991314644;
        Tue, 05 Nov 2019 14:01:54 -0800 (PST)
Received: from ?IPv6:2600:1010:b05d:f15:cda1:50c9:611b:faf7? ([2600:1010:b05d:f15:cda1:50c9:611b:faf7])
        by smtp.gmail.com with ESMTPSA id a33sm20535517pgb.57.2019.11.05.14.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 14:01:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK
Date:   Tue, 5 Nov 2019 14:01:51 -0800
Message-Id: <273986A1-A4BE-4FE5-B547-49CAA44C6FD3@amacapital.net>
References: <CAKOZuet+fgaJR72YwYrHFdFVSOo6EWpcT8jUoh7se4cZb0V2aw@mail.gmail.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
In-Reply-To: <CAKOZuet+fgaJR72YwYrHFdFVSOo6EWpcT8jUoh7se4cZb0V2aw@mail.gmail.com>
To:     Daniel Colascione <dancol@google.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 5, 2019, at 9:02 AM, Daniel Colascione <dancol@google.com> wrote:
>=20
> =EF=BB=BFOn Tue, Nov 5, 2019 at 8:56 AM Andrea Arcangeli <aarcange@redhat.=
com> wrote:
>>=20
>>> On Tue, Nov 05, 2019 at 08:39:26AM -0800, Daniel Colascione wrote:
>>> I'm not suggesting that we fail userfaultfd(2) without CAP_SYS_PTRACE.
>>> That would, as you point out, break things. I'm talking about
>>> recording *whether* we had CAP_SYS_PTRACE in an internal flag in the
>>> uffd context when we create the thing --- and then, at ioctl time,
>>> checking that flag, not the caller's CAP_SYS_PTRACE, to see whether
>>> UFFD_FEATURE_EVENT_FORK should be made available. This way, the
>>> security check hinges on whether the caller *at create time* was
>>> privileged.
>>=20
>> Until now it wasn't clear to me you still wanted to do the permission
>> check in UFFDIO_API time, and you only intended to move the
>> "measurement" of the capability to the syscall.
>>=20
>> So you're suggesting to add more kernel complexity to code pending for
>> removal to achieve a theoretically more pure solution in the band-aid
>> required to defer the removal of the posix-breaking read
>> implementation of the uffd fork feature?
>=20
> And you're suggesting making a security check work weirdly unlike most
> other security checks because you hope it'll get removed one day?
> Temporary solutions aren't, and if something goes into the kernel at
> all, it's worth getting right. The general rule is that access checks
> happen at open time. The kernel has already been bitten by UFFD
> exempting itself from the normal rules (e.g., the
> read(2)-makes-a-file-descriptor thing) in the name of expediency.
> There shouldn't be any more exceptions.

I don=E2=80=99t think ioctl() checking permission is particularly unusual. I=
n principle, it=E2=80=99s better than open for a retrofit =E2=80=94 open did=
n=E2=80=99t capture this permission in the past, so adding it makes an exist=
ing capability stronger than it was, which isn=E2=80=99t fantastic.=
