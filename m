Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20FEC48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5252089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561379177;
	bh=0GL2bo1FUJp25hX3xPKVZx1c8sZfOJZVJeUWmtAR7l4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=N4CNttHX3h7AfCZT36SfG8bLoK5KcaVeQqcHL+HvjelLXD5TD0JuFG+XGIYKHeiuz
	 CyC2uB22epGoABva7PZw25+yLxv140plbK5k85yhpbW7zlE4HumhWqqNE3ELB8qt5G
	 uEQY53t1Z/Gnkc+eZcMcRPTw6/kV02AjmSh8Y710=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfFXM0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:26:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbfFXM0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:26:16 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95A9E213F2;
        Mon, 24 Jun 2019 12:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561379174;
        bh=0GL2bo1FUJp25hX3xPKVZx1c8sZfOJZVJeUWmtAR7l4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vVMtIzdK/J+ap5W5TOZR0rbfAH4vrx3esUAex4ZBSV3gqqu3T5h53SYPkTyhymyNh
         5EOqMwPwMbuIzHFOupls06FB7n2Ethuj3/M2jKkZ2vdzGyRtEmzj2KUMsj/zlqfYwD
         536NbBGaK+wbS/igmEDmkkwLWoKU2ecFSzbdC3AM=
Received: by mail-wr1-f44.google.com with SMTP id n4so12497824wrs.3;
        Mon, 24 Jun 2019 05:26:14 -0700 (PDT)
X-Gm-Message-State: APjAAAVQaMhfdB5j3dA6o/mccUPOCyI4NNfhIJi4A5CwZ2qIUX3rvVMY
        CziHqjQBXZMPmpf+1jA4mBu5ut9UzX7py9V1Xw0=
X-Google-Smtp-Source: APXvYqzukQENehrpRZz95k0wGVgMQVV73CDNWm4n4HrcRIq1+GGGivB+ICvTeybbRjHf4EECeHffdpMACqQtQyPgSdY=
X-Received: by 2002:adf:9bd3:: with SMTP id e19mr31933353wrc.38.1561379173221;
 Mon, 24 Jun 2019 05:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <1561305869-18872-1-git-send-email-guoren@kernel.org> <20190624114010.GA51882@lakrids.cambridge.arm.com>
In-Reply-To: <20190624114010.GA51882@lakrids.cambridge.arm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 24 Jun 2019 20:25:59 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTEW5iomUQBBYUg5TgONURcWpdvLBD5EMFuvG5SSixAQw@mail.gmail.com>
Message-ID: <CAJF2gTTEW5iomUQBBYUg5TgONURcWpdvLBD5EMFuvG5SSixAQw@mail.gmail.com>
Subject: Re: [PATCH] arm64: asid: Optimize cache_flush for SMT
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Julien Grall <julien.grall@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 7:40 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> I'm very confused by this patch. The title says arm64, yet the code is
> under arch/csky/, and the code in question refers to HARTs, which IIUC
> is RISC-V terminology.
This patch is used to answer Catalin's question:
> While the algorithm may seem fairly generic, the semantics have a few
> corner cases specific to each architecture. See [1] for a description of
> the semantics we need on arm64 (CnP is a feature where the hardware
> threads of the same core can share the TLB; the original algorithm
> violated the requirements when this feature was enabled).
Here is my reply for Catalin:
C-SKY SMP is only one hart per core, but here is a patch [1] with my
thought on SMT duplicate tlb flush:
[1] https://lore.kernel.org/linux-csky/1561305869-18872-1-git-send-email-guoren@kernel.org/T/#u

Our talk is on this thread:
https://lore.kernel.org/linux-arm-kernel/20190624102209.ngwtosgr5fvp3ler@willie-the-truck/T/#m92396a2f238c9eece660cdc0f275e787531d4ec1

>
> On Mon, Jun 24, 2019 at 12:04:29AM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > The hardware threads of one core could share the same TLB for SMT+SMP
> > system. Assume hardware threads number sequence like this:
> >
> > | 0 1 2 3 | 4 5 6 7 | 8 9 a b | c d e f |
> >    core1     core2     core3     core4
>
> Given this is the Linux logical CPU ID rather than a physical CPU ID,
> this assumption is not valid. For example, CPUs may be renumbered across
> kexec.
>
> Even if this were a physical CPU ID, this doesn't hold on arm64 (e.g.
> due to big.LITTLE).
That's ok for csky, C-SKY smp logical CPU ID is the same with physical one.

>
> > Current algorithm seems is correct for SMT+SMP, but it'll give some
> > duplicate local_tlb_flush. Because one hardware threads local_tlb_flush
> > will also flush other hardware threads' TLB entry in one core TLB.
>
> Does any architecture specification mandate that behaviour?
>
> That isn't true for arm64, I have no idea whether RISC-V mandates that,
> and as below it seems this is irrelevant on C-SKY.
Harts in one core share the same tlb and I think one hart flushing tlb will also
affect on other harts in the same core. So we just need one tlb flush for one
core.

>
> > So we can use bitmap to reduce local_tlb_flush for SMT.
> >
> > C-SKY cores don't support SMT and the patch is no benefit for C-SKY.
>
> As above, this patch is very confusing -- if this doesn't benefit C-SKY,
> why modify the C-SKY code?
Ditto, it's for Catalin's question and this patch compiled for csky.

Best Regards
 Guo Ren
