Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3559C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921FB20882
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJiwm9+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfELPlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 11:41:45 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45444 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfELPlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 11:41:44 -0400
Received: by mail-vs1-f67.google.com with SMTP id o10so6497742vsp.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 08:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1uG0bivhTUejUYCRrrklLeHk3N0BPLHnD725/cI68EM=;
        b=sJiwm9+KPs7IRgLD8j4w62N2RmFZ1h0n4FhkeFXOTaRxUOiCyOT0/KzvQ3gLCEkUH1
         1djUf7rJ9bpcpU6xPvfCUX5Y0ZNmrh8eC732/6AaHHvfIT9EoQ1lPCUm3uY2e24OKUnx
         GsHCfsFTMVXBut+R3LrniecbHpz/QHeJ4h7IiA0HmzKAhp4rfu9a6Ya66Y2l0gsKYTCs
         r+ZAeKLi6tKTwtcudZEOvvbFoXGdAhZRrBuPFC5NtJp9FemmZweDoAl1kIZEIp5vgek0
         ceW2B0Tz6QDO6fI6CpzE7/vvXzOpOCdmwY1vzdhQXyYPXp5mDI6M5cju8XNhapYm7JRc
         AdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1uG0bivhTUejUYCRrrklLeHk3N0BPLHnD725/cI68EM=;
        b=aGCAvKWaDC9wuVZT5myWkz5lbybV6fX0ez67dtasp81KyUf9B5eQfHL8Cl3cq+S5WV
         S2/Pz1enCqH+/9gjOmAHwthMzSUvgnd7tusiOeYdc1zZea+5xXBDpITBYVG/mlNfUAnx
         vaXZogtmmxaPCz1Qd55L4OQS4AjFCsidXU3Vwd+mKZ0B/jfX9aqplU3eXkWBomDoMmE0
         j1nK8zbDLIybeO/lMhzUj7RVwYY9VF/iFuUWsAuHNiChUCHm/kl1clrFFYEwjyohB+Zu
         2RkQQatSP9siQN8ZObvWPmKYW8/F+MBeHjuELSSNWx3ouu8Rz9/aGb2krP3LhnhRuXuD
         vsnA==
X-Gm-Message-State: APjAAAUUURTk1TYKaq/PTB4pPTMddu8a/3kfsotrdeVgDBgD+mC8A7DE
        K7uOVf3+e84H9oT6CGkfoQTmH2PNILK5j3GWQxU=
X-Google-Smtp-Source: APXvYqwT2y7jDLgGNhBNA81qUTnKiEMzx8FUsJG2jY1R1VLHVs9RSkBhQHi/GzpncbnQfylq8oyUSgTVUgIjrMjbG4Y=
X-Received: by 2002:a67:ca1c:: with SMTP id z28mr659462vsk.6.1557675703831;
 Sun, 12 May 2019 08:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190408163319.10382-1-vichy.kuo@gmail.com> <CAKv+Gu9gfq6PdwwLJd-zXYTiVT0oKtkhJHG4+AaOdD+N0k6c=Q@mail.gmail.com>
In-Reply-To: <CAKv+Gu9gfq6PdwwLJd-zXYTiVT0oKtkhJHG4+AaOdD+N0k6c=Q@mail.gmail.com>
From:   pierre kuo <vichy.kuo@gmail.com>
Date:   Sun, 12 May 2019 23:41:30 +0800
Message-ID: <CAOVJa8EGh2Unqok1JNhxmRUi4vU45G_d0W+cWupkmRaqRPk9NQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kaslr: shift linear region randomization ahead of memory_limit
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Price <steven.price@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ard:
> > The following is schematic diagram of the program before and after the
> > modification.
> >
> > Before:
> > if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {} --(a)
> > if (memory_limit != PHYS_ADDR_MAX) {}                               --(b)
> > if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {}       --(c)
> > if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {}                           --(d)*
> >
> > After:
> > if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {} --(a)
> > if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {}                           --(d)*
> > if (memory_limit != PHYS_ADDR_MAX) {}                               --(b)
> > if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {}       --(c)
> >
> > After grouping modification of memstart_address by moving linear region
> > randomization ahead of memory_init, driver can safely using macro,
> > __phys_to_virt, in (b) or (c), if necessary.
> >
>
> Why is this an advantage?

1st, by putting (d) right behind (a),  driver can safely uses macro,
__phys_to_virt that depends on memstart_address, in (b) and (c) if necessary.
That means:
(a)
(d)
----- finish modification of memstart_address --------
(b) --> can safely use __phys_to_virt
(c) --> can safely use __phys_to_virt

2nd, it can make current driver more concise.
Letting (d) right behind (a), as below v3 patch shows,
https://lkml.org/lkml/2019/4/8/683
it can put initrd_start/initrd_end to be calculated only when linear
mapping check
pass and concise the driver by eliminating
"if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) " as patch shows.

Thanks for your message.
