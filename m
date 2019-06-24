Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB75C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B29F20663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561405529;
	bh=n2b+nuA+X2CY6MpU/dv+MIG99d47st+jgZCetTZsj8o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JSKf+xqrmaHa6GsS5qfuwmtxsYCquuqwEpo8lIzFNcJ/CLIHKC6I6UBX2675xD/Tx
	 5x22qUiGZSf7+z+VhaMYpw/yVoploMBBn5uzyyNVWDtSiQGNEtzlVrOx3A8MaFt5rr
	 ZRiqLQUeUJYtUca1efuu4ApvOj5ORlkpb5JNTVbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfFXTp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:45:27 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:39878 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfFXTp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:45:27 -0400
Received: by mail-lj1-f176.google.com with SMTP id v18so13786647ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOESn/qQaoyqyNDPIMYen/vQAdPBp5pl7Zqakdc+XiE=;
        b=bv6b0nQaSxv3RfGAtQsqlRoLkYuhh502/N0q7/XsVfyh9bA4BkYMrYmVw4sqKkctNv
         WRTHWYeEVs4xTZttAh3BmYyMLufXRz6dzZQ7rvnem1ZFD2A2qRCFkiUvIhJ0ZSdCdhXx
         i9YbKcQir1cwRedTfA14rtx6yM9WIGsyC0tPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOESn/qQaoyqyNDPIMYen/vQAdPBp5pl7Zqakdc+XiE=;
        b=joGuamapWAPjb63nFcoGHRQNMaBBGjEhgG7irEW+Jhd81SKCwFqx+9Hw6IuXNtCPLh
         wfIwIbeMoFrK69P/CwHO44vGQw345kpLWFicBHkVXK0ssWhqf26gBnyUVttBfCgm5vcE
         6kRWSlo/3lNbUHLbAoGYI2rpya/Qq5M/mJRK9q+371Kbtfdar0q9pxfCEr4Wc3VjFYPX
         /DRB6tcdDbcOr1c5LXvifF+FHexk8Ok+YqmyuDNDqlUZvbE1UtLWCI+STRmhTdmkTKdW
         VD1iUCG7DNeMZeJJXCz8fPJYsqOVDfpuzsGmux0Kn50LhLIl3Vc6TmVNyZru80F/YmvD
         15vg==
X-Gm-Message-State: APjAAAWjaevaDgOupfebh5Cfx53dLUnWiiBO/401VAtHY91ZHmm8s1CN
        zK6oNiB2ryWaOIvKwPoFvE+S403XrDQ=
X-Google-Smtp-Source: APXvYqzZyQOdPOqVO+WlwaOmqvPwRd+6wK+DiAkAXYdXyHlAoW6xYi4Ft6Xyj0aCCxhh/pKhdFmhkA==
X-Received: by 2002:a2e:6348:: with SMTP id x69mr72733684ljb.186.1561405524640;
        Mon, 24 Jun 2019 12:45:24 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id l25sm1669917lfk.57.2019.06.24.12.45.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 12:45:23 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id v24so13764069ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:45:23 -0700 (PDT)
X-Received: by 2002:a2e:95d5:: with SMTP id y21mr64383920ljh.84.1561405523515;
 Mon, 24 Jun 2019 12:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190617100054.GE16364@dell> <20190624143411.GI4699@dell>
In-Reply-To: <20190624143411.GI4699@dell>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Jun 2019 03:45:07 +0800
X-Gmail-Original-Message-ID: <CAHk-=wjFZr5xfa-8t=5nhcMDzXQeu4wBggJ1htc7Z5T84dQkXA@mail.gmail.com>
Message-ID: <CAHk-=wjFZr5xfa-8t=5nhcMDzXQeu4wBggJ1htc7Z5T84dQkXA@mail.gmail.com>
Subject: Re: [GIT PULL v2] MFD fixes for v5.2
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:34 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Hopefully this is more to your liking.

I would actually have preferred you to throw the old buggy "fix" away,
and just do the final state.

But the end result looks sane, so I pulled it.

           Linus
