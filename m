Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5B7C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BC4208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567629827;
	bh=cAe9qQtFNQXsaMDJ3A4Gp8qfwwwxMgYDPrpFGlz3tkY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KA2OBh7rb8gnSR1foezvoXfsC82oy/LpvVpgXzhVgUoXxQd1VZ5lcfbd/NyaKLhft
	 IZKX5HN71yr6FohN9e0Ml/lorg35l8/gn9xjmDk8D1Gz9KWkXts36iX6WbS0E925L8
	 C9ZqPdf/31B6SOrrvKgqZm7hQE9H0EOL9xrubJn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbfIDUnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 16:43:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44724 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfIDUnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:43:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id y4so77564lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 13:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YiYO9VWWpRx7v6PM8o2EGGH10D6630klg63G2tZstsw=;
        b=CDKSoL3y0gWDvz+9iXrm8ACq+PKIk4ww39yv5fj7+QG8AIlQEFQdFDHCMmlHDeSux1
         WIGXEeanbtpped938Baz6GkN4m/db3Ltfk6ySLhsaFUavZIkhyTfz5limM1z/Fx5YSyN
         jQ4gK+rRnsHjNSTKgxuK6NxXCkcBIYr8FcoUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YiYO9VWWpRx7v6PM8o2EGGH10D6630klg63G2tZstsw=;
        b=IC0clGg2MI6v9K4UuEvuVfUjFvrJyuMNm8l3nNo+x50kRCOkkcIKqHifVOkOF67jay
         VHVTvDi7Qk4ZfOfgqhUDoTZDAREpDDBSWkfH1LLz0tGFn2gRI7CqJqBqHOknDAGevzd1
         cL000YzZ7V+mYtv1dycweCNUEcdHFvosbvNguYAdNqj2GcLVwXzDrllNkcLfk6iH8csI
         XqVqRX7BULwdNSe/uk/H0JtXvVpYk2VmRiCXTB3h36gM3z2x4ZNER/Zl7262PmoIA3CI
         xDOyKeR+L9G6ugJFjg5Hz1R/qWGtZKyhxRNhuYHHCWkYwZ8p06tgSLwOua/Sp4zRDwuf
         mjiA==
X-Gm-Message-State: APjAAAXZaalbU241VVJ+9yBFNd8cem1hGD1ROKT5rWOfx+4K2dRTbVZO
        YWgCrAodFKFDybOb/2FtyUDdiPv6nCI=
X-Google-Smtp-Source: APXvYqyJDwUHa75cR41qmIj6g9CRI3nFmuWNLIjDjeqo+KRRLT5vHRvhJ2FVN14HITkxKCAYYK5s+A==
X-Received: by 2002:a19:c191:: with SMTP id r139mr42625lff.23.1567629824059;
        Wed, 04 Sep 2019 13:43:44 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id m23sm1167728lfl.62.2019.09.04.13.43.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 13:43:43 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id q27so82232lfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 13:43:42 -0700 (PDT)
X-Received: by 2002:a19:7d55:: with SMTP id y82mr55521lfc.106.1567629822677;
 Wed, 04 Sep 2019 13:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1909041252230.94813@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1909041252230.94813@chino.kir.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Sep 2019 13:43:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmF_MGe5sBDmQB1WGpr+QFWkqboHpL37JYB5WgnG8nMA@mail.gmail.com>
Message-ID: <CAHk-=wjmF_MGe5sBDmQB1WGpr+QFWkqboHpL37JYB5WgnG8nMA@mail.gmail.com>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote hugepages
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 12:54 PM David Rientjes <rientjes@google.com> wrote:
>
> This series reverts those reverts and attempts to propose a more sane
> default allocation strategy specifically for hugepages.  Andrea
> acknowledges this is likely to fix the swap storms that he originally
> reported that resulted in the patches that removed __GFP_THISNODE from
> hugepage allocations.

There's no way we can try this for 5.3 even if looks ok. This is
"let's try this during the 5.4 merge window" material, and see how it
works.

But I'd love affected people to test this all on their loads and post
numbers, so that we have actual numbers for this series when we do try
to merge it.

            Linus
