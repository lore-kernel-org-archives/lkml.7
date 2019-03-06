Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DB4C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEF320854
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551896142;
	bh=5RKV9xCxxOj3NLftF6Ews9/GEEjdh4eSI4JWp5DC7bA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qRJkvponOqsakvFjrN3C3Nt/KnqTqZj+eC9WrRCFqB2GkZ8x/Cp7cy0qqxIgG4iL3
	 yM1S/8VvUxCu15J2OCeSkfGELtYbe4mhyyuv/R8C+Enwa+8X0ZoF5KUr44vE2JXMic
	 qQ6Lk4CC9tBmNFbE2KoC5yzmptfANgeFevfZwB5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbfCFSPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:15:39 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46357 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbfCFSPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:15:37 -0500
Received: by mail-lj1-f193.google.com with SMTP id v16so11733725ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 10:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goaJSAAjdS8o/vR/VlEGijb2bevPyqkblXj27hvZmw4=;
        b=V2b7LjsUeH7ZxT1Ls1HXkkMl03dZwKfEC00OjLASbtH8KlUBFyd9GEDRwAOPthl0cF
         jNXXjL4n1qiNPhFmH63FGTKmF8DxtcdBMo4nBAD4bqKC+Niro9hNuNZOmdje4lTG7Ato
         W62BDUJ1cWr+R0Pk/LAponrU7i7+OjM2aLRXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goaJSAAjdS8o/vR/VlEGijb2bevPyqkblXj27hvZmw4=;
        b=mCGxzQ7fUDmFwbgPYL2drZTaHMT8BHpVGkze6Gxcneh0OLPO41iVGFX62eakpa01Y3
         I6lt1nztRE0XRRcyEBwiijvjpTbNJfBGmgXiryRMXwZ025hoT5cx6ZnH610GVzxspoeb
         S2LI8cedsivYOOP4itpzX8MA/uuH5wSAgZ2bQarcyBq0jo4Y7MCeTb0hjw1sN6pqcuqt
         +Tv/3sc8c5Uj4+aYhZ2rz950s2dZrqmB/ibHrKsgqm7zGsfvVGA0Ii1wkhl5FHvmo6Vp
         mfBLGy451hYrEyQ17BNVcfKEfL3iMX+W38lnRi9LFH+uFhkwRlERKv28OBk+PZWnLvjP
         KrCg==
X-Gm-Message-State: APjAAAWalqta2qQaRT4tzy5jIUQY3RfNCIZiD8q79C2TgfXUw3+8WVN0
        IztgHMV/SuPlGEqHeZTsVss6ecueI+o=
X-Google-Smtp-Source: APXvYqwzbPcKAOGt3nvFrdGNLffjLBHR2h3xuqLhGnH+q73gWZK2VKF4HFTsjtGShPygA5IUb/ZixQ==
X-Received: by 2002:a2e:6309:: with SMTP id x9mr3150448ljb.75.1551896134690;
        Wed, 06 Mar 2019 10:15:34 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id q12sm432110lfc.8.2019.03.06.10.15.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 10:15:33 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id g12so9624449lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 10:15:33 -0800 (PST)
X-Received: by 2002:ac2:424c:: with SMTP id m12mr4953679lfl.62.1551896133156;
 Wed, 06 Mar 2019 10:15:33 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
 <CAK8P3a1k3y0ZHLxGNBoynF+tpej9PVQUT7PgP1RLCuXWonKmHg@mail.gmail.com>
In-Reply-To: <CAK8P3a1k3y0ZHLxGNBoynF+tpej9PVQUT7PgP1RLCuXWonKmHg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Mar 2019 10:15:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgzU7hcH+6oabXn-WDtCxvJhmG1Wopx0KLFo-o8ySPbHw@mail.gmail.com>
Message-ID: <CAHk-=wgzU7hcH+6oabXn-WDtCxvJhmG1Wopx0KLFo-o8ySPbHw@mail.gmail.com>
Subject: Re: [GIT PULL 4/6] ARM: SoC defconfig updates for 5.1
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another small side note on these pull requests:

On Wed, Mar 6, 2019 at 7:35 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
>  arch/arm/configs/lpc32xx_defconfig    | 65
> +++++++++++++++++++++++++++++++----------------------------------

You have a lot of these kinds of line-wrapped diffstat lines.

The reason is *probably* that you've just cut-and-pasted from your
(very wide) terminal where you ran your scripts into the email.

Becaue if you run "git diff --stat" normally in a germinal, it will
take the terminal width into account.

If you run it in a script to a file or pipe, it will default width of
80 columns.

You could make your scripts just do "--stat=80" to do that, but you
might also consider using "xsel" to avoid the cutting-and-selecting
part, and just do

    my-release-script | xsel

to select the output of the script, and then paste it with your mouse...

This is not a big deal, but it does make those diffstats ugly, and I
_suspect_ it's because you didn't realize what is going on.

             Linus
