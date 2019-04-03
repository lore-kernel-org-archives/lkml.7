Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE68C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8197F2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="W8XxZkUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfDCFSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 01:18:30 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:38337 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfDCFSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 01:18:30 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x335IJ2r025071;
        Wed, 3 Apr 2019 14:18:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x335IJ2r025071
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554268700;
        bh=Pan6kbLEqd0Bp/ZwtxT4KpWfhApzkS4/9SXjDUrP1RQ=;
        h=From:Date:Subject:To:Cc:From;
        b=W8XxZkUSxF+icfpP41zqWSgPnAmMPzrN7BLqxDT/4sBDKvt3iHwQliaysxPmLFj5M
         86fZ1rBnt5YF1n9HQ63iv1Nm6HpWEBITRIUwfnJXHd8JpLQdyUgr8poFTQu4XlxwtR
         Kt5t5Tp8bJuhVAk19wA1L1T29MNU+iOpSlMIj3cHB/hSIwjr2BMfTEGM/fmDSZZajP
         VEzYG6lMDm5ju3VT327l05OsG0BIcr6ecCPUlytJK/G9/tYS0Ob9NtZK3T9aqmANpX
         X9sMNsZ4iTgZ0TEvXugd5pqOn7KaL94HqR5OZnRsgBw/a//WjZsuyadMrQktBNeOE/
         k0EwcaZqM2DeA==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id j184so9207136vsd.11;
        Tue, 02 Apr 2019 22:18:20 -0700 (PDT)
X-Gm-Message-State: APjAAAUXCmbHKvDfaVIjaCawMvN03BVUNTCoPPOfQNu8OHNwlOAT96pv
        gZ9inag+tKEVFm/TkF0mjIQxeBFwdAl45NINifw=
X-Google-Smtp-Source: APXvYqwKiUG6C79u6dnHCag93mX94eYj7Xazpa8k4f2tg9PQ5t6RT66oh7aPS1zGPLvVvadZdimbqT8J3Pwo/kA2Wuc=
X-Received: by 2002:a67:c29e:: with SMTP id k30mr45312946vsj.203.1554268699243;
 Tue, 02 Apr 2019 22:18:19 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 3 Apr 2019 14:17:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com>
Message-ID: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com>
Subject: Does vdso_install attempt to re-compile objects under root privilege?
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have a question about 'vdso_install'.


In my understanding, vdso is embedded in the kernel.
In addition, you can run 'make vdso_install'
to install an unstripped version of vdso.
(Mainly, debugging purpose?)

By default, 'make vdso_install' will install it to
/lib/modules/$(uname -r)/vdso/.


Since that directly is owned by root,
'make vdso_install' could potentially be
executed by root, isn't it?


Currently, 'vdso_install' depends on vdso,
so it may cause recompilation of objects
in the source tree.


This violates the basic rule:
"Installation targets must not modify the source tree".

We often miss this point. For example, see
commit 19514fc665ffbce624785f76ee7ad0ea6378a527


If this is a problem, I will fix Makefiles to
make 'vdso_install' not depend on vdso

Thanks.


-- 
Best Regards
Masahiro Yamada
