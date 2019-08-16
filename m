Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15562C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D76206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cihxO+YY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfHPJWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 05:22:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45821 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfHPJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 05:22:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so2645659pgp.12;
        Fri, 16 Aug 2019 02:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ecN5oXMiEZjV2F0Oa58Q+yKo9ivsAVzldeQfVYkRrE=;
        b=cihxO+YY+3C2mg/dNbgdwcsdVTxEIPgKIFyXfek5ixCTfHXiS8CSjgrWyxznHeuw+m
         9SSd6/oaNcu8jvDfJLQ75yDKGr6Acw7iuXqkaFGWw66lm+IfE/xdSuDxPuBFp+95GWYi
         bw4e92tDtvr0mcnnPdUIQA3p01dO9LXwnvrNpoLe3D58SnGnQfqbriUe2Qb3MqJCoyUM
         ZYU9OUwB6c984EMFKb9udJteBBut2o02SGBxlNByZ8LbwWPLwt2OCaiW/Lmi+1r6peyL
         WVJnGidYs3GX2VlmydtYfp+lPe0HNSZZwha57X+JdIk7dKk1VtVnjthtoiUiT/FNWyNO
         rx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ecN5oXMiEZjV2F0Oa58Q+yKo9ivsAVzldeQfVYkRrE=;
        b=A4U9Ms6pFzvqNEE4/h4lcSwF7iVxtSe7YeqAkG5oEKfjK+mMHiV866YsvG3LYzJKRm
         EC5FjQGBRD428IVyLJj+/r/kJcp/legm2hVOumyoWCaRXdI2LTdCS49Ri5Gcn6hbez6b
         sVHMfUkokVb11L1RSACreOrsZqyg2hFzFHep9tjBFO+l6/sPTpt9AttFOOqqrXE9BTNn
         VCGSRGZI86H5cG0Hjz3aqxsUs7hhjDsB+FQFJEJYa1vvK4JvZFJ+9FWnbLOoIbVwW+Yj
         OlP799cKlrqEvQrVxcHmbGZdQ/tBXULAg6aiF9BLBVF/vOO9orSeiYyNzNEQpFu9yOG5
         auNw==
X-Gm-Message-State: APjAAAVNGGeNud1EJ8Nte9Gzaw8rPDvP+oWRWWnHQJO+jK+GJIJw9d2X
        i7T9ULY3braRMfO/pGHYcsmZcIm2I80mGXJZxyM=
X-Google-Smtp-Source: APXvYqznoRkaQ5GGcoSzSFwlDt1oEQZmbLYLEWCLaguzIcJK2jrm5d8J8n4mqZwdgOew9hcmBQwx+uxIqxRS/ZS1Eyw=
X-Received: by 2002:a63:e54f:: with SMTP id z15mr6915845pgj.4.1565947330601;
 Fri, 16 Aug 2019 02:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190816014140.10687-1-m.v.b@runbox.com>
In-Reply-To: <20190816014140.10687-1-m.v.b@runbox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 16 Aug 2019 12:21:58 +0300
Message-ID: <CAHp75Vc1BP9UXBWW1tv7T8v8vgqxZWngD+tN9=ZKkgc1imUVxQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_pmc_core: Do not ioremap RAM
To:     "M. Vefa Bicakci" <m.v.b@runbox.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 4:42 AM M. Vefa Bicakci <m.v.b@runbox.com> wrote:
>
> On a Xen-based PVH virtual machine with more than 4 GiB of RAM,
> intel_pmc_core fails initialization with the following warning message
> from the kernel, indicating that the driver is attempting to ioremap
> RAM:
>
>   ------------[ cut here ]------------
>   ioremap on RAM at 0x00000000fe000000 - 0x00000000fe001fff

> This issue appears to manifest itself because of the following fallback
> mechanism in the driver:
>
>         if (lpit_read_residency_count_address(&slp_s0_addr))
>                 pmcdev->base_addr = PMC_BASE_ADDR_DEFAULT;
>
> The validity of address PMC_BASE_ADDR_DEFAULT (i.e., 0xFE000000) is not
> verified by the driver, which is what this patch introduces. With this
> patch, if address PMC_BASE_ADDR_DEFAULT is in RAM, then the driver will
> not attempt to ioremap the aforementioned address.

Thank you for the patch.
Is there anything preventing us to use memremap() in such case?

-- 
With Best Regards,
Andy Shevchenko
