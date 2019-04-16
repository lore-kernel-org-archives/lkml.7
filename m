Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9361EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C51206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="mVcQ2Wr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfDPS4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:56:33 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45475 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPS4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:56:33 -0400
Received: by mail-oi1-f193.google.com with SMTP id y84so17881425oia.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 11:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hd6YYQ3v11Q102JhxXilIcflTiefu/2D26xYyg0/qvg=;
        b=mVcQ2Wr9m9exR/ADm+8pWn+2G+7anyuu8bmTfoMGizO2ZSTTgvDDH+Ys1aus/m0irL
         HLD71ccNVozch8SMoiY0HhUmsckNjOYVeUG5jhzEpe8gkiq3ZQ1sYmtG1xYwZ1tsIx3+
         Db+maTwVua7KGT7FtqmjM3Kd6ZXgpnVOB1BuT8psnZiRGm8D7tlYRKYEx2HM9RXojzyZ
         yFgfWYTbZ+U4CgoT+fC3RDNME2Zb2ItZMprPbcGesvpuEzbvByfx6sLaC6OSz7oAiSzE
         xR6uBXe3bitD8guNe2dnOiYbNxLaA3RSPoyRTyKngTQAtCdKsd8GqjqE9qIg4XlvYRdB
         0yKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hd6YYQ3v11Q102JhxXilIcflTiefu/2D26xYyg0/qvg=;
        b=PxKm1wKRi1Oh9eWmTpE40hNm+wA0Cr9pLfxnJtuCb135Vsy33VUzxp6QF0/3j4Kw3Q
         pwpPo33L1cycrjJdRXXfQBgz1lEujOyHd0ZLBuGbCdUXNQYI+m9FCtPuiuI2WR8cc6C0
         cwRcDicRfL/v1mPBKVtxJybZrZMHeS5P9lFz3R89sgXCGJfO/XTY691rpVM+zyBguonv
         sN04OvnsG8ysbckOxrS+flGd4OLiW+Bql87T/AU43n1U5Vb+jYtvctT3U8ALF6cb7h0k
         pGU9WRIQDABolDdFL6MSt4uvRQQVf6s2FgL8FWuUSIILYlKXDsca2QHhBus1Fj50lZJg
         iRJA==
X-Gm-Message-State: APjAAAVrIH3iuxuI1oJWYhm5iYRWwj4uTDEXN765gBITnYbkoZ91B0fB
        shtLpSCPzFxlQabe8SN301fRBsjccs3cU+RflYJ1KQ==
X-Google-Smtp-Source: APXvYqyof3rRxq8JcY/+UyB5ka2SU7k7Ud9CzBYhFIOjtp6+4fm1P94K7C5lJZgZxUuKEgOBrh+Cv5KHLS7VYiKyxjc=
X-Received: by 2002:aca:3f07:: with SMTP id m7mr24154237oia.179.1555440992614;
 Tue, 16 Apr 2019 11:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190415142229.GA14330@linux-8ccs> <20190415181833.101222-1-trong@android.com>
 <20190416152144.GA1419@linux-8ccs> <CANA+-vDxLy7A7aEDsHS4y7ujwN5atzkGrVwSvDs-U3Oa_5oLFg@mail.gmail.com>
In-Reply-To: <CANA+-vDxLy7A7aEDsHS4y7ujwN5atzkGrVwSvDs-U3Oa_5oLFg@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Tue, 16 Apr 2019 11:56:21 -0700
Message-ID: <CANA+-vAvLUFPhfXj_CxkV8Fgv+zmqvu=MxwtwFTbr5Nrn68E9g@mail.gmail.com>
Subject: Re: [PATCH v2] module: add stubs for within_module functions
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Greg Hackmann <ghackmann@android.com>, linux-mm@kvack.org,
        kbuild-all@01.org, Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petri Gynther <pgynther@google.com>, willy@infradead.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:55 AM Tri Vo <trong@android.com> wrote:
>
> On Tue, Apr 16, 2019 at 8:21 AM Jessica Yu <jeyu@kernel.org> wrote:
> >
> > +++ Tri Vo [15/04/19 11:18 -0700]:
> > >Provide stubs for within_module_core(), within_module_init(), and
> > >within_module() to prevent build errors when !CONFIG_MODULES.
> > >
> > >v2:
> > >- Generalized commit message, as per Jessica.
> > >- Stubs for within_module_core() and within_module_init(), as per Nick.
> > >
> > >Suggested-by: Matthew Wilcox <willy@infradead.org>
> > >Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > >Reported-by: kbuild test robot <lkp@intel.com>
> > >Link: https://marc.info/?l=linux-mm&m=155384681109231&w=2
> > >Signed-off-by: Tri Vo <trong@android.com>
> >
> > Applied, thanks!
>
> Thank you!

Andrew,
this patch fixes 8c3d220cb6b5 ("gcov: clang support"). Could you
re-apply the gcov patch? Sorry, if it's a dumb question. I'm not
familiar with how cross-tree patches are handled in Linux.
