Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FC3C76191
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 02:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714E92080A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 02:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Y7yTdqSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbfGPC5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 22:57:12 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45258 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730712AbfGPC5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 22:57:11 -0400
Received: by mail-qk1-f194.google.com with SMTP id s22so13370578qkj.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 19:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63o0ErhP//1BFgLuSNxAKDeebTl8IjDLr5/KnLD3GRQ=;
        b=Y7yTdqSRC1ytCTZm2vH4l0zj0OosyMtjRA8K/FoK3g2ilmEzaZVA53WE7EJjn6PsFL
         tm6uivbAkhtZGs0NU91PEJDGqq6phIir5dXJeq5fjboNRFlaxOd4BHVzTgwLrYuEu9rG
         4rYcnPGSCBFJ9uIggkT/qcXOcYwcQtEMTgFP5dAV5xwrDrSdBB46fQZFHSTOweJNGyvo
         6+Mr0XbPqgYAez3fOoWArD9xYxgNK/ximcmVGb+VCG1ApsTQNGwbG6S3YOSm55EqTc9+
         ynz4ffVv1rizevksn1koo1Coj9pmbcWO+uZzmKob9LokFyBp1rF0V1qZBQVSo22qFZU6
         YEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63o0ErhP//1BFgLuSNxAKDeebTl8IjDLr5/KnLD3GRQ=;
        b=rwNx/QgnXnO+oj/YHxLm9wVOdBYieN+RUjQNwQuV49u/wqQvBNmbuu/A26ErPdSx3l
         cvkEK73m4dNKMv6odyG2m7kUHn6VfyAMT7/nzo4XwJ+W0uud1wWuQwp+1dcrPYfUW0TD
         nDt64ncTxH1rU7NM6nqjSGkU5gohcBcik1bfjpmBv4PF+sD190so5O0KbzKoEd+NPIuX
         YVSyp6pYQ4Uzxp89aLVzvN+iC8or8i2JF3nth4PlRHp0zuiKG7F7rzX9YaaBAPI1WlO7
         JSaiviNAPCJMV7W0P4BASjrn+MS7jqbHN6VslXamxVisRNSIpM4gRnj/N6Iaust0FQeZ
         lYBQ==
X-Gm-Message-State: APjAAAWQQjBFdB544XSuM/rxirJrSPocyciH0vNpJPcIMwBwqhVxx/Jo
        vnpwhmf+3hNw93uieowoFFA0TK0QCy06a28MuBpSUQ==
X-Google-Smtp-Source: APXvYqxV/W+WUnDi/vtmk5o0fUc07VThwPkzPIWiDoyenDY2Lv+seJF5RcFs2kgbF+LDe5z9/5p5MufNf9s+TApBVOY=
X-Received: by 2002:a05:620a:10b2:: with SMTP id h18mr19360197qkk.14.1563245830757;
 Mon, 15 Jul 2019 19:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190715133811.2441-1-sashal@kernel.org> <20190715133811.2441-13-sashal@kernel.org>
In-Reply-To: <20190715133811.2441-13-sashal@kernel.org>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 16 Jul 2019 10:56:59 +0800
Message-ID: <CAD8Lp47XuF26FP0XEPz6KFMg=UGDvZx5bejjF6NZ2qSRdZSR_w@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.1 013/219] x86/tsc: Use CPUID.0x16 to calculate
 missing crystal frequency
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 15, 2019 at 9:38 PM Sasha Levin <sashal@kernel.org> wrote:
> From: Daniel Drake <drake@endlessm.com>
>
> [ Upstream commit 604dc9170f2435d27da5039a3efd757dceadc684 ]

In my opinion this is not stable kernel material.

It alone does not solve a particular bug. It's part of a larger effort
to decrease usage of the 8254 PIT on modern platforms, which solves a
real problem (see "x86: skip PIT initialization on modern chipsets"),
but I'd conservatively recommend just leaving these patches out of the
stable tree. The problem has existed for a while without a
particularly wide impact, and there is a somewhat documented
workaround of changing BIOS settings.

Daniel
