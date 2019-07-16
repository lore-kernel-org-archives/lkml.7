Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3976CC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1243C2173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UxyLjO/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388668AbfGPWHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:07:14 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44935 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388447AbfGPWHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:07:14 -0400
Received: by mail-ot1-f65.google.com with SMTP id b7so22767190otl.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=am3zTTAioUL0WnBW6RccNxphyDc3aO0XKt7PXXLcHQ8=;
        b=UxyLjO/rW4wV+XGw3XGomgV83T/DKFlBystntsKgmvFkWmCwMpj/GM1V9lthCAaawH
         nN2CpACN8q+A0EP0pjJ/NzdCHbXnhaPvZxcvgTlK5YKUYE8G3wjU8E5R1cpJPvUJEQGK
         T4wUbFt57KyYzIMCQBzzack4HRvbwTcdYv4wyQjEL2gbyUfTvZzUKVB2lfDGb2utJmTr
         yLHu8JQguEmIFgxF3sZpQoANON1BeFbk735OqwlbGJ/BX1TOIxUymC6rtPDCUgjiv1WS
         dSq5YbkzLmAfcbuH2eOUWFXsy483B0KKD5VTIvPVEjEL0gqBIpNLA1bJ3QF1ImtcdbIf
         uiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=am3zTTAioUL0WnBW6RccNxphyDc3aO0XKt7PXXLcHQ8=;
        b=mE7TETnrZK4GEVpI5HHup+FaBJud/I6P8uliLk2a9XXCGMm/FLpSgIig4G5QihT+Qz
         dYO5aq7m3hQHDhnA83W0GB/LbXsOAQZeBqdnVvQh7j63+U+UsBoMxUN7c3LXAxC1greV
         DSXhyjEnFKNgtzKzvGSKDELBbO2jF39L6FTy3pb71t8IJ6Ap/upU/kebG7J5x53Mb2Rz
         m+c6SA0ZL632inUJu5YLCTA8GKStm+wA/bK9sUAAwl7PuAMn2i4XRTbpa+t0MqrNwuAl
         13DO2Zlyks8DGp9+zVSrgUmuPaLyDI1jbLXXTX7O3G3oia5OPDg3FCEn2kCD9JXFo6IT
         s4Qw==
X-Gm-Message-State: APjAAAXGidBScGWaVU9EXrFkzvIcssXdJpnj/0Jx6bt3d3zxuLxwj9TH
        Z1wbiJ982YyWPcprg56VJ56Z6yLUampBiEw/yEcYpg==
X-Google-Smtp-Source: APXvYqwh13LvFILQ4sc7Xet21Uj0uBONLPMpu0RdYeM/DiLsx/zxVJRrL7wQuzP6kM+SbvQZXwKMI1JwlYV3FYaciZA=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr18339062otn.247.1563314833269;
 Tue, 16 Jul 2019 15:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190613045903.4922-1-namit@vmware.com> <CAPcyv4hpWg5DWRhazS-ftyghiZP-J_M-7Vd5tiUd5UKONOib8g@mail.gmail.com>
 <9387A285-B768-4B58-B91B-61B70D964E6E@vmware.com> <CAPcyv4hstt+0teXPtAq2nwFQaNb9TujgetgWPVMOnYH8JwqGeA@mail.gmail.com>
 <19C3DCA0-823E-46CB-A758-D5F82C5FA3C8@vmware.com> <20190716150047.3c13945decc052c077e9ee1e@linux-foundation.org>
In-Reply-To: <20190716150047.3c13945decc052c077e9ee1e@linux-foundation.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Jul 2019 15:07:01 -0700
Message-ID: <CAPcyv4iqNHBy-_WbH9XBg5hSqxa=qnkc88EW5=g=-5845jNzsg@mail.gmail.com>
Subject: Re: [PATCH 0/3] resource: find_next_iomem_res() improvements
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nadav Amit <namit@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Borislav Petkov <bp@suse.de>,
        Toshi Kani <toshi.kani@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 3:01 PM Andrew Morton <akpm@linux-foundation.org> w=
rote:
>
> On Tue, 18 Jun 2019 21:56:43 +0000 Nadav Amit <namit@vmware.com> wrote:
>
> > > ...and is constant for the life of the device and all subsequent mapp=
ings.
> > >
> > >> Perhaps you want to cache the cachability-mode in vma->vm_page_prot =
(which I
> > >> see being done in quite a few cases), but I don=E2=80=99t know the c=
ode well enough
> > >> to be certain that every vma should have a single protection and tha=
t it
> > >> should not change afterwards.
> > >
> > > No, I'm thinking this would naturally fit as a property hanging off a
> > > 'struct dax_device', and then create a version of vmf_insert_mixed()
> > > and vmf_insert_pfn_pmd() that bypass track_pfn_insert() to insert tha=
t
> > > saved value.
> >
> > Thanks for the detailed explanation. I=E2=80=99ll give it a try (the mo=
ment I find
> > some free time). I still think that patch 2/3 is beneficial, but based =
on
> > your feedback, patch 3/3 should be dropped.
>
> It has been a while.  What should we do with
>
> resource-fix-locking-in-find_next_iomem_res.patch

This one looks obviously correct to me, you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> resource-avoid-unnecessary-lookups-in-find_next_iomem_res.patch

This one is a good bug report that we need to go fix pgprot lookups
for dax, but I don't think we need to increase the trickiness of the
core resource lookup code in the meantime.
