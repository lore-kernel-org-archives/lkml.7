Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA20C2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF2D20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577937647;
	bh=e3m+O59irVmfcoExyBR7e/0eB3QoNyM4MTy85+P5f5E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dAYbYtJIVXpK7XPXjf/bLpdOSSY0jsrlOYAi348E+kExqizgxWtp1DtDRyFbpXB4O
	 sZ+zksVDaOp8jf3lJauGN+HViC5ycxWw9gow0PDpnUB8DljpeQHjp52zNJajgmzL4v
	 /25idrsHStW2pf4t8lacMcfCsQ6smnrNB2HtCRFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgABEAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:00:45 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43075 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgABEAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:00:45 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so39488746ljm.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 20:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S0197JAbT3609qdeVOguHyX5qih6T1NylQSSosDQ49o=;
        b=U5QcOJGBBtGJn20Hvc5D/3jAi4yaL2Wt9kmOrQdfF0KaToXExpu1YvsAy4lQ1sDHWj
         9eGb3cd+31Tfllf6QKNoyZChIdLjREGxv8A9kazouHODIGgssfrKLUVBXcSMJTTw+SPn
         mNvePXeK752DQTpq9yLGcNaFfqIOLYgoO2ZuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S0197JAbT3609qdeVOguHyX5qih6T1NylQSSosDQ49o=;
        b=KjwERZscxg8XGfG0zlJYJiCQDh/wZyt1QUxb16phNm7EoMy0+2fLO93JcUBGeQngD7
         tza1iXPYJryRHRpZdZ7/v2XLNQmzrsmX7VmpioJGIfiJiRgpIGcRT3SiStABnjRkSyQo
         bzSqgTzgSmg0IN69l7AfINsEUoq3JA3vw8okTjB1NcloQv2L+iHb7U7r1bZMLCbUXTju
         GEVt9AqAke+ak3f4exvAHmoO02xuqPELXyIgBCgf8IPns7mtuRIN4Gq/aFxO6OR6I+CA
         8F+TQdS5yH0ZkNrDb738mM+vosytvbK0+D7EfI/hm/jXCCOzGWUurIPNJXaapPGrk+xY
         OAgg==
X-Gm-Message-State: APjAAAXG1b13vKrwS+u8qtBsyZSh20pqoNHcg8Rlks8+GMeU2UiRyqO7
        xHzv95lfbQPMpCViv6D2Ve2Akob7j/0=
X-Google-Smtp-Source: APXvYqzyV93CCYHzXY2oBiQo8oBeEaYbnY3BbKOQK0T0deNdr32lhmJakHxQ/wktxi3vH3fBjt2o4A==
X-Received: by 2002:a2e:9015:: with SMTP id h21mr29687066ljg.69.1577937642752;
        Wed, 01 Jan 2020 20:00:42 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id s18sm26050513ljj.36.2020.01.01.20.00.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jan 2020 20:00:41 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id l2so39490792lja.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 20:00:41 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr48000575ljn.48.1577937641472;
 Wed, 01 Jan 2020 20:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20191231150226.GA523748@light.dominikbrodowski.net>
 <20200101003017.GA116793@rani.riverdale.lan> <20200101183243.GB183871@rani.riverdale.lan>
 <CAHk-=whzgLPi4szh8xOKysuS9CKaQESngc=n0omBVpwdQ822aw@mail.gmail.com> <CAOzgRdYqqYNU8jyXCu88RLstWhQUANUroQDz71fEjfDoEg-VqQ@mail.gmail.com>
In-Reply-To: <CAOzgRdYqqYNU8jyXCu88RLstWhQUANUroQDz71fEjfDoEg-VqQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jan 2020 20:00:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj4CBDJ=VvUkQBcYC1XwyG6bDpWXg+iv6NyEE1eV+SKKA@mail.gmail.com>
Message-ID: <CAHk-=wj4CBDJ=VvUkQBcYC1XwyG6bDpWXg+iv6NyEE1eV+SKKA@mail.gmail.com>
Subject: Re: [PATCH] early init: open /dev/console with O_LARGEFILE
To:     youling 257 <youling257@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 1, 2020 at 7:09 PM youling 257 <youling257@gmail.com> wrote:
>
> test this patch.diff, no the system/bin/sh warning, fixed.

Good to finally have figured out the silly reason this broke.

I may end up deciding just to revert after all, but even if I do that,
I'll just feel a lot better about knowing _why_ things broke.

Thanks a lot for all the testing you did,

                   Linus
