Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A67C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4391120811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EPucXkbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfDXKKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:10:10 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:40719 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfDXKKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:10:10 -0400
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x3OAA3So029190;
        Wed, 24 Apr 2019 19:10:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x3OAA3So029190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556100604;
        bh=fAHzJgmTpcgaeXli9t2VJI/ayV0hqVJGtbtoz1w6xmo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EPucXkbwEJ/fJdTbzrdYoqhAf7FHeLqOYwyyEqdwKiYdXwJc14QEreqSPirZzKtyj
         ZUf4DwTBQKtBs6LUBjTvUsXkLIKRODpSFTgD766NTosA1+cr5l2pA8vB4lz+mSJ4Ab
         fzQu5WYno/CuQ3W7B7+ygbxQ01sTPq9wjBSfXOTptxPbnfOu8flUEsecL0/jizVZAR
         O9cwTgiJqlV+E2jymDAOkTeUuUJBUQWIc8WNvWt9K2zQXf/xX3wzsanoVaXURgyqPF
         16ohXNhlsAKnGVu+KYAWMwk99DBBi2ZdgwEDTVEGDWTufWZANh/fqoH1cvvIepGFeT
         TF5+SH3zL7e8g==
X-Nifty-SrcIP: [209.85.221.181]
Received: by mail-vk1-f181.google.com with SMTP id f77so784169vke.8;
        Wed, 24 Apr 2019 03:10:03 -0700 (PDT)
X-Gm-Message-State: APjAAAWNsQtEBCvIGP/DdsDNuWf3SvR8k7XoJzKeofsVWSM56fRimyq4
        XGOk18QubtdTCnhdfcu3aV0bbL8DDyQaBU04iAg=
X-Google-Smtp-Source: APXvYqykfqrEZqWi+BulWM+BmTcfHYh8zgrPhXMl30I/1UdP47GTQLOQcjtkGAAy7F1gKLr4DxV+RJKcvz93SolXpKE=
X-Received: by 2002:a1f:b297:: with SMTP id b145mr16645284vkf.74.1556100602843;
 Wed, 24 Apr 2019 03:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <1555669773-9766-1-git-send-email-alex.popov@linux.com>
In-Reply-To: <1555669773-9766-1-git-send-email-alex.popov@linux.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 24 Apr 2019 19:09:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQP8ys181hL9EtGVoQppn_-aLn+Ufineebf396rDn-Ezw@mail.gmail.com>
Message-ID: <CAK7LNAQP8ys181hL9EtGVoQppn_-aLn+Ufineebf396rDn-Ezw@mail.gmail.com>
Subject: Re: [PATCH 1/1] kconfig: Terminate menu blocks with a newline in the
 generated config
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 4:12 AM Alexander Popov <alex.popov@linux.com> wrote:
>
> Currently menu blocks start with a pretty header but end with nothing in
> the generated config. So next config options stick together with the
> options from the menu block.
>
> Let's terminate menu blocks with a newline in the generated config.
>
> Signed-off-by: Alexander Popov <alex.popov@linux.com>


The .config file is a flat list of CONFIG options.
It does not represent menu structures at all.

I tested "make allyesconfig"
and the resulted outcome looks cheesy.



[1] Two blank lines in a row


---------->8-----------------
CONFIG_EFI_EARLYCON=y
CONFIG_IMX_SCU=y
CONFIG_IMX_SCU_PD=y

#
# Tegra firmware driver
#


CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
--------->8------------------------


[2] Some blank lines appended at the end of file

----------->8-------------
CONFIG_CPA_DEBUG=y
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_ENTRY=y
CONFIG_DEBUG_NMI_SELFTEST=y
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set


---------->8-----------------



The readability of the .config could be improved somehow,
but this patch is not the right one.



-- 
Best Regards
Masahiro Yamada
