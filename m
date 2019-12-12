Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC03C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF6D214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576183816;
	bh=N3ehCkzaOKKNmRjuozGnn6u/MPJ+2/47fGjgg4X3WTo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hDzjodjWsYkzLWe3tYgaTmpHR6oCExj8psyREUDMSxbVZmpSfcdU0EMXTzT2o8aQK
	 00Z7T2FaQJ4DxNnAneaGjpd6RwkquG7EEQc+90yQd+e4obIChiX9ixEIZGbtj6i2Jk
	 dmeCzGj7ey/H25mATp4CmbphTPq3pe3+6FEzeeqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbfLLUuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 15:50:15 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34313 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730844AbfLLUuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:50:14 -0500
Received: by mail-lf1-f68.google.com with SMTP id l18so309829lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 12:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=udrNHrYblR3sF99SQEkYkwez4FCarU/iIh5v4su3FS8=;
        b=bkVtv5h8m32kLkiXM0qzlbz+nqjHfWFk9/qgPuPRhcgkiw0ZGyA729E8BGkFqzS3Dp
         q+Wa3RFyS+SBMMZulr9ppWHo8LKoN71JFOrHQs6VbNoqHdluxrgUNcjbxTHasQy97nOf
         M7t7yc8gf4qDYxsmtgtXGgGLWzQC2DeoAcm+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=udrNHrYblR3sF99SQEkYkwez4FCarU/iIh5v4su3FS8=;
        b=cUS0xyk+NkHGRZCGVs4Ijx72oWU0le9xHSyCYUTZC7J+sIlhGfP0swaUH5ZKhav24s
         tB1aHh0Yp/uIh12gOKT3CzVB3iftKN/W7EPPoDSHXji5D2W9HPKY1N0tGEq2PEMsh16n
         TJjdEwQ+v7zWsEbmwybA4b2BMKhkm2MWjmjyco7waWiIkt+sJod4ldv7LKWJyz+OLYyJ
         4sEZp0b+L8CRb9QKnq8RvNkTvV/TW7RkegX3Djl3uP3nJ0cyrhWzsV2uocAZRXU9C5o5
         dwclEFKI8E/3S6/ZP0eBugtqcMjYWXONyJkgGQZhjykiml27sPdvZyUn7TpN7C7gIFEI
         coww==
X-Gm-Message-State: APjAAAVre/CvWLZY4W2TJaVMA6/wUhOuG0b4x92uS6tZ7n5Gsz9CQNWe
        Yk1ziuKVft3qpnJeQT5yZWOdpXKGmXY=
X-Google-Smtp-Source: APXvYqxvPIi+k2mRZclK+Bacb5vzI2iSoAFEh/gNDWgT+SklGqqT/Ge/VL4YdE3yjgOOciAgz6TkmA==
X-Received: by 2002:a19:8a06:: with SMTP id m6mr6459057lfd.99.1576183810914;
        Thu, 12 Dec 2019 12:50:10 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id z13sm3647765ljh.21.2019.12.12.12.50.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 12:50:09 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id y19so279720lfl.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 12:50:09 -0800 (PST)
X-Received: by 2002:a19:23cb:: with SMTP id j194mr6971490lfj.79.1576183808614;
 Thu, 12 Dec 2019 12:50:08 -0800 (PST)
MIME-Version: 1.0
References: <87blslei5o.fsf@mpe.ellerman.id.au> <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au> <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck> <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
In-Reply-To: <20191212193401.GB19020@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Dec 2019 12:49:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
Message-ID: <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 11:34 AM Will Deacon <will@kernel.org> wrote:
>
> The root of my concern in all of this, and what started me looking at it in
> the first place, is the interaction with 'typeof()'. Inheriting 'volatile'
> for a pointer means that local variables in macros declared using typeof()
> suddenly start generating *hideous* code, particularly when pointless stack
> spills get stackprotector all excited.

Yeah, removing volatile can be a bit annoying.

For the particular case of the bitops, though, it's not an issue.
Since you know the type there, you can just cast it.

And if we had the rule that READ_ONCE() was an arithmetic type, you could do

    typeof(0+(*p)) __var;

since you might as well get the integer promotion anyway (on the
non-volatile result).

But that doesn't work with structures or unions, of course.

I'm not entirely sure we have READ_ONCE() with a struct. I do know we
have it with 64-bit entities on 32-bit machines, but that's ok with
the "0+" trick.

               Linus
