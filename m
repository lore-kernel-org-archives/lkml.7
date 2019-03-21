Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D03AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6380721916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cuPhabid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfCUQcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:32:03 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40177 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfCUQcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:32:02 -0400
Received: by mail-vs1-f66.google.com with SMTP id z18so4034091vso.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vLLYpkhwyVCGB47ykaKDlKMTohTTzEK3L6YjFwu//CE=;
        b=cuPhabidKRd2ljsGTLkhICoT0iyC+EYQ1qxgBV5Z6QDSKstTtD8PGGTmJRhaIJaxXu
         LNe2J/QZto2E5FPiT+J1xuty+IJ+XVMXGf9x20Z3xNdqFLY662wqCPGJIDjslBevhgSA
         6d7OHDc+fOI/ZNuIFaymSv7f5Yiv0qO1snzzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vLLYpkhwyVCGB47ykaKDlKMTohTTzEK3L6YjFwu//CE=;
        b=edKPCTN8LASUkFhAy4dd9F3d/JlAqqmbg7MrLGI3Xt07VmKvr9dO1R65fLm8xjZeT/
         sZtyTqSIGtLnJZvA7I8UPtF3uAGTq5tnovdNUp4Jkw8Uh/dzLy3C+iTkV+DR6XJWkgFk
         M2GWWuMeos6P2GN7wtxRoKa1L7H/Sw0itGYpJG/60jWuDiNBcWbwC8GCo5r3bHfI9RQv
         HFZ+wVLjoP56SyBLQG+bcfTHzrgH5GvUDegM6qXb5Jqpeob4qcHFWEUnrb+hL+YFATVJ
         j2Ae2DI7QrOQGv1nDjzw3P8fJkXv+d2LrrO+580nelaB3Yxdx5KkKmLCIGYJ7FUo4FH0
         V2UA==
X-Gm-Message-State: APjAAAVYwXEFEY+001OF/OIDC707u9ZmhyANl+GYXZOQAQMTUF28RjjE
        E7UHMcM/Y8Ws2271BA74zWNDSHb1ZT0TNA==
X-Google-Smtp-Source: APXvYqyGS8MFJIBG2RSbd/gyrhNFjTGKieEFIxOTa9cQuvWkb2Yppu5s9Ht7NX1Pmm/93aaje8px0A==
X-Received: by 2002:a67:e3cf:: with SMTP id k15mr2726934vsm.185.1553185920665;
        Thu, 21 Mar 2019 09:32:00 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 190sm4904083vsz.0.2019.03.21.09.31.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 09:31:58 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id b8so2124744uaq.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:31:58 -0700 (PDT)
X-Received: by 2002:ab0:6294:: with SMTP id z20mr2435390uao.134.1553185917786;
 Thu, 21 Mar 2019 09:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <155316885201.29437.3428987891437242750.stgit@warthog.procyon.org.uk>
 <155316888615.29437.17558157678296689830.stgit@warthog.procyon.org.uk>
In-Reply-To: <155316888615.29437.17558157678296689830.stgit@warthog.procyon.org.uk>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Mar 2019 09:31:46 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJvSk=sJbjE+-6USvr4qXHxxwEOK64_FAWh74-eBkm+YQ@mail.gmail.com>
Message-ID: <CAGXu5jJvSk=sJbjE+-6USvr4qXHxxwEOK64_FAWh74-eBkm+YQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/8] vfs: Convert pstore to fs_context
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 4:48 AM David Howells <dhowells@redhat.com> wrote:
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Kees Cook <keescook@chromium.org>
> cc: Anton Vorontsov <anton@enomsg.org>
> cc: Colin Cross <ccross@android.com>
> cc: Tony Luck <tony.luck@intel.com>

Thanks for doing this conversion!

Acked-by: Kees Cook <keescook@chromium.org>

Some questions/nits below:

> +static int pstore_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +       struct pstore_fs_context *ctx = fc->fs_private;
> +       struct fs_parse_result result;
> +       int opt;
> +
> +       opt = fs_parse(fc, &pstore_fs_parameters, param, &result);
> +       if (opt < 0)
> +               return opt;
> +
> +       switch (opt) {
> +       case Opt_kmsg_bytes:
> +               ctx->kmsg_bytes = result.uint_32;
> +               break;
> +       }
>
> -       while ((p = strsep(&options, ",")) != NULL) {
> -               int token;
> +       return 0;
> +}
>
> -               if (!*p)
> -                       continue;
> +static void pstore_apply_param(struct fs_context *fc)
> +{
> +       struct pstore_fs_context *ctx = fc->fs_private;
>
> -               token = match_token(p, tokens, args);
> -               switch (token) {
> -               case Opt_kmsg_bytes:
> -                       if (!match_int(&args[0], &option))
> -                               pstore_set_kmsg_bytes(option);
> -                       break;
> -               }
> -       }
> +       pstore_set_kmsg_bytes(ctx->kmsg_bytes);
>  }

Why the separation between parse and apply now? Is this due to the
reconfigure calls? (i.e. why not call pstore_set_kmsg_bytes() in
pstore_parse_param()?

> @@ -416,14 +423,38 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
>                 return -ENOMEM;
>
>         pstore_get_records(0);
> -
>         return 0;
>  }

I prefer to keep a blank before "return", but no need to drop this
unless it gets a respin.

Thanks again!

-- 
Kees Cook
