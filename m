Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65932C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DC32073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555409971;
	bh=E2vKRGjJ+z8S2HXfa6FzVP2ZRMe7ML6XOCbVjt3pf1w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cpsIxjBHuoMiZfkM5bDKeboem54erDTkoYTfkPpRuFO2k4ZpM6xXZ/4KL8tNrXJ6e
	 a15ekjE9qTBT686M+Q6HeDWUXA0b+48B21AaSlpvGO4Ru+XpphyMvvEvGzBRaZpnQI
	 5VDKHSS2zoaQR+qX1hBaHVYWBimG6rth62HO80HI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfDPKTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfDPKT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:19:29 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6018420872;
        Tue, 16 Apr 2019 10:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555409968;
        bh=E2vKRGjJ+z8S2HXfa6FzVP2ZRMe7ML6XOCbVjt3pf1w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P0R4wlLpREN7FXprU+rnhtap6chmLWWBHJ+th5ngE3VOobQWt7v65HQpNuJ7qCR0r
         bXDXQxLbZQEGY7MZHJ7hC9x+3dgVumPz6W/2hGEdx925EsNdJ6pmcw6Wb2uqvPKUcD
         sqf6x7ePqqmXXmejwa67EQtWL/bL27XQUfSI+P4U=
Received: by mail-lj1-f176.google.com with SMTP id t4so10073394ljc.2;
        Tue, 16 Apr 2019 03:19:28 -0700 (PDT)
X-Gm-Message-State: APjAAAUyarKZJjryOg8CWp6QGNCxbjOg4PdXIYpIbHWgnLgJe7g6ho1K
        Y7lxuVzyBE+TMW+0mhNJi+TPTo8JTwoYYBcHuq0=
X-Google-Smtp-Source: APXvYqzL0gPQ0S0ZzAku8dhj9PLkVZ6Yhvt9njOXJefuMLrwaAjJ/Mt1yqoA6uSipC9V+0RqPhpYQtGo1EFiKUlaLQI=
X-Received: by 2002:a2e:960b:: with SMTP id v11mr30606783ljh.135.1555409966546;
 Tue, 16 Apr 2019 03:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190412172545.fkxnpnymhcw7xncc@macpro-scc.lancs.ac.uk> <CANAwSgSX6q4M2EcWvEA3B6zQuY0DBrh-0_r3v__R--p7dzjs7w@mail.gmail.com>
In-Reply-To: <CANAwSgSX6q4M2EcWvEA3B6zQuY0DBrh-0_r3v__R--p7dzjs7w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 16 Apr 2019 12:19:15 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeUYw2DNEzRfKGzTmNAtg5mHJObVFHygKJ2eUdDpAFmOQ@mail.gmail.com>
Message-ID: <CAJKOXPeUYw2DNEzRfKGzTmNAtg5mHJObVFHygKJ2eUdDpAFmOQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: add CCI-400 PMU nodes support to
 Exynos542x SoCs
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 at 14:24, Anand Moon <linux.amoon@gmail.com> wrote:
> Cache Coherent Interface (CCI) among Cortex-A15 and Cortex-A7, G2D, G3D and SSS
>
> Level 0 > CPU blocks such as Cortex-A15 (CA15), Cortex-A7 (CA7) are
> joined as the member of Level 0 CCI bus
>
> Level 1 > Display engine block (DISP) and 2D graphic engines (G2D) are
> directly connected to Level 1.
>   DISP, MDMA, SSS.
>
> Level 2 > While all the other IP is connected to Level 1 bus via Level 2 bus
>    G3D, MSCL, MFC, ISP, JPEG/Rotator/DMA/PERI, NAND/SD/EMMC.
>
> So my question is the mapped with the cci ip block correct.
> Level 0 (cci_control0)
> Level 1 (cci_control1)
> Level 2 (cci_control1)

Hi Anand,

I do not understand the question - what is mapped with correctly or not?

Best regards,
Krzysztof
