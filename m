Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D7ECA9EA2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C8621925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="rRoeANGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504205AbfJRGBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:01:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37462 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390743AbfJRGBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:01:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so4802204wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 23:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bUJLiWvB08iFLxWpJBCXj620abxUzMl2/mW6lq36/Xs=;
        b=rRoeANGsJLnSZrG5kRjo8/KXrHiJxoVnXcihkW4lnkRzzXtMfnMdyATHmpj3F6cSw0
         C+CFQ86vc7DCbYuL7k+lL55VwPISMoshItEXPffvA8xKWAwDSeJvs8lM/aGxxOoyDA0G
         xQBmef4H9PQuimhjHxXrFeNtkvFTkoP5AuYU2Yqo+ElVWGUi6aZ8W8K6puS5Y5pI9/uV
         j/nbluVD2cLJ2uq2jmiFKAlIaAjYSe/mZbaL7GL5QKHKON/Aa8eb5//LlEOJqBGD1AWf
         K6LUg1fNHAWy6K6Qy/xP+eqoeljlnpltqgWcfJ23LkZtF6ZlsA9XXUXxrNtbMaF+LfQf
         /VDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUJLiWvB08iFLxWpJBCXj620abxUzMl2/mW6lq36/Xs=;
        b=NW3e4eKE43F4JZpXHVHELGyNqCifi5k0YFKQe4003iYrPM6zVghZtus7XIGRdq73ou
         zQrnMnsegJ+l0ZHRHaIaej3bMDroDhLNSTvfipc1gF5FVzlRCYsK3WWUFVMuJ0ZAAOLB
         tiijkEWlpj9Hk92VfiDtSAT5Mn+ygmmwX0fk4fz982t0Xapqc3QgdJgtU0J5JyvcqFNd
         J5VYpg0V24fRutg9ZbrdXrrkL/j/2iDWG7xODozEDMQlvxeQHF9MNk/QIoLVPBi+RUSy
         PHH1TOOJPXLC0GHYAD0gudSPra7LRP5YMzmBFOeYeywB61Y3Fq/GPXlyMCecujW2zPRo
         98EQ==
X-Gm-Message-State: APjAAAVrG8+xNHMgxV2nconnjT9M8B+nz++8d20F2SUYD1Emd79k93Ka
        O9p0l7xCdhd5m4FW8KMYktNN3sCszFov23MM4PjlYKq/
X-Google-Smtp-Source: APXvYqxM0KahMGBxIxTv+KeVzUN9KXIJyXEf4oKMa/uoCQ1jReXlmJOheGaVaL4ufWKZW6jVK6rQl/xrP3+BPhfN5o8=
X-Received: by 2002:a7b:c775:: with SMTP id x21mr5621790wmk.52.1571368137819;
 Thu, 17 Oct 2019 20:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191017173743.5430-1-hch@lst.de>
In-Reply-To: <20191017173743.5430-1-hch@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 18 Oct 2019 08:38:47 +0530
Message-ID: <CAAhSdy1dvFzEh_WZ8aDNyCKi968Dwxm+ru6D0DF08QoOq3JjLA@mail.gmail.com>
Subject: Re: RISC-V nommu support v5
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul/Palmer,

On Thu, Oct 17, 2019 at 11:07 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> below is a series to support nommu mode on RISC-V.  For now this series
> just works under qemu with the qemu-virt platform, but Damien has also
> been able to get kernel based on this tree with additional driver hacks
> to work on the Kendryte KD210, but that will take a while to cleanup
> an upstream.
>
> A git tree is available here:
>
>     git://git.infradead.org/users/hch/riscv.git riscv-nommu.5
>
> Gitweb:
>
>     http://git.infradead.org/users/hch/riscv.git/shortlog/refs/heads/riscv-nommu.5
>
> I've also pushed out a builtroot branch that can build a RISC-V nommu
> root filesystem here:
>
>    git://git.infradead.org/users/hch/buildroot.git riscv-nommu.2
>
> Gitweb:
>
>    http://git.infradead.org/users/hch/buildroot.git/shortlog/refs/heads/riscv-nommu.2

It will be really cool to have this series for Linux-5.4-rcX.

Best Regards,
Anup

>
>
> Changes since v4:
>  - rebased to 5.4-rc + latest riscv fixes
>  - clean up do_trap_break
>  - fix an SR_XPIE issue (Paul Walmsley)
>  - use the symbolic PAGE_OFFSET value in the flat loader
>    (Aurabindo Jayamohanan)
>
> Changes since v3:
>  - improve a few commit message
>  - cleanup riscv_cpuid_to_hartid_mask
>  - cleanup the timer handling
>  - cleanup the IPI handling a little more
>  - renamed CONFIG_M_MODE to CONFIG_RISCV_M_MODE
>  - split out CONFIG_RISCV_SBI to make some of the ifdefs more obbious
>  - use IS_ENABLED wherever possible instead of if ifdefs to make the
>    code more readable
>
> Changes since v2:
>  - rebased to 5.3-rc
>  - remove the EFI image header for nommu builds
>  - set ARCH_SLAB_MINALIGN to ensure stack alignment in the flat binary
>    loader
>  - minor comment improvement
>  - use #defines for more CSRs
>
> Changes since v1:
>  - fixes so that a kernel with this series still work on builds with an
>    IOMMU
>  - small clint cleanups
>  - the binfmt_flat base and buildroot now don't put arguments on the stack
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
