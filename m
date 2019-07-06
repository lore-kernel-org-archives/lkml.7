Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1E8C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 18:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8600A2070D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 18:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UjWcfa2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfGFSVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 14:21:03 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39643 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfGFSVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 14:21:03 -0400
Received: by mail-ot1-f66.google.com with SMTP id r21so7395135otq.6
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vjy9ZMLMCWdJezrwnUnOrpuuoAl0MqUTiwkUbUfsV0k=;
        b=UjWcfa2yuiQr3pr6jvHS9G7b7/XrW6vhOl4h4FyA2pkmQyD/Ukwh09WsYtkSmGlf36
         NaUNZYVoR4bKyHeWOylNLEXv5vLpalbjvzXxCYVwPOWxoj3K9lMpnkwGWJIVWHgk/Aam
         fgp58HCVxZAA3ggPprt8eU47o+2iD3IHtRrmkvzuzEKjw9xrg42OYiz27ZrFCVg3ZiAw
         PPhz7cmQ8J6Y7yCj4QkHQyabon240CsqoSLHPPTtKWV93yHoxLdYcTf8yeghcgy4y7Y1
         B9Juh+11Z1nJ1KPi3G3ufLi7AjloCOX15qfZkMELt6FbO4ouAg7q+pMykjE4c8bjWO5z
         4bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjy9ZMLMCWdJezrwnUnOrpuuoAl0MqUTiwkUbUfsV0k=;
        b=kqCbTwTxxOvd7kWLOpLn9dR8+9eF8eaQZSL1sR4JVYPK8AlGVxuOkrtnEEWf6t56tY
         ANDB4KDEZgo7PS5c/GNaYqUyLCrby9XB2KylA6rvd3m6TDLEj5VN77wWnIix1a0kIZMp
         HMiNLEwM8tKR0pDgf7QEZRW4JwkP6BcCnxM5jXTqdMSYy5ZF19vawgTtVHPBK0SbC3Ae
         QUg1LmXQ3nDd2yyTmyPYxbftlaMFUdYbxB0VARnmBk46hFV4ZKA+ok3Y6lR2FGimw6li
         UqYUQDqu2dQ2TcupJsbAhxKq3fbz5QYVFoyZi9ubLqlk9JFGg0wfzNtbI+i09beuUllt
         boHw==
X-Gm-Message-State: APjAAAVuL3U0JQAFR3zqHG2DlvkExlXfj9307rWAxp/wQ5B/u4Nn7RDF
        zHnPAlBKH4xurKqMmxLvJ0t9Y9tSiLdw1Kd0upLhWx38a9w=
X-Google-Smtp-Source: APXvYqzj5WEE2VrNr3N+Gwhig3lJufmMH6pDUKtfm7kJ7qx1O0a+Ca76u4RhV3hyGQEys/0AWVBDs6sVNq/tKZ0qalw=
X-Received: by 2002:a9d:5a91:: with SMTP id w17mr4400771oth.32.1562437262037;
 Sat, 06 Jul 2019 11:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com> <1562410493-8661-12-git-send-email-s.mesoraca16@gmail.com>
In-Reply-To: <1562410493-8661-12-git-send-email-s.mesoraca16@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 6 Jul 2019 20:20:35 +0200
Message-ID: <CAG48ez0uFX4AniOk1W0Vs6j=7Q5QfSFQTrBBzC2qL2bpWn_yCg@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] S.A.R.A.: /proc/*/mem write limitation
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        James Morris <james.l.morris@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 6, 2019 at 12:55 PM Salvatore Mesoraca
<s.mesoraca16@gmail.com> wrote:
> Prevent a task from opening, in "write" mode, any /proc/*/mem
> file that operates on the task's mm.
> A process could use it to overwrite read-only memory, bypassing
> S.A.R.A. restrictions.
[...]
> +static void sara_task_to_inode(struct task_struct *t, struct inode *i)
> +{
> +       get_sara_inode_task(i) = t;

This looks bogus. Nothing is actually holding a reference to `t` here, right?

> +}
> +
>  static struct security_hook_list data_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(cred_prepare, sara_cred_prepare),
>         LSM_HOOK_INIT(cred_transfer, sara_cred_transfer),
>         LSM_HOOK_INIT(shm_alloc_security, sara_shm_alloc_security),
> +       LSM_HOOK_INIT(task_to_inode, sara_task_to_inode),
>  };
[...]
> +static int sara_file_open(struct file *file)
> +{
> +       struct task_struct *t;
> +       struct mm_struct *mm;
> +       u16 sara_wxp_flags = get_current_sara_wxp_flags();
> +
> +       /*
> +        * Prevent write access to /proc/.../mem
> +        * if it operates on the mm_struct of the
> +        * current process: it could be used to
> +        * bypass W^X.
> +        */
> +
> +       if (!sara_enabled ||
> +           !wxprot_enabled ||
> +           !(sara_wxp_flags & SARA_WXP_WXORX) ||
> +           !(file->f_mode & FMODE_WRITE))
> +               return 0;
> +
> +       t = get_sara_inode_task(file_inode(file));
> +       if (unlikely(t != NULL &&
> +                    strcmp(file->f_path.dentry->d_name.name,
> +                           "mem") == 0)) {

This should probably at least have a READ_ONCE() somewhere in case the
file concurrently gets renamed?

> +               get_task_struct(t);
> +               mm = get_task_mm(t);
> +               put_task_struct(t);

Getting and dropping a reference to the task_struct here is completely
useless. Either you have a reference, in which case you don't need to
take another one, or you don't have a reference, in which case you
also can't take one.

> +               if (unlikely(mm == current->mm))
> +                       sara_warn_or_goto(error,
> +                                         "write access to /proc/*/mem");

Why is the current process so special that it must be protected more
than other processes? Is the idea here to rely on other protections to
protect all other tasks? This should probably come with a comment that
explains this choice.

> +               mmput(mm);
> +       }
> +       return 0;
> +error:
> +       mmput(mm);
> +       return -EACCES;
> +}
