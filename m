Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F23C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E63278B9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf+9V9+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfFCOjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:39:36 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54755 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbfFCOjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:39:36 -0400
Received: by mail-it1-f194.google.com with SMTP id h20so27839187itk.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aYhQSHvrs+dU7MwteB9MNwuhLcVxfIzy9hHd0CUZe84=;
        b=Sf+9V9+7ibseCrKO9whYdkIYIChrhMZZew8B1PFci99yh9YWMSY85U5ldzJtE2UcLW
         EsQiZg8Is24JRG5Ze3CnzJmUAmaTdO04DmwLkVtjZlUxZm/WV7r9pYbh7q1+JcVg5PEf
         odrLbtzr4tz6HQ9zHP+8wRloqXXviMK61NKYZYDNJlQ/bAXLZr9TmaYsKt9lnIGoribY
         rNaxxWJ48xgFB3Nvx6Q8kaR3AXiEZfY8S/fC85aT6+8Vlipj9D8xZQqS9gNQgS6tuOCD
         28sbtaEqv6BhmZ5XRxHVqnSIS0IFr6FXlGBt3Btk9xr9g5XrJjHK5OO8E8Zjwslr5Sk4
         vvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aYhQSHvrs+dU7MwteB9MNwuhLcVxfIzy9hHd0CUZe84=;
        b=pP8zPZRFo15w10BzDeijUkS0a3ThHxc90xKACpXdMnuiIWqobNCvJ3xL7GtWstAFCd
         yXELkiJwKtFTco1H5c5gA2aIiddFP5Wbr7B8RfrYHKkrk/cb+DXl5nRK0yjfjlWRtHIz
         Q12TVVkBqTSLi0p5VsDPxSCH8yX62T4NlfOnBz47r0FiZ7NilRNVSB75QwOIDKl0hklo
         Iu/oCoVSCOP5Jp4xCupCLMRpLgD+3NL6hGISV19/S2RrNYWm4uDo1vo3g6BuR7A+kDPN
         8klIU7a0CtcPooS+5/7lyJ0vd2L9Uy2selhFLDhbJZBKm+PUM0S1iZwNGv6dCMLdkWJK
         LIFw==
X-Gm-Message-State: APjAAAUuNwyPlwKZXRt/HWM034tnXvDuU5mm8JK7n1Re4d6qigsog/xl
        YEeFlgutrecSAjzFBSNoKU6rQOzq9kzzmXYwtWc=
X-Google-Smtp-Source: APXvYqxgMuXt/+56wQ4vv3SWYxXLYaUd164tRW2u105w0ICJyxSGeSdU6A4i0IWYmGxlHDIMemYTtc9dwPx3tJ21phg=
X-Received: by 2002:a05:660c:64f:: with SMTP id y15mr18126402itk.180.1559572775444;
 Mon, 03 Jun 2019 07:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <1559251257-12383-1-git-send-email-kdasu.kdev@gmail.com>
 <20190601095748.35d1c1aa@collabora.com> <CAC=U0a1q2CTZx+btLBJNewK8Rv3WXVE-ZV+j5fFWZPJLoJ94NA@mail.gmail.com>
 <20190603161825.4044f953@collabora.com>
In-Reply-To: <20190603161825.4044f953@collabora.com>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Mon, 3 Jun 2019 10:39:22 -0400
Message-ID: <CAC=U0a1Re=+=EmoFEx2yAO-ffHu6uLErX5g_OzruyrL_DX2ZGA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mtd: nand: raw: brcmnand: Refactored code and
 introduced inline functions
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     MTD Maling List <linux-mtd@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 10:18 AM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Mon, 3 Jun 2019 10:11:20 -0400
> Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>
> > Boris,
> >
> > On Sat, Jun 1, 2019 at 3:57 AM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:
> > >
> > > On Thu, 30 May 2019 17:20:35 -0400
> > > Kamal Dasu <kdasu.kdev@gmail.com> wrote:
> > >
> > > > Refactored NAND ECC and CMD address configuration code to use inline
> > > > functions.
> > >
> > > I'd expect the compiler to be smart enough to decide when inlining is
> > > appropriate. Did you check that adding the inline specifier actually
> > > makes a difference?
> >
> > This was done to make the code more readable. It does not make any
> > difference to performance.
>
> I meant dropping the inline specifier, not going back to manual
> inlining. As a general rule, you don't need to add the 'inline'
> specifier unless your function is defined in a header. In all other
> cases the compiler is able to inline things on its own when it sees the
> number of instructions is small enough or when the function is only
> called once.

Oh ok got it, will get rid if the inline specifier  and send a v2
version of the change.

Thanks
Kamal
