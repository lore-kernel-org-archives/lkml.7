Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7415C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9DC2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tf3Get4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbfJNPjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:39:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33370 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbfJNPjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:39:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id a15so14133510oic.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hUnyvpuP6/HkBMSiwtb5MS7vmorhboIr5Cucxcuf8O4=;
        b=tf3Get4qoIzO39iWyOCRegFp1wY/dzAobHeBdf2VA+8pw3oS7q1F2IvIw6nkg3OFX8
         F52Y2qTRW1vOzUC69B3PjcYdqNMNkS8ARtcRvIhTZhp0Y9EvPL3iiCtc3KuWJUMDZBbr
         4KjUbkltVWZcLU3sPz2wnmO7B8UNdUOXLyK3DcO+64luJBp44YYRzG3XBXo+PPoIvusg
         aMefEtXMJnH1iBF71IodEUiM/Q1k0gqyau8N9LGuq7lcmSrtL8I1gGq0Pn5RjwpM3+hS
         i1FPYiz/Ahj0pNmlgA1mBNABGuSVs+2gCKHOWqwIa871YMYgf/FRN55VJS4lUKxCsi5B
         0WZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hUnyvpuP6/HkBMSiwtb5MS7vmorhboIr5Cucxcuf8O4=;
        b=VXFTE7beO9c0IMuHRSkHTCmsZKmpVQgm3bRIR04tZQ858vEo0x+BZptGgN+gkgsflB
         FioPSocOTFOzdFkrjf/u+fnpPJ7Cos03GTTHXu2CueQGJYWPpE4IvESS5pTsyb4MoDbH
         9kqnPqWSnKE6QlRXTRWHHdzTmSGJFk8BaW6kJFVmbyINq7XbjA/88XamWuv0qQDUqvm/
         3IOHIG1rki38s/c724YldwezS1jazODoFjx023PYar1Dcbt9KkHUAPzuK7jzvNtbTYSg
         /TrUVulUoKCp5Df8mcPPeQ3iS6HAoxAT1E1cqC44Nbwd4lvCRsdvX4cnPOEZGZN/T85u
         wsWA==
X-Gm-Message-State: APjAAAWAsPIvpRCwEYJrGux3r+cZqD3OrrUNNoJO5aYuQ93+1lTQ4LPx
        u93wpFwDIXx3G7wmhBC9j/SLVGrRAUeyZR8EQ891eA==
X-Google-Smtp-Source: APXvYqzlapnRWtDbK3b6aprG708THmDneKBseQVBxn9YWloRQP7Qc5j44+rxOMdffE3xnRJL3og0OsxxQYOLitd7CLk=
X-Received: by 2002:aca:da41:: with SMTP id r62mr24035154oig.47.1571067553182;
 Mon, 14 Oct 2019 08:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-2-dancol@google.com>
In-Reply-To: <20191012191602.45649-2-dancol@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 14 Oct 2019 17:38:45 +0200
Message-ID: <CAG48ez3yOPAC3mTJdQ5_8aARQPe+siid5jaa8U+aMtfj-bUJ2g@mail.gmail.com>
Subject: Re: [PATCH 1/7] Add a new flags-accepting interface for anonymous inodes
To:     Daniel Colascione <dancol@google.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>, nosh@google.com,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 9:16 PM Daniel Colascione <dancol@google.com> wrote:
> Add functions forwarding from the old names to the new ones so we
> don't need to change any callers.

This patch does more than the commit message says; it also refactors
the body of the function. (I would've moved that refactoring over into
patch 2, but I guess this works, too.)

[...]
> -struct file *anon_inode_getfile(const char *name,
> -                               const struct file_operations *fops,
> -                               void *priv, int flags)
> +struct file *anon_inode_getfile2(const char *name,
> +                                const struct file_operations *fops,
> +                                void *priv, int flags, int anon_inode_flags)

(AFAIK, normal kernel style is to slap a "__" prefix in front of the
function name instead of appending a digit, but I guess it doesn't
really matter.)

>  {
> +       struct inode *inode;
>         struct file *file;
>
> -       if (IS_ERR(anon_inode_inode))
> -               return ERR_PTR(-ENODEV);
> -
> -       if (fops->owner && !try_module_get(fops->owner))
> -               return ERR_PTR(-ENOENT);
> +       if (anon_inode_flags)
> +               return ERR_PTR(-EINVAL);
>
> +       inode = anon_inode_inode;
> +       if (IS_ERR(inode))
> +               return ERR_PTR(-ENODEV);
>         /*
> -        * We know the anon_inode inode count is always greater than zero,
> -        * so ihold() is safe.
> +        * We know the anon_inode inode count is always
> +        * greater than zero, so ihold() is safe.
>          */

This looks like maybe you started editing the comment, then un-did the
change, but left the modified line wrapping in your patch? Please
avoid that - code changes with no real reason make "git blame" output
more annoying and create trouble when porting patches between kernel
versions.

[...]
>  EXPORT_SYMBOL_GPL(anon_inode_getfile);
> +EXPORT_SYMBOL_GPL(anon_inode_getfile2);
[...]
>  EXPORT_SYMBOL_GPL(anon_inode_getfd);
> +EXPORT_SYMBOL_GPL(anon_inode_getfd2);

Since anon_inode_getfd() is now a static inline function in
include/linux/anon_inodes.h, exporting it doesn't make sense anymore.
Same for anon_inode_getfile().

[...]
> +#define ANON_INODE_SECURE 1

That #define belongs in a later patch, right?
