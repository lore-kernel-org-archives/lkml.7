Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30196C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDA12147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552338290;
	bh=sILPUSCBjeZteGUqcymIsxyhgjsmmnjkp1fLjWlBtgo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QAkQ22+azdi7ZbOFAuxOMZ/BFeXKrZ0sLGbjB0QudTBRXHxOv1kwsjj54/NCeZvwj
	 ++PccsI3ziehuZGOO49FsFiPD0IYXAqLnTE3C5pwNSplmUuw7v5tWiAWxf1vCwXDts
	 P+gcZCvMV0tofox0RKi1VuJvzmWtUhbq0qMXTHws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfCKVEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:04:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46131 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfCKVEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:04:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id g12so345202lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tTpvQr8V2XjLcJy07bmdbeLo6K65ZGZy/aMoiiWwkto=;
        b=ffUzRV3sNKOKMd1e9fKYcmjwft/kNYsxXlyV+kFPWHfc4NUjf4pBjGVYJjACZcNxX0
         0/Ve4kQEWjdxCtoS+xDHLBnbA6ohE2gnoOPf4/A0cjPsrunp7NrHVZOoDknQAnF0HShU
         3qzrkijg9kpGN3NTaupxkwB+F4g50jDhfpujo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tTpvQr8V2XjLcJy07bmdbeLo6K65ZGZy/aMoiiWwkto=;
        b=YhbmcZeoZcwRHRGgeqMFbEfUij+l9zquZku3l1v8ks/MsO2OnZ2QPDENCUvNdg8Juj
         FTr6fvhYsssfqFBInlcAM/95uHFg0Gu1Z9dNkE8P33jFCbfOCcr5Y9PCzKK/cSxGqnGq
         ZRD5j65v3vZzjZRVhtHZNnuoK4T42BwTo1fH715dY26wujLuIm+Lb7BAvq7WV1HfQ2Px
         j3hjKtDP0ojijCen5eTy8idcrwnsoWy5aZb8Gu/Mivg+fN2Nh7i42mUEOI1P5mne/M2t
         DvAz5exJU5JdX9zTKPYdNOqDnRQVA0BIm6vb6wRnFwP5yuz3ikzLbGm7FjJ0df8P30KA
         c+qg==
X-Gm-Message-State: APjAAAXoSdLKER9njyreqGoUJBTcs3Q4QUdhiar+sp45A7lK0FE0xMDW
        OfInMhGsdxzNLLF+5Squep8pzxrLjQg=
X-Google-Smtp-Source: APXvYqwS4F61z9Mu2eD41AclX9+pSKWrFMskMKsUl0kGqnFHrS3PNWey8+q77ruPmI+2denvF+izHw==
X-Received: by 2002:a19:9794:: with SMTP id z142mr4215493lfd.46.1552338285857;
        Mon, 11 Mar 2019 14:04:45 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id e2sm75143lfc.75.2019.03.11.14.04.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 14:04:45 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id d24so342753ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 14:04:44 -0700 (PDT)
X-Received: by 2002:a2e:8585:: with SMTP id b5mr17709478lji.125.1552338284392;
 Mon, 11 Mar 2019 14:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
 <155221755097.13878.5173016541431155948.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjNes0wn0KUMMY6dOK_sN69z2TiGpDZ2cyzYF07s64bXQ@mail.gmail.com>
 <alpine.DEB.2.21.1903111516190.1691@nanos.tec.linutronix.de>
 <CAHk-=whUyG3+Zwb74LSOPGtTBvK9N6DG4f=Y5Yv9Xzcy-qY0Qw@mail.gmail.com>
 <CAGXu5j+NB16S2gAz9TOW6izZykuOXqRoP0nDkTqgn02OJ2ht5Q@mail.gmail.com>
 <CAHk-=wh6=X2TauxJzEBkLwcq5wcV3zM53FLDiVjD4LiBRcD9Qg@mail.gmail.com>
 <CAGXu5jJLnsQm20A87-1+vH4kXwE1APjNqv=6qx32gCYk7SaW_g@mail.gmail.com>
 <CAHk-=whQYG7iHO8Gv2Ka2_2tXNJkX1LdsyqKUZ=EO0aP6uS+2g@mail.gmail.com> <CAGXu5jJkB2L3-_Q1Vw_myCcx8hE49Vih8ogHqTFEYsio5LRm3w@mail.gmail.com>
In-Reply-To: <CAGXu5jJkB2L3-_Q1Vw_myCcx8hE49Vih8ogHqTFEYsio5LRm3w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Mar 2019 14:04:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDF_R4PyzrPio5PQoUWAzNki1g-1xeB0Q2tSEju4NSrg@mail.gmail.com>
Message-ID: <CAHk-=whDF_R4PyzrPio5PQoUWAzNki1g-1xeB0Q2tSEju4NSrg@mail.gmail.com>
Subject: Re: [GIT pull] x86/asm for 5.1
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 1:36 PM Kees Cook <keescook@chromium.org> wrote:
>
> Oh! I see what you mean -- separate the or and test.

Yeah. You'll obviously need to or in the bits at run-time then if the
test ever _fails_ and you warn about an attack and do the fixup, but
that's a separate path.

              Linus
