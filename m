Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F63DCA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6341208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572266409;
	bh=XMe79G3hmuZmmBLpLsWSI1UGg1qy6reTMAyOYN7BqCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EuM21Y3glmc6ssuGQU7s8COOAAJ2ITaN+AFnJa8hO+JA3EDxTBG9q8S8kwpGFnD2z
	 oumaf+KsmEVP/9x4CBF9PO7iu2SWZtLTz0iHLpxW1oQVuwzsd6vgd9Xjk+Hr0jlf8d
	 MaFHVrUaabZBQhRSZUzUlAUzGxpjGE/aDNATnIL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389148AbfJ1MkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:40:07 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43086 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbfJ1MkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:40:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id s4so10275572ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 05:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATDKJMcIxCSwydf+1lUKxJ7Ftg71NmlGmbozwsqMkmc=;
        b=QlzDd1Bh3krOIKFjcDBdZoayUKXaWxUvGFEq2duRqI6syPWfllKIuNiRiwFp3Rsvlm
         nxqwqgYi8hs/NEk8mASxHt8carAtxDUSL6DW6fwUayesh7ZvlNihXqYJHT/hp5a3B/c/
         sAj/eEL2RfuIZGHXujz05q+R3v1iYQI3WZw6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATDKJMcIxCSwydf+1lUKxJ7Ftg71NmlGmbozwsqMkmc=;
        b=AMXzU0RNbGOV1yzMY087YzMOGQ/vLh8QBhZ/2LBCSViQf3GXOyYvZHJ9R/z/wn8coa
         fTddVou04fzxK2bWVOjPpJcXoxH9KC+6EoGYzczuJMm3jdIh2Xb6aVIoQrDyACjQFTYp
         qmVX6yVg9zOXsk4UoapPAFFHy6vNWAigljjiMfNOR9nboBkFjDBTuqlx9LKhd8wjuFvX
         LUBSEdH2Yvgyi0Gs5N4UTsIxCqIkI6UuV1LnRSGQEyFWbMHsFBXmnS+9EV66ON08u3ki
         mOwpXE0NUE7mU+ZRW55bp7Z7hgl1jhdeQxmM60beNyMmMjSgrhaAQrNvKWW6aHe0NRB4
         7nOg==
X-Gm-Message-State: APjAAAWfrp48qH3emPnn4kuPHn9WI6OgaI9+iGaFzfd4qKdgfvrGmwV8
        vEYFspiC8uw53ylkhBj0XutNfBdsihnQWQ==
X-Google-Smtp-Source: APXvYqz118h2m8jfJKzmQfER+B+nZ41xDJhyJm+4lpKghTiEXm4SSXE3la2Ois9be7h6adPFUzYo2A==
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr1931443ljo.221.1572266404791;
        Mon, 28 Oct 2019 05:40:04 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id f1sm4700434ljk.77.2019.10.28.05.40.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2019 05:40:02 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id v24so11188342ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 05:40:02 -0700 (PDT)
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr8529100lja.48.1572266402291;
 Mon, 28 Oct 2019 05:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <157225677483.3442.4227193290486305330.stgit@buzz>
In-Reply-To: <157225677483.3442.4227193290486305330.stgit@buzz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Oct 2019 13:39:46 +0100
X-Gmail-Original-Message-ID: <CAHk-=wjmLgo7DQT7Cy5rAGd=+2OK5Lqa8BN9qJFW1NPRoDfx5A@mail.gmail.com>
Message-ID: <CAHk-=wjmLgo7DQT7Cy5rAGd=+2OK5Lqa8BN9qJFW1NPRoDfx5A@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 10:59 AM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> Page cache could contain pages beyond end of file during write or
> if read races with truncate. But generic_file_buffered_read() always
> allocates unneeded pages beyond eof if somebody reads here and one
> extra page at the end if file size is page-aligned.

I wonder if we could just do something like this instead:

  diff --git a/mm/filemap.c b/mm/filemap.c
  index 85b7d087eb45..80b08433c93a 100644
  --- a/mm/filemap.c
  +++ b/mm/filemap.c
  @@ -2013,7 +2013,7 @@ static ssize_t generic_file_buffered_read(
        struct address_space *mapping = filp->f_mapping;
        struct inode *inode = mapping->host;
        struct file_ra_state *ra = &filp->f_ra;
  -     loff_t *ppos = &iocb->ki_pos;
  +     loff_t *ppos = &iocb->ki_pos, size;
        pgoff_t index;
        pgoff_t last_index;
        pgoff_t prev_index;
  @@ -2021,9 +2021,10 @@ static ssize_t generic_file_buffered_read(
        unsigned int prev_offset;
        int error = 0;

  -     if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
  +     size = i_size_read(inode);
  +     if (unlikely(*ppos >= size))
                return 0;
  -     iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
  +     iov_iter_truncate(iter, size);

        index = *ppos >> PAGE_SHIFT;
        prev_index = ra->prev_pos >> PAGE_SHIFT;

and yes, we still need to re-check the inode size after we've read the
page cache page (since it might have changed during the IO), but the
above seems fairly benign and simple.

Hmm?

              Linus
