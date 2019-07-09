Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3DAC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4341C214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Hm1OhBOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfGINIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 09:08:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40887 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGINIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:08:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so17698541eds.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 06:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZUz4WDQf+ePZiJBY+IeyizcaneS7fRJMcv4JWg/06b8=;
        b=Hm1OhBOVDMZQHda4zzcLuqGw7waEGq2WvK+G8jN8/SRdmwfeo/59Bi1wqs5ICvYh45
         GSjHRCeswdfMkPiDeZA4K7UuRQ+BVA61r4PJ6Dtal6ytrFHpU6gZjMj/6wjBhdP3VjxE
         gy2rOEL5UW0eDkKhXLHxmiw6wc3KjwZu15XvEPQ54pKulEfTZdYyjRjm5VPGzd5S84dg
         Ov9r7Pm2PMSdm3IS9926s6o8cfugx62BAxygvgcv5VnWSurbToFFkRfD9DFMr31Bg8rC
         QRb/uiLG96RBV5+2aXtAVpUJ7HGaNLcmpvDHc8a5cLRQO52fZuUjLf2QN5y+OcMPBFvw
         g6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZUz4WDQf+ePZiJBY+IeyizcaneS7fRJMcv4JWg/06b8=;
        b=W7WUrhDIWaigc7NZt4rOysCEiklW6t4BwaUPLegZHweWTOFJ+pqn+5tE4tvOxdBu5B
         sGpU8RYL/rTC3H4aqunz7+2tincdDmOWvPLQ/6T3QOaecRm/iwL9sm9WZ5Y4D9aws8Y6
         8eq5CuJLZ6RT9b57mDOqUGdStyymWUxBwU4n+HI7n6nQ5ZAh0m+JWe7JYeL/bH6lUvoU
         IMmb1VwmF/wZbIcdKRC5dtIaNncfqndGDvqjZYZCgnj388fU3MG235TEbQQ+5gDiYVtR
         ZruUOA0hqmRTUe+OZPFGJMysRyAEc7Oh2cYsbXxXtjL+jGqdDQCqY9u44U1SPRhIFgS8
         3V0A==
X-Gm-Message-State: APjAAAXm7iikVzzL/1pbD/JVq7+CfQL+5QL67wLiyZNHwgQooVf7HXp3
        uR4a7IMKEg0pMs4/3UHvygOeeS3/vVY2a7yluxfMhg==
X-Google-Smtp-Source: APXvYqxiyJAFhEGRILc1BLQA9hva/JyooHVB+Ro4OjuwmAXAGlQqOwGA/cJXY+H0KZR6uBrhYIjHWmDcBko3Uo9wDmU=
X-Received: by 2002:a50:a4ef:: with SMTP id x44mr25897335edb.304.1562677684997;
 Tue, 09 Jul 2019 06:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190708211528.12392-1-pasha.tatashin@soleen.com>
 <CACi5LpNGWhTnXyM8gB0Tn=682+08s-ppfDpX2SawfxMvue1GTQ@mail.gmail.com>
 <CA+CK2bBrwBHhD-PFO_gVnDYoFi0Su6t456WNdtBWpOe4qM+oww@mail.gmail.com> <2d60f302-5161-638a-76cd-d7d79e5631fe@arm.com>
In-Reply-To: <2d60f302-5161-638a-76cd-d7d79e5631fe@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 9 Jul 2019 09:07:54 -0400
Message-ID: <CA+CK2bA40wQvX=KieE5Qg2Ny5ZyiDAAjAb9W7Phu2Ou_9r6bOA@mail.gmail.com>
Subject: Re: [v1 0/5] allow to reserve memory for normal kexec kernel
To:     James Morse <james.morse@arm.com>
Cc:     Bhupesh Sharma <bhsharma@redhat.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Enabling MMU and D-Cache for relocation  would essentially require the
> > same changes in kernel. Could you please share exactly why these were
> > not accepted upstream into kexec-tools?
>
> Because '--no-checks' is a much simpler alternative.
>
> More of the discussion:
> https://lore.kernel.org/linux-arm-kernel/5599813d-f83c-d154-287a-c131c48292ca@arm.com/
>
> While you can make purgatory a fully-fledged operating system, it doesn't really need to
> do anything on arm64. Errata-workarounds alone are a reason not do start down this path.

Thank you James. I will summaries the information gathered from the
yesterday's/today's discussion and add it to the cover letter together
with ARM64 tag. I think, the patch series makes sense for ARM64 only,
unless there are other platforms that disable caching/MMU during
relocation.

Thank you,
Pasha


>
>
> Thanks,
>
> James
