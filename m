Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A2EC282E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630FC20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUMhZtkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfDICNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:13:13 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45883 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfDICNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:13:12 -0400
Received: by mail-ua1-f66.google.com with SMTP id c13so4977375uao.12;
        Mon, 08 Apr 2019 19:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EyI77CdUtd3imX8c2og/tF7W43FQ8JfQEdZaPTZMBh4=;
        b=DUMhZtkzhHKADNgDqmCt1jxfDk3fUiSR2EfRKhCpZCTjsSpCJV15artTULCDvF+9vF
         IpZKUhTluu2oRXn5RU4WPv5sKYX9jxFs2OjXwNh7sVY2ef7t1+lqulUDnIucAKK5frED
         UwguBtWypTkHws2CMYzN6vAovJM4OjXG4fiVRxNdFKt7521HL1rOl+GRGCy/KO6+xt4J
         sMVuPzJ423EVmZbsF55RZWlCGHIYKyViMjesiu5VFEoAVYlXg8+UJ8s/xWcEM2Qli9QA
         Mx2s4ePwcctwMKcGvwkvi4MiLZOzMaMD1hVih5SKYSCCcAxJ1CgS1eg9+xnCucb5Pg7Q
         wTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EyI77CdUtd3imX8c2og/tF7W43FQ8JfQEdZaPTZMBh4=;
        b=JnL6d+Kq4SQZq8SOc7WRs78cUCTr7XBzul558FucBf0iKNc7DJhYpiGBu5VM0d9hqj
         Mg4cyLIPg25efNsKiHwytegPcGLas3xKjP10qLOvxgmy75qMoXy9nf7GR3JOFU4mU/D9
         rGVRydc/t0GbDrIj69rKK92zWTiIK2FsVqnqmAC3azDOfv8YEVD8W+mNVFMQa/avqkdA
         DiAUkS4Gebw2Jw/NBNZ/oausRDeonLsjYg8xjadnUPgxz4zgbcEJg0E8UOimKorX9Ene
         BxetFijs/bm9fIuBEn5Efo7mkfzKnZiBtrm1Vodpow8AVhxEqVj8CC0n68hBpfbgcIIC
         N+qw==
X-Gm-Message-State: APjAAAVL4fwrfgvNBI7M53g6UkcF3VVPfkWc1RxsJgFJtC4qTku1As2a
        4yuCsVDbF548t/CtnJ5nFXaxcIv4oEpsRIs6vuc=
X-Google-Smtp-Source: APXvYqyauLh/8EgScDhRRs6LYglKLBhvem3mNXlppuciaAXP/bNuE/51oXZ9NdbXfPOl5/N0Bs7aZymVWTr8pweTM/0=
X-Received: by 2002:ab0:3419:: with SMTP id z25mr17791439uap.102.1554775991757;
 Mon, 08 Apr 2019 19:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190219074500.16454-1-vichy.kuo@gmail.com> <CAL_Jsq+wUGxeQUMJd0eu52QadvLvkkT=36q9e1Qbru2gEsUGCw@mail.gmail.com>
 <CAOVJa8HUx-8Ok8yMm91UmXpo39KAipt6C1BsfOL1c0Q_kqs1Vg@mail.gmail.com> <CAOVJa8FROiP7e=p_4Bs=QxiwcdqD5ydrrO=6G2GX2TJkQh9U8A@mail.gmail.com>
In-Reply-To: <CAOVJa8FROiP7e=p_4Bs=QxiwcdqD5ydrrO=6G2GX2TJkQh9U8A@mail.gmail.com>
From:   pierre kuo <vichy.kuo@gmail.com>
Date:   Tue, 9 Apr 2019 10:13:00 +0800
Message-ID: <CAOVJa8F2eXE4yjj3OM0J3nd4GnW6brXuNLvF7h5Sdr1YSpQWAA@mail.gmail.com>
Subject: Re: [PATCH 1/1] of: reserved_mem: fix reserve memory leak
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Rob, Marek and Frank:

> >
> > In this patch, we un-reserving memory ONLY if explicit compatible matching fail.
> > That mean driver found something wrong while matching and let OS know.
> > (But reserved-memory without compatible property will not be affected.)
> >
> > So per ur explaination, there would be cases that driver reported
> > matching memory fail,
> > but the memory is still needed by another processor?
>

Would you mind to give some comment and suggestion for this patch?

Sincerely appreciate ur kind help.
