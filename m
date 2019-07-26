Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716B4C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F1921743
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RT8iuHWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfGZFyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 01:54:40 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:47098 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZFyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 01:54:40 -0400
Received: by mail-ua1-f68.google.com with SMTP id o19so20857714uap.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 22:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oXHxtrY/1JPtBqrQIWoexay88qj+bMo7PQ0N6TAP0FQ=;
        b=RT8iuHWKJO+K6tK3R+Y+Y00ITNtcOoEgtttRUEM2NMaSU2tB0CJB9SKMqgyUAhVLGE
         vb8lMrGX6RPYmLfo/h8VQXu3cMpxn0wRrjSa5/b8QZlkr72fiARnCgV6nMwei2A20KiT
         ZAJybqEQT0Nt1XC9KaEFHhSae+BvhmPTQtl3o66Gm9LILvFSMsceQfSw9W4G3TvZGRIK
         ZwOovOj91qPRy3V7eYs1aupLGRuTNKl0TBfi6RvEFAj+aWRuJC3HJ3FpcOZ1qEfmieic
         hMJJ3ChOg1DlNyoAR8vaLaU7WKZBWQqYG3cj/E+Du637cZ4NZHyYYzXKDSU4NSuMN7x3
         xT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oXHxtrY/1JPtBqrQIWoexay88qj+bMo7PQ0N6TAP0FQ=;
        b=EPI7ma8N6CV/RO0KraYQTV5k2JBt5P1Pa0PB7rOOeAdqJKOqYc2jyJYMGHT/64K/u4
         Sq4UHY7sl0Hg5fQJHyU+mhl7qEbrR4rt0fdwbYH54JevrD02Rv+eHZO6/sFrOJAEftle
         /Smbj9Db3bT5BYq1Vhoj00YYx2fkOJmpyzDesg4olZ76hEYOnTw53IOFr4YyHP+ckYAR
         HZQUeCg4US1Mb+PiykeflLGrlq8Wfk7P/1m2n04KKiWG+1K9Ne1cTsPRvLrBs8BMErli
         NMLVUrlE9WoTDxeTmEArGrN7YR0FfI7dVXVjJRA9UXDHdDiIMfmfIGKX8JSVQmSInGFi
         JFZQ==
X-Gm-Message-State: APjAAAVYmObXTN3A/PMYPCFNkkb9H8YqyhHz52bfkimQ3RsCJzCU6Scj
        VuzjIyIdO/Vy7rrfgaAIQR9FCZYGrlMM6oHuzBSENlSJUiE=
X-Google-Smtp-Source: APXvYqyZVy8en1WC391nxzGnZAXn3I+0fS7Pbg7x7y5GbYYx1gFKKUihOzlftKLHCxOjx8Mc9D4use6fh4MYflHZK8E=
X-Received: by 2002:ab0:2442:: with SMTP id g2mr7216037uan.47.1564120478505;
 Thu, 25 Jul 2019 22:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190703034812.53002-1-walken@google.com> <20190725201920.fa67c2a95e975dcbb1f859af@linux-foundation.org>
In-Reply-To: <20190725201920.fa67c2a95e975dcbb1f859af@linux-foundation.org>
From:   Michel Lespinasse <walken@google.com>
Date:   Thu, 25 Jul 2019 22:54:26 -0700
Message-ID: <CANN689GWsF97UcdOUQu11qXvfy7LBBHxCwRhixoJ_utS4BrDbA@mail.gmail.com>
Subject: Re: [PATCH] rbtree: sync up the tools/ copy of the code with the main one
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 8:19 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Tue,  2 Jul 2019 20:48:12 -0700 Michel Lespinasse <walken@google.com> wrote:
>
> > I should probably have done this in the same commit that changed the
> > main rbtree code to avoid generating code twice for the cached rbtree
> > versions.
> >
> > Not copying the reviewers of the previous change as tools/ is just another
> > copy of it. Copying LKML anyway because the additional noise
> > won't make as much of a difference there :)
>
> That isn't really a changelog.  Could we please have a few words
> describing the change?  Was it a simple `cp'?

Hmmm, sorry about that. Here is what I propose as a changelog:

---
rbtree: avoid generating code twice for the cached versions (tools copy)

As was already noted in rbtree.h, the logic to cache rb_first (or rb_last)
can easily be implemented externally to the core rbtree api.

This commit takes the changes applied to the include/linux/ and lib/
rbtree files in commit 9f973cb38088, and applies these to the
tools/include/linux/ and tools/lib/ files as well to keep them synchronized.

Signed-off-by: Michel Lespinasse <walken@google.com>
---

The files are not a straight copy, but are very close. I opened the
tools/include/linux rbtree files, cut out the parts that were modified
in commit 9f973cb38088, then pasted the corresponding replacements
from that commit. Then I diffed the exported commits against each
other for a sanity check - they differ only in their context and in
irrelevant detail (for example whether some removed function had some
EXPORT_SYMBOL on them).

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
