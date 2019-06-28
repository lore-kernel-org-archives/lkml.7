Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CBCC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B99E2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="U2/XpaCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfF1H0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:26:20 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45789 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF1H0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:26:20 -0400
Received: by mail-qt1-f196.google.com with SMTP id j19so5223618qtr.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 00:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/QdUNDcGRTIn4Mm1UmaweKSH9RuZF0BWTBRT3JrMYA=;
        b=U2/XpaCZZAGxGXBysk14pwxKFeBZknZSzVbGUajAjQnFulC4yADxymGFGlJrAhAobU
         Vnt4S4ERl2Hb4S/Hf40jdRkOgvVg5xThytoFkowCyZEtRFFK1J79VVfWdWPiSSi6sUe0
         mtDZwYbIJP81SfRPSxT/7/ET4VQLa6U2K54eG0TFMU28U/oRd6brXSHybCLk0PE3QCDt
         3ns5245/0b2D1CUtVjDMu3VFUvxDFofCaQ6S8SIj8gaoWP/br0IgAeO6zVQNYiSU4WhB
         RbjtLa6xAJyoHTsGBryD9Uj5vV+A27mdYYFoih+XNbo1UEO5uYb3NHLGX9pnOqY97SPH
         10/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/QdUNDcGRTIn4Mm1UmaweKSH9RuZF0BWTBRT3JrMYA=;
        b=e6oqTKuLi4qjo6HmmXPYR3uAyrG8AefJanEGn0DG2EyBLfB0yCqKieqq6l4oIRYnmF
         gI0Bi7NxoS12yTC86q/WGsnG/qdUcHMgXnsG9X4Qn0llYZt6O2LhxMWUM6ftMpghJsa/
         7Ugs6lvwp515o1NYrYFP6nSU8RWmMa5Y3qZN9ogKR+KVQqpLBSZdxSQb6bUOsKCWgv1+
         bc/GFZt1D+YoInXI/rvZUtBh+d6Ga0Bl8SYXDbtmhUOy1jall/LMWOZyeW6Av8LoiXF+
         cwa/nlnDjGMmSGjU/bTOCqUAHEyvgrKIgTmSG1pgXOCGbnfDNsdNa7ByVdXGRAo0Ks0n
         mPDQ==
X-Gm-Message-State: APjAAAXJOQmWCZf9jr3OiSMEOjct/2srNuomYQ7xL/C33N5ESYXoD2Rf
        S4eM612RJY2tYbIRrycdKxz4NOIA4jrnaLZNOG5bze7e/gdq6g==
X-Google-Smtp-Source: APXvYqy76jBgXLP94PRu+jSfGP37fpyVr0djqBetr+sqr/L6y14YqWlVTXhs5Lar1aYlHNFKkG78ZzIlsVS4Q8kbips=
X-Received: by 2002:a0c:895b:: with SMTP id 27mr6622552qvq.94.1561706778916;
 Fri, 28 Jun 2019 00:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190628072307.24678-1-drake@endlessm.com>
In-Reply-To: <20190628072307.24678-1-drake@endlessm.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 28 Jun 2019 15:26:07 +0800
Message-ID: <CAD8Lp4577Vd109p2ax22WtXUH=bEXYP8o8Ak5Gk9texCw9+x5Q@mail.gmail.com>
Subject: Re: [PATCH] x86: skip PIT initialization on modern chipsets
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     hpa@zytor.com, x86@kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, please also add a reference to the main thread:

On Fri, Jun 28, 2019 at 3:23 PM Daniel Drake <drake@endlessm.com> wrote:
> Detect modern setups where we have no need for the PIT (e.g. where
> we already know the TSC and LAPIC timer frequencies, so no need
> to calibrate them against the PIT), and skip initialization PIT in
> such cases.
>
> Skip the IO-APIC timer-checking code when we don't have a PIT
> to test against (this was causing the panic).

Link: https://lore.kernel.org/lkml/CAD8Lp45fedoPLnK=UmUhhtkjy5u2h04sYKrx3U+m04U6FpVZ4A@mail.gmail.com

> Tested-by: Daniel Drake <drake@endlessm.com>
