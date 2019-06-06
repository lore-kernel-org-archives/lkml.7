Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD1AC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DE7206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/nIJ9XV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfFFQvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:51:21 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40678 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfFFQvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:51:21 -0400
Received: by mail-qk1-f193.google.com with SMTP id c70so1877041qkg.7;
        Thu, 06 Jun 2019 09:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8kfH/p9w5fOEVub+27JCS8Z7PNh8HtMqCoYVK0Nmwk=;
        b=q/nIJ9XVwRlmf4TxaES13DvVRJsdhh4JoYAu+xzhVKv/px2vmX3KXcOr2vYbAUH8cP
         7+Zw25Z2eIjA1YOs1de8Ow8+V5aIUr3f4sO7iH3VghgvFe/IlvuprDPAeJY/dAt/QQGb
         e3PBt0/tEgtMKI7XW0gqlWO0jTXOjBUN9bNAvNXd5CTBW1GCAJXHkh46hL4WTIkw1YAR
         izuNLA69UWi0sBqryFkJqu1qR+W+uS8EyNKJqw7R206wLT9OPCzmzXS6/7FEmo+bD7Yi
         tAdUvNj/E36uuf1VYvI8VZ9es6mQoi5s/KjmnJplp+MUE4fJD2wVzNwImVDVgwMRF7Uq
         tl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8kfH/p9w5fOEVub+27JCS8Z7PNh8HtMqCoYVK0Nmwk=;
        b=fK6Il0FHPIttMZosat/1eCKWhvaJjqXu8UZZlrKZ3wIjLgjyeazJJQM4ovKB8S7O5I
         PzbuEwY9zvdht4CaRwLXI1QGeDdzsr8JxMEdvuYlBg57nYoF1GrsTd6O2gpl/PAS/PF4
         YZD2p/rzaW85TVRUkhea20eMjyxeyljq1b/UGNcRzRQ4nJ/Xt9RdZAsHwZO9vYtpkFbN
         AbkIiH22o0oRqnsoE4WH72goSIuHCQlAyhbITBEk9DYwDGrMe+h8rY69mvDNG/V/u9+8
         xDMELbQXIcOVXEgJZFaQ0wkJ4hZsnmm9ZLUKpPp4iqQFxhxdLbaWOJ5Abn3wby6Y/dQ6
         ZjHg==
X-Gm-Message-State: APjAAAWUI2AgOi0repse1enCBzLIBARqnw2Q5tWnUN5QRSVK1y29fD4Z
        AJ5Jp8c+lkw2se6SMtX7/zBzK9UzXOr2lspZq9ZDRQ==
X-Google-Smtp-Source: APXvYqy73a2R1Ge9q/w+QOUBx9Dq/x++7WAcMxkT+efJfMMjzYXz/0Wbx+FacrHn9liJVIqdmiNB8DwCM5wSt6CKlBo=
X-Received: by 2002:a05:620a:12f8:: with SMTP id f24mr20131508qkl.202.1559839880644;
 Thu, 06 Jun 2019 09:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190604224418.GA23187@embeddedor>
In-Reply-To: <20190604224418.GA23187@embeddedor>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 6 Jun 2019 09:51:09 -0700
Message-ID: <CAPhsuW5cBSsQemfBOyJ_kPLFbaiES8Koh2cvpy9AV4dMB68OJA@mail.gmail.com>
Subject: Re: [PATCH] md: raid10: Use struct_size() in kmalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Shaohua Li <shli@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 3:47 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>    int stuff;
>    struct boo entry[];
> };
>
> instance = kmalloc(size, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = kmalloc(struct_size(instance, entry, count), GFP_KERNEL);
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to my md-next tree.

Thanks,
Song

> ---
>  drivers/md/raid10.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index aea11476fee6..3caafd433163 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -4780,8 +4780,7 @@ static int handle_reshape_read_error(struct mddev *mddev,
>         int idx = 0;
>         struct page **pages;
>
> -       r10b = kmalloc(sizeof(*r10b) +
> -              sizeof(struct r10dev) * conf->copies, GFP_NOIO);
> +       r10b = kmalloc(struct_size(r10b, devs, conf->copies), GFP_NOIO);
>         if (!r10b) {
>                 set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>                 return -ENOMEM;
> --
> 2.21.0
>
