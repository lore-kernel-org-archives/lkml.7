Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8ABC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6148920661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552009347;
	bh=15GmStecjlXs99zA2qZiq5OPra7vpWSydy9c6sluy9w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XrBtr8+gq79Ej6XoYnsLojYsStS2Luk7RiZA6zH2gAmSzeLT+qptAPQyeQLcPaZAl
	 OmC+JhTNy2HCRhbG9zmdlYCHHw9CUEQcAD+3X5btexVNKMLwWF+8yx+d+pwCoEosEL
	 CkdG3maXESU0GIB42FUNWWp+qllny4wgaBNfMe54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfCHBmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 20:42:25 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37949 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCHBmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 20:42:25 -0500
Received: by mail-lf1-f68.google.com with SMTP id k136so2871274lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 17:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GfR5X7FdiIg2pKHW+h2JsDBVwCHpABIOsZaDtWAy34k=;
        b=FoMZlGWGtZTx/wNSCT/UMTKBQZZ1BqzbHeEeLFAK7yuV2w6rNeHcK4ItsAxSmAomFx
         cPdLAZreRaJrFF9t/oNexOQcekqly+edIklx/ZXTEMzVr/kIqtrtYzf+d3MjEYeZ3Xnl
         xBH8uP/H/63Nlp6pXgdpU8AV0Ma7U8SZ/nHyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfR5X7FdiIg2pKHW+h2JsDBVwCHpABIOsZaDtWAy34k=;
        b=S2DUGWluuGZjWExV8ugCZ/W4LUxbD4m/fpgCf5q8tPcK8+wZInXk7G1R1yqWg1P6dC
         uDjna9sBv3dNN9MSCiXYPc/rqaAqLRb0SDPGidRUsH9+PVkeowW80Z4z1HxWPYjmvXND
         bfWQZV2xAfLz7vasCtn123V5c9xQPBYQjJjQxqBZxk2Wp0KXrBO3T1PszZ3pc6jjcjHU
         lTUr+pgnR09daYqcUlBPhkiHdhq1nyHZJLZjjhnC6wYONexW8T7R3BLBL+q9IUqUyLF/
         CZxNXo3tG28LjQhUWED3HGFqodnIYafp7p8ppQ7Ovq5wcf1PYzvaOqsZPIX+378BZuIb
         8G4w==
X-Gm-Message-State: APjAAAWuBXdTVqI7yOtJ2nF34RGkwNVwtTY7jRLeuj4YwVLxGn0itb7Q
        Y/CgsqmVOPr1VL2wlvDKSIZyiikLRQM=
X-Google-Smtp-Source: APXvYqx/xzBxHNqNXNit4sTy8nDO+wWXveleN5AEA7SPd15qvbwfGh8LgBsvPmyzzYV4rdWYo9g0vg==
X-Received: by 2002:a19:520e:: with SMTP id m14mr8650148lfb.64.1552009343140;
        Thu, 07 Mar 2019 17:42:23 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id u29sm1099735ljd.84.2019.03.07.17.42.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 17:42:22 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id d14so16049928ljl.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 17:42:21 -0800 (PST)
X-Received: by 2002:a2e:8585:: with SMTP id b5mr7446559lji.125.1552009341516;
 Thu, 07 Mar 2019 17:42:21 -0800 (PST)
MIME-Version: 1.0
References: <20190307192305.GA33711@gmail.com>
In-Reply-To: <20190307192305.GA33711@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Mar 2019 17:42:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wih-jHhN6LHb_EyBEw-iP8kXpDYd56jKLKzOa0u8fOiww@mail.gmail.com>
Message-ID: <CAHk-=wih-jHhN6LHb_EyBEw-iP8kXpDYd56jKLKzOa0u8fOiww@mail.gmail.com>
Subject: Re: [GIT PULL] x86/kdump changes for v5.1
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 11:23 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> Please pull the latest x86-kdump-for-linus git tree from:

Hmm. No diffstat?

The branch is simple enough that I'll pull anyway, but I would have
wanted to see that up front..

              Linus
