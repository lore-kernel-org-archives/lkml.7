Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F03DC28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 00:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E6A20872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 00:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhicxqzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfFFAYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 20:24:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40531 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfFFAYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 20:24:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id a9so199286lff.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 17:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N1TbV63VvRheR5OgJaz2rfajmrYQQlbC4P7mXaYbfMg=;
        b=VhicxqzHgalolOYgzImxTAg2DnXaE9sizZjeFz2laU6Mhcz0uaO5DMJBRj0nNsCpVX
         CejYO6l2zddgkF7VyKKkgrKWcFgiCN3CQHo69ZqkTYgfXK+O5PpPERricJEYTVZesK88
         bW7myqV+mjCeVS1lufYXhgsjGA96xAYSoFhdegPcOIK7vEXein990h+BhIwQEnGJP/+F
         ie4Fv9bHJZLPWtVDw+pT9atpxKRxkJsBibNXoyZvkli6btodCReDjs4DALS6lervjSKV
         CX9uJsL83jO5wrfYxiIJuH6nWclhy5a4NLiSW/EykeAow2dB0LuUC70JGuYPJs288yZf
         IiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N1TbV63VvRheR5OgJaz2rfajmrYQQlbC4P7mXaYbfMg=;
        b=DKg3lD9+VozGxElqr/5zI5ZmTAkBzyOUt7xFm9nN9+/2Me6DP9Fh54KN0k47Jcc7SW
         1ueJf+DWoC8DjNs6ZxfLSRq+itu8IRPE89KejLqR/wruR02fdN5ZyYBoEmv/Oe3yVVeB
         lMk1l6rN7NNBRvs+3CSlwTUSVd5XAq87Q3aeGykD13le2IOKAi3FmBv4opK6NW6J/rBl
         1VvzbNjymCuhzeD0M0U9EkZLnQCwuBLfnHJzQYQlxyu/qdvNf37FREMx6c3W7tp1IV46
         skAr9fNCzIThWpiLSN+34zzauBj/QbgZVdTVDRe+jltZ1744c/gZQfNyDULLpUaBzSHr
         5Rgw==
X-Gm-Message-State: APjAAAVJ3A/SPKENA0TJfHhA/KHh2s2lxRj8UU4bJHqi8e6q6m0gCMh9
        rfWYt735kkQ3RKH/tGSH93szzEbK1WRp8dkVPfc=
X-Google-Smtp-Source: APXvYqyAK15issZTBtgo/8FWyF3L+MOFJjpUHKt/wl5sPRIaIXeUr7b8lgPa0a4QzGVoi+lctioiYGIFHcmRejmD+zg=
X-Received: by 2002:ac2:43bb:: with SMTP id t27mr2134686lfl.187.1559780673815;
 Wed, 05 Jun 2019 17:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190605100630.13293-1-teawaterz@linux.alibaba.com> <CALvZod7w+HaG3NKdeTsk93HjJ=sQ=6wQAYAfi9y5F34-9w6V3Q@mail.gmail.com>
In-Reply-To: <CALvZod7w+HaG3NKdeTsk93HjJ=sQ=6wQAYAfi9y5F34-9w6V3Q@mail.gmail.com>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Thu, 6 Jun 2019 02:23:56 +0200
Message-ID: <CAMJBoFN67ByX7ZBu_GDv_h1oMWD6SU+_nj8fmYWo6Qzdrn9JuQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] zpool: Add malloc_support_movable to zpool_driver
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Hui Zhu <teawaterz@linux.alibaba.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shakeel,

On Wed, Jun 5, 2019 at 6:31 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Jun 5, 2019 at 3:06 AM Hui Zhu <teawaterz@linux.alibaba.com> wrote:
> >
> > As a zpool_driver, zsmalloc can allocate movable memory because it
> > support migate pages.
> > But zbud and z3fold cannot allocate movable memory.
> >
>
> Cc: Vitaly

thanks for looping me in :)

> It seems like z3fold does support page migration but z3fold's malloc
> is rejecting __GFP_HIGHMEM. Vitaly, is there a reason to keep
> rejecting __GFP_HIGHMEM after 1f862989b04a ("mm/z3fold.c: support page
> migration").

No; I don't think I see a reason to keep that part. You are very
welcome to submit a patch, or otherwise I can do it when I'm done with
the patches that are already in the pipeline.

Thanks,
   Vitaly
