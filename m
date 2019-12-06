Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81107C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3352173E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfLFKZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:25:50 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:58914 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726213AbfLFKZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:25:50 -0500
Received: from mr5.cc.vt.edu (mr5.cc.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xB6APkUK015183
        for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2019 05:25:46 -0500
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xB6APfMr019712
        for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2019 05:25:46 -0500
Received: by mail-qk1-f199.google.com with SMTP id d26so4136936qkk.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 02:25:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=iTp7Q0LC13BTmcaDzvUDNCKm0YiwERAvXAhvOGv2zyA=;
        b=MLAPfV52vvQASTybEtziCIdCJDzoIXZaZ/muuOXo2SwJ/tCpWIQXrn+pR0faVnXgZW
         fBX27/GMdePYuQOTwWQg2az08TF0tLI9EfKO5aOttThfmYiUwGm1BvoUZqmR1NhYuHQ8
         ts1i1rGqGG9y+Zj0kV+uIm90wgran3Jrhhq7jKCz52iYtOdffE8h5hPFCk0kpR1U0wMf
         hLzW5FRuGIVYTcBZezQ+vkKBPF1xug3+eurfWMBIHvUtdL1Ksx1Ce3OokerfJ4UyIQyS
         fUGadfHwps0w9fUCC0arwTTuCvX5GtFM+SeQ4CjtUNC8PKtGa2kJeX9mlaSZHnWscP2Z
         Lofw==
X-Gm-Message-State: APjAAAUP1U85dBkne7duh16gzqXBvhONW49PrXUKam7KEASMnfFOjlS6
        qLDBlkzvs1X0ns2YBZKZ6yU0oMlwGV+iUusNGxfAAqvdicv7kZVuNs7iKjxvNvzRxooNbwXKMRF
        nUs3QlE0+DYq5LWKiJFcC+rXI7Qwlgr5nUPU=
X-Received: by 2002:a37:9a46:: with SMTP id c67mr13155669qke.308.1575627941395;
        Fri, 06 Dec 2019 02:25:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZMU1mUOXObYclXm7ZUlvWykdYorRU6QPSIvyLh9zuWYWu9hVyLbbLi31cMFkuAxTzO96NMg==
X-Received: by 2002:a37:9a46:: with SMTP id c67mr13155652qke.308.1575627941082;
        Fri, 06 Dec 2019 02:25:41 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 62sm5700268qkk.102.2019.12.06.02.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 02:25:39 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Namjae Jeon <namjae.jeon@samsung.com>
cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, linkinjeon@gmail.com,
        Markus.Elfring@web.de, sj1557.seo@samsung.com, dwagner@suse.de,
        nborisov@suse.com
Subject: Re: [PATCH v5 02/13] exfat: add super block operations
In-reply-to: <20191125000326.24561-3-namjae.jeon@samsung.com>
References: <20191125000326.24561-1-namjae.jeon@samsung.com> <CGME20191125000628epcas1p28c532d9b7f184945c40e019ce9ef0dd0@epcas1p2.samsung.com>
 <20191125000326.24561-3-namjae.jeon@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Fri, 06 Dec 2019 05:25:38 -0500
Message-ID: <81423.1575627938@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Nov 2019 19:03:15 -0500, Namjae Jeon said:
> This adds the implementation of superblock operations for exfat.

>  fs/exfat/super.c | 738 +++++++++++++++++++++++++++++++++++++++++++++++

> +static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
> +{
> +	struct exfat_sb_info *sbi = sb->s_fs_info;
> +	struct exfat_mount_options *opts = &sbi->options;
> +	struct inode *root_inode;
> +	int err;
> +
> +	if (opts->allow_utime == -1)
> +		opts->allow_utime = ~opts->fs_dmask & 0022;

This throws a warning when building with W=1:

  CC [M]  fs/exfat/super.o
fs/exfat/super.c: In function 'exfat_fill_super':
fs/exfat/super.c:552:24: warning: comparison is always false due to limited range of data type [-Wtype-limits]
  552 |  if (opts->allow_utime == -1)
      |                        ^~

which means that opts->allow_utime will never get set. Except for
the use of -1 to show an uninitialized value, all the other uses  don't
care about sign/unsigned, so let's make it signed....

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

--- a/fs/exfat/exfat_fs.h	2019-12-06 05:17:58.344590227 -0500
+++ b/fs/exfat/exfat_fs.h	2019-12-06 05:18:25.429222169 -0500
@@ -210,7 +210,7 @@
 	unsigned short fs_fmask;
 	unsigned short fs_dmask;
 	/* permission for setting the [am]time */
-	unsigned short allow_utime;
+	short allow_utime;
 	/* charset for filename input/display */
 	char *iocharset;
 	unsigned char utf8;


