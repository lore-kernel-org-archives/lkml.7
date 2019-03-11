Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9A6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CA120657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC2BJvDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfCKPtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:49:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40850 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfCKPtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:49:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id w6so4513851ljd.7;
        Mon, 11 Mar 2019 08:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkTwuSuUrvAfYTxhTtl3jPOWwSFwVfQ4XW4R9t4auyY=;
        b=fC2BJvDnqic4e5XV0AAUtmzHuGdeMFWq4JHpuC9MBVYskM0uJHVVlggkjnRikykH7S
         8/zkR2QhnPYCBSZWSlNYBvHfDkr9JHNR297W50P/Rs1w47MpmyxuZnP6QKGy3bNC5z3R
         8T1P63pH0ULs0niFUO+EogB6PpwWds2NwTzIgj54uBQtID0AYu8zlIS7zdpCgCL4RrNG
         1MdkJLXf9kGPeD3weOreSJGHOHHF1qlGGkSoRMwfMQSSVfbwU5J326z8XnUpJjavlUVo
         dkceL99vAcPcetiXizzmnA8e+c9XTI3mHPbRo7rht5d2RtyCRGc1NPL4xxIwAtqPPWy6
         ygYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkTwuSuUrvAfYTxhTtl3jPOWwSFwVfQ4XW4R9t4auyY=;
        b=JDbMipeVZhtZqLhAMUKrhpDjnzVI3ImQdohIBWQkCifAPspdXUasAgwC2NpehRDqp9
         cjATw9HTwofHh3eWH6FDCwmFZc3SBikoBR6R3LTnMmt5gYLw2kR5FSLvuO01MSk4CMw+
         DvdLb1YsGHdXVq3qq+/mxVqid81brcCg2I8yWqQVQPeZqfWH+Z99telcwU61BVVF5bWL
         /TYxMJaW8RQAvm517N+dVOXlh3FWrBNTmWvEMhS0YPwEwXo5PYsgXOJVI8GdKTr+40dJ
         ZkciVolUszPBBjFxk/7Ri28sg10CK8bc35Z9ZVLz0AHQF9uqFg3b2u60bEYekJvZH/5M
         6a/A==
X-Gm-Message-State: APjAAAUFG6BtXH3LXPM8+8YS4d3UueKrCW4DN6LeSZ/DEIGaoC7ESq6B
        9pJkDRgU8FVa/dZXuFlyeGxsd1dgVMMPIsgbe6V9Dw==
X-Google-Smtp-Source: APXvYqzZ63i54gDGq0YXX6eB+2k9v9Z9fJQ8xOjVABbpPwqoJVXGcNwZZaDM1JW3tOM0I7AEABXnpZocJ+yJwp9/5lQ=
X-Received: by 2002:a2e:9b99:: with SMTP id z25mr16634054lji.106.1552319372922;
 Mon, 11 Mar 2019 08:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <5c867e95.1c69fb81.4f15a.e5e4@mx.google.com>
In-Reply-To: <5c867e95.1c69fb81.4f15a.e5e4@mx.google.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 11 Mar 2019 21:19:19 +0530
Message-ID: <CAFqt6zb4yG6ZZ=Fh2dWc5GnxJA5T7BRAxjXXfRxdJ1dSn_QtUA@mail.gmail.com>
Subject: Re: [PATCH] fs/block_dev.c: Remove duplicate header
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 8:58 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Remove linux/dax.h which is included more than once.
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  fs/block_dev.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index cdda48f..8abcdb6 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -29,7 +29,6 @@
>  #include <linux/namei.h>
>  #include <linux/log2.h>
>  #include <linux/cleancache.h>
> -#include <linux/dax.h>
>  #include <linux/badblocks.h>
>  #include <linux/task_io_accounting_ops.h>
>  #include <linux/falloc.h>
> --
> 2.7.4
>
