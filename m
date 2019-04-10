Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A302CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646CB2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E9gnJVUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387808AbfDJQ1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:27:01 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39797 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730614AbfDJQ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:27:00 -0400
Received: by mail-ua1-f65.google.com with SMTP id d5so987043uan.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 09:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RGqWd5s2z6twzy3qMbCU3gfqqHA/VTihRqe1wZ4RTtA=;
        b=E9gnJVUtMzsmf5rEACunC74b4NvUmMxRKKstD0MEOfGYfSWUcIWFiJSPJnbwfbjOFc
         aD0o75AWKlg92da2NVPisryx8XdC4Vw9m04sdHyZOWMED4/lmbb2aoKxZO3LSjElsXW/
         E4Z0lg6C2FfGLHAdisUsa8OiwULoAiSLtmSws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGqWd5s2z6twzy3qMbCU3gfqqHA/VTihRqe1wZ4RTtA=;
        b=nYfz/hfCtY5YrJTc6L87h2THREzWu8XAsmadEtfys0guAoMmrSraqdTgopcQY7ltGL
         r0kVxGTn8kDK7NLkejCVjtzu4F100OockGDybjm52Ygcn+Wshwim0IheT0FjX2Myu/Fh
         M0zIqevu8vttqZehfiEmRaHPnNurDaOmWBbt9ou4fXDy4t0pgqR4Oyy0G4LXR/qmbShQ
         6IBrk6ev2rzjfSxvWv7x7isAroTcbpBfg0euAONVa7nH6Vq8ekf4vLEdHpmajx31A/Q3
         Z/65qkDZ3ay19WDjinyXIx/l/FaY+AtTHDFxE9D2dZvOIATFUNJ81bzprGzCkwWTqNt0
         qS8w==
X-Gm-Message-State: APjAAAWK/3wZo68vhTGwqT1LaoTCOA6gWqi3qv0tBXQztsBWeajvP899
        gtNw4vAKGr2n3L07q1b1krcX59Ee5WQ=
X-Google-Smtp-Source: APXvYqynMhNncPp/uwx9BR/ACtWDnJSsaXU24QVvPfhbHwig/NKAUNwqZIVSR3lKQ11ewMcFSISSBA==
X-Received: by 2002:ab0:70d4:: with SMTP id r20mr7119005ual.67.1554913618913;
        Wed, 10 Apr 2019 09:26:58 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 2sm14376864vke.27.2019.04.10.09.26.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:26:57 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id c6so992011uan.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 09:26:56 -0700 (PDT)
X-Received: by 2002:ab0:4eaa:: with SMTP id l42mr18185593uah.80.1554913615771;
 Wed, 10 Apr 2019 09:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190410011418.76408-1-joel@joelfernandes.org>
In-Reply-To: <20190410011418.76408-1-joel@joelfernandes.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 09:26:44 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKs6Ag2L+GYEVYAzPky1pLntZt-Tc5ki-pqjVoyCWgxxg@mail.gmail.com>
Message-ID: <CAGXu5jKs6Ag2L+GYEVYAzPky1pLntZt-Tc5ki-pqjVoyCWgxxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] module: Prepare for addition of new ro_after_init sections
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Android Kernel Team <kernel-team@android.com>,
        Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 6:14 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> For the purposes of hardening modules by adding sections to
> ro_after_init sections, prepare for addition of new ro_after_init
> entries which we do in future patches. Create a table to which new
> entries could be added later. This makes it less error prone and reduce
> code duplication.
>
> Cc: paulmck@linux.vnet.ibm.com
> Cc: rostedt@goodmis.org
> Cc: mathieu.desnoyers@efficios.com
> Cc: rcu@vger.kernel.org
> Cc: kernel-hardening@lists.openwall.com
> Cc: kernel-team@android.com
> Suggested-by: keescook@chromium.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> ---
>  kernel/module.c | 42 ++++++++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/module.c b/kernel/module.c
> index 524da609c884..f9221381d076 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3300,11 +3300,28 @@ static bool blacklisted(const char *module_name)
>  }
>  core_param(module_blacklist, module_blacklist, charp, 0400);
>
> +/*
> + * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
> + * layout_sections() can put it in the right place.
> + * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
> + */
> +static char *ro_after_init_sections[] = {

static const char * const ... Need to make sure the table and its
strings can't be changed. :)

> +       ".data..ro_after_init",
> +
> +       /*
> +        * __jump_table structures are never modified, with the exception of
> +        * entries that refer to code in the __init section, which are
> +        * annotated as such at module load time.
> +        */
> +       "__jump_table",
> +       NULL

Since this table is known at build time, you don't need a NULL
terminator, you can use ARRAY_SIZE() instead.

> +};
> +
>  static struct module *layout_and_allocate(struct load_info *info, int flags)
>  {
>         struct module *mod;
>         unsigned int ndx;
> -       int err;
> +       int err, i;
>
>         err = check_modinfo(info->mod, info, flags);
>         if (err)
> @@ -3319,23 +3336,12 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>         /* We will do a special allocation for per-cpu sections later. */
>         info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
>
> -       /*
> -        * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
> -        * layout_sections() can put it in the right place.
> -        * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
> -        */
> -       ndx = find_sec(info, ".data..ro_after_init");
> -       if (ndx)
> -               info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
> -       /*
> -        * Mark the __jump_table section as ro_after_init as well: these data
> -        * structures are never modified, with the exception of entries that
> -        * refer to code in the __init section, which are annotated as such
> -        * at module load time.
> -        */
> -       ndx = find_sec(info, "__jump_table");
> -       if (ndx)
> -               info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
> +       /* Set sh_flags for read-only after init sections */
> +       for (i = 0; ro_after_init_sections[i]; i++) {

i.e. for (i = 0; i < ARRAY_SIZE(ro_after_init_sections); i++)

> +               ndx = find_sec(info, ro_after_init_sections[i]);
> +               if (ndx)
> +                       info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
> +       }
>
>         /* Determine total sizes, and put offsets in sh_entsize.  For now
>            this is done generically; there doesn't appear to be any

Otherwise, yeah, looks good to me.

-- 
Kees Cook
