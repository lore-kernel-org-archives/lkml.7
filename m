Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBC9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8B720857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lYQtmjWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfDAPAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:00:53 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44274 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfDAPAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:00:52 -0400
Received: by mail-vs1-f67.google.com with SMTP id j184so5683344vsd.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l7jNAnF6vluKh8XW+4HppBaLLV2wos1UJRlLQEOl/LA=;
        b=lYQtmjWi4vlVPreI9e0sFX0A+Tu9l2DMboMenuDrnHS/U+LAdXHkOmoUVSE7//HYlT
         tUhHdClFIEkrSvUHlgep1Se9IQCMBSXYUAW3eZHFGjDkicofjn/kg7AFIRVD9joupGmP
         5WjMSY5P3JoVowHr1MlCd39+w2wlMv/NUQW7MWKHELxhuyP8aEktfdEi0ehq5ast8U8M
         tSG2dDtBf3+QyTn9PCtdGmWuKWhb3NrPuYICCB5nxHsS2p0KSoeygo93VvZFNXfLNYWg
         VLMFfonSpmS/hzqYNpQ9GTyqbUq6nyBaQ27MhALTGCrB2/f79YtBEYbUsqDmFGlMosXa
         cJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l7jNAnF6vluKh8XW+4HppBaLLV2wos1UJRlLQEOl/LA=;
        b=knUD87LEVser4ZZ5Ey6O/M1DHdkfW8vB7/8grBpAdEbTB/m6rFHAIap8jl4uZXNGHS
         bKUjRU9beDGZutrNbB7i2rEUsIK3IteUvw8WKbVrOqLzdMEHsLYWVzDX/hl9b6ISpb7/
         Q6yK6cbbdmh7vKrJOC11leKqNIi9vaeoJ2YraCkfPpK3Afti0J8hWeza3goEglibRfc/
         2j8XEn8vOoAHGAXl4FAFHIH8ym3070FyuwsEmFYB6YUemy8kD5a90KCiV5Oi7m8cN6V1
         rrc45sJqm/Ua8Nnc6Y0QKbXg11tXPb9Zzl6Sy8J1yjUqHwf1uRIJ5UiAtSeB+9tPywrN
         DUiQ==
X-Gm-Message-State: APjAAAVOwAuHU9Ahvxxa+wx93/80YwvM3Zfvzl6kG8QGTGn/xD0bHjWX
        p22En9vXlItu1i6k6mGV8EUEFrVhOxKGNdjG4qoQeg==
X-Google-Smtp-Source: APXvYqzolv8KvMYWm4u/u3IpyeXxWl03e2QcY+JyW+051te0JySzgvHU34WoAPlLfnM0m7OYrcf1mueXedcpx1sH06A=
X-Received: by 2002:a67:83c5:: with SMTP id f188mr37949466vsd.163.1554130850762;
 Mon, 01 Apr 2019 08:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAG_fn=X9tpSW6jvJd_COk_RU8zvcr-cxSWuJ05qcV0LotTxEEQ@mail.gmail.com>
 <20190328162222.GO4102@linux.ibm.com> <CAG_fn=WKA_4Vzsh6yH+=5TFv-EMrX87pr+2c_ANoH_MOVpbe1w@mail.gmail.com>
 <8e32ab34-c14c-1ccb-76f9-0dcd729a0ef6@zytor.com>
In-Reply-To: <8e32ab34-c14c-1ccb-76f9-0dcd729a0ef6@zytor.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 1 Apr 2019 17:00:39 +0200
Message-ID: <CAG_fn=UWGqg-U=CciYKOv11X6xQiQrQX5wKaoieE1co9v0rdBQ@mail.gmail.com>
Subject: Re: Potentially missing "memory" clobbers in bitops.h for x86
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Paul McKenney <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        James Y Knight <jyknight@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 9:52 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 3/29/19 8:54 AM, Alexander Potapenko wrote:
> >
> >> Of course, this would force the compiler to actually compute the
> >> offset, which would slow things down.  I have no idea whether this
> >> would be better or worse than just using the "memory" clobber.
> > Just adding the "memory" clobber to clear_bit() changes sizes of 5
> > kernel functions (the three mentioned above, plus hub_activate() and
> > native_send_call_func_ipi()) by a small margin.
> > This probably means the performance impact of this clobber is
> > negligible in this case.
>
> I would agree with that.
>
> Could you perhaps verify whether or not any of the above functions
> contains a currently manifest bug?
Yes, I've checked that none of the above functions contain the bug.
For a patch adding 7 memory constraints to various functions in
bitops.h there are already 258 functions that change their size.
I've skimmed through those with the biggest diffs and didn't find any
flaws, but that can be just pure luck.
I would expect such bugs to be more likely with full program
optimization kicking in.

> Note: the atomic versions of these functions obviously need to have
> "volatile" and the clobber anyway, as they are by definition barriers
> and moving memory operations around them would be a very serious error.
>
>         -hpa
>
>
>
--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
