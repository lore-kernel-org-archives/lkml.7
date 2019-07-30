Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F40C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06AB20882
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YsRaAx+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbfG3HbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:31:18 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36960 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfG3HbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:31:18 -0400
Received: by mail-vs1-f65.google.com with SMTP id v6so42863807vsq.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 00:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fECuqTI21Ojn1LPYHq9mS1W5JJM7snWl8FCqRE1MoYU=;
        b=YsRaAx+Hf0mEuPnCsWO2W2dYecdgMTRK+nJ/4M33VHXYcgt7lj5n4IJnicf/5wcAae
         64a69Md/r9aL7yyzqpZZFIVQ7bSAgGz9+3PY5Ee+6+xCd1QyEwj7sf+tHZjZLfz1PX7m
         xZJKAnvEakRRnnxcyhhPaC2DOQKcrrdoPO27BhVwFqND8uGjwxUilHIdzaYZwAusqAPG
         xFQ71irW+Dc1x+CBeOCuijqMadQ9k3OZO1gEfFiNs3cpiyIfW2xF1DQd6dXLCBObU5Bx
         kJ+TDttpTt4QUqlbC4T/0WzXyAgUELTkmqp0xzQ44NQN8VcbTv6f4nP86EINFUxmnLGw
         RzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fECuqTI21Ojn1LPYHq9mS1W5JJM7snWl8FCqRE1MoYU=;
        b=SWoK1ysPKdm7ZHGsaIM++5skjqvm5oXtD3UasSBe1JPsibVejg9dipqzqDiW3dka/m
         70R4WLCnHEd3q5W8QQ3XqrprHsm+Y9O1S+TYKykww2di3VEJYrdOd8Bv4PCK543AAtQw
         NDegD01AiSgHqmssmZh/19Y03+5c3ymIqs8a4DsQBmTN61e0TiVYqJ1yxcEinPZqKIg/
         2Lxp4hDnfwx87b6LWZMLSdsK7jNAvAhOuCRZkt0WeDFHA+VK9ag7ezsG7wKoSZ6NCmM4
         bN5b2kMlnVyWFqvSrLWFveFoqlHJkSIfhpR+1vbIYiY7pvokLJbDdgi+wuOSoPGtjXMp
         wh9g==
X-Gm-Message-State: APjAAAX/4KbK9OLHZdC2o/uiZ6AblWAnqSnLxyH5YPaRMdH/b6uC/h00
        NLcJxvnzK7Cy6VbsJYQAHxX4/G5MzD3e/5vdogU9zw==
X-Google-Smtp-Source: APXvYqzrda20t8D3j5KRYDQFv4L3fC2HefMVmH59xLO2jtaB7TCZGadKQNr1xx7fBjjkKocKHeYxrFzer+xdwJOHtWk=
X-Received: by 2002:a67:fe5a:: with SMTP id m26mr44751008vsr.230.1564471876985;
 Tue, 30 Jul 2019 00:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190703040156.56953-1-walken@google.com> <20190703040156.56953-3-walken@google.com>
 <CANN689FXgK13wDYNh1zKxdipeTuALG4eKvKpsdZqKFJ-rvtGiQ@mail.gmail.com>
 <20190726184419.37adea1e227fc793c32427be@linux-foundation.org> <20190729101454.jd6ej2nrlyigjqs4@pc636>
In-Reply-To: <20190729101454.jd6ej2nrlyigjqs4@pc636>
From:   Michel Lespinasse <walken@google.com>
Date:   Tue, 30 Jul 2019 00:31:04 -0700
Message-ID: <CANN689FMTh=Odn-KM06bPAf9zFwOpSg3FthL7Q5OXRGVWQUOhg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] augmented rbtree: add new RB_DECLARE_CALLBACKS_MAX macro
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 3:15 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> >
> > --- a/lib/rbtree_test.c~augmented-rbtree-add-new-rb_declare_callbacks_max-macro-fix-2
> > +++ a/lib/rbtree_test.c
> > @@ -220,10 +220,6 @@ static void check_augmented(int nr_nodes
> >       struct rb_node *rb;
> >
> >       check(nr_nodes);
> > -     for (rb = rb_first(&root.rb_root); rb; rb = rb_next(rb)) {
> > -             struct test_node *node = rb_entry(rb, struct test_node, rb);
> > -             WARN_ON_ONCE(node->augmented != augment_recompute(node));
> > -     }
> >  }
> >
> I have a question here it is a bit out of this topic but still related :)
>
> Can we move "check augmented" functionality to the rbtree_augmented.h
> header file making it public?

Hmmm, I had not thought about that. Agree that this can be useful -
there is already similar test code in rbtree_test.c and also
vma_compute_subtree_gap() in mmap.c, ...

With patch 3/3 of this series, the RBCOMPUTE function (typically
generated through the RB_DECLARE_CALLBACKS_MAX macro) will return a
bool indicating if the node's augmented value was already correctly
set. Maybe this can be used for test code, through in the false case,
the node's augmented value is already overwritten with the correct
value. Not sure if that is a problem though - the files I mentioned
above have test code that will dump the values if there is a mismatch,
but really I think in every realistic case just noting that there was
one would be just as helpful as being able to dump the old (incorrect)
value....

What do you think - is the RBCOMPUTE(node, true) function sufficient
for such debugging ?
