Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F95C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD32D2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfC0VXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:23:04 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34684 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbfC0VXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:23:00 -0400
Received: by mail-oi1-f196.google.com with SMTP id v10so9757316oib.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 14:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xA+J9+qxpjYrvLlBENyd15g25TWUXawOHVU0GWnQ7iI=;
        b=KoajO8FOLCWHCMU5dNnr0nlamfJNP3YIGLb0eMbGC9G4ei6M1bVv9tNc2Ffbl/GT0Z
         4pRvDh75UtLgA+9tDYuWqJ2Q4fxFOPhhUDO54DoBX0bD4tIjEcDn0ZYeV/6TaBR1fDV9
         xWxco+XpziFJgwiC5AL0JbUlU+cePhvZoKMrmH8RaD5tkS7nW6mNhjA7soYpOKK1xBYe
         UWGL5qAiYjTeL/E738u8mHS/SV7E26LISjWD0W3QSbQZ82PjJ/SudtIMuzRrGWgcg1It
         MoIUwhB8W6SfxGcsZwyuo8kzVSled6I47jRDl7v9KUIMxFZkQXSHzfQ9hPczcu0wNrCu
         Kpug==
X-Gm-Message-State: APjAAAVLO1g0C4COb58LCdpnI5dN3HKrrMHtxX+uXMZcBQgmWL7drZls
        UaFJY4IVoaHBq4lO0+MD7oZARkWsutV1xwFKX9X8vw==
X-Google-Smtp-Source: APXvYqzremYJFwcMf7BNHxK7Vhhh/+PUKR1Sws7vRhnuVJd98dQQg30XsS/jzIQjWNaVXGhT9cZf920u8HzC/3D11fY=
X-Received: by 2002:aca:5747:: with SMTP id l68mr21535254oib.103.1553721780041;
 Wed, 27 Mar 2019 14:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552665316.git.rgb@redhat.com> <700e4313571f86cc0cdcb7310fbe060f02c7c2db.1552665316.git.rgb@redhat.com>
In-Reply-To: <700e4313571f86cc0cdcb7310fbe060f02c7c2db.1552665316.git.rgb@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 27 Mar 2019 22:22:49 +0100
Message-ID: <CAFqZXNukuKkiVrw1Svm17dqkBAWW=dShwEzW89AZanWSQyZZBQ@mail.gmail.com>
Subject: Re: [PATCH ghak90 V5 06/10] audit: add support for non-syscall
 auxiliary records
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Simo Sorce <simo@redhat.com>,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>, nhorman@tuxdriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 7:34 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Standalone audit records have the timestamp and serial number generated
> on the fly and as such are unique, making them standalone.  This new
> function audit_alloc_local() generates a local audit context that will
> be used only for a standalone record and its auxiliary record(s).  The
> context is discarded immediately after the local associated records are
> produced.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

> ---
>  include/linux/audit.h |  8 ++++++++
>  kernel/audit.h        |  1 +
>  kernel/auditsc.c      | 35 ++++++++++++++++++++++++++++++-----
>  3 files changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index ebd6625ca80e..6db5aba7cc01 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -285,6 +285,8 @@ static inline void audit_log_contid(struct audit_context *context, u64 contid)
>
>  /* These are defined in auditsc.c */
>                                 /* Public API */
> +extern struct audit_context *audit_alloc_local(gfp_t gfpflags);
> +extern void audit_free_context(struct audit_context *context);
>  extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
>                                   unsigned long a2, unsigned long a3);
>  extern void __audit_syscall_exit(int ret_success, long ret_value);
> @@ -512,6 +514,12 @@ static inline void audit_fanotify(unsigned int response)
>  extern int audit_n_rules;
>  extern int audit_signals;
>  #else /* CONFIG_AUDITSYSCALL */
> +static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
> +{
> +       return NULL;
> +}
> +static inline void audit_free_context(struct audit_context *context)
> +{ }
>  static inline void audit_syscall_entry(int major, unsigned long a0,
>                                        unsigned long a1, unsigned long a2,
>                                        unsigned long a3)
> diff --git a/kernel/audit.h b/kernel/audit.h
> index c5ac6436317e..2a1a8b8a8019 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -111,6 +111,7 @@ struct audit_proctitle {
>  struct audit_context {
>         int                 dummy;      /* must be the first element */
>         int                 in_syscall; /* 1 if task is in a syscall */
> +       bool                local;      /* local context needed */
>         enum audit_state    state, current_state;
>         unsigned int        serial;     /* serial number for record */
>         int                 major;      /* syscall number */
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index f04e115df5dc..aa5d13b4fbbb 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -872,11 +872,13 @@ static inline void audit_free_aux(struct audit_context *context)
>         }
>  }
>
> -static inline struct audit_context *audit_alloc_context(enum audit_state state)
> +static inline struct audit_context *audit_alloc_context(enum audit_state state,
> +                                                       gfp_t gfpflags)
>  {
>         struct audit_context *context;
>
> -       context = kzalloc(sizeof(*context), GFP_KERNEL);
> +       /* We can be called in atomic context via audit_tg() */
> +       context = kzalloc(sizeof(*context), gfpflags);
>         if (!context)
>                 return NULL;
>         context->state = state;
> @@ -912,7 +914,8 @@ int audit_alloc_syscall(struct task_struct *tsk)
>                 return 0;
>         }
>
> -       if (!(context = audit_alloc_context(state))) {
> +       context = audit_alloc_context(state, GFP_KERNEL);
> +       if (!context) {
>                 kfree(key);
>                 audit_log_lost("out of memory in audit_alloc_syscall");
>                 return -ENOMEM;
> @@ -924,8 +927,29 @@ int audit_alloc_syscall(struct task_struct *tsk)
>         return 0;
>  }
>
> -static inline void audit_free_context(struct audit_context *context)
> +struct audit_context *audit_alloc_local(gfp_t gfpflags)
>  {
> +       struct audit_context *context = NULL;
> +
> +       if (!audit_ever_enabled)
> +               goto out; /* Return if not auditing. */
> +       context = audit_alloc_context(AUDIT_RECORD_CONTEXT, gfpflags);
> +       if (!context) {
> +               audit_log_lost("out of memory in audit_alloc_local");
> +               goto out;
> +       }
> +       context->serial = audit_serial();
> +       ktime_get_coarse_real_ts64(&context->ctime);
> +       context->local = true;
> +out:
> +       return context;
> +}
> +EXPORT_SYMBOL(audit_alloc_local);
> +
> +void audit_free_context(struct audit_context *context)
> +{
> +       if (!context)
> +               return;
>         audit_free_names(context);
>         unroll_tree_refs(context, NULL, 0);
>         free_tree_refs(context);
> @@ -935,6 +959,7 @@ static inline void audit_free_context(struct audit_context *context)
>         audit_proctitle_free(context);
>         kfree(context);
>  }
> +EXPORT_SYMBOL(audit_free_context);
>
>  static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>                                  kuid_t auid, kuid_t uid, unsigned int sessionid,
> @@ -2163,7 +2188,7 @@ void __audit_inode_child(struct inode *parent,
>  int auditsc_get_stamp(struct audit_context *ctx,
>                        struct timespec64 *t, unsigned int *serial)
>  {
> -       if (!ctx->in_syscall)
> +       if (!ctx->in_syscall && !ctx->local)
>                 return 0;
>         if (!ctx->serial)
>                 ctx->serial = audit_serial();
> --
> 1.8.3.1
>


-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
