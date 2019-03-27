Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEEEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56A02075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfC0Uoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:44:37 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37355 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfC0Uoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:44:32 -0400
Received: by mail-oi1-f193.google.com with SMTP id v84so14042890oif.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 13:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KZJmoyAqUqbMB9q3YWMVJZoUVK/xcklwjtBjD0Nm+dI=;
        b=IuwAPSPS0AF02IBz13Ez8Hw/JoBjcEfaHcAM2A2mTDt9Ke09rSU6P7mlDwiwWcZcaE
         uYT1OqRxrLcpGK8JOWVSErXRFW/cSWTRt5RkvKyNg8Z5xKORyGfihNKgf57SRjF+THIa
         WOZEc7RcMePUQWKYiRa7B6/s2+DAu5TTdZlRpGTgwc4jMvYqzyE9d3bG8P3ouA1UPtoJ
         vFDpEc+rjbnjXgrwNDHPbEQIPJ4p4erYhOPNnmMh6mjvL76phh26K+rZ5NBm7gY5Ge1p
         3irhv7Iqze2n8Cg50oHiE41SzXQU2IDrzuVhZRfr4gynkK4dqMJ28fl7xh2RKHxE8Ou7
         5gvA==
X-Gm-Message-State: APjAAAXm92wT3fsfzkZ0Oa08TMSoIeOjghL97odaNNrVLqpzBado/g8u
        6kDFzHU0KnPkB1/S0x4hbL4MzKAgRfjOHDiaboB9bQ==
X-Google-Smtp-Source: APXvYqwTudjoMV5HRGyOnm1K+LX76Vn0PG5wR78c0WqxslpxFTU7aufRZNYe+7VutV1f2UXad8JYlGRjsR/CrLQtCmk=
X-Received: by 2002:aca:4507:: with SMTP id s7mr10402500oia.127.1553719471862;
 Wed, 27 Mar 2019 13:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552665316.git.rgb@redhat.com> <25543e3db4d8f3853119f92c09a60664555249a2.1552665316.git.rgb@redhat.com>
In-Reply-To: <25543e3db4d8f3853119f92c09a60664555249a2.1552665316.git.rgb@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 27 Mar 2019 21:44:20 +0100
Message-ID: <CAFqZXNtShvR6rJD0cuxMaZuT2_-L5VQP0jDxcJvGkfaAk49vWA@mail.gmail.com>
Subject: Re: [PATCH ghak90 V5 03/10] audit: read container ID of a process
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

On Fri, Mar 15, 2019 at 7:33 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Add support for reading the audit container identifier from the proc
> filesystem.
>
> This is a read from the proc entry of the form
> /proc/PID/audit_containerid where PID is the process ID of the task
> whose audit container identifier is sought.
>
> The read expects up to a u64 value (unset: 18446744073709551615).
>
> This read requires CAP_AUDIT_CONTROL.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

> ---
>  fs/proc/base.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 2505c46c8701..0b833cbdf5b6 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1295,6 +1295,24 @@ static ssize_t proc_sessionid_read(struct file * file, char __user * buf,
>         .llseek         = generic_file_llseek,
>  };
>
> +static ssize_t proc_contid_read(struct file *file, char __user *buf,
> +                                 size_t count, loff_t *ppos)
> +{
> +       struct inode *inode = file_inode(file);
> +       struct task_struct *task = get_proc_task(inode);
> +       ssize_t length;
> +       char tmpbuf[TMPBUFLEN*2];
> +
> +       if (!task)
> +               return -ESRCH;
> +       /* if we don't have caps, reject */
> +       if (!capable(CAP_AUDIT_CONTROL))
> +               return -EPERM;
> +       length = scnprintf(tmpbuf, TMPBUFLEN*2, "%llu", audit_get_contid(task));
> +       put_task_struct(task);
> +       return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
> +}
> +
>  static ssize_t proc_contid_write(struct file *file, const char __user *buf,
>                                    size_t count, loff_t *ppos)
>  {
> @@ -1325,6 +1343,7 @@ static ssize_t proc_contid_write(struct file *file, const char __user *buf,
>  }
>
>  static const struct file_operations proc_contid_operations = {
> +       .read           = proc_contid_read,
>         .write          = proc_contid_write,
>         .llseek         = generic_file_llseek,
>  };
> @@ -3039,7 +3058,7 @@ static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
>  #ifdef CONFIG_AUDIT
>         REG("loginuid",   S_IWUSR|S_IRUGO, proc_loginuid_operations),
>         REG("sessionid",  S_IRUGO, proc_sessionid_operations),
> -       REG("audit_containerid", S_IWUSR, proc_contid_operations),
> +       REG("audit_containerid", S_IWUSR|S_IRUSR, proc_contid_operations),
>  #endif
>  #ifdef CONFIG_FAULT_INJECTION
>         REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),
> @@ -3428,7 +3447,7 @@ static int proc_tid_comm_permission(struct inode *inode, int mask)
>  #ifdef CONFIG_AUDIT
>         REG("loginuid",  S_IWUSR|S_IRUGO, proc_loginuid_operations),
>         REG("sessionid",  S_IRUGO, proc_sessionid_operations),
> -       REG("audit_containerid", S_IWUSR, proc_contid_operations),
> +       REG("audit_containerid", S_IWUSR|S_IRUSR, proc_contid_operations),
>  #endif
>  #ifdef CONFIG_FAULT_INJECTION
>         REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),
> --
> 1.8.3.1
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
