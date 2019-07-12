Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7249BC742C7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C23A21670
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i30lgvwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfGLPJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:09:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35772 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGLPJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:09:12 -0400
Received: by mail-oi1-f195.google.com with SMTP id a127so7526296oii.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 08:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJ8/wMSygZBfB3wNzWuYzcvp2/BWwETDvXU2IK3PdxQ=;
        b=i30lgvwLkeVpXQsVjPYonpEPiGWlUBv2z2qDgJQMxrpKENxTorJSehxeqy+LUhfYzv
         VtQK7axqN3W8U1LkXDuWZF1uP/L2p5KuLxKw4qI6wW++8B5fsIOnjjNBcW6teOiQ7tII
         mzaCC2ZUY+uYaRDsXXA4s9KcaDlBUAOOWLZdYfvJUEAQEBDrP1cVZ7aiVZqE4JPjLspM
         gGX5Sxlw25a4BwETR5XcKtZkSZrIlIkMg/I5T2vbeOKWQ6GxTtCPuP3CCKEjJvhuAnNI
         gUc8VfcZTZNpYUjORWUUYKbazILP48oH1baF5oAlWmAp2Iq73gk63PjeR6tPL6TgX/5n
         EdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJ8/wMSygZBfB3wNzWuYzcvp2/BWwETDvXU2IK3PdxQ=;
        b=pmO/InhCSjoSmH2w/HL68DRYlAR71Qso8YU+l1+bNzLI/1Ml2WwiKLMu3kIvcNlxOo
         gR/D7fYz3EvBQ4iehjPmBwt9vC0V4Z8wNwjRpBZ/nQzah2rzfkFGwb8YXn4GJ3pjsGxB
         7QUnBGax79Ham6WiqXmBmpqt27hizYmPP54AxWE1JihRHPlEmaLrN/tO5NBa2SdiaJkQ
         H7oTwxdEYqHFoXrQ0XQi5OcRvn4Ag0DQ8WIM4BjHUz2fwGcLmIXIMZi3x0BPJpgbvPG6
         xQstEB/HFICY+4hZ21g/LK84NpyhSKfIsx4PwiRZAIf7TX/UJQuhT7nllUt3Pz8TzbND
         +kbA==
X-Gm-Message-State: APjAAAWUn6hNtoVDMfZ9aoNNnMHuK4vb2YAyQQjotAfGk0VhC/RVGL35
        NCW7IuTCzFvmpP0VKwKVL6Mb4YrUu8VQM5YMpMNdinImxmQjiA==
X-Google-Smtp-Source: APXvYqx6mGiQZVnuJ8vBdqFSeKXfLAml4k5LUaP7pbQDRWmiFpLAtMv5q6hcSKqWv8vY99TgvNNCYqHMtYCIHspx+74=
X-Received: by 2002:a05:6808:4d:: with SMTP id v13mr6048794oic.22.1562944151822;
 Fri, 12 Jul 2019 08:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190712120213.2825-1-lpf.vector@gmail.com> <20190712120213.2825-3-lpf.vector@gmail.com>
 <20190712134955.GV32320@bombadil.infradead.org>
In-Reply-To: <20190712134955.GV32320@bombadil.infradead.org>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Fri, 12 Jul 2019 23:09:00 +0800
Message-ID: <CAD7_sbEoGRUOJdcHnfUTzP7GfUhCdhfo8uBpUFZ9HGwS36VkSg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mm/vmalloc.c: Modify struct vmap_area to reduce
 its size
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, rpenyaev@suse.de,
        peterz@infradead.org, guro@fb.com, rick.p.edgecombe@intel.com,
        rppt@linux.ibm.com, aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 9:49 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jul 12, 2019 at 08:02:13PM +0800, Pengfei Li wrote:
>
> I don't think you need struct union struct union.  Because llist_node
> is just a pointer, you can get the same savings with just:
>
>         union {
>                 struct llist_node purge_list;
>                 struct vm_struct *vm;
>                 unsigned long subtree_max_size;
>         };
>

Thanks for your comments.

As you said, I did this in v3.
https://patchwork.kernel.org/patch/11031507/

The reason why I use struct union struct in v4 is that I want to
express "in the tree" and "in the purge list" are two completely
isolated cases.

struct vmap_area {
        union {
                struct {        /* Case A: In the tree */
                        ...
                };

                struct {        /* Case B: In the purge list */
                        ...
                };
        };
};

The "rb_node" and "list" should also not be used when va is in
the purge list

what do you think of this idea?
