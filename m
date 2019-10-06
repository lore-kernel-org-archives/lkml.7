Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1A8C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 21:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066402080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 21:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570396521;
	bh=6DP+aECEIPfgWdS3lEboMEVPdbxhdcq06tbNqZcqeBM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IVnUetvWHap3dGr2/EbHBAzaqUluIwDr9kPK3s+3eTejWMcDfiX98KTVawyW7PzvF
	 Fr76DdAhtPT57P0N/vIN+cx5YntZNkLBUv/sGNtX28QHelrE6qNahazgxW6eHdoAzs
	 ojDxdtKqnWAuweelyNkPmQTahAOe2JpHI22bTKQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfJFVPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 17:15:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38264 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfJFVPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 17:15:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id u28so7831174lfc.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 14:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LXbxhEgAdieyKJ5fuAzsqlFn8HIyUjW9y8Ps47VX0Fg=;
        b=TjvsohBpIUlEMZohWwfuphM7aKCJuOx1Jp6+bi7TadNzoKDl4nG3om1x1SOgVLvCDl
         /FOzKmyhWUVcykBTKFtntJEAJWA5/5WMkYhygH/AumL61lb+JY7V7CSbKlzEhJJKLQ9b
         Y+G+Nn1TooEF28IjZbrGbDeedH1wub5GCL1R8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LXbxhEgAdieyKJ5fuAzsqlFn8HIyUjW9y8Ps47VX0Fg=;
        b=OK5IvyhZvjMDCg7UhIFd5gmV8fl1Vw6gFedCgAcgI9ftFU0rZWuXuCRK6Dwid60U60
         fTFE0fDFKHCjP4ZaQcp98+BNrs9juikxMvwBTlLaezW5wZysm7j1NutkB1uFiji+2U+u
         B+lTAcz8fosxM5aJwkcln5xuMm0b3cFN4p5mLMVwwy520mv271j+SV+mizdFkUjwba2n
         g1EiTOFZfuteDK/2f4Fkw/NwE1hhITYSzmwnHB83RnKhJEgkpTCaVgshtW2ofs/eWQMw
         Ybqn/66P7plc++2Pq4aU2iUPwkLb+bApU4E13+BVg/EIe63J0+o1GrxIDioCRMpbyzYf
         Nb8A==
X-Gm-Message-State: APjAAAV2hpTxmOO47W3oc2XeAqZV885s0lGRUIgyMdv0/8bzMIUnRjao
        L8ALkRh7svg9MMRjdBfG2+wOE8vk/hg=
X-Google-Smtp-Source: APXvYqyvLRe64YUO/3qKFHmjNeqGQTT1LGes3z5U5TdkCuerSW9GPWpZZOV+hRuU/xk9FwhAJHv2AA==
X-Received: by 2002:ac2:47e3:: with SMTP id b3mr14014075lfp.80.1570396517316;
        Sun, 06 Oct 2019 14:15:17 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id c6sm2336572lfh.65.2019.10.06.14.15.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 14:15:16 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id x80so7847659lff.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 14:15:15 -0700 (PDT)
X-Received: by 2002:a19:2489:: with SMTP id k131mr14363203lfk.52.1570396515673;
 Sun, 06 Oct 2019 14:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191005233227.GB25745@shell.armlinux.org.uk> <CAHk-=wiy9MWteoaoV15FJ7QJeRhBtCVgo6ECiLb4khuc5PxHUg@mail.gmail.com>
 <20191006130924.GC25745@shell.armlinux.org.uk> <CAHk-=wh6jhO1X3VZuZ28aA4m0k6wGhkHRRrJSQpQ69N901D7Mw@mail.gmail.com>
In-Reply-To: <CAHk-=wh6jhO1X3VZuZ28aA4m0k6wGhkHRRrJSQpQ69N901D7Mw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Oct 2019 14:14:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg14VfTec2AiW0iSVUzj2x2_PYffH9O5sDV5ZRagjQwRg@mail.gmail.com>
Message-ID: <CAHk-=wg14VfTec2AiW0iSVUzj2x2_PYffH9O5sDV5ZRagjQwRg@mail.gmail.com>
Subject: Re: MAP_FIXED_NOREPLACE appears to break older i386 binaries
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>, Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 6, 2019 at 11:07 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yes, we should get this fixed. But I continue to ask you to point to
> the actual binaries for testing..

Just to bring the resolution back publicly to lkml after rmk sent me
test binaries in private email, the end result is commit b212921b13bd
("elf: don't use MAP_FIXED_NOREPLACE for elf executable mappings").

             Linus
