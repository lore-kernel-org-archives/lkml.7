Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DEBC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 21:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0889220873
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 21:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9awFJIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfJHVDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 17:03:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55882 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbfJHVDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 17:03:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id a6so4638516wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 14:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DwbSuCVPgdnfuc55S5QoU+HrLN1Lslk6AXfdZ8RTC9E=;
        b=m9awFJInBde/MGOYE/MIqKtZr254xTohNiS2+mSSIvOf6QYazbZsauAFzC+R96cNZU
         FHRiK1EV+xl1Hf80/ZxOlgvL99n8j2vUPooWgdBZ+3gK+yKTOdm0CB5EwID5jz4eLTob
         VkMsVAtLV/+wAPhEhd/juT7Ng5r3FCrE48RVOVo+JNH/JCp2LiebjcvBhdz77+TsaU1F
         PloVThIxID6gSWpY3zv14vLM4agKPnOcpN7k6vPoTABaeNYNbzqFKghgUc0lGZ2wUgE6
         ysZCu4KDi+SrkKL0/QlOBJ3TjI1f/bdvfaEPurvezpqQNCbjzXX62+pezZk9JXkzjSxH
         lRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DwbSuCVPgdnfuc55S5QoU+HrLN1Lslk6AXfdZ8RTC9E=;
        b=tjMd3MikV33dOswwXj+UDUYnbv2/pEUllU++hBDjTg0MUvYfNkcEzzgpWDgRsWxYcw
         bruNEgwRzcNN4jFt3OC66v7zV8Ewa7MUeVLPcnkQNa9Zrnis3eCiI6ujqE6re8gij2P1
         YdcM6j86mTe1BWuzOE/Ahz7dAPiQHFLjg77+olkIQK0V33lsinuIbz2tBLt7lLMl4unp
         0MBVxf/CAg3oxxklBWtNfnpU/8kU8lXNaVJAu5h4hlg4bA4X9RpPdPZBm4RanHBXjNiP
         982urixBeLRufSP1271M47G6PAkS+GaXTQr3gYMszKbhr/mHNty7he0M8PwbYAUBdVPZ
         946g==
X-Gm-Message-State: APjAAAWvgftLUGEB464Q6UIQI5nr1DwoygypsCO+V8nRxgCaotfTMS4L
        kbAuvubE9YTzKpJv0bkbijvZWQKpoHinN3JMeEc5cQ==
X-Google-Smtp-Source: APXvYqztuQvm09D/e/iuK2cvpYO1uTjf4jBe0A/iujbXm8RUQJnLMWOcFU+QjXddgGnDARg3HVbK57y4JBwp9f8cYNE=
X-Received: by 2002:a1c:a651:: with SMTP id p78mr72278wme.53.1570568615342;
 Tue, 08 Oct 2019 14:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191007201452.208067-1-samitolvanen@google.com>
 <CAKwvOdmaMaO-Gpv2x0CWG+CRUCNKbNWJij97Jr0LaRaZXjAiTA@mail.gmail.com>
 <CABCJKufxncBPOx6==57asbMF_On=g1sZAv+w6RnqHJFSwOSeTw@mail.gmail.com>
 <CAKwvOd=k5iE8L5xbxwYDF=hSftqUXDdpgKYBDBa35XOkAx3d0w@mail.gmail.com>
 <CABCJKucPcqSS=8dP-6hOwGpKUYxOk8Q_Av83O0A2A85JKznypQ@mail.gmail.com> <c0f0eb7e-9e46-10cc-1277-b37fcd48d0be@arm.com>
In-Reply-To: <c0f0eb7e-9e46-10cc-1277-b37fcd48d0be@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 8 Oct 2019 23:03:24 +0200
Message-ID: <CAKv+Gu82ERZjaEH265+RNVjtQSk51ekHONniDZg-4vWy1VHkuQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: lse: fix LSE atomics with LLVM's integrated assembler
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019 at 18:19, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 08/10/2019 16:22, Sami Tolvanen wrote:
> > On Mon, Oct 7, 2019 at 2:46 PM 'Nick Desaulniers' via Clang Built
> > Linux <clang-built-linux@googlegroups.com> wrote:
> >> I'm worried that one of these might lower to LSE atomics without
> >> ALTERNATIVE guards by blanketing all C code with `-march=armv8-a+lse`.
> >
> > True, that's a valid concern. I think adding the directive to each
> > assembly block is the way forward then, assuming the maintainers are
> > fine with that.
>
> It's definitely a valid concern in principle, but in practice note that
> lse.h ends up included in ~99% of C files, so the extension is enabled
> more or less everywhere already.
>

lse.h currently does

__asm__(".arch_extension        lse");

which instructs the assembler to permit the use of LSE opcodes, but it
does not instruct the compiler to emit them, so this is not quite the
same thing.
