Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB850C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B3D2190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="V4Xxbr0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfJKAkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:40:17 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43450 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfJKAkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:40:16 -0400
Received: by mail-lf1-f67.google.com with SMTP id u3so5722444lfl.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WruOl9m8rjj6B/eISV7ZrAuuDk2P1Av0bY+CVqaL58Q=;
        b=V4Xxbr0U3eWT6U16YQ3PdgJXfFSijS5xRPN5nuMN6zDdNiLlA8dHWQaXw0Yzr3J0GG
         jRh9YIrZ+DWce+KF5cgww4hLWK47rxojTThwR/zgSvMLAFygAJZkWRqj2iX38L3KwI8a
         8I1WdUsdx/j6CuBhFGYvw5LMxUP/iOf/nOVB405Wnz4NBTkrngUoYzEwv5G2EC8sUbzW
         8umuXVw1jEwxdYwwQY1tM0o6fLNk5h+gKKD1b6UGgzKcpmc1HiwzfF7qiFKwl/7qqXWI
         JgymE+NEGRdwv29QW/erS6VgnlAN5h0RSuumHCtPnB4wHvJox9JrE8jqfIDTC0rUqT73
         QlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WruOl9m8rjj6B/eISV7ZrAuuDk2P1Av0bY+CVqaL58Q=;
        b=HGy8xUiGElZDU3IrEu1GmZpiHla/OZIlh4A/thr4cnQE3ls8kKv4Yi76H1Er68HF5V
         YPM9jPWENHbSOtfIrF/45HigdI3+d+mZs48Ti7TrphyehwIV0W11GusRcv5Svp32gXW3
         NqNua2OVxS6H1wC8ky03MiXsY3lvn1SinSXDJWbKt56ZrOvoDoruCY0jZLwGbgebvNDr
         eZlLbz+PCLPdhjMdz7BRRKQ39Etr99KTZ8mRCIPHJGUkJXepWEFOnGFTBdcbXWWEbY0m
         T3kGpYEmdFk4py0dMltO5w1dl8SL8VeefW2aNjNQGtkIuNfVSQAhBmN6xl8RvBYZTJdV
         TAoQ==
X-Gm-Message-State: APjAAAWjk6XXGkVn4NeKIaWyj5dYvo9B7BGxeXwHnusvB5V+h3l5S36B
        oXgNl1iI4ogjZrie5zEbFbhjrjvD1Bepe8AcjENl
X-Google-Smtp-Source: APXvYqx4281+tmbi3ZlPDrW+JB0898oZIUJra8F7IZWiEF8jcqHh8UQR+dgmOr5eN7CEnXk9zl63wAZJvDvH7MBwJLo=
X-Received: by 2002:ac2:51b6:: with SMTP id f22mr7273869lfk.175.1570754414142;
 Thu, 10 Oct 2019 17:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568834524.git.rgb@redhat.com> <16abf1b2aafeb5f1b8dae20b9a4836e54f959ca5.1568834524.git.rgb@redhat.com>
In-Reply-To: <16abf1b2aafeb5f1b8dae20b9a4836e54f959ca5.1568834524.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Oct 2019 20:40:03 -0400
Message-ID: <CAHC9VhSRmn46DcazH4Q35vOSxVoEu8PsX79aurkHkFymRoMwag@mail.gmail.com>
Subject: Re: [PATCH ghak90 V7 14/21] audit: contid check descendancy and nesting
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 9:26 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> ?fixup! audit: convert to contid list to check for orch/engine ownership

?

> Require the target task to be a descendant of the container
> orchestrator/engine.
>
> You would only change the audit container ID from one set or inherited
> value to another if you were nesting containers.
>
> If changing the contid, the container orchestrator/engine must be a
> descendant and not same orchestrator as the one that set it so it is not
> possible to change the contid of another orchestrator's container.

Did you mean to say that the container orchestrator must be an
ancestor of the target, and the same orchestrator as the one that set
the target process' audit container ID?

Or maybe I'm missing something about what you are trying to do?

> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 62 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 9ce7a1ec7a92..69fe1e9af7cb 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2560,6 +2560,39 @@ static struct task_struct *audit_cont_owner(struct task_struct *tsk)
>  }
>
>  /*
> + * task_is_descendant - walk up a process family tree looking for a match
> + * @parent: the process to compare against while walking up from child
> + * @child: the process to start from while looking upwards for parent
> + *
> + * Returns 1 if child is a descendant of parent, 0 if not.
> + */
> +static int task_is_descendant(struct task_struct *parent,
> +                             struct task_struct *child)
> +{
> +       int rc = 0;
> +       struct task_struct *walker = child;
> +
> +       if (!parent || !child)
> +               return 0;
> +
> +       rcu_read_lock();
> +       if (!thread_group_leader(parent))
> +               parent = rcu_dereference(parent->group_leader);
> +       while (walker->pid > 0) {
> +               if (!thread_group_leader(walker))
> +                       walker = rcu_dereference(walker->group_leader);
> +               if (walker == parent) {
> +                       rc = 1;
> +                       break;
> +               }
> +               walker = rcu_dereference(walker->real_parent);
> +       }
> +       rcu_read_unlock();
> +
> +       return rc;
> +}
> +
> +/*
>   * audit_set_contid - set current task's audit contid
>   * @task: target task
>   * @contid: contid value
> @@ -2587,22 +2620,43 @@ int audit_set_contid(struct task_struct *task, u64 contid)
>         oldcontid = audit_get_contid(task);
>         read_lock(&tasklist_lock);
>         /* Don't allow the contid to be unset */
> -       if (!audit_contid_valid(contid))
> +       if (!audit_contid_valid(contid)) {
>                 rc = -EINVAL;
> +               goto unlock;
> +       }
>         /* Don't allow the contid to be set to the same value again */
> -       else if (contid == oldcontid) {
> +       if (contid == oldcontid) {
>                 rc = -EADDRINUSE;
> +               goto unlock;
> +       }
>         /* if we don't have caps, reject */
> -       else if (!capable(CAP_AUDIT_CONTROL))
> +       if (!capable(CAP_AUDIT_CONTROL)) {
>                 rc = -EPERM;
> -       /* if task has children or is not single-threaded, deny */
> -       else if (!list_empty(&task->children))
> +               goto unlock;
> +       }
> +       /* if task has children, deny */
> +       if (!list_empty(&task->children)) {
>                 rc = -EBUSY;
> -       else if (!(thread_group_leader(task) && thread_group_empty(task)))
> +               goto unlock;
> +       }
> +       /* if task is not single-threaded, deny */
> +       if (!(thread_group_leader(task) && thread_group_empty(task))) {
>                 rc = -EALREADY;
> -       /* if contid is already set, deny */
> -       else if (audit_contid_set(task))
> +               goto unlock;
> +       }
> +       /* if task is not descendant, block */
> +       if (task == current) {
> +               rc = -EBADSLT;
> +               goto unlock;
> +       }
> +       if (!task_is_descendant(current, task)) {
> +               rc = -EXDEV;
> +               goto unlock;
> +       }
> +       /* only allow contid setting again if nesting */
> +       if (audit_contid_set(task) && current == audit_cont_owner(task))
>                 rc = -ECHILD;
> +unlock:
>         read_unlock(&tasklist_lock);
>         if (!rc) {
>                 struct audit_cont *oldcont = audit_cont(task);

--
paul moore
www.paul-moore.com
