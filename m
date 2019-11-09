Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF71C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1699921882
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yx8JTiSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfKITVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 14:21:00 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:34753 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfKITU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 14:20:59 -0500
Received: by mail-il1-f195.google.com with SMTP id p6so8174136ilp.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 11:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MkH89WBzNu1RX65KEpd7wgGkq9IjrOpUII7CjYIWD7Q=;
        b=Yx8JTiSUcJDTDqeV3JVqYyR8mb11sdfgDH3KPlIJpVSaAEotIGmprjGixANdnPex4g
         pIs8vrUy87i6mT5L5tHi2oIioAsuUdd7d5Aj3pIZoUS92kclX6r76i5cDjqlujc/WhcX
         A0I0bpGuBFQ1qIPoACyLBYKW8vkRuLumYNpws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MkH89WBzNu1RX65KEpd7wgGkq9IjrOpUII7CjYIWD7Q=;
        b=TJB5Cmk7dEK2Gi43Zsij234RvNUZwot85B5YWQLgOQItZmDXzVtVYX2newgJRcyDl6
         WoQmm0aEye2AxwhsiUIBbg/t8TpYzvyviGnGlD75DnAVdKVqkNQ3nCRXZq4rg2YCLbsk
         gaD0JQhPPn+42yffL0BHIv26tR11MPrY5Xm70mfy8yKK6Gf1IEBowWau3Gfk+b67gVQB
         hCc8LCebTXo+NTxK/FFTteDDC+BnvncD7DQphJ323Whx/0wUgsffZpYaVzNTlueM3XOw
         t1IGFABfu5rV7avB+niF/spaFzMOtLjg51WO4EEqjU/RLSo0QhvMHtWuB/s5SIF8z2HW
         RViQ==
X-Gm-Message-State: APjAAAXO0WiBmJNbuy0fQTQAH3BVDrOWBlyEpH46HHoO1m9OfRSG7fJo
        KIPvx+LfrAWxZwVvCEyuRcd8RsinLp8=
X-Google-Smtp-Source: APXvYqxDgxLrW9x38pGleJHL7xMfKC4d4Yf7J2koyp44X+/A9D8bLbUc2YhVphBXT2W2Hxzm5uTpQg==
X-Received: by 2002:a92:99ca:: with SMTP id t71mr19965324ilk.61.1573327257128;
        Sat, 09 Nov 2019 11:20:57 -0800 (PST)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id b9sm1361893ilq.46.2019.11.09.11.20.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2019 11:20:56 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id i13so8612603ioj.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 11:20:56 -0800 (PST)
X-Received: by 2002:a02:7158:: with SMTP id n24mr18296678jaf.127.1573327255569;
 Sat, 09 Nov 2019 11:20:55 -0800 (PST)
MIME-Version: 1.0
References: <20190925200220.157670-1-dianders@chromium.org>
 <20190925125811.v3.3.Id33c06cbd1516b49820faccd80da01c7c4bf15c7@changeid>
 <20191007135459.lj3qc2tqzcv3xcia@holly.lan> <CAD=FV=Vqj9JqGCQX_Foij8EkFtSy8r2wB3uoXNae6PECwNV+CQ@mail.gmail.com>
 <20191010150735.dhrj3pbjgmjrdpwr@holly.lan> <CAD=FV=VuOVpvEB60-prMxuPyjcrJ-9O2hyaLKf86c-r9BVocdg@mail.gmail.com>
In-Reply-To: <CAD=FV=VuOVpvEB60-prMxuPyjcrJ-9O2hyaLKf86c-r9BVocdg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 9 Nov 2019 11:20:42 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UQeHp9=HGWUHHHpYTt0w+AfTMhTrVAjLeiEReszJLJfQ@mail.gmail.com>
Message-ID: <CAD=FV=UQeHp9=HGWUHHHpYTt0w+AfTMhTrVAjLeiEReszJLJfQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] kdb: Fix "btc <cpu>" crash if the CPU didn't round up
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 10, 2019 at 9:38 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Oct 10, 2019 at 8:07 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > > Reading through other control flows of the various backtrace commands,
> > > it looks like it is intentional to leave the current task changed when
> > > you explicitly do an action on that task (or a CPU).
> > >
> > > Actually, though, it wasn't clear to me that it ever made sense for
> > > any of these commands to implicitly leave the current task changed.
> > > If you agree, I can send a follow-up patch to change this behavior.
> >
> > Personally I don't like implicit changes of state but I might need a bit
> > more thinking to agree (or disagree ;-) ).
>
> I can post up a followup after this series lands and change it.  I
> have a feeling nobody is relying on the old behavior and thus nobody
> will notice but it would be nice to get this cleaner.

Sorry it took so long, but follow-up series can be found at:

https://lore.kernel.org/r/20191109191644.191766-1-dianders@chromium.org

-Doug
