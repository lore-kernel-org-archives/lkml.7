Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B92C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D9820881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M4RbnVlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfEOJHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:07:54 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42041 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfEOJHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:07:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id j53so2360015qta.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 02:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbQtz0/a90pIaMSCWP84iVzFuP3XKcJmSksz/GcBaK0=;
        b=M4RbnVlDKOEx9SpprG/yztIqOThSh+PXtYU/A1m2flZulmsPxxYArIr39yKexfC4pA
         cmwOmpGLegz8F6VpHrz8MeJNeKVNWm3vsNwQztlv6YrT93c6ZMUgkUxH77A1JR0sIt2d
         49XheDHbU3/+MqkMrzDMV0cYtgGt8H2hAimUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbQtz0/a90pIaMSCWP84iVzFuP3XKcJmSksz/GcBaK0=;
        b=YKo3Smpc4bto/bAxLg5lHS0f6BEa8b0sXZR2JGC9oqvdk8oMglZnufGtk/Svkv767C
         ckSicGuTrtVX92/rrM/kWpg2RhsVpkHM2ZQN8/qUyvCPy+hW4mGO0bH6jHCtubxO9jNY
         thNAF1NXwl9MbvSXIMiJNUFKvZMrQZV84TppkLLX834IBZlPtdUkXXsd1w1/hr5VltJF
         K7v96cFIuRktyw6d3d++IFhXzcyqRvlC2E+3Kls+MawQoj6bASdS7Y5bkbll9PAwIKs7
         iSbeQGyfmjaoYGEakc1reMwP+z8eItKO4wUXkCm/KBD0M7W972sM4wzfqAYXxm6hhU7N
         P/Ng==
X-Gm-Message-State: APjAAAXOwSXbMNaOJIr8gJ09v0alSKKGK8KMu/+rWilvrspJzyuH/SHC
        GvmklaM83EbUdZ/T2AruoNj25+IU2UyzLwKeYqnEqQ==
X-Google-Smtp-Source: APXvYqyXl9+Efyxlf2al2/kO4uZaNzAovVvLGkNka+wUbkkqJvcl3CuDnIvDXQ6VyY6lb4I0Ezw26J8OV7wIwh0ZW1o=
X-Received: by 2002:aed:24ae:: with SMTP id t43mr34214820qtc.187.1557911272310;
 Wed, 15 May 2019 02:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190513003819.356-1-hsinyi@chromium.org> <CAL_Jsq+Z5+M7fYCrkRKqN1yKTu6uyMKRKh-R4b-cj46y18hXOw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+Z5+M7fYCrkRKqN1yKTu6uyMKRKh-R4b-cj46y18hXOw@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 15 May 2019 17:07:26 +0800
Message-ID: <CAJMQK-jei0j5R6sgn4GfxnqK127J5dtzcuiw8XP6hzLf_9vRAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fdt: add support for rng-seed
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 9:14 PM Rob Herring <robh+dt@kernel.org> wrote:

> > +        fdt_nop_property(initial_boot_params, node, "rng-seed");
>
> I'd just delete the property.
>
> Also, what about kexec? Don't you need to add a new seed?
>
Will update in v3. Thanks.
