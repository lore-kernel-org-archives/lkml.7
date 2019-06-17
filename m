Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D32C31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0E7208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560786893;
	bh=aQEphLJjoGNsTWF7PUdVBXP9/NtJHbD77gDyFsJX9OY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GZJxubBe+nvmnpICjYWcHx3+Ziqw0nURq9+Q0Q/2eEHqCQkxbsgnfgGF0tscpwDuD
	 ncEUJAjld05A1rOwz5DNq77sgbwOqQe7hlU9AUMY58kRiuZHvkRmO1j4FPWG0MgpmQ
	 aHpBA7MVuplHdYAnKI9ylO0T+lj4pgY15rXnkOdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfFQPyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728519AbfFQPyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:54:50 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E75932166E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 15:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560786890;
        bh=aQEphLJjoGNsTWF7PUdVBXP9/NtJHbD77gDyFsJX9OY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qhOUahTGEyUHegfv4CFWy7tkV4dfGHY5ttlEqkwBP2tiXzGEfMzJPElZH2oeSSJA0
         rsnYLYI8jLtjfOKiK5Ee2GKss2TnarwRGAOSUPGb+qZpd65W4APU5Itf6Ar+aac5xH
         gguaXWWoFgjuokF/kcsWPV63ALSIUKuQ4QvaRPnU=
Received: by mail-wr1-f50.google.com with SMTP id d18so10559945wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 08:54:49 -0700 (PDT)
X-Gm-Message-State: APjAAAWfZuN+U9JO6lqigHzzD2E+lK5jMVxF5ojdeVNXxAgUnJvw8z3n
        qem0+sFJijAYaRS7OJxCev2mze+FHi/y4HIgurdedw==
X-Google-Smtp-Source: APXvYqykHUxihfkEY2tiikg8dXKgA4M9BplCJytE01KiNZl2hAMC6m+RW666K7HHMIykrPzo3dGyP3UaxzXnfm7HuLw=
X-Received: by 2002:a5d:6207:: with SMTP id y7mr55951191wru.265.1560786888514;
 Mon, 17 Jun 2019 08:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190612170834.14855-1-mhillenb@amazon.de> <eecc856f-7f3f-ed11-3457-ea832351e963@intel.com>
 <A542C98B-486C-4849-9DAC-2355F0F89A20@amacapital.net> <alpine.DEB.2.21.1906141618000.1722@nanos.tec.linutronix.de>
 <58788f05-04c3-e71c-12c3-0123be55012c@amazon.com> <63b1b249-6bc7-ffd9-99db-d36dd3f1a962@intel.com>
In-Reply-To: <63b1b249-6bc7-ffd9-99db-d36dd3f1a962@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 17 Jun 2019 08:54:36 -0700
X-Gmail-Original-Message-ID: <CALCETrXph3Zg907kWTn6gAsZVsPbCB3A2XuNf0hy5Ez2jm2aNQ@mail.gmail.com>
Message-ID: <CALCETrXph3Zg907kWTn6gAsZVsPbCB3A2XuNf0hy5Ez2jm2aNQ@mail.gmail.com>
Subject: Re: [RFC 00/10] Process-local memory allocations for hiding KVM secrets
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alexander Graf <graf@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marius Hillenbrand <mhillenb@amazon.de>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Alexander Graf <graf@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 8:50 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/17/19 12:38 AM, Alexander Graf wrote:
> >> Yes I know, but as a benefit we could get rid of all the GSBASE
> >> horrors in
> >> the entry code as we could just put the percpu space into the local PGD.
> >
> > Would that mean that with Meltdown affected CPUs we open speculation
> > attacks against the mmlocal memory from KVM user space?
>
> Not necessarily.  There would likely be a _set_ of local PGDs.  We could
> still have pair of PTI PGDs just like we do know, they'd just be a local
> PGD pair.
>

Unfortunately, this would mean that we need to sync twice as many
top-level entries when we context switch.
