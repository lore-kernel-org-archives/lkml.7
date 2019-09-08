Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9974C4360D
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 20:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94163218AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 20:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vd8B1p6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbfIHUor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 16:44:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42199 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbfIHUor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 16:44:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id y23so10688669lje.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1juM/iMQ96QooUUt3f77LO+IV8A/P1jdeBRL84BbUZU=;
        b=vd8B1p6vAgV+BtAIEf0xv0O+Y4Vm/xhVfRv4TU+EyRD9QBl/R8GaZu4HLoGkEtk5e6
         oHp0+VcNHewZ4JRNXZRhAZEwgrV2uESOmdeVVr3fytPmTmBj9rhHIhz3jtvUAgBH5jjt
         SOImtUAKCMn/kRf5v1wa2/0dld4ICc+ZUEV+fF0u5sX5a+D2yUPsDZZHFXtYwqGguiyr
         UAWhgas7L840y2sXbDf+W2jJwY9UeFTBpR4NA6fWqRODuARyElMF3+m2TfA8jgSnahjW
         dUbg9pmU3ftyKRD6vOcUGDoN+bvtJ2C+b0rujLRZ5YdyNQpbJu5ahSir2rFBEtLpGUqC
         wvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1juM/iMQ96QooUUt3f77LO+IV8A/P1jdeBRL84BbUZU=;
        b=mIqb1ZKxvik5qLokJcI7gEZKksa0IPqehQZ1z/QYBKpC+Dmwy+kG4XYjTSR9Wz9Wtv
         unLqoHGJI+Tz39OJxrzbf46agt6FIsXIu3WuG387Mch1SXZxNR9OqLrzAVxUBCyg1lpu
         +FvCCyT0J/tYdCTuZaTGyfnuA/zVFjnv3qvn9FV2/jbqSY8FOB28jilSeIIAQ3dBI4gS
         ohJiU24liQhkZljaHe0vRxsoUf+SQQNC0SVQ87CUNe3RYMz41uOIBu6AydvX/JtaB5Ht
         uVoRpS6kCM2PHKRUC2Mqv7TMGBq4i2aVWFdERru6jgzID5duV1l9gFA8oKuhksLQL727
         Il5w==
X-Gm-Message-State: APjAAAXgp9CN9hYrFWFJTyJ6PBjk/+stunKCBFooad6IuCS+px0egnh6
        wxVZDqKIwsBeotM0YIatIXhGSNVM3Tzk13/Iae7TDV8V
X-Google-Smtp-Source: APXvYqwlv/wBgFFrFzrC4IrBPrmdeLAs0UNxrB4MpaAENwAGnvMZb8JChTPKYfY8wUlnapiIlX1xsEqLNddVi3ZOIMY=
X-Received: by 2002:a2e:90c7:: with SMTP id o7mr13234884ljg.73.1567975485166;
 Sun, 08 Sep 2019 13:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190908162919.830388dc7404d1e2c80f4095@gmail.com> <1ed46a95-12bc-d8ee-0770-43057a09f0d9@maciej.szmigiero.name>
In-Reply-To: <1ed46a95-12bc-d8ee-0770-43057a09f0d9@maciej.szmigiero.name>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Sun, 8 Sep 2019 23:44:33 +0300
Message-ID: <CAMJBoFPVmZ=9G0hYz0YYeVH=cMZ=F1urMorvRtm8ZwV7fc4haA@mail.gmail.com>
Subject: Re: [PATCH] z3fold: fix retry mechanism in page reclaim
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Agust=C3=ADn_Dall=CA=BCAlba?= <agustin@dallalba.com.ar>,
        Dan Streetman <ddstreet@ieee.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Markus Linnala <markus.linnala@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 8, 2019 at 4:56 PM Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> On 08.09.2019 15:29, Vitaly Wool wrote:
> > z3fold_page_reclaim()'s retry mechanism is broken: on a second
> > iteration it will have zhdr from the first one so that zhdr
> > is no longer in line with struct page. That leads to crashes when
> > the system is stressed.
> >
> > Fix that by moving zhdr assignment up.
> >
> > While at it, protect against using already freed handles by using
> > own local slots structure in z3fold_page_reclaim().
> >
> > Reported-by: Markus Linnala <markus.linnala@gmail.com>
> > Reported-by: Chris Murphy <bugzilla@colorremedies.com>
> > Reported-by: Agustin Dall'Alba <agustin@dallalba.com.ar>
> > Signed-off-by: Vitaly Wool <vitalywool@gmail.com>
> > ---
>
> Shouldn't this be CC'ed to stable@ ?

I guess :)

Thanks,
   Vitaly
