Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3046C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FB720856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Go9MIwE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfDAOuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:50:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37286 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfDAOuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:50:08 -0400
Received: by mail-lj1-f196.google.com with SMTP id v13so8457917ljk.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 07:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Coo03ipoUMnJ4xj5TqhJFPQMyWUkyhuF806s2eM2rEg=;
        b=Go9MIwE7iRiUd2uRhh1y5zEDnXqEtbUz4ViYuuWnd6gb34enrAGi90xnzj7xFijXoN
         GnheUgsyUtI9HxDWVkkSpoyx9LSiwwPOlFmo0QPDy5CGyU361/De3n/90W3qV38xx1cq
         qXLuXuyoM0L19v6+pFxLrK7lK2eW71CkIHuArT8muQ8LX2M1oo+VM1SysIjAtmfDo/NK
         F2rqEoWtbmL7thlEaZjXjPRXe0FvQ68/2WAfepjhR98lV7pqBsXvJYaBSN/pKrx1t7+6
         NuyzNjnVMRZqCnNhRHDL9UYuJw0RFhQ3RHjcJzZG19e9chU5vLrPLdUZtjgVx4lTVC7R
         oarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Coo03ipoUMnJ4xj5TqhJFPQMyWUkyhuF806s2eM2rEg=;
        b=WTesJIjqb+7sZAYDMsXekf09JckwNcWsnuvpa0gSI36kC1HtlcXkRn7QvuIZern9sJ
         RdgJKcKYhqcIYzhX1IiGcRMBlkTjOyHMHAkj6ubBieP3LxXjo4BuuwCIp8hnRkAvdkn6
         K0udLGxl4ZojmW2s38Aug7awja4zEYuzHgLP+ex0ySn0p+8jawM17UpRSK7OtcUOcwTt
         ge7AvEBUlUlupaiTY2aOHnB8qnpIjZ1qmgSph4W9IUA3e/YMt+FSlkr29cA/6tJuSdbm
         ixeV6LKljxWYQqCe0DgIe2vByuVY8M2XkXl1Cg9sa4N2Mefp5iQrngPoaBoZdeTov15Z
         5azA==
X-Gm-Message-State: APjAAAUSSyCdw/QGOOEo1wZu5IwS9moDgdbt50c4RCpzzXknmjEdBIKa
        oUrqkvNL7FRY4FU7X6obnDD3jEUj2CMgZwNXGMlO
X-Google-Smtp-Source: APXvYqymwecfXZrv+PqxW8nDy8P4JXKSxv1PgGeEc3QQJL5M553B9tDco7OWbKVe0erv/Mt3Cx2MrWS7bR7nuMBR7Lw=
X-Received: by 2002:a2e:42cf:: with SMTP id h76mr35699754ljf.95.1554130205890;
 Mon, 01 Apr 2019 07:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552665316.git.rgb@redhat.com> <700e4313571f86cc0cdcb7310fbe060f02c7c2db.1552665316.git.rgb@redhat.com>
In-Reply-To: <700e4313571f86cc0cdcb7310fbe060f02c7c2db.1552665316.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 1 Apr 2019 10:49:54 -0400
Message-ID: <CAHC9VhRWUvG6DwiPn4o+vt=fgGfY+JmG8m78M8CeyGYxF2yRXQ@mail.gmail.com>
Subject: Re: [PATCH ghak90 V5 06/10] audit: add support for non-syscall
 auxiliary records
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 2:34 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Standalone audit records have the timestamp and serial number generated
> on the fly and as such are unique, making them standalone.  This new
> function audit_alloc_local() generates a local audit context that will
> be used only for a standalone record and its auxiliary record(s).  The
> context is discarded immediately after the local associated records are
> produced.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> ---
>  include/linux/audit.h |  8 ++++++++
>  kernel/audit.h        |  1 +
>  kernel/auditsc.c      | 35 ++++++++++++++++++++++++++++++-----
>  3 files changed, 39 insertions(+), 5 deletions(-)

...

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

It's very possible I've missed it, but "local" never gets used in any
meaningful way in this patchset does it?

>         enum audit_state    state, current_state;
>         unsigned int        serial;     /* serial number for record */
>         int                 major;      /* syscall number */

-- 
paul moore
www.paul-moore.com
