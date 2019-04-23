Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEADC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6FA208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/wr8asY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfDWSP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:15:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40356 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWSP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:15:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so7891368pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 11:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FV/NcFrzRWeOO+2zT710hr9wGxbQrLpeRbnYdiKJYjM=;
        b=N/wr8asY5Rx7HCprlfR5RiWUC4c76UdOUNaI2jwBIWLoXRI59zZVreJ6ePIoT6tjh5
         rZ23E3hWB6b3QMH7OmfW75ANn7dJM0yHhdYSywWaw8NvYvEFI2EQCtd5SCP2UEc5OuFJ
         xLxo2zxFZy8jdHmnWnAVVAtByx4eQCdbTM5dtHDI3gZmXQLW6S2HTeZMa3VGf5JPdQU+
         VTuNB3IxrtnsvvhA5zuAY4aRNNWRBgBziBhMcCR0azqh7rKIlGnalhlK3Mb5RaG4qcWm
         U4g/SIaEflEn5MzTmhLwf4RzDiftICQgYW2q1AUmnMkv65NTukAFSYg/4EkdfqBq7TYK
         F1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FV/NcFrzRWeOO+2zT710hr9wGxbQrLpeRbnYdiKJYjM=;
        b=NAKzve/rGdeh3aaU2vQUlN1mLAcU2o5VkA/FCfHprhrtMbThrnqSBngJ/aIIglz9+0
         Xu3d+xDdfpl4UeRufD0Q8xLfrv5czK8m2/6hpqENPeZZzbGvoDKRjCAtsUVLq7uiH1he
         oY65NDJ7AcDMcIL9ELdYufWbMTOpZj+xHj7IKj0g8mysbwcpW8re4D1f1sYNSxQLooZB
         NIcTIeQpgZo6bj7fy/WsS2q4ugJBZlbIt9QDoftZUS1m4eou1ynU7DtQI6XuddEponOT
         x427kBi1lVayIHrjvQo79UsCTKHwhKdKMAFG+M/eInC/QmbcQ8zy136RUFbVNWfmtofA
         DCnQ==
X-Gm-Message-State: APjAAAVR2hQsOr8rN9F0xbnQCpxc5htRkYUYz4l1VaQz/1ph1e33ow6x
        +vbiCKK2DneI2GSZuN5UdB2bDcrdTS1RzR3Rn1y4TA==
X-Google-Smtp-Source: APXvYqysNqwMjOuZMuJn2TTBtaGHwd4iGrXW+CFRjN8yOqefCOhvxQedmG7eSvjF6W2PDXYF4rxDosuD37Uwjuo7OMo=
X-Received: by 2002:a63:f817:: with SMTP id n23mr16407646pgh.302.1556043355201;
 Tue, 23 Apr 2019 11:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190415143821.GA46880@beast> <20190415170604.GA44415@lakrids.cambridge.arm.com>
 <CAKwvOdk_jFQKW2C2=925So_dvZ6dm03AXMZ9Nk+O1J2xyhE2EA@mail.gmail.com>
 <20190416170808.GC54708@lakrids.cambridge.arm.com> <CAGXu5jKJ4_uY45xJV_Fy=Q7cJzmJz9pZVRFJG0U-C3h95OiZzA@mail.gmail.com>
 <CAKwvOdn-MGokV0vsGq2GdRK-eGHdyC6+vVHYSfwOfpqNWwQzXw@mail.gmail.com> <20190423141240.GC56999@lakrids.cambridge.arm.com>
In-Reply-To: <20190423141240.GC56999@lakrids.cambridge.arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Apr 2019 11:15:43 -0700
Message-ID: <CAKwvOdmQWSO9w5WqsC0RYG-KuRjC2RWGuyckEd-VB14Pie=Osg@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: sysreg: make mrs_s and msr_s macros work with
 Clang and LTO
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alex Matveev <alxmtvv@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 7:12 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, Apr 22, 2019 at 10:44:10AM -0700, Nick Desaulniers wrote:
> > On Tue, Apr 16, 2019 at 9:03 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Tue, Apr 16, 2019 at 12:08 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > On Mon, Apr 15, 2019 at 10:22:27AM -0700, Nick Desaulniers wrote:
> > > > > On Mon, Apr 15, 2019 at 10:06 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > > > > It would be nice if we could simply rely on a more recent binutils these
> > > > > > days, which supports the generic S<op0>_<op1>_<cn>_<Cm>_<op2> sysreg
> > > > > > definition. That would mean we could get rid of the whole msr_s/mrs_s
> > > > > > hack by turning that into a CPP macro which built that name.
> >
> > Mark, can you give me a test case for this? I'd like to check if
> > clang's integrated assembler supports this or not, so we can file an
> > issue and fix it if not.
>
> The below is a smoke test. The entire op0:op1:cn:cm:op2 space is 14
> bits, so it should be feasible to generate and run an exhautive test for
> all encodings.
>
> I've included SYS and SYSL here too, since I strongly suspect we'll need
> those going forward.
>
> Thanks
> Mark.
>
> ---->8----
> /*
>  * ${CC} -c test.c
>  *
>  * OLD_* encodings already exist, NEW_* encodings haven't yet be
>  * allocated (per ARM DDI 0487D.a), but should assemble. All encodings
>  * chosen arbitrarily.
>  */
>
> // OSDTRRX_EL1
> #define OLD_DBG_REG     "s2_0_c0_c0_2"
> #define NEW_DBG_REG     "s2_7_c0_c15_0"
>
> // MIDR_EL1
> #define OLD_SYS_REG     "s3_0_c0_c0_0"
> #define NEW_SYS_REG     "s3_6_c1_c0_7"
>
> #define REG(r)                                  \
>         asm volatile("msr " r ", xzr\n");       \
>         asm volatile("mrs xzr, " r "\n")
>
> // DC IVAC, XZR
> #define OLD_SYS "#0, c7, c6, #1"
> #define NEW_SYS "#7, c15, c15, #7"
>
> #define NEW_SYSL_MIN    "#0, c0, c0, #0"
> #define NEW_SYSL_MAX    "#7, c15, c15, #7"
>
> #define SYS(s)  asm volatile("sys " s ", xzr\n")
> #define SYSL(s) asm volatile("sysl xzr, " s "\n")
>
> void test(void)
> {
>         REG(OLD_DBG_REG);
>         REG(NEW_DBG_REG);
>
>         REG(OLD_SYS_REG);
>         REG(NEW_SYS_REG);
>
>         SYS(OLD_SYS);
>         SYS(NEW_SYS);
>
>         SYSL(NEW_SYSL_MIN);
>         SYSL(NEW_SYSL_MAX);
> }

Hmmm...yes looks like Clang's integrated assembler is missing support.
https://godbolt.org/z/wDBpz4
https://bugs.llvm.org/show_bug.cgi?id=41573
https://github.com/ClangBuiltLinux/linux/issues/453
We'll follow up on getting that fixed.

Kees, are you able to respin the patch with the above requested
changes from Mark to the macros?  Let me know what I can do to help.
-- 
Thanks,
~Nick Desaulniers
