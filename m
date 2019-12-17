Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1E6C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 17:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E50206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 17:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="zLFq+JLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfLQRj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:39:29 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:55295 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfLQRj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 12:39:29 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id f02a4d59
        for <linux-kernel@vger.kernel.org>;
        Tue, 17 Dec 2019 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=gjEGDPHzpB27JP7eId/5W93JMGs=; b=zLFq+J
        LIef3V13zXIQuObOOy+PS40Ja4mhsykFQbYVuD3rIBHJxQc+z/ZBwr7JaZc3wFN5
        21IzSZzhY8JQA/5iaYuyxwMeYgci3lbO9bhxeeVcTyf0dbRjrT5lwHL1KdgRcbtj
        0XjViephnChyI/9jYL2zrH4d9YNDo4aX7bxkAuqcFtYU/RnOS0AuZ6tzpETu2rcT
        LFEttiW8gcrekZFnz4cCq8IhIxZRBLWNNs/U+dyz4/Gx5FHGZx8Bg9NutY06MpEv
        n2sqIbx/0bzgnbb0C8fh6iLI8zQPplTPNVG06yvcsf0htajS7xL5Hwa4fBwR8KJ8
        MyrEfobs+ru5KWUA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 94a97e0b (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 17 Dec 2019 16:42:59 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id w1so32619otg.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 09:39:27 -0800 (PST)
X-Gm-Message-State: APjAAAXG5WqkBpKFWkzQhZcuQYydbTQX/EprgA/hDJHvphOBKVXOGFm6
        4GaF4Emz8XYpmyMkhhKZa7AW0rpc4ym3t53C36U=
X-Google-Smtp-Source: APXvYqwZI6jzltaaQmdWoNpPxor92AkiXyOpIylpZAh8aLfyDAzSI1vovdG09uzDKOwqTk6rYNphFMeFdpQ6r0PHEgg=
X-Received: by 2002:a9d:1e88:: with SMTP id n8mr40257798otn.369.1576604366364;
 Tue, 17 Dec 2019 09:39:26 -0800 (PST)
MIME-Version: 1.0
References: <20191217172455.186395-1-Jason@zx2c4.com>
In-Reply-To: <20191217172455.186395-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 17 Dec 2019 18:39:15 +0100
X-Gmail-Original-Message-ID: <CAHmME9rdx_mvXjRk6E43s1MMjQCRbsALACoKRKBemMwFtO_rMQ@mail.gmail.com>
Message-ID: <CAHmME9rdx_mvXjRk6E43s1MMjQCRbsALACoKRKBemMwFtO_rMQ@mail.gmail.com>
Subject: Re: [PATCH] random: don't forget compat_ioctl on unrandom
To:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ooof, typing too fast. "unrandom" in the subject should be "urandom", of course.

On Tue, Dec 17, 2019 at 6:25 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Recently, there's been some compat ioctl cleanup, in which large
> hardcoded lists were replaced with compat_ptr_ioctl. One of these
> changes involved removing the random.c hardcoded list entries and adding
> a compat ioctl function pointer to the random.c fops. In the process,
> urandom was forgotten about, so this commit fixes that oversight.
>
> Fixes: 507e4e2b430b ("compat_ioctl: remove /dev/random commands")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 909e0c3d82ea..cda12933a17d 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -2175,6 +2175,7 @@ const struct file_operations urandom_fops = {
>         .read  = urandom_read,
>         .write = random_write,
>         .unlocked_ioctl = random_ioctl,
> +       .compat_ioctl = compat_ptr_ioctl,
>         .fasync = random_fasync,
>         .llseek = noop_llseek,
>  };
> --
> 2.24.1
