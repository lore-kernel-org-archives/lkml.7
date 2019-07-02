Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616BCC5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A72B21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GtPoE1zF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfGBAZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 20:25:58 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35249 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfGBAZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 20:25:58 -0400
Received: by mail-ua1-f67.google.com with SMTP id j21so5807228uap.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 17:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eCM6IGl0POOS9v+6zF5Qx7pdDuSmAeyB4UjeKG4bXPE=;
        b=GtPoE1zFBRjF6mtkyRmZVPufRQIoF6BPVLaVQcNXccZeRcYqs7ssYiMVt6Hkzl3uj5
         YvvZ9dW+c39J1FQM8aBzyy1ZZZAlVaqBHEm803J2KHdFFGIKHrB1wYMo2XTAYA4HXEuS
         8vtcnysv5NKgq3k6VvI2wAVCowp529L212TFqhmuGug6P7Q5xDDKbuYa9nb3r6bUvFIx
         sDvT77TTnmJzpmUdKuYZirjenLok8aRMX0mq/9xtQGm/qh14gMw2g9+82MddM1UkzYAz
         tDGO4FxySoYv0y8Afp0Jmg23q/vqx+Pu6t55bbbaZTCkDWbZmkIosI4QY2mA1LHOXrXc
         y5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCM6IGl0POOS9v+6zF5Qx7pdDuSmAeyB4UjeKG4bXPE=;
        b=ByYIVhIyamBg3SI7bFMroszh68EUhjiaZ9y1O8K9Ff4C06Eh3uzVucBFs8V6okBO17
         xZ3Ffz/3QkcT+bx4mdYLhxOWP4fGu91MlGFv1KQ1Jxis/F8cP1Fxdfzw/jp19FSw0N01
         HNYwyIi/47B8izIk8sHY7f3Ngm8KLas8ww7tVMNos8na9TLSI9RwI9vnqO4J8ud6WfV5
         abiSY1Bu85ZUPdUh6pqXKvaW6h7zCwdV//1NmeY7MMNVQJlq7Q3/nMLbBFOwHKFM+pN6
         YSf1vIXh/ChTbMheC31xvd0Rs9JwzMcKAtzacMScXNHk7WuJ58ZWJ12FWi1ldxEehKyd
         sHcg==
X-Gm-Message-State: APjAAAUcCYdtj7Rp8mQdTUPPv9w9sjdEcyHEFugH30OoOxB1NYspWV4j
        vWVgtWLtAZU/3hy8+3+kjkA5C9rdHLOy7FEJ5PMVyA==
X-Google-Smtp-Source: APXvYqzxZiTtBQcEhNLba+IhIqTyH+FE4A6h2w15+wKQl00XAYBOSwQ9BBlooa8lk7fEzJZ/nV2bfYxF5YAlBjtNPDU=
X-Received: by 2002:a9f:31a2:: with SMTP id v31mr16180169uad.15.1562027157015;
 Mon, 01 Jul 2019 17:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190629004952.6611-1-walken@google.com> <20190629004952.6611-3-walken@google.com>
 <20190701074630.GM3402@hirez.programming.kicks-ass.net> <20190701144026.GF3463@hirez.programming.kicks-ass.net>
In-Reply-To: <20190701144026.GF3463@hirez.programming.kicks-ass.net>
From:   Michel Lespinasse <walken@google.com>
Date:   Mon, 1 Jul 2019 17:25:44 -0700
Message-ID: <CANN689HQ9UyWTgvj-i-Xuc-trHfAuy5PuaL=C5QZh-YOQ2Z=DQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] augmented rbtree: rework the RB_DECLARE_CALLBACKS
 macro definition
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't like adding additional levels of macros to build the augmented
rbtree callbacks. OTOH, all of the existing callbacks compute the max
(within the subtree) of a per-node scalar property. So, I guess I
could do a RB_DECLARE_MAX_CALLBACKS, and one of its arguments would
tell it how to compute the per-node scalar property, and it would
generate the code that both computes the max within the subtree and
assigns it into the augmented variable for the subtree's root. I will
prepare a v2 version of this patchset that does that.

On Mon, Jul 1, 2019 at 7:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 01, 2019 at 09:46:30AM +0200, Peter Zijlstra wrote:
> > On Fri, Jun 28, 2019 at 05:49:52PM -0700, Michel Lespinasse wrote:
>
> > > The motivation for this change is that I want to introduce augmented rbtree
> > > uses where the augmented data for the subtree is a struct instead of a scalar.
>
> > Can't we have a helper macro that converts an old (scalar) style compute
> > into a new style compute and avoid this unfortunate and error prone
> > copy/pasta ?
>
> Or add a RBEQUAL argument that does:
>
> -               if (node->RBAUGMENTED == augmented)
> +               if (RBEQUAL(&node->RBAUGMENTED, &augmented))
>
> With a bit of foo you can even provide a default implementation that
> does: *a == *b.
>
> See GEN_UNARY_RMWcc() for how to do that.



-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
