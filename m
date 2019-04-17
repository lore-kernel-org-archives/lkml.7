Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74657C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357D721850
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz4JnTW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732988AbfDQRUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:20:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37488 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732905AbfDQRT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:19:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so12411409pfr.4;
        Wed, 17 Apr 2019 10:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V1yIYIvLzz+BOCdxdX2gjSKybWz8E9N/6tRrpN2enDY=;
        b=lz4JnTW0SxRkuzYb5nVwScOlj31C+NR7Pbf9V6itmwyvo+tcPA9xux9vHCBHlmzlf8
         l+V8GGCFjPLmvBpRzgeACiPtj6mSkfCDd56w0bYBQkYTi/I/GVwyrRB3giEJR/zpWrC4
         Ly8vw18KA3Ytm2WNNnQcY8KjOlhY9n59X1m03ngRjQ/6YOOtXsB0oAtRdnVrdBL5lghC
         QBkS95ipjK32Jj5COWARIon/mFRjh9umt56N+abO+6I5bCPJQveIPH6XghPnvqF21iIb
         6KuFUeO5O8Syhf418LaQuuqrU8N7SpRNvehZAKN9N0qsgeiSnMw38h0ltYF4duUQ5Hob
         SBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V1yIYIvLzz+BOCdxdX2gjSKybWz8E9N/6tRrpN2enDY=;
        b=AB+/5bNqzE8pPKMWg9FiN//MJYp3G1BhgJSc/dK3fyktQOWyPLdJyLHxV9tntozdnb
         cf0TBXLrcllVT12pP2ij/P3plJTU362VNXTcaFgrE3z6smBoYcF6Lv07DaewFtujuKfi
         NP6rq7N5tJ26iGeQTj2VWruA8HBQKmXLw35XXy4uNP9RE8D5FJmbaFywgdAN1nTC0kKv
         zmgM6m3ZVGsFeua8grL5fCrQqvlyZ/lK7qzYMhTWd+X7M1zBk3j14PWDeYfUWMEd02Ma
         gWWq7eQRuBhglXizoJOsZB7UHsEfOWAzHZR0NKUaL6GlWws7DNW98aeaZAbGAU+XNgSH
         z/gw==
X-Gm-Message-State: APjAAAVZar6fhiCvhSUN1mDOVEOSESRq+jGCoH0PjzVR8CtIg2UsJn0P
        mGI4pMZrX9G5sUA3obemFGk=
X-Google-Smtp-Source: APXvYqw8tbbQTyJUpI8x5or/uOxF5UZyuqm6K8VfzwsOuau8hPR4i1Hby9IWvX82aT/ndMHLmdxiHA==
X-Received: by 2002:aa7:814e:: with SMTP id d14mr90827247pfn.101.1555521598738;
        Wed, 17 Apr 2019 10:19:58 -0700 (PDT)
Received: from [10.33.115.113] ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id b7sm149466641pfj.67.2019.04.17.10.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:19:57 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20190417170918.GA68678@gmail.com>
Date:   Wed, 17 Apr 2019 10:19:54 -0700
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
Message-Id: <56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
 <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com>
 <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
 <20190417170918.GA68678@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 17, 2019, at 10:09 AM, Ingo Molnar <mingo@kernel.org> wrote:
>=20
>=20
> * Khalid Aziz <khalid.aziz@oracle.com> wrote:
>=20
>>> I.e. the original motivation of the XPFO patches was to prevent =
execution=20
>>> of direct kernel mappings. Is this motivation still present if those=20=

>>> mappings are non-executable?
>>>=20
>>> (Sorry if this has been asked and answered in previous discussions.)
>>=20
>> Hi Ingo,
>>=20
>> That is a good question. Because of the cost of XPFO, we have to be =
very
>> sure we need this protection. The paper from Vasileios, Michalis and
>> Angelos - <http://www.cs.columbia.edu/~vpk/papers/ret2dir.sec14.pdf>,
>> does go into how ret2dir attacks can bypass SMAP/SMEP in sections 6.1
>> and 6.2.
>=20
> So it would be nice if you could generally summarize external =
arguments=20
> when defending a patchset, instead of me having to dig through a PDF=20=

> which not only causes me to spend time that you probably already spent=20=

> reading that PDF, but I might also interpret it incorrectly. ;-)
>=20
> The PDF you cited says this:
>=20
>  "Unfortunately, as shown in Table 1, the W^X prop-erty is not =
enforced=20
>   in many platforms, including x86-64.  In our example, the content of=20=

>   user address 0xBEEF000 is also accessible through kernel address=20
>   0xFFFF87FF9F080000 as plain, executable code."
>=20
> Is this actually true of modern x86-64 kernels? We've locked down W^X=20=

> protections in general.

As I was curious, I looked at the paper. Here is a quote from it:

"In x86-64, however, the permissions of physmap are not in sane state.
Kernels up to v3.8.13 violate the W^X property by mapping the entire =
region
as =E2=80=9Creadable, writeable, and executable=E2=80=9D (RWX)=E2=80=94onl=
y very recent kernels
(=E2=89=A5v3.9) use the more conservative RW mapping.=E2=80=9D

