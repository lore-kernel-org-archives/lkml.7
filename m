Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54106C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 12:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1779620818
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 12:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b7w+cAg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfDMMlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 08:41:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37229 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfDMMlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 08:41:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id z16so14357756qtn.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6UEuPciT2jqWTP9u8f+boXyu7qcE24vOwqg8IPOLBQ=;
        b=b7w+cAg2sYAWe2k9qDCj1ghA8QsHvYLg3glnJV4ifZwvrdgkuJ1+wO/NVYhDFPP9Td
         tBIeA4UMm/JMQOMSnXrUj6Z5V6J4TWNRArHiM2Rw332Vpgp360iHkHkr+Mw3u0FlRtre
         7NhrrjdsdXsBLk/OpVQoIzAGLuK62BZvMl2ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6UEuPciT2jqWTP9u8f+boXyu7qcE24vOwqg8IPOLBQ=;
        b=MycODdvW/BI1cXy3JarEczde1nprU+syF3US5sA+n14RdxSz1d5fmW1Wi2mB+wUmB8
         YmM3KU1uJ4V7gJhxu3HRDzLnTmA8aP6dX1vMtkg3SuqpXjuOAaL/g/asZXsdtyqHGw5x
         Oj/tfYEndvExk9No1Mb7hJHmWRu5TBkY8CBwhebHY6hVz9oaRSoSBHvJg4m0rG0jZIiz
         dOQ2pXRR5YY2W2qvjXO0C5buovyQ6IrF+UtlgbviSCQL6cn057Iu7TTf+/fivuuP+ABw
         aLoulHgBa/QfQykMUW2noq1/kX7QJowk18ILKn6O2e9ga/TuVolQ9Vq3EOBY7VszSYZW
         86JA==
X-Gm-Message-State: APjAAAUIJHw5GasaLo90Fuh1bT4xwn5NkS8cI+TsauDCr0/Da5tPa7uL
        XRkYD1w7x9AS0W8QFRLy9/j9dR6eOJRfrif6aQM03A==
X-Google-Smtp-Source: APXvYqzePUjZledZ4taT5erXAtMjigOCxJREoEg9Q0gT9Cz/n9HDamGmRSLVqM2qe6YKRJOmrOTZz1xMqElegrjmacw=
X-Received: by 2002:ac8:304a:: with SMTP id g10mr51433930qte.118.1555159304853;
 Sat, 13 Apr 2019 05:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <BLUPR13MB0289A32373545C7FBE3400CBDFBB0@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu_m353cv=Pf2cEUDLn8=5YTLjLDDO23n=P14nWXydQWDQ@mail.gmail.com>
 <BLUPR13MB02892B82F5EB663B2FECF20EDFB40@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu-YTdQmhU_br4amNZYn12=6Amr7w=wP57DyNn7_axptCg@mail.gmail.com>
 <BLUPR13MB028993B73A531E5C7EA62DCEDF820@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu-0JUqihHGQt+YyvUHRTizTOWywXqMaE4RiXOjQ7xi7zA@mail.gmail.com> <BLUPR13MB0289B8C3D58E9A3FAD2CF3DEDF820@BLUPR13MB0289.namprd13.prod.outlook.com>
In-Reply-To: <BLUPR13MB0289B8C3D58E9A3FAD2CF3DEDF820@BLUPR13MB0289.namprd13.prod.outlook.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sat, 13 Apr 2019 20:41:33 +0800
Message-ID: <CANMq1KCdagM3L23Fgz2znhFCB_2JvtBWNvVCXZp4iGc8T46GwQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in
 linear region
To:     stable@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yueyi Li <liyueyi@live.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear stable maintainers,

I encountered a similar issue on a 4.19.33 kernel (Chromium OS). On my
board, the system would not even be able to boot if KASLR decides to
map the linear region to the top of the virtual address space. This
happens every 253 boots on average (there are 0xfd possible random
offsets, and only the top one fails).

I tried to debug the issue, and it appears physical memory allocated
for vmemmap and mem_section array would end up at the same location,
corrupting each other early on boot. I could not figure out exactly
why this is happening, but in any case, this patch fixes my issue (no
failure in 744 reboots with 240 unique offsets, and counting...), and
IMHO the ERR_PTR justification in the commit message is enough to
warrant inclusion in -stable branches.

The patch below was committed to mainline as:
commit c8a43c18a97845e7f94ed7d181c11f41964976a2
    arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in linear region

and should be included in stable branches after this commit:
Fixes: c031a4213c11a5db ("arm64: kaslr: randomize the linear region")
i.e. anything after kernel 4.5 (git describe says v4.5-rc4-62-gc031a4213c11a5d).

Thanks,

Nicolas

On Wed, Jan 16, 2019 at 4:38 PM Yueyi Li <liyueyi@live.com> wrote:
>
>
>
> On 2019/1/16 15:51, Ard Biesheuvel wrote:
> > On Wed, 16 Jan 2019 at 04:37, Yueyi Li <liyueyi@live.com> wrote:
> >> OK, thanks. But seems this mail be ignored, do i need re-sent the patch?
> >>
> >> On 2018/12/26 21:49, Ard Biesheuvel wrote:
> >>> On Tue, 25 Dec 2018 at 03:30, Yueyi Li <liyueyi@live.com> wrote:
> >>>> Hi Ard,
> >>>>
> >>>>
> >>>> On 2018/12/24 17:45, Ard Biesheuvel wrote:
> >>>>> Does the following change fix your issue as well?
> >>>>>
> >>>>> index 9b432d9fcada..9dcf0ff75a11 100644
> >>>>> --- a/arch/arm64/mm/init.c
> >>>>> +++ b/arch/arm64/mm/init.c
> >>>>> @@ -447,7 +447,7 @@ void __init arm64_memblock_init(void)
> >>>>>                     * memory spans, randomize the linear region as well.
> >>>>>                     */
> >>>>>                    if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
> >>>>> -                       range = range / ARM64_MEMSTART_ALIGN + 1;
> >>>>> +                       range /= ARM64_MEMSTART_ALIGN;
> >>>>>                            memstart_addr -= ARM64_MEMSTART_ALIGN *
> >>>>>                                             ((range * memstart_offset_seed) >> 16);
> >>>>>                    }
> >>>> Yes, it can fix this also. I just think modify the first *range*
> >>>> calculation would be easier to grasp, what do you think?
> >>>>
> >>> I don't think there is a difference, to be honest, but I will leave it
> >>> up to the maintainers to decide which approach they prefer.
> > No it has been merged already. It is in v5.0-rc2 I think.
>
> OK, thanks. :-)
