Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FCFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5055C20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jpuoB9vv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388803AbfDXSNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:13:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34959 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733146AbfDXSNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:13:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id j24so97638pgk.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/lPnz3iiNJFWLVIVI4pdMnJCAuKJb8MhJ/7UZGvRlGw=;
        b=jpuoB9vvLYtfALu3v/epDerQViw/ZXHvhGTTCwdHAy0rNeeFUzKYdPmorYMoVY5PH4
         PXJ8AznFpeAj6fJOQQZL/cW0jdkPvP6wBkx/vR1HaGL/c3KRRyE1rVGsrcyASdI0J5k8
         Jxhr2+jIql8xPfFEI6kyNUWxdqKDBg6/uHAu6fgz8GSGO2jsekwQSP/vBOs0ZwdltiOM
         pY/TzgAwhZh1JXH0WxUJSUuMNlzTbIWs7HbIHjKCUlAd/6cSj6zLP9dmzjjdDZbklZuz
         Z81n1dxsAhBvoeo1lE5haFORM4Zjj9kPWtApnyyhLS9CwXlzM8dWISQBdUo2U8xXSq+1
         RXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/lPnz3iiNJFWLVIVI4pdMnJCAuKJb8MhJ/7UZGvRlGw=;
        b=LN95BAnfz/cCGEgO3Z01gf7H0QRuv49kMhvoRhl7Aqv1u0LoTjh+5dAtPYPd32U4Nq
         VrbXeSVX+L/I+sju5/8odG0HVOWLXT06Oy9OvTlhe2C1Du8HJpNq99u+oGyVz2EKapAg
         ou5IR+kKjR9mHPbS15yV3lKxvA3kNjjqsz4fqmA2k2NuKVdPguPg8ApCl1jhNGb6+vFL
         4Gvnzqu6Qh1UBnMafFO7t5jErZX5nmVxSBxXbmGkdNUjE+iArAE1UFwK8l1CArvn1Dj6
         VmycPU0Nfa3hbUmuISDa5Xk4ONgYJcV9IC2TlkXY8zAf+CHIVKOlVDxUv2m1kPg86tcP
         8QWA==
X-Gm-Message-State: APjAAAUTuCqEjYc4Y1Nk6O10Vgm8orQlU62h9btNWQGECr/6kOQ5xn93
        X9NuDFJcOm63mi6t8qtUoYeCAd7h6XEiKrNxjUnlBw==
X-Google-Smtp-Source: APXvYqzwhCB03grTJpBJ854az/AP62CnlurMT4KPH9q65JN89/VdutPBev3zZJOEoLTF0GQtW/qv1c9wqojMald3Jrg=
X-Received: by 2002:a63:4558:: with SMTP id u24mr30651707pgk.225.1556129583794;
 Wed, 24 Apr 2019 11:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181210223133.22667-1-ndesaulniers@google.com>
 <CAK8P3a3At0Znn7BRxVxFdxcCa2=uJ9fAJYazKe3E9688axPj2g@mail.gmail.com> <87a7gfseis.fsf@linux.ibm.com>
In-Reply-To: <87a7gfseis.fsf@linux.ibm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Apr 2019 11:12:52 -0700
Message-ID: <CAKwvOdn2B=410e7yCXNmc=94mQHydh=KzKv4nnpC6+UbKodFKg@mail.gmail.com>
Subject: Re: [PATCH] ARM: VDSO: Drop implicit common-page-size linker flag
To:     Nathan Lynch <nathanl@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 6:45 AM Nathan Lynch <nathanl@linux.ibm.com> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Nathan Lynch <nathanl@linux.ibm.com>

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8859/1
-- 
Thanks,
~Nick Desaulniers
