Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEBCCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFAF20874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nu+IXLvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfJ3KaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 06:30:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33023 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfJ3KaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:30:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id c184so1309408pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 03:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K9dz1flpb3x7Oxzcj/V7nFSU5z6F4ELP/G1doRSrpMo=;
        b=nu+IXLvmOAq7s8CzjblbRsMl9s1YCbJSabDqRwE0hwrJ/jWNE1VoJNn3CtNpshp7bn
         KAvU7g5AuzoxbYtLNYtVdACU8ywpdh9X11ZxVCB1iHnj9gPma3cF5VcA7v2PD7HuUNeN
         jx/lj6aQqxFULwQ0gfSJBWxNUDmtLTW8RpK+riRVkADQNw1fEVuaeJ8GjGnaR7QXT2Q6
         bbX+6MDCMBKwe+5CW35hCXo3Bm+oJd+bo9/eiyxVb7MvHsXrqd+MgE/+eISN3F6vtmOf
         JAZKTj75qbzIFmsYgkBZA3wDd0FnzQpG4Rj3uj1wQLmw0WlJA4N37k8kxR8uVk1065jw
         0yXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K9dz1flpb3x7Oxzcj/V7nFSU5z6F4ELP/G1doRSrpMo=;
        b=FJ8QgW8E7G5f47vrugV8oPWqSssStUC81iPUHSigjM5f3x/+/ZwDp0EshEHIQIJaiw
         QvA4uScnhUjBq9z/lPCFqLqv7dU6J5TlZSxDuF7Pjemhl+RUEXSJsbvU3u3EXPMI9FTZ
         1AWNPKbR39YWSS4Is6SOfDbyjexrazB55fCtLGhJvK/a5z9w9+O7kb3Ztlmuc/2xjdWw
         YxxxhLS9g2ulHf4I7Uo9WJHDuh+glHjR3SMLU4Io+0jHLTenMHnNyjuEp8MkzkD0xNax
         BcAdXuek/WxArqH7hMBWmi09IqZixFqomdjqlPx/If994FcFCsOwbASE7/5gGtm4A9M9
         d82A==
X-Gm-Message-State: APjAAAXV9U+4VzcgKuHIUj8+YvmDuNTo9VAIeZfkxIgaQd0U6KmLF10f
        lEn27T7tVW1Nkb5PuID9MULYD/J/SnuoyJ+3Wzc=
X-Google-Smtp-Source: APXvYqwpQBaz98Y/9V9H6sJ1Db37/4ZcSGCis4zDiJBavLcl0GEgrodGSi2UtX77t+2DyWsFZLFrE7IN/tTNVFhDrr0=
X-Received: by 2002:a17:90a:714a:: with SMTP id g10mr12870225pjs.13.1572431406696;
 Wed, 30 Oct 2019 03:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <1572423756-59943-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1572423756-59943-1-git-send-email-zhongjiang@huawei.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Wed, 30 Oct 2019 19:29:55 +0900
Message-ID: <CAC5umygBcEic4HXCWfFKj0ZJHo8RRzPkO959051eYoH7y4C39A@mail.gmail.com>
Subject: Re: [PATCH] fault-inject: use DEFINE_DEBUGFS_ATTRIBUTE to define
 debugfs fops
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B410=E6=9C=8830=E6=97=A5(=E6=B0=B4) 17:26 zhong jiang <zhongjian=
g@huawei.com>:
>
> It is more clear to use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs file
> operation rather than DEFINE_SIMPLE_ATTRIBUTE.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  lib/fault-inject.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/fault-inject.c b/lib/fault-inject.c
> index 8186ca8..4e61326 100644
> --- a/lib/fault-inject.c
> +++ b/lib/fault-inject.c
> @@ -164,7 +164,7 @@ static int debugfs_ul_get(void *data, u64 *val)
>         return 0;
>  }
>
> -DEFINE_SIMPLE_ATTRIBUTE(fops_ul, debugfs_ul_get, debugfs_ul_set, "%llu\n=
");
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_ul, debugfs_ul_get, debugfs_ul_set, "%llu\=
n");
>
>  static void debugfs_create_ul(const char *name, umode_t mode,
>                               struct dentry *parent, unsigned long *value=
)

Nowadays we have debugfs_create_ulong(), so should we use it instead of
debugfs_create_ul() defined in this file and remove the definision
altogether?
