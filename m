Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D84DC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500382086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569020741;
	bh=nVpUqAlEnUS9wyz/Qv41mAigNGxnJ9yVVurMcY+h8Zk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fzQcJfQtgiZkss2IBc47SAEGmvjMXHXsXlt98Hbt663f7h5XNZXn5jpLpsXQn/6d8
	 lCr80MwMnXdxuZgVX5+SR0MD2KZHa8It30L7gOwwji4uT2s7vjeHYo7uYT1V3sVLsU
	 JJiWRnF/XEkNNPN7oZ8mnw4UtS0ZaJqwVCJeLowU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407023AbfITXFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 19:05:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34558 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407011AbfITXFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:05:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19so7079204lja.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 16:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mtHJRljpIthtHGh3XxE5kG38evjyZkXXa2KwhkF3cfE=;
        b=Cc5gWnHvSFkt/XOMA27VwmYwG7DVJmBzs0dIyEV6yq14mog53/7iNdQvPU8DH7UYCO
         WARG7/ZwIOBICzkQ8IQmexLNL7Ke5E6YBstlJKL71nq+d4fqB4s2qSAcsuYAbWAYHSRu
         k6yu+jXAPxOkH/L5OLNGuUB3Vt3R3U+Wxs+NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtHJRljpIthtHGh3XxE5kG38evjyZkXXa2KwhkF3cfE=;
        b=IEnCzUJtKDNJoy6w2iAuhIv6sSK0cVmSWNNFYhQZQIzohtF8SJUgaNIse1KH41EO9f
         /l6IfiCoKuLGFWmG7XhzWr5VxPB1hVfM6hDNtfiuGD03Crwo6rinogFsZZAeRgX7livQ
         upLeZZ3G5SG2jfffVqaXJEo5w04JSIk9+64gXEG5dPILh50AiMh9Q79pTerLNok7Quai
         3CB71turFWexfcQuvKuk4JwHpsEOwaO19j+pQXo919XdV+mWc5fN45l5sP0HKi3+FnIt
         b1IM9TXVLtICMMXGWgjpwIf+2n0DA4Ze2SiJLhJ/NaoxQNsuNEa6gSYYnm8GofhYk7oE
         Gvzg==
X-Gm-Message-State: APjAAAUi8xWfQ6xYvArT17bM1rEACQdtKnCdsfLqI79prFul79siEKYh
        MAvgrSDMit2y2fsKksu0rgE6+JCx3aQ=
X-Google-Smtp-Source: APXvYqwGD05Fiycdt48H3ysUmdVQEs0AA7tc2ot8Fgb1EMHcvDAwdSRwaWIVACzgby+Wt2bPBns4GA==
X-Received: by 2002:a2e:9eca:: with SMTP id h10mr3222597ljk.32.1569020737143;
        Fri, 20 Sep 2019 16:05:37 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id h25sm824768lfj.81.2019.09.20.16.05.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 16:05:35 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id l21so8583257lje.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 16:05:34 -0700 (PDT)
X-Received: by 2002:a2e:96d3:: with SMTP id d19mr1246398ljj.165.1569020733395;
 Fri, 20 Sep 2019 16:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <156896493723.4334.13340481207144634918.stgit@buzz>
In-Reply-To: <156896493723.4334.13340481207144634918.stgit@buzz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Sep 2019 16:05:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmCZvYcR10Pe9fEy912fc8xywbiP9mn054Jg_9+0TqCg@mail.gmail.com>
Message-ID: <CAHk-=whmCZvYcR10Pe9fEy912fc8xywbiP9mn054Jg_9+0TqCg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file writes
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 12:35 AM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> This patch implements write-behind policy which tracks sequential writes
> and starts background writeback when file have enough dirty pages.

Apart from a spelling error ("contigious"), my only reaction is that
I've wanted this for the multi-file writes, not just for single big
files.

Yes, single big files may be a simpler and perhaps the "10% effort for
90% of the gain", and thus the right thing to do, but I do wonder if
you've looked at simply extending it to cover multiple files when
people copy a whole directory (or unpack a tar-file, or similar).

Now, I hear you say "those are so small these days that it doesn't
matter". And maybe you're right. But partiocularly for slow media,
triggering good streaming write behavior has been a problem in the
past.

So I'm wondering whether the "writebehind" state should perhaps be
considered be a process state, rather than "struct file" state, and
also start triggering for writing smaller files.

Maybe this was already discussed and people decided that the big-file
case was so much easier that it wasn't worth worrying about
writebehind for multiple files.

            Linus
