Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D5EC46460
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE45E247DA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uBMZGMO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfE3HBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 03:01:40 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40063 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfE3HBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:01:39 -0400
Received: by mail-vs1-f66.google.com with SMTP id c24so3723084vsp.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 00:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1AVZODHTXqoipQTcM+k2pyJLkPC3ogLcgg1avCL8ws=;
        b=uBMZGMO+qZsoCeRw3kwv3k0YCQqz0heCVI7dQyQhnaQFQ5ZilokWnv7NVtCi1n3603
         KCttYxV550rM84xbifejh3+nH1PU5HGaKhHDfo3cCBBpAgZFQ2z9OjbrTQlZ10kBqCVx
         O3tSin/t98cyBT9WfRD0LS94HiP9OmZtTWp96r2PF7NSi/6sPt7aIH8LifQyHh2w31xY
         r3BGguEr91cNp35qZY4p3JjNPrz/ikziz3UjVG1t+YOTJvoTb4jE9WuAewN8N3mzn5du
         ViEJY/Xke/XpBKvX9oFQN+iNAZtiUawVNxC14cY8LzqVWhbOPpV233Liw+XKTdMG8Wvk
         GHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1AVZODHTXqoipQTcM+k2pyJLkPC3ogLcgg1avCL8ws=;
        b=PfybBJHCFGMfXmRVu8trN/5UZwW3sBlCpFM45PQP755mfYlFwlaT5yjA2yQXf6CGPH
         BLQockDTHeqIKNlJ+5rsz2Pbs0XPVdZ2n4OyFyVHPaYDyKV4Ju0nBRgrKEquaZxCLOug
         LVgrG4ATn4ovjHI7pJwCQ6HcjE12yP9ZWFpjPoh3l9Yn15vCXMphPobOvB2vns//w+4x
         rg1v5KMmz+28jhjMC7cUFljLiSlKKc1a6Ms/iMMZ/PAg03eWs6MPlTz2Y3i/MJXRrOod
         oObAsFYDrUUCT7TjvvTVCavSefxL9svWFc3g4BVZ1gt1oXvQMCbdClGyk8zoZ+POwXlL
         4BxQ==
X-Gm-Message-State: APjAAAXCAhL4Xe1xxY7tqXvfvgLzVkT8oe//C5qkzbiTC9Gq3WfKUcNP
        gsE5/MGtTtffl9x/sz9gr8EahKiqt80lA0WxTo4=
X-Google-Smtp-Source: APXvYqyDrKD/2h1wpy+U/GzxKvdJhWnVi3tIS5/8fKwMsqErxVDkOlmuINTDW+gtqY3qjgGWsBUMQTbVNCXJLkZZejs=
X-Received: by 2002:a67:f34d:: with SMTP id p13mr1054255vsm.95.1559199698948;
 Thu, 30 May 2019 00:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <1559133448-31779-1-git-send-email-dianzhangchen0@gmail.com>
 <20190529162532.GG18589@dhcp22.suse.cz> <CAFbcbMDJB0uNjTa9xwT9npmTdqMJ1Hez3CyeOCjjrLF2W0Wprw@mail.gmail.com>
 <20190529174931.GH18589@dhcp22.suse.cz> <CAFbcbMA6XjZqrgHmG70Vm_a34Rn4tKqoMgQkRBXES2r3+ymYwg@mail.gmail.com>
 <20190530062418.GB6703@dhcp22.suse.cz>
In-Reply-To: <20190530062418.GB6703@dhcp22.suse.cz>
From:   Dianzhang Chen <dianzhangchen0@gmail.com>
Date:   Thu, 30 May 2019 15:01:26 +0800
Message-ID: <CAFbcbMA4UKErsTDp97QgYkqBXLiL_YbfSE4JM80NVDqpHQgTkQ@mail.gmail.com>
Subject: Re: [PATCH] mm/slab_common.c: fix possible spectre-v1 in kmalloc_slab()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 2:24 PM Michal Hocko <mhocko@kernel.org> wrote:
> I understand the general mechanism of spectre v1. What I was asking for
> is an example of where userspace directly controls the allocation size
> as this is usually bounded to an in kernel object size. I can see how
> and N * sizeof(object) where N is controlled by the userspace could be
> the target. But calling that out explicitly would be appreciated.

In the syscall call poll, the user can control the `nfds`,
when call the function `do_sys_poll` it can pass the nfds to function
`do_sys_poll`, and pass to variable `len`,
although there exit compare instruction llike `len = min_t(unsigned
int, nfds, N_STACK_PPS)`, `len = min(todo, POLLFD_PER_PAGE);`,
but it can also bypass by speculation, as the speculation windows are large,
and in the next `size = sizeof(struct poll_list) + sizeof(struct pollfd) * len`,
which can indirect control the size.


> Please mention that in the changelog as well.
ok, thanks for suggestion.
