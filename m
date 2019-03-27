Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3EFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CCC206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt02eZLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfC0RJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:09:06 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40643 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbfC0RJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:09:05 -0400
Received: by mail-qt1-f194.google.com with SMTP id x12so19717952qts.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HaYG3Urew4OVW3qYddWpvb72dK52f/h7DEtTWkLewsc=;
        b=Zt02eZLzvyhCzgcyfOCuXWgb5LFJOrKhunf2mdDI8EhXMf1hWEjRfjBPwtCzvX2XIn
         eIS43V3oeR/XwxnmvBRYR50j0BeJVcOFChzJtKcvvQ3Dm1WCgKVKRCKkVTanyGxst3Ck
         U8jEHddZDJQZxebsPB3ryWfgFR4uAPFNliM/zpBmYcOYeio3dfUe8m2mihnljnDehXnn
         hUC+OEzfM3P8sQA/dSNC5OkWHpYb/JsxPCzH50RQFA6Q5tnQtCoO1kVG39I6O61rTgT4
         RkgJ94YYMi+wCvzje62Ilqfh9ADMgX5056DeVsZzIwIsO5eyfFOtLWm8lbUfZNnt0kFP
         ib8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HaYG3Urew4OVW3qYddWpvb72dK52f/h7DEtTWkLewsc=;
        b=sZNz+Td5o/s0YOCMCZsDtI/8H+ONAU5/NXIrCHzsD/6fwabDOnRvga/zrebMs8WKij
         xem7G6cMz7Jhfpm2rNBhZLsC/5hHRsjd8IEWDegfw44Ur6ilHlWLqNKV/EXlyBbhrjeo
         qEH91ucY5b7BJaGq5YmFsaVENrIh9cAWXIoq2uiayUMTX1M8y52Y5WA0el3qvjxgHQe9
         +JEG+fvvOjZVFTHIvyq/Kh1adkKnVWvG8JzcqU7WgakvCoIsn20kKBlwCAgnjUnc5rRF
         5ae5uvGzyKEEcLjLLuonpMUpAhCb8RIxGuRjrdURj0+FZzrMhbt0R97Gz0XK93EkeO5l
         g4NA==
X-Gm-Message-State: APjAAAXbSE0G+a/Gdoc0gcrNMYR//BBGdiZOayOafb4O2yYTaJuhjRaa
        pcXm/Hh92DmQfPDC4S6MdwLjBswno2bxG1DkF6k=
X-Google-Smtp-Source: APXvYqxf70uM0t6IC//VyWJxovsPyAy6lPYKfixO6Bj3pDL6kJhfIkSbFlcfJaC6XN6HCwiA6ZegljaIOzivWuJUF0o=
X-Received: by 2002:a0c:96eb:: with SMTP id b40mr2477600qvd.131.1553706544769;
 Wed, 27 Mar 2019 10:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <1553648174-24913-1-git-send-email-v.mayatskih@gmail.com> <20190327164914.GE27283@stefanha-x1.localdomain>
In-Reply-To: <20190327164914.GE27283@stefanha-x1.localdomain>
From:   Vitaly Mayatskih <v.mayatskih@gmail.com>
Date:   Wed, 27 Mar 2019 13:08:53 -0400
Message-ID: <CAGF4SLiKv06rzuGprfpWg-EOi8y+DW+cTybCkoT_9OoE+y8tcQ@mail.gmail.com>
Subject: Re: [PATCH] vhost: zero vhost_vsock memory on allocation
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 12:49 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:

> Which field was accessed before initialization?
>
> I ask because the situation is now unclear since code remains that
> assumes vsock is *not* zero-initialized:
>
>   vsock->guest_cid = 0; /* no CID assigned yet */
>
>   atomic_set(&vsock->queued_replies, 0);

It was hash.

> If we're going to zalloc, let's get rid of explicit zero
> initializations.  Or let's use kvmalloc() and fix the uninitialized
> access.  Mixing both is confusing.

I would go with zalloc, since it's easier to read and it prevents
further situations like this.
A zalloc was there originally (not in fallback though).
