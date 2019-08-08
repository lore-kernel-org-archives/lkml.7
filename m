Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D020C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80052186A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="v0i3/1Mf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbfHHGUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:20:54 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:40732 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfHHGUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:20:54 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x786KlG6001719
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 15:20:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x786KlG6001719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1565245248;
        bh=AaI2IrKsSqMnysxi/K+DT8cvw8vTc+G4FLL3R7l2mcg=;
        h=From:Date:Subject:To:Cc:From;
        b=v0i3/1MfIhgcbQJzOXPTvDHFNc9N81zokJQr1SiSj6IWbeEeK9Qfpvabh+rRYPL5W
         LWXoIFJpExE435cQkTyKy2CGYjCUMKOY0TnINOqveSDuLSqHNzNp27YJaAjjsSPmRX
         8RWLR6luUO7Syo83XiG7bod3j7hWBUNBn0Nnl4dadxfbOkGVplKANspqHSL9mlFr4u
         IqFTKA0BPxbTTA7xNbd/ob22WPwyaYeIAL3Gm/mNieYrdl9xnETSSQ22dNuY9mYxlu
         5FKWQdClHRPpEVC0sXZHdU85Z4EtrRikJ1JKfqd3wp9SY2My3JJy5jYvUCm40QXjdk
         4dKK3XFKv9aVw==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id z13so36005176uaa.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 23:20:48 -0700 (PDT)
X-Gm-Message-State: APjAAAUQ+sI7UL4BnTJDjxCLE1cAUbIONmg50R7wYwBYGT9Twy4MqX1Z
        FDkxqCO8BSooAg5jRd4+D8yolG/K7WPiNdmLsE4=
X-Google-Smtp-Source: APXvYqz0T5cMWkVEaqHnLfggX2YdTd0DZHi/ap8FhWcrJt/Ae6ZtKteZhrtl05GvyTKvN+HRYjapTVTm81BEP/f2Mso=
X-Received: by 2002:ab0:234e:: with SMTP id h14mr8149570uao.25.1565245247326;
 Wed, 07 Aug 2019 23:20:47 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 8 Aug 2019 15:20:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNARd_RVY9K6ZG0rvamuPizj8E2hfN35UROv++KYekDUcyw@mail.gmail.com>
Message-ID: <CAK7LNARd_RVY9K6ZG0rvamuPizj8E2hfN35UROv++KYekDUcyw@mail.gmail.com>
Subject: Please revert c4b230ac34ce for today's linux-next
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

I queued the following commit in linux-kbuild/fixes,
but it turned out to produce false-positive warnings for single-targets.

commit c4b230ac34ce64bdd4006f5e0e9be880b8a4d0a5 (origin/fixes)
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue Aug 6 19:03:23 2019 +0900

    kbuild: show hint if subdir-y/m is used to visit module Makefile


If it is not too late, could you revert it for today's linux-next ?



-- 
Best Regards
Masahiro Yamada
