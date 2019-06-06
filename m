Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78762C28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFF520872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vWUtlo4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfFFSZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 14:25:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43460 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729214AbfFFSZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:25:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id 16so2961549ljv.10;
        Thu, 06 Jun 2019 11:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVEDAoIFFlWb1rsNi/Us300S3WqZNyamti10qXGYYK4=;
        b=vWUtlo4Ky7i+6DkehPxxeo9n6TdVNTxXdvNfGhmFFmZzdIQkBrpZ6ZcfdUiwybaMNR
         dNc0bzTPn2Oyjt1/JxgpZn7VQJCL7BhzI1iBMoyjNgPBC+4dBedIgKOH1CJmEnw5izqd
         h5zgAyCPZyWN0JB4mFS6E3bDpqg42qIMvRxdLF8BQdsaqotpMVEQL8jOecZU0OmgCn37
         hZI7JD4upw51xc9j3aV2wqyeC4P+9Ynl+udTWlvL3OofPutwyjFVtwLKI4eHbQl4y/ks
         +h24mDbM+NQMwXLgzcudryGZAcG02Oemfo2iunViurWNUUL//S3HmWUFX7uxVirFSaT5
         pzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVEDAoIFFlWb1rsNi/Us300S3WqZNyamti10qXGYYK4=;
        b=sjiiPAiE2EpDfi77VzfdEOjxSn59E+42/TMLkGNISaSpI4aHyg9Ia0/4Sx6W77pYGq
         HAW3KhPwfw+Hn5AwMfoFCofenVw3Ph5nLhkqsZChYYdJIeJQNP0IL3RGtnQ2rrOkhHx7
         aCrzHj8nnhEdVOb8eYI1Y/lIIxG14z7GV8N2ENyrIJRRdMRvG9XKTvXwYsN0uYGGwgIe
         W3LzpkwuSW7cUoPSKtzgs0P32Om0BTR9GIK9b556FCRojWFpWAANOzqEEm3nWbyvL0o3
         xbqP45rqAh/ZVBDW7pZvldWWn2j6UbMR3W3JWI/nE8G38afD2sC5Q/cRC5qOspWRNsi4
         HwlQ==
X-Gm-Message-State: APjAAAUmKg8R9v6w7Lg2AJDtZ0qCzTSDNVOm1Quyzsb/bO/D3JMTsMLT
        R/tnootcj8ugjIfIiX1XCJsb7RVGty4DsEhswU78NpYY
X-Google-Smtp-Source: APXvYqwOzuVxwyFZ6rO1u+r6W/2d/s21chYx945k6ByTHmPJ3vtSuppD1FSvJJnYWTzoA7CviQezCzuxw3pGu+P3J4I=
X-Received: by 2002:a2e:8143:: with SMTP id t3mr25289297ljg.131.1559845539469;
 Thu, 06 Jun 2019 11:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <259986242.BvXPX32bHu@devpool35> <20190606152746.GB21921@kroah.com>
 <20190606152902.GC21921@kroah.com>
In-Reply-To: <20190606152902.GC21921@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 6 Jun 2019 20:25:28 +0200
Message-ID: <CANiq72nfFqYkiYgKJ1UZV3Mx2C3wzu_7TRtXFn=iafNt+Oc_2g@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Linux_4=2E9=2E180_build_fails_with_gcc_9_and_=27cleanu?=
        =?UTF-8?Q?p=5Fmodule=27_specifies_less_restrictive_attribute_than_its_targ?=
        =?UTF-8?Q?et_=E2=80=A6?=
To:     Greg KH <greg@kroah.com>
Cc:     Rolf Eike Beer <eb@emlix.com>, stable@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 5:29 PM Greg KH <greg@kroah.com> wrote:
>
> And if you want this, you should look at how the backports to 4.14.y
> worked, they did not include a3f8a30f3f00 ("Compiler Attributes: use
> feature checks instead of version checks"), as that gets really messy...

I am confused -- I interpreted Rolf's message as reporting that he
already successfully built 4.9 by applying a6e60d84989f
("include/linux/module.h: copy __init/__exit attrs to
init/cleanup_module") and manually fixing it up. But maybe I am
completely wrong... :-)

Cheers,
Miguel
