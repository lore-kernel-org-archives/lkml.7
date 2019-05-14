Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182E4C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 21:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D967820879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 21:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HNMe7lJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfENVFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 17:05:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40344 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfENVFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 17:05:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id d31so172462pgl.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 14:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references:from
         :subject:cc:to:message-id:user-agent:date;
        bh=AWxN5ptvu2yKLcW7Bm5LBMGr1ZVlYaAwhpzhB0nfW30=;
        b=HNMe7lJXqBT7y/2cp+foZU0p50cuTfYKYZaABdqFDmkYX0VtYXw/Kvo3ZvmvCEzShG
         WSo8VBK5+qTNJbQ9jH9/9p27q8As73WWcxqiY7ehdNv6hnmu4NF7FABbOlZFSkoE1wV6
         ToM2vsichYz943+Om1qhsn7V2bTiJylmDMwOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:from:subject:cc:to:message-id:user-agent
         :date;
        bh=AWxN5ptvu2yKLcW7Bm5LBMGr1ZVlYaAwhpzhB0nfW30=;
        b=BSTG5wgUYEQNI40iIm//6hYYLMU3cbdCTCH3OP1UkV+O5Trk3zORfFde5m08vEsfwB
         bNC5TMyZeWsOAZY1seaCLcamr9omepz9LCPHvtNFyjbNayYWhPc4u9fvmd+62w1zsFHT
         gGgAOxBWkV3PdWV4V9fzUgFsqpHiCfNQqUcNzfcF1wcESY/0Y1gC+0tuiq2BZ3+G2L+c
         f4RqwoF4Ps71ODbOiEkyJDF08WqeTdZxCQBffSpkvw3u6OCm+FgFFlwI0L66Sh1OieiM
         3in4O/CqArPv3V6Y6cH/Z3Y9vJovcjzuc4WvPlYqymj0x/TLG4tNC3ato5J5fFW7e7yR
         nogQ==
X-Gm-Message-State: APjAAAXad3qa1D2Ya1aYgT0fDghKoXwA2hJRNx3vG3VEtBH8rp6/IOog
        YrvhqrI8dovjVysiqpADRYGExg==
X-Google-Smtp-Source: APXvYqz18bKfEM+qcHPBKQrWe+JFncgiIpoNu7rrAuyxF/9xscQmII8ueAu5RYyZ1oE1cXXVHko4AQ==
X-Received: by 2002:aa7:8186:: with SMTP id g6mr43384614pfi.126.1557867944834;
        Tue, 14 May 2019 14:05:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id n35sm28281pgl.44.2019.05.14.14.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 14:05:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJMQK-hKrU2J0_uGe3eO_JTNwM=HRkXbDx2u45izcdD7wqwGeQ@mail.gmail.com>
References: <20190513003819.356-1-hsinyi@chromium.org> <20190513003819.356-2-hsinyi@chromium.org> <20190513085853.GB9271@rapoport-lnx> <CAJMQK-hKrU2J0_uGe3eO_JTNwM=HRkXbDx2u45izcdD7wqwGeQ@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 2/2] amr64: map FDT as RW for early_init_dt_scan()
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Message-ID: <155786794318.14659.2925897827978978040@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 14 May 2019 14:05:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hsin-Yi Wang (2019-05-13 04:14:32)
> On Mon, May 13, 2019 at 4:59 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>=20
> >
> > This makes the fdt mapped without the call to meblock_reserve(fdt) which
> > makes the fdt memory available for memblock allocations.
> >
> > Chances that is will be actually allocated are small, but you know, thi=
ngs
> > happen.
> >
> > IMHO, instead of calling directly __fixmap_remap_fdt() it would be bett=
er
> > to add pgprot parameter to fixmap_remap_fdt(). Then here and in kaslr.c=
 it
> > can be called with PAGE_KERNEL and below with PAGE_KERNEL_RO.
> >
> > There is no problem to call memblock_reserve() for the same area twice,
> > it's essentially a NOP.
> >
> Thanks for the suggestion. Will update fixmap_remap_fdt() in next patch.
>=20
> However, I tested on some arm64 platform, if we also call
> memblock_reserve() in kaslr.c, would cause warning[1] when
> memblock_reserve() is called again in setup_machine_fdt(). The warning
> comes from https://elixir.bootlin.com/linux/latest/source/mm/memblock.c#L=
601
> ```
> if (type->regions[0].size =3D=3D 0) {
>   WARN_ON(type->cnt !=3D 1 || type->total_size);
>   ...
> ```
>=20
> Call memblock_reserve() multiple times after setup_machine_fdt()
> doesn't have such warning though.
>=20
> I didn't trace the real reason causing this. But in this case, maybe
> don't call memblock_reserve() in kaslr?
>=20

Why not just have fixmap_remap_fdt() that maps it as RW and reserves
memblock once, and then call __fixmap_remap_fdt() with RO after
early_init_dt_scan() or unflatten_device_tree() is called? Why the
desire to call memblock_reserve() twice or even three times?

