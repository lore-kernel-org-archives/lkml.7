Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04963CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1FA2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437459AbfJYH5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:57:46 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45944 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437161AbfJYH5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:57:46 -0400
Received: by mail-oi1-f196.google.com with SMTP id o205so926082oib.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 00:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4Obnzy7VbllcsBWAG1yWv4o6m8aHs6PeND33uMddFQ=;
        b=C2WP10JyK1MppkzRqSHulgcscDYsqiLiBI3wtdAmPTB43ecwDcf2Et2d424gR3CZRb
         1knVJpz/7OaG3zXSaQCoBKhNpanO/Fq0fYReYvRvh0GAcDvgPBzafw5aI1s6lpMym+JR
         Ew26fljQWcMycdHeHTFDWtU/Rlr4mXnZ3UdcafF0ormG4euC0zET/G5IyqWaE6s+qWwU
         QTEmy+vSZgghbEGzE3G8L7hgcpCyIQAbNFvCBDXe48Zy+XhkCCdNneJ/gSnTvReIcafu
         w6zGnY0NzYX63aIODGCI0/oQSEULNSUEyAxJN+5h+/fg1ilVEx6vJN7d8aCbF8CzgSFR
         lu7g==
X-Gm-Message-State: APjAAAWzHdKKa3WB8IJ9kiMsFINcn9r/zIylJeFJPQsNbWSsKwcUE1Dv
        VWus+/9aAZAi0u180lC18Czc9IwIZJ5CzOQfrE0=
X-Google-Smtp-Source: APXvYqyfnJ+dy4wBkvd4/tg8hxR0xQoQa82GCOzKvlEF+4HiTRrSEXgg68lJoNd3q+IHUF3QAJjVi6QqyPRctI5LUaA=
X-Received: by 2002:a05:6808:3b4:: with SMTP id n20mr1723311oie.131.1571990265293;
 Fri, 25 Oct 2019 00:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191025044721.16617-1-alastair@au1.ibm.com>
In-Reply-To: <20191025044721.16617-1-alastair@au1.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 25 Oct 2019 09:57:34 +0200
Message-ID: <CAMuHMdUXVy1AYcqquJ2UHdG=2Own=HA3sAGzL_4M+nYd-xh+Dg@mail.gmail.com>
Subject: Re: [PATCH 00/10] Add support for OpenCAPI SCM devices
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alastair,

On Fri, Oct 25, 2019 at 6:48 AM Alastair D'Silva <alastair@au1.ibm.com> wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
>
> This series adds support for OpenCAPI SCM devices, exposing
> them as nvdimms so that we can make use of the existing
> infrastructure.

Thanks for your series!

The long CC list is a sign of get_maintainter.pl-considered-harmful.
Please trim it (by removing me, a.o. ;-) for next submission.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
