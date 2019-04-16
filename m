Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C240C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D12A2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="n7f0b46/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfDPFVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 01:21:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41633 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfDPFVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 01:21:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id w30so21926617qta.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 22:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lz9Hz4ZbqFyVEt168korXa9MrletdxQKUiTb4F1So3Q=;
        b=n7f0b46/7gqDXlhSCN5OBr87MyNrmNa264JzuzeEKP1i5OSz4QirUYpOxH7g4EE/Sb
         5JKARwqNSey1eqR6xOMXvulgxxnGbyCa/kf4id31WZdqOl553TuatYGpWrUFhdC+yykF
         9g6s4+cU73kmCv9db3tavoO6PvBsiuUl0Q3Z+tvxFUihTlbMX5Cr87iA7w/+jyTYZIvB
         Zo4OM0zK8BJDAEFM7sbJmBqChLa36pSKdScfG8WVbCf3nSzl/VrZSB6UIfkv9h6vUlM3
         CI66rSvSoTbYlU9NtjEUrOvmR8yiLYGwqHqvf/FHeCVJr/WzSqL4oMN+lRhLsFFE4Ly4
         J3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lz9Hz4ZbqFyVEt168korXa9MrletdxQKUiTb4F1So3Q=;
        b=ohkbaaEy/lfkR5Kzcy4jfZW+NHE2Lb5aKRNQrWENsN3SW9uVSS5l3WFX7LQK2vBE9v
         KY4pIzeUbVLeAtF/XuqxhIKWLacIzGeIfr4XIxFVJ4+vu2prowtiNLa9o22/C7TtiDUl
         yQ1Q6F21txep5Hjc8Kz0dIiwX54BUKk9FNnKbIKcF7dFi+KPA3mGsCa2skZqKZGxBxAn
         RQ+BFjoMN6EsrV3MPL/3b6B6kEg54AM3ZX1DFMv52FhaEcie4Tt+czQlqRcqLx9RFbC8
         F1ZGCN5/UTI2asWYQQMkM0K2n/0/A1LUpKZwYj9FUFfhs3A4MEwMSomdyY0fOOM/Fv20
         tl6Q==
X-Gm-Message-State: APjAAAU1WNESVzFSX2k9OuolEvkuiNIjp4yBrZCRW4RnujjnVkGIStdg
        BTr8l9syGSS/+u8P4QYWHa8R697ahYj0Ww/YlHMfHA==
X-Google-Smtp-Source: APXvYqwy9rZeeSYX+bPKjnk+yiFVc7YGa8cB4GbPEhklEUYGk38u58gjNGCG2dXm7vGdkCxJP7PD/d56qkbzru/B0UA=
X-Received: by 2002:a0c:ba8b:: with SMTP id x11mr63127338qvf.196.1555392093573;
 Mon, 15 Apr 2019 22:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp45fedoPLnK=UmUhhtkjy5u2h04sYKrx3U+m04U6FpVZ4A@mail.gmail.com>
 <alpine.DEB.2.21.1904031206440.1967@nanos.tec.linutronix.de>
 <CAD8Lp45nvFY=nj1q2wh4Y6w-8RVRfi3iJmC+xX1Vv7_VZOftdg@mail.gmail.com> <alpine.DEB.2.21.1904101442080.3479@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904101442080.3479@nanos.tec.linutronix.de>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 16 Apr 2019 13:21:22 +0800
Message-ID: <CAD8Lp45_JVnusGVa7CPTTd6ji3AFkFUtbPnFhpTfyvR4LPM=aQ@mail.gmail.com>
Subject: Re: No 8254 PIT & no HPET on new Intel N3350 platforms causes kernel
 panic during early boot
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Hans de Goede <hdegoede@redhat.com>,
        david.e.box@linux.intel.com,
        Endless Linux Upstreaming Team <linux@endlessm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 8:54 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 9 Apr 2019, Daniel Drake wrote:
> > On Wed, Apr 3, 2019 at 7:21 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >          - Prevent the TSC calibration code from touching PIT/HPET. It
> > >            should do that already when the TSC frequency can be retrieved
> > >            via CPUID or MSR. Should work, emphasis on should ...
> >
> > >From above, this seems to be working acceptably already. It does touch
> > the PIT, but ultimately ignores the information that it provided.
>
> Yes, but we might actually be smarter than that.

Do you have anything specific in mind?

You originally laid out this idea in the context of doing this if the
PIT/HPET is not working. However, I can't immediately see how to judge
that because:
- According to the analysis in my last mail, the PIT is actually
ticking even when it is gated in the BIOS. The BIOS setting just seems
to make it tick 4 times slower and not generate any IRQ0 interrupts.
- TSC calibration code runs really early during boot. To make it
detect this situation we could make it check if IRQ0 is working,
however setup_default_timer_irq() only happens a lot later, so I'm not
sure how this could be checked at such an early stage.

I think I'm now fairly clear on the other suggestions you have made so
I'll see if I can come up with some patches.

Thanks!
Daniel
