Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4D1C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89C0217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCS8BLMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfDJIP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:15:57 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:36447 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbfDJIP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:15:56 -0400
Received: by mail-vk1-f194.google.com with SMTP id w140so368754vkd.3;
        Wed, 10 Apr 2019 01:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3KIbH7PQ/+EhCRd6dFZrUyEEKxdSCK+Tg4Azj5CZNfg=;
        b=KCS8BLMpQF7FI4UPjcgFc26LkSmUfBe3VGzCMx3ZQXdHUNJTkx5tli9AZ8r7Iv8FUv
         4UzY02RzFxJ996bZvBXBO0iy7goFr+cdhnCgxqgnVQgCu/SqOuySG5IDq7kStWJBTg+R
         iswlqAN9kH/D9/3rCVEHBTUA9eS1lOaZcrV5RUH+OeHtcsoFhSm9MRC43TfAkYKnQ76b
         XO7JK06H0lIwPGGFT0CfrvLbARQgfKH4iHbxJ7TvEo/ySpSrHMpmNYbvfCeQ9VWhkpqt
         xz/MCGxJmCm+tl4C2hM4n/O+Z0VeMYwzr1p7HlyMWvfhhjROcT0YPt6BVBTC4hmkJmS9
         PhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3KIbH7PQ/+EhCRd6dFZrUyEEKxdSCK+Tg4Azj5CZNfg=;
        b=Jn91fWq2Ap1eTwZR55ORiMivXL6ngW+JCBvm5Gg7XYnz8MdtLZmviF5IT5omjMkfn0
         SCg9I3oUOIl/B1qgcBD4UGesGtTJXx7x9A/vM1gW/0Xhdycw2LQCwfczoCGb7ZhNOGNT
         lyer7pbCTz1qLoVSaQLSoa7y9BpcXZiC5NSF+G6ohir4QAoiwXqD+G5LFCpnmXkDAkIL
         QNgXi78TEJEhddIMHMbxgRMiajYGVzkmYH1XP6Upa6cseEecJNsiD3T9fGb8tGlg1fkH
         Nm0uIKEzJxX8bNRinp1N9ClmlajG4oiGpsfdgcnUu0RYhuuqRVlltNbaRMTfB9xGXNN2
         D/5w==
X-Gm-Message-State: APjAAAW65jgMeY5IEnI3HdFKZHpRiW1FLVlS4Hso9FCtxC7fSSqvDhGR
        L8Jd3ngNpbLyPtjhlLqScUIfQkBGnqWoF1rKMYE=
X-Google-Smtp-Source: APXvYqyBHoxiCrzs1mlaGt3/GNDWKnHf84FEFVec4EGaNAnYFcuvsLX4ZHWlsAZtobHmu4C1atdtwsQgbgm5vIDsB6Y=
X-Received: by 2002:a1f:1185:: with SMTP id 127mr13785077vkr.6.1554884155575;
 Wed, 10 Apr 2019 01:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <20190213091936.GA22829@shao2-debian> <CAHk-=wiF2qv4TdKOTaTYeMnmsn4h6z9ot+MRj1=s7dm5y1FUwQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiF2qv4TdKOTaTYeMnmsn4h6z9ot+MRj1=s7dm5y1FUwQ@mail.gmail.com>
From:   huang ying <huang.ying.caritas@gmail.com>
Date:   Wed, 10 Apr 2019 16:15:44 +0800
Message-ID: <CAC=cRTM5=e7rJX80m0vL10aQoLawK_VTnQubH8A7_sUO2VUCNA@mail.gmail.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
To:     Waiman Long <longman@redhat.com>
Cc:     Chen Rong <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "IngoMolnar@shao2-debian" <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Waiman,

What's the status of this patchset?  And its merging plan?

Best Regards,
Huang, Ying
