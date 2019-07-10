Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B62C74A2E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D702084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfWu2USi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfGJPB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:01:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32904 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJPB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:01:59 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so5458740iog.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 08:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TmbEkkK+CqBlu5lf4ZqLqOZNHYRlqw/lrYYIdmqXv58=;
        b=QfWu2USizXC0KMquGV6dlMozA5qcpBgq1amcr3rHc7cEtoUQECUgVzRW8Qq8x1sDXe
         w0ikGjCOHuz/O1gaNu8oGvnGTgVYevxkyQuKMPJ6wO06+l/FynPjON7iYc/tspNmvNOz
         ky34RkznwLTqbpcGq3d9BLv9Np6FGkFlUznc2TARp/gYf7Zfxw36itbJvjah8YLymzOA
         EF2LyLae+WWb2jkBb3Wqumf9lmhH87+v8pGWgYZrugoUdo41g9R7+a/TIyDuPux9Lmsy
         vHWoTcI2YZENwCQLMVcIC2i9dd4OkwoeinTto4LivZFZYVXm4DxfI6hCKAh5QzPB8hx4
         4jhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TmbEkkK+CqBlu5lf4ZqLqOZNHYRlqw/lrYYIdmqXv58=;
        b=BWPJyiE0DQNDvtJ2lQwPP/IPxjmUjlJFQQnCrGU/NBoC/8vzACKpBhuncH8g3dJfNC
         xN1z8CnCuwNVcwWZ0d34eoFMAnA+AoSzs/zSS67wCSG56phKDOV0y1D6JKYFVF0HEMGo
         amqrUHUtLCMkdewfn5N6lQMj02HDr/5uQ/CwxeHUffHFclnMt8jaOlGQSBczXZiFFfW5
         HphDVZYb35sy9KI6ZggzpYbDgTDGF2iGQxKW2e8GNxdo8F2ghgb1qYrOmrKr3Mc3GcPA
         c1bt51ccG6ShEwnsI28GqI4mQU5R7vkrd5MxPtJG+xQImswoKZ3PMpRvjc+gkHw8N4zv
         X3Eg==
X-Gm-Message-State: APjAAAWb+KeSQKZKZ1yx8Irme3ebAHV665uqhVuEu4fipwyGLo7m3Fal
        56nISIU1rfVpAj9QmT955AdatnV9nCIw4sxl5gY=
X-Google-Smtp-Source: APXvYqzQ2BXQGKlhlJlFKcKu40msLPfp+OtgWnM+vycaJvB2v/zLtDVOzF2EixuDwdQhuDNs+g4WF4Ev2d9vagou+Lw=
X-Received: by 2002:a6b:5106:: with SMTP id f6mr4531622iob.15.1562770918520;
 Wed, 10 Jul 2019 08:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <1562754389-29217-1-git-send-email-bsauce00@gmail.com>
In-Reply-To: <1562754389-29217-1-git-send-email-bsauce00@gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 10 Jul 2019 08:01:47 -0700
Message-ID: <CAKgT0UcWy9kpwhkk9zPbdgj896GzqLV0P7dGMQAUAPr9rURApw@mail.gmail.com>
Subject: Re: [PATCH] fs/seq_file.c: Fix a UAF vulnerability in seq_release()
To:     bsauce <bsauce00@gmail.com>
Cc:     "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        h <l.stach@pengutronix.de>, vdavydov.dev@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>, alex@ghiti.fr,
        adobriyan@gmail.com, mike.kravetz@oracle.com,
        David Rientjes <rientjes@google.com>, rppt@linux.vnet.ibm.com,
        Michal Hocko <mhocko@suse.com>, ksspiers@google.com,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 3:26 AM bsauce <bsauce00@gmail.com> wrote:
>
> In seq_release(), 'm->buf' points to a chunk. It is freed but not cleared to null right away. It can be reused by seq_read() or srm_env_proc_write().
> For example, /arch/alpha/kernel/srm_env.c provide several interfaces to userspace, like 'single_release', 'seq_read' and 'srm_env_proc_write'.
> Thus in userspace, one can exploit this UAF vulnerability to escape privilege.
> Even if 'm->buf' is cleared by kmem_cache_free(), one can still create several threads to exploit this vulnerability.
> And 'm->buf' should be cleared right after being freed.
>
> Signed-off-by: bsauce <bsauce00@gmail.com>

So I am pretty sure this "Signed-off-by" line is incorrect. Take a
look in Documentation/process/submitting-patches.rst for more
information. It specifically it calls out that you need to use your
real name, no pseudonyms.

> ---
>  fs/seq_file.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index abe27ec..de5e266 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -358,6 +358,7 @@ int seq_release(struct inode *inode, struct file *file)
>  {
>         struct seq_file *m = file->private_data;
>         kvfree(m->buf);
> +       m->buf = NULL;
>         kmem_cache_free(seq_file_cache, m);
>         return 0;
>  }

As has already been pointed out we are calling kmem_cache_free on m in
the very next line. As such setting m->buf to NULL would have no
effect as m will be freed and could be reused/overwritten at that
point.
