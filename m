Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2457C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10162173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFMJqLm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfGSNhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:37:51 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45445 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbfGSNhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:37:51 -0400
Received: by mail-io1-f66.google.com with SMTP id g20so58436971ioc.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 06:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZjbY0MaT6UAbPH1wjXD/28Vzvm/xrV41gWCDtH/Zgc=;
        b=CFMJqLm8STRXF20f8x5Scl80Jvrnq7e0wqiZJfZxXCAu1VhsIA7eBko5wd6eS1OEw5
         Uy42PvzmsnI6FwM+axqYz7Z0vY/owPz8hNge4q2iBf83vDVxqykAPd9hYOApcMK1qBS3
         uGbARDadMZv8c5LxATRua3tUulE9864iGWNLvMcWHARqCqc5JXtOY94tt9uiai/RzmeT
         mvA/lO4xITNKXLoA/VoHsaifsLyUiK0F5TAQIZPBhwD0JxESy+nqp34n2YIyYLQHqXKg
         WtDdkR5UMBB32tTcmiwCZ7NLWASFIRaCZzeVODmLvm7KNg2STC1hcyjQcXWsYgLk2Ifg
         Sj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZjbY0MaT6UAbPH1wjXD/28Vzvm/xrV41gWCDtH/Zgc=;
        b=AJaBAOLBL1GTz0PrzJ47PSMCdT3epD3DsLgigUB2bA/K6N2X1XwUMEB+hehdV8qmm7
         CeTlgG7jTEv/LkRVlZ8TtZCVv02BJA8m931WIh+6gfeGGkhM5lI6ypKKhbssNeTKy8j0
         3gtN2zeqzx3TwVNZqZdWq8QERJkgNxzcH6jMskxL0uJzxsY3h2Iz6zjcIUTTUFZ6VHkJ
         W1z5TkkW0fNh1Mb3gvTYHOPtPUjq4liyk12+/cn84z8DIJSFZUYt/XPHiwDieMunmMKv
         g+pNln0xG6cVva+WukRMmXtNIb7264rqDaJIOMDeadF26D9wao1NJdmA4U+kDWATpNwD
         v6vg==
X-Gm-Message-State: APjAAAXeN/hhcUnRoSV/W0+Tlo3A/Pzh2iH9tVNmCdriWjioGLGtuqTE
        AEbLMz0XC2sOZw7KdDI24Ow+AJ/nunXk0FSRjYUXqw==
X-Google-Smtp-Source: APXvYqyBhZpTSPfvsPmtieVyZpieljJsIsnw3wZLtW5Q7oA/SdVcTnOz10NqjvVRw9/mQWgrE57FGHsmh11BaU/x1Us=
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr26351958ior.231.1563543470069;
 Fri, 19 Jul 2019 06:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190719124329.23207-1-nh26223.lmm@gmail.com>
In-Reply-To: <20190719124329.23207-1-nh26223.lmm@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 19 Jul 2019 15:37:37 +0200
Message-ID: <CACT4Y+aVS5nn0Pv31tAOujcAPvCAOuK_iPZ1CCNbgAOL=JDvvg@mail.gmail.com>
Subject: Re: [PATCH] fs: fs_parser: avoid NULL param->string to kstrtouint
To:     Yin Fengwei <nh26223.lmm@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 2:44 PM Yin Fengwei <nh26223.lmm@gmail.com> wrote:
>
> syzbot reported general protection fault in kstrtouint:
> https://lkml.org/lkml/2019/7/18/328
>
> From the log, if the mount option is something like:
>    fd,XXXXXXXXXXXXXXXXXXXX
>
> The default parameter (which has NULL param->string) will be
> passed to vfs_parse_fs_param. Finally, this NULL param->string
> is passed to kstrtouint and trigger NULL pointer access.
>
> Reported-by: syzbot+398343b7c1b1b989228d@syzkaller.appspotmail.com
> Fixes: 71cbb7570a9a ("vfs: Move the subtype parameter into fuse")
>
> Signed-off-by: Yin Fengwei <nh26223.lmm@gmail.com>
> ---
>  fs/fs_parser.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index d13fe7d797c2..578e6880ac67 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -210,6 +210,10 @@ int fs_parse(struct fs_context *fc,
>         case fs_param_is_fd: {
>                 switch (param->type) {
>                 case fs_value_is_string:
> +                       if (result->has_value) {

!result->has_value ?

> +                               goto bad_value;
> +                       }
> +
>                         ret = kstrtouint(param->string, 0, &result->uint_32);
>                         break;
>                 case fs_value_is_file:
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20190719124329.23207-1-nh26223.lmm%40gmail.com.
