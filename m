Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B08BC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19576206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWps4SXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbfJIQhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:37:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46123 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbfJIQhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:37:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id u22so4255753qtq.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ec6uY7QIeFnNOpPEARpChIvoJP+vgPq80NUTGh7cu3k=;
        b=EWps4SXHmX5+MfNDLcFHuM7VcPJo0XDJ3NeCDGJUWa6ELO3CVWu4a2npkzyyx9rOL7
         a52v7UCxyNSwFG8VhnGIF0EdyVH3rIKdDWlVNTDRg8HozVV+CLwpEGN3MjcukTCCqCSt
         nk1VbfcAdF32WKhqWB1+0xIvduDcXkqd9gcuXdXECYZNqTLwnliWUo+QGAAjU43+k08f
         hnC5iY0mG6LIn1dtILjVFwrHIVN068JFrF0HtUzZcj6if/UfSw7dRpYB/dR2emIkkNBI
         A79/j+yoMXDi79juOh6DO12yzBRQkoZOKBw7rC4oRUK4H/XYXiZhwDzi1U+upGY8i8oz
         uz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ec6uY7QIeFnNOpPEARpChIvoJP+vgPq80NUTGh7cu3k=;
        b=rPtIRq6ObcKmMKqgM5YoX9HBrEEl4mqrnOngjReBKg6olScui38/5wks9sGhf/1lY/
         lRfi6EIutPrlHoPKNr5V0qb9Z6FA5ODNazau0vQJ748xhXtZyLXgcdnD0k8/rrpFIYQz
         F0RjPTgWw4iOSRJ2G+Xtj3QG7j9q90dzUlgvcbwFQBgKwLOcg3NAaft79y3xFCnuq4gm
         yIy3aJ0G/mnv6C4lk/IaUVH0BmqJBkRSpFm/7rPWPusX0ZtSIp2JIXzJI2ouBaQA0f7J
         zXyYeBBlt0tyaTPfjs/bsfDe6I4xZkSoyDhsLjrfVuLLBAk9JtWNkXI73V9/x+LWcV7G
         82Tw==
X-Gm-Message-State: APjAAAXI6HXy4oBMeM+8F5CDPEjwDkHdDB21a2BjsHflaTuZNohAOmmN
        hVgR8MPu6/XTfpHkSXboiIY4iAhe7kmA+QS0mP0=
X-Google-Smtp-Source: APXvYqyrV8BL95rNsh8BGN9dFZL1ckmAfqD+NBGIGdshndEdb3ZyMVdE5Hj4YTQy2inDFwtYeHVu9Q8OOahxzQdyct4=
X-Received: by 2002:ac8:1a78:: with SMTP id q53mr4557831qtk.379.1570639055533;
 Wed, 09 Oct 2019 09:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191004134624.46216-1-catalin.marinas@arm.com> <5a75249e-47ee-bb7c-d281-31b385d8bb86@ozlabs.ru>
In-Reply-To: <5a75249e-47ee-bb7c-d281-31b385d8bb86@ozlabs.ru>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 9 Oct 2019 09:37:24 -0700
Message-ID: <CAPhsuW4TOM+u+W2YwDkQjjZbDubPDR_69F0VMxSOzb6eRMPbaw@mail.gmail.com>
Subject: Re: [PATCH] kmemleak: Do not corrupt the object_list during clean-up
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Marc Dionne <marc.c.dionne@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 8:11 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
>
>
> On 04/10/2019 23:46, Catalin Marinas wrote:
> > In case of an error (e.g. memory pool too small), kmemleak disables
> > itself and cleans up the already allocated metadata objects. However, if
> > this happens early before the RCU callback mechanism is available,
> > put_object() skips call_rcu() and frees the object directly. This is not
> > safe with the RCU list traversal in __kmemleak_do_cleanup().
> >
> > Change the list traversal in __kmemleak_do_cleanup() to
> > list_for_each_entry_safe() and remove the rcu_read_{lock,unlock} since
> > the kmemleak is already disabled at this point. In addition, avoid an
> > unnecessary metadata object rb-tree look-up since it already has the
> > struct kmemleak_object pointer.
> >
> > Fixes: c5665868183f ("mm: kmemleak: use the memory pool for early allocations")
> > Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > Reported-by: Marc Dionne <marc.c.dionne@gmail.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>
>
> Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Tested-by: Song Liu <songliubraving@fb.com>

This fixes my vm, which could not boot with 5.4-rc3.

Thanks,
Song
