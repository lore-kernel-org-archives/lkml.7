Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0E8C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2F021B26
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v66nxs5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfDPN4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:56:12 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:35132 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfDPN4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:56:12 -0400
Received: by mail-vs1-f54.google.com with SMTP id d8so11587129vsp.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hl1SR1d+fQ0s8rpI/iVMF3m6ctga84zjhEJtjFfUIhg=;
        b=v66nxs5Jc88EyVLHuO7UoXfOAFHKHN8S8Au7epwUOoL6pE/GQPqRtSXYxeO5/mn/+k
         0FgZkJusjtO5ZfPP1fNtoxCpqPy+/nEI+FMi8KbeTXDtv/uGzV1KONflPWlsJMgHq6Gx
         PBxhK6lM0xCjTYhr/CcApRNhClj9vstEkJQmTbdGjnycCSoZgW0frJaiIGAcHndg+MJF
         E8JPdvs+XU7eL4EawO3LvR2NPwqG/M99ujNRqn4RqvFdTuCDV69NU/vBbm06afvz7j1t
         r76fvKxDUJJvBJGtx4Mmziq+H7SOdMYGsY/vNJL6QDp3Cqmu2/1wcd89JT199e+hFmb/
         5Jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hl1SR1d+fQ0s8rpI/iVMF3m6ctga84zjhEJtjFfUIhg=;
        b=dp2Uk+6xxc6YKASLD0Z1SgByGpe3zs4daTzg6VyqVkJW1k1Wc5caETg+7t/p97aiXS
         VxVceuDUctIzldm6lwetM29xEZzYzBE/Fa1sf9V3JYnkzNsUyUTXrfKwA8kr/H2jzciB
         17AkGm2S4R4kPxdG0feXNy4l5zKgJJqaNcd3H4Vw2YuGVWzrD2Xg9oqG+vHIV+MCoQwR
         rr5217qzBRTeVYdD277y8pcBmiz+2rUusG4rYgpRfRoAvhyvxitM2IcllxW9oQ/pwXPv
         jsfoinoBAfhbsgn8ALba8cb60oxMy7JSs0P0dCKGoh8j0RQYY4ZNSY8lVRxb0Zal47Ck
         y7pw==
X-Gm-Message-State: APjAAAXCpMu99Zo4I0rHStrbM36dzFNoxMoAgIsBJap6c4iTFJ86m+2T
        WZokIk7CkAPG1mtLakxdHfDQaGfjx3ScNIIPDGKBaWs6
X-Google-Smtp-Source: APXvYqzvVRK2xLKEL2erpwTiXsTcbYgj1LVZTDlnNa8g7z5OrmEZWl54Jjf6Rr8E06SuMMeeE46mzo7NjGs+qo7Lu8A=
X-Received: by 2002:a67:7e12:: with SMTP id z18mr21457705vsc.82.1555422970881;
 Tue, 16 Apr 2019 06:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAGXu5jL6LVU7KyUvwaEHWE6t2TaVBs5TWNayB5cW2=PWzSMyEw@mail.gmail.com>
In-Reply-To: <CAGXu5jL6LVU7KyUvwaEHWE6t2TaVBs5TWNayB5cW2=PWzSMyEw@mail.gmail.com>
From:   Kees Cook <keescook@google.com>
Date:   Tue, 16 Apr 2019 08:55:59 -0500
Message-ID: <CAGXu5j+Ny=1YF0BkATbU3Xb-fb=_0a1W-iZ3jYFhTcWrTPqCJQ@mail.gmail.com>
Subject: Re: BPF RNG
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Hannes Frederic Sowa <hannes@stressinduktion.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[correcting Alexei's email address and resending...]

On Tue, Apr 16, 2019 at 8:54 AM Kees Cook <keescook@google.com> wrote:
>
> Hi,
>
> In looking at prandom_u32() users, I noticed that BPF uses its own
> state variable with bpf_user_rnd_u32(). It appears that this state is
> never reseeded like regular prandom_u32(). (See __prandom_timer().) Is
> this intentional, or should reseeding be happening?
>
> -Kees
>
> --
> Kees Cook



-- 
Kees Cook
