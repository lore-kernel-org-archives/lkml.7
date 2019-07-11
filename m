Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A40C74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 05:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6733208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 05:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562822687;
	bh=iYMcVpQ5clOcfTfPZvn8pgaLNC4FxrNjOwB8wzJjHpw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gaNimJmI2Oa4Rr8mMrGfrPfsf5KpMpaBtDYp4s4IUVbW+8Leay8Qm7F39TU4ftFIe
	 eh4CsXStiIhWb2MuZDbbMoLyiwW5/P49jYLwqwEwMOKX1naYgGxhXXM3nnbVN64wtg
	 EDVNFgkZp5kMLzHWPcTJ8uz/wyj9HQqwe3MHEpvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfGKFYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 01:24:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45305 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfGKFYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 01:24:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so4367019lje.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 22:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w2QefrsAjIehGtDojO7YZaq80yDR8F0qCpFLc2+qa/0=;
        b=H7VoW1U4KMDnSQnEks1lB1DXI/XutCdpSAI2x/EgYxR2MJk992T56S9+CXihWWwWVi
         TgbEhtMy9NDRdx9/joyGodU/U8RbuWkLZ3SyK50GAgnauL2nI982f3JWYcBd+HTapx5s
         monewQA3W2G1+RiPyY4Ljlmffi+ZPlRdhn68s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w2QefrsAjIehGtDojO7YZaq80yDR8F0qCpFLc2+qa/0=;
        b=R98WBi1NjCKuS86o5fJFVaof7OayfDS+7khQZI5fwLW/OrCaUjLfI7+chAfsRFry4V
         zumBkblqEvKtz6DEb28y+RrJQHtZvKg5L3xr72fGZH4knfUdTq9sNAyrrotfSt8rxigX
         /FpHIT+wNI8YPfqD3p0wZR7VtzCDq0hISe2Uak2CMCLAuX7kkgkj8Vql0Nza5WKzGuov
         A9SQ1Ohyz5K5Y9tnGUj1QvU5gyziPqJfjXf8vNoL6yF/zTfi22mfHhZTaBq3kb1TDspR
         r2AF7F/Z0qDQifNnjrUONP9lpcUk34q33RC27RwXwdGT7SfBCAnvKxBC81w3JswukXB5
         DBbg==
X-Gm-Message-State: APjAAAV+iwHoSGYJKaN9Los12LcpsfDwvogHzC7wC5HmnGSlyWMxmx8/
        NJisY2/Z9uzv8bilTfoM0bh3bFtdGOk=
X-Google-Smtp-Source: APXvYqyiIYdACr4N2vVo9FuQEFlu/c/Sg0kyUY54s0qb6OSD8GhLMu9G8H/b3pYKF0NCbdO0JSarGA==
X-Received: by 2002:a2e:89c8:: with SMTP id c8mr1187922ljk.70.1562822683731;
        Wed, 10 Jul 2019 22:24:43 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id m17sm672220lfb.9.2019.07.10.22.24.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 22:24:42 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id s19so3129266lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 22:24:42 -0700 (PDT)
X-Received: by 2002:ac2:44c5:: with SMTP id d5mr749470lfm.134.1562822681814;
 Wed, 10 Jul 2019 22:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190708150042.11590-1-christian@brauner.io>
In-Reply-To: <20190708150042.11590-1-christian@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Jul 2019 22:24:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0jcyTO+iXgP-CpNwvJ4mTCcg3ts8dLj3R5nbbonkpyQ@mail.gmail.com>
Message-ID: <CAHk-=wg0jcyTO+iXgP-CpNwvJ4mTCcg3ts8dLj3R5nbbonkpyQ@mail.gmail.com>
Subject: Re: [GIT PULL] clone3 for v5.3
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 8:05 AM Christian Brauner <christian@brauner.io> wrote:
>
> /* Syscall number 435 */
> clone3() uses syscall number 435 and is coordinated with pidfd_open() which
> uses syscall number 434. I'm not aware of any other syscall targeted for
> 5.3 that has chosen the same number.

You say that, and 434/435 would make sense, but that's not what the
code I see in the pull request actually does.

It seems to use syscall 436.

I think it's because openat2() is looking to use 435, but I'm a bit
nervous about the conflict between the code and your commentary..

              Linus
