Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD1DC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214A72173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563380030;
	bh=/zbHdhQP1KVCMv42GvX8S9P+u5Mf58/S9qfhRKVUBs0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LbdYlMCLiTtp1oTB/BI4idvXiZ4yZS1Se2vphNn09o6Kno4+YCuyvoEDQTzGYbuyj
	 eYzzoo3Un4lPNj/+6E2vRdAAIK+S6xs5uQJWrDQD8fWvjKpu5mgTp/qBh8f7UhBiAv
	 +atrGnb7k3PpvuBIY+7q35ZchKz0hMOgeHqYCiuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfGQQNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 12:13:49 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:35322 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfGQQNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:13:48 -0400
Received: by mail-lf1-f41.google.com with SMTP id p197so16921022lfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMkHfaU67BchYChypR6OGoPRtecIrRaXkSjINopMJ7E=;
        b=OLl9lkjdcYSnuxCTAJOQsNMwFOpw8ryeimFhE1ANkVONZVt21tze74/Y5gnh0UZvqA
         dhREWrcTisRLQxADCiSzp92AqaDsndFz3EbTrI3SrJSW2GB+VRBEXQJckND8M1PEm/wd
         WW+T2kuE/xXCQFTAUkUGPcsGrhkWVUdw2wFp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMkHfaU67BchYChypR6OGoPRtecIrRaXkSjINopMJ7E=;
        b=P4UgSkDIyqsoStrE2pK6nziqZRxro5zXitQ9hlZmIQUFme5VSIvs/h4qHApFa2ekD2
         1sz26qsfN2FYR8DkGfN8Y+52C9RkLdSuIPXyo9iG5oiZofzqVhzilkDSmrn+3tPjmj08
         j8+hpAPGHOomIXvlv4nqp2NQu4MDApJIPTMlHfi/6Ig6HYlj6okJVhN7X5fptl1JwRbu
         vxkBGGWitFxhK66bFpg2GuFci0plCyEeAkk4+KYp0pzjdeXcTiZcRtUnAm6oY1ai9vUP
         Zjzo6i1mxJlH4kBAAKnVwZkkoH3XxyvAQp3txGySlGmZgT9TEpQXwv/WmE0dddQ4CPBB
         PCYw==
X-Gm-Message-State: APjAAAUpLoqDNMWD6ZT357/4UircLu5iF60BLTq/dTqPyK5Xwv7H2Vwq
        CwQMiAaiHCIuAR/VNqOxVvzfj2likas=
X-Google-Smtp-Source: APXvYqzIiqQETOrYYLmRgoIigBDd3zfXz20KnW7jvvWnCHiKppDH/wAzTy4IXsFNwxkPTbBkrAsfWQ==
X-Received: by 2002:ac2:5337:: with SMTP id f23mr18746467lfh.15.1563380026241;
        Wed, 17 Jul 2019 09:13:46 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id q4sm5074130lje.99.2019.07.17.09.13.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 09:13:45 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id c19so16924324lfm.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 09:13:45 -0700 (PDT)
X-Received: by 2002:ac2:4565:: with SMTP id k5mr18364164lfm.170.1563380024874;
 Wed, 17 Jul 2019 09:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190716162536.bb52b8f34a8ecf5331a86a42@linux-foundation.org> <8056ff9c-1ff2-6b6d-67c0-f62e66064428@suse.cz>
In-Reply-To: <8056ff9c-1ff2-6b6d-67c0-f62e66064428@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Jul 2019 09:13:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1VK0sCzCf_=KXWufTF1PPLX-kfSbNN0pk+QHzw7=ajw@mail.gmail.com>
Message-ID: <CAHk-=wg1VK0sCzCf_=KXWufTF1PPLX-kfSbNN0pk+QHzw7=ajw@mail.gmail.com>
Subject: Re: incoming
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 1:47 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> So I've tried now to provide an example what I had in mind, below.

I'll take it as a trial. I added one-line notes about coda and the
PTRACE_GET_SYSCALL_INFO interface too.

I do hope that eventually I'll just get pull requests, and they'll
have more of a "theme" than this all (*)

           Linus

(*) Although in many ways, the theme for Andrew is "falls through the
cracks otherwise" so I'm not really complaining. This has been working
for years and years.
