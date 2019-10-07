Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BFDC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1892F20700
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYigjaBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfJGQhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:37:09 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:47046 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfJGQhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:37:08 -0400
Received: by mail-oi1-f194.google.com with SMTP id k25so12190574oiw.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 09:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/g+TIxP8SKNK08vLgY7W9iyDhVKXTg+mETBQIQmONM=;
        b=iYigjaBz68RW2Bfcgp0fWz6OYG118ciQXbBGXfJhyah1zWW9HRBSERHlefrRDVzDS0
         6EKOP9bHv9wNAkSDU1yxaWcA4ueQ4XYHxEaPwmiycXashgdG/gFXU2UkJp+lsX1IFFmp
         q+I6gtr0azcLMCJi6zWIm8q3RUDuiZnb2sKlifzfZdfoeIrodFZLckMjcl6mCvajS7km
         p5X6XDqcqWX+J/oi7bmVjMKIy9zapHhxfuH7GV2HAKDNmx6TKYZgruQTG+BBqU6iCM0M
         F2CnsYGbPfpTaXjr1rP5SoMQfTt8nxtzsIhk7Ocz7T1vxsr2NG+d0gT4IVMKHO6oH8wV
         K/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/g+TIxP8SKNK08vLgY7W9iyDhVKXTg+mETBQIQmONM=;
        b=V8h726O7kFb1un+tBi3znaIfboC9GCrOunpA9PApplZymKJha5nEhxpKxEdtfu9x32
         ks3/QnEF7k3nJqzb0JBzGb9qhO8nZlG6DrRCveWU8iO1tqTrDHZubHBAhb5OmrD/1I1N
         f7CbL11rPq4Ncuh6D3oGd4Y8KfVo5aY8Q1teWLnnHZpQctrgf/4vbMmSI6WqcwlQbkXa
         Mc4FquvJ/Xe+80V5CaQMdFGppd8xdCIwo3e/c7y+X1fIwtVDZE5aYZSuJjbxugTGqzOO
         fZec3/ITemleKK2QMkhHoWXhvYlzmq8BnOabsi//ObMEZI7dFnjlthmIzZ4tJS8rmsmg
         63Cw==
X-Gm-Message-State: APjAAAWa7CmWHiypEqMHANrUmen083Q+kuYTqsHJ18H7iBqZgKKPv6OB
        gxmQxY6n/+zwxNLkXwOkXowVaPKNrqTWogQw8Lz49A==
X-Google-Smtp-Source: APXvYqzUhlB9PtqR7NHp3xjUlZzNM07sATiI2jyj22GcPQlMzPRghy85v1lw9NAyqiJNqoBtVLmt7pKggR/ukGEFOfw=
X-Received: by 2002:aca:b506:: with SMTP id e6mr142694oif.39.1570466227052;
 Mon, 07 Oct 2019 09:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191003145542.17490-1-cyphar@cyphar.com> <20191003145542.17490-2-cyphar@cyphar.com>
In-Reply-To: <20191003145542.17490-2-cyphar@cyphar.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 7 Oct 2019 18:36:40 +0200
Message-ID: <CAG48ez2LuOGAXgKftZKfDKxhdb6xcBTdoK468-HXdcpxCW4r4w@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] symlink.7: document magic-links more completely
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 4:56 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> Traditionally, magic-links have not been a well-understood topic in
> Linux. Given the new changes in their semantics (related to the link
> mode of trailing magic-links), it seems like a good opportunity to shine
> more light on magic-links and their semantics.
[...]
> +++ b/man7/symlink.7
> @@ -84,6 +84,25 @@ as they are implemented on Linux and other systems,
>  are outlined here.
>  It is important that site-local applications also conform to these rules,
>  so that the user interface can be as consistent as possible.
> +.SS Magic-links
> +There is a special class of symlink-like objects known as "magic-links" which

I think names like that normally aren't hypenated in english, and
instead of "magic-links", it'd be "magic links"? Just like how you
wouldn't write "symbolic-link", but "symbolic link". But this is
bikeshedding, and if you disagree, feel free to ignore this comment.

> +can be found in certain pseudo-filesystems such as
> +.BR proc (5)
> +(examples include
> +.IR /proc/[pid]/exe " and " /proc/[pid]/fd/* .)
> +Unlike normal symlinks, magic-links are not resolved through

nit: AFAICS symlinks are always referred to as "symbolic links"
throughout the manpages.

> +pathname-expansion, but instead act as direct references to the kernel's own
> +representation of a file handle. As such, these magic-links allow users to
> +access files which cannot be referenced with normal paths (such as unlinked
> +files still referenced by a running program.)

Could maybe add "and files in different mount namespaces" as another
example here; at least for me, that's the main usecases for
/proc/*/root.

[...]
> +However, magic-links do not follow this rule. They can have a non-0777 mode,
> +which is used for permission checks when the final
> +component of an
> +.BR open (2)'s

Maybe leave out the "open" part, since the same restriction has to
also apply to other syscalls operating on files, like truncate() and
so on?

> +path is a magic-link (see
> +.BR path_resolution (7).)
