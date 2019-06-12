Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B8CC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A783620866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="dosYpfHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389264AbfFLU1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 16:27:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40700 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389032AbfFLU1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 16:27:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so7104041pla.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wQSIjj1uz1dtSEsQ8et37d1oi55PupCcmG/N44FomHg=;
        b=dosYpfHyXQnOIHiak4h4vT7DtMsiDthIYDzQhi40A07vw+2UujEnaY2h1t/znWnsFr
         quz6BW2DabQNadx+sDAO2O97r0jLz2nrIHQjYC9CHjraeetUerSWSoTLviI8HPycXoZZ
         EhrCJYG29dvXZxU6C2YJtgjuh1T7f1raROHKgUW3XwqaYfDhqi2gu8n47/JClJNSwZFK
         Cy50WsRvmzOO0Wm82pvIO18xzLdWmPQlSHYbVv4RpfrfhpGtr7WHpa/8Vj6GKkjUbi4J
         I1Lys/X6FYmMf0ochoRNkJNNr7r0V1GDgqmSXn2lH+6rIIfw12YCjQ4hkbB9ywHjoOzK
         tg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wQSIjj1uz1dtSEsQ8et37d1oi55PupCcmG/N44FomHg=;
        b=U1f0gksR+jicnacwq/rT4b6ar2lFw6aNoGAyYSPbkafRqi7nnCnxcNDwTuSroV34AG
         lLxThDTppN/rPDv+xCrh3Y+WKz+Pjr4zVV9lEC28YeDiKD9aEYnS8UOTC1elTru44L03
         nTBAeFXIIhJohfprIy3Z8Jozwix9ojJ5EsOT6nXdpnPfIOIQ1lLYRN4V8s0TbuNqCGmd
         Cx9t8CXyHqaMS4wDikNIzmDgeTuyykzKwrv9uMseaWP5IoFHZesrLLirFJfRjCHO+kTD
         tIBTHDuznEHZaNSw0yO/IE+y2mugFz4XC1S2UE1LXEgl+pNbyRHdFMGtY+msJjMhEsKK
         Pogg==
X-Gm-Message-State: APjAAAUu0QRKW7blcbincj8R6tDx40e+q8dt1SxJg8lN905y6n1PJjEP
        05vsid1r7LcVy6WX/wqPJ8PmAMThc5ixCg==
X-Google-Smtp-Source: APXvYqz0dHD5fq+ketC5HFnEXuKjsrvf/JQonYxBDCeP2VEnkY8AJZcbmbqYowRApnU+lnXqwECpog==
X-Received: by 2002:a17:902:760f:: with SMTP id k15mr58881187pll.125.1560371227543;
        Wed, 12 Jun 2019 13:27:07 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:e92e:2d95:2c68:42e6? ([2601:646:c200:1ef2:e92e:2d95:2c68:42e6])
        by smtp.gmail.com with ESMTPSA id m1sm267870pjv.22.2019.06.12.13.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 13:27:06 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 00/10] Process-local memory allocations for hiding KVM secrets
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <eecc856f-7f3f-ed11-3457-ea832351e963@intel.com>
Date:   Wed, 12 Jun 2019 13:27:04 -0700
Cc:     Marius Hillenbrand <mhillenb@amazon.de>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, Alexander Graf <graf@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A542C98B-486C-4849-9DAC-2355F0F89A20@amacapital.net>
References: <20190612170834.14855-1-mhillenb@amazon.de> <eecc856f-7f3f-ed11-3457-ea832351e963@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 12, 2019, at 12:55 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
>> On 6/12/19 10:08 AM, Marius Hillenbrand wrote:
>> This patch series proposes to introduce a region for what we call
>> process-local memory into the kernel's virtual address space.=20
>=20
> It might be fun to cc some x86 folks on this series.  They might have
> some relevant opinions. ;)
>=20
> A few high-level questions:
>=20
> Why go to all this trouble to hide guest state like registers if all the
> guest data itself is still mapped?
>=20
> Where's the context-switching code?  Did I just miss it?
>=20
> We've discussed having per-cpu page tables where a given PGD is only in
> use from one CPU at a time.  I *think* this scheme still works in such a
> case, it just adds one more PGD entry that would have to context-switched.=


Fair warning: Linus is on record as absolutely hating this idea. He might ch=
ange his mind, but it=E2=80=99s an uphill battle.=
