Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6503CC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A055215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N2wbjO7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbfJCU4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:56:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37213 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbfJCU4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 16:56:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id p1so684764pgi.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 13:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xKarWPt6lvQJGvS6YLjAUhktx3P1H06FEKjY24EE5Jw=;
        b=N2wbjO7zmQMQz/t4ljgc0TF/ObEvPwnzF1g3g8vfnQ4ia+DVPId7P6OeXnGqHRaGOk
         WHGiv4/ObZ0KYB4bRoFlH6h4ag7QiuhKTD7/ohoXYA4yImmx2bGROflqjWedJ0aWtGDK
         4e1nKlvyrHtP5Ru7mlJMS2wdVNPsOMuZzlb0jF20TYd87TYn+/avUlTMbvtF8S+Q49YN
         gCtSduE8FBNffOmgDvaqEbmvjeWhHGnwrcMv299mr4fkeKAVTHDARAeanLehxeDAUq79
         RwaBb379XDiSFDprzFg3L9E7ARcDq9CnOWozbZyRht8X0Hs1sco0piN/NfJ8KZZ3preQ
         mtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xKarWPt6lvQJGvS6YLjAUhktx3P1H06FEKjY24EE5Jw=;
        b=sW7fnNFA1/aRpfqwF5d9koIxS8fPke9ENJnis7MVkAeENBXuXn4D7VG224Gj+1zUPH
         ag+5/HaWWMAjOZUzwoYcYqg5SDn/Tfmpm5Eo9uCAXJ9uZzVJ/2mvICUhw1HAzvQJQs8z
         c0o+NVw1PVeGZ/tni6YTy1cmkBZ9Sp/2gRdyJyrB9/e/8s/9dESgKhdeFzAExPb/+D7L
         tFbV0w65G1GJEWzKirmrwiqKNsUt/RmbIW0jKTGfV/HvqPbcATlsrQFmNX5YTXgvtU6D
         12Ggne09Q9CfPrjQhG0sQUdKldKHZwDSUKyjXGI6bFXvaaeyZsabZ1WFzrAGw98B8cC5
         8YFQ==
X-Gm-Message-State: APjAAAXTBFRUERYxM4FpNo3gP4gu2tCFV9V9CAgsUyrmaZnPBZYu74Xw
        r9DHzimKMO6b/MwlK5GW/s5C+jZgN7Ys7EChYVHNvVhB
X-Google-Smtp-Source: APXvYqzepTwSLkK7xurMnEnd3RkNLkJ//qnYMQYypNWa2g9ldvI5+aGCn/jYSbxr/9DZIC/Q3+Dyw1SEpDKUCCqRcOU=
X-Received: by 2002:a63:d909:: with SMTP id r9mr11434400pgg.381.1570136210748;
 Thu, 03 Oct 2019 13:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191003174838.8872-1-vincenzo.frascino@arm.com>
 <20191003174838.8872-3-vincenzo.frascino@arm.com> <CAKwvOdmhyVHREHvyB0wL2GfMsE8GcJ1Ouj_8ifrR4hU8kBYukQ@mail.gmail.com>
 <20191003204944.6wuzflqkjdpawzvp@willie-the-truck>
In-Reply-To: <20191003204944.6wuzflqkjdpawzvp@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Oct 2019 13:56:39 -0700
Message-ID: <CAKwvOdm4ccfhXDDSKXgdN4qkn2NHwAHKCwRV7OqLEG_PQj09vQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] arm64: vdso32: Detect binutils support for dmb ishld
To:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 1:49 PM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Oct 03, 2019 at 01:18:16PM -0700, Nick Desaulniers wrote:
> > On Thu, Oct 3, 2019 at 10:48 AM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> > >
> > > Older versions of binutils that do not support certain types of memory
> > > barriers can cause build failure of the vdso32 library.
> >
> > Do you know specific version numbers of binutils that are affected?
> > May be helpful to have in the commit message just for future
> > travelers.
>
> A quick bit of archaeology suggests e797f7e0b2be added this back in 2012,
> which seems to correlate with the 2.24 release.

Cool, thanks for digging.  Vincenzo, can we please add that to the
commit message?
-- 
Thanks,
~Nick Desaulniers
