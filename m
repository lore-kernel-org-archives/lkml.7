Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F11C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B143120848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rusCImqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfEPKAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 06:00:52 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40665 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfEPKAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:00:52 -0400
Received: by mail-oi1-f194.google.com with SMTP id r136so2053937oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 03:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dC3aSgv+o3HSYvM8J8FMKymuhEQ4FThUEnqG0ntB4g0=;
        b=rusCImqcsRelViq7BjTj8x6kkzQ7cL9BId6Q2hif54CzbiF2xexI8tw8D5bQ3Q6HLt
         l4Fc8osLWvc/mFIQ0lcIGpQelUQltkxqLGCz+/Oe6Un0I0xiembCGtk90t1JUC8cFExL
         hiM8oJYcfzEbVRzLR+jVGIv2X+WSy8ArgEm6sDYpKjifpSCcPcFIaQ42Qg4wirz6BBHO
         RKDlH9nba+5XQn6n19kOSVR/TU/lT++yDt/HW6vWFf86nDvW72knrug0SBpJeZIKzOOD
         W5xi2wekab69fIhm12WD6de9sXy3LG6XrRTh7bl6poYUh4ZyEl4VUbR4nVo667mnp3wj
         UpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dC3aSgv+o3HSYvM8J8FMKymuhEQ4FThUEnqG0ntB4g0=;
        b=sApnQiaqw7TsHuGIkQWgfU763oXzm35MlNVctvaRoP/fjVck21eQJyCqR/EeRDxhNf
         qTsNkm4TzSJ4DloSvmKPwNm1Q6e2jccqKi5I6QoGDURLU0OF5JGQHGg39/mzJBWblvQE
         cy36DkSbTBR9Jk9nY85mQF0e5lcxgMgfRnzH9AJYM7eI0iSuEES0eanjvM5a1BA8rdkP
         /zA7WdE7C57p39LbEVwvb53O6r8HWopG9jCxod9F6/hMWeBA4eTOzeiInrt2svdWZrSI
         xE4XszQOvvmDbf08gk5L4WQgL7orMfvGJqk8hBkCxQNUW/1a6fpC3OtdXFrciLsa8k92
         InLg==
X-Gm-Message-State: APjAAAUYRnoc/gV5ePKTo+pkIomjeXoc3nStowq1h24KJMnm3hjtPl7h
        4kI4ZkMjG6aqmLDXZT6Q2+uc2GfBPrjfFJGa1g6pxw==
X-Google-Smtp-Source: APXvYqw8UaGLIZvpXm/eLsQS3GmsqOIGz12mauFeRh7e/B8z5XURykeEcCxzQqp0PTqaQVSeftW47QM4HusRyiTUL58=
X-Received: by 2002:aca:180d:: with SMTP id h13mr9485857oih.39.1558000850840;
 Thu, 16 May 2019 03:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190516094234.9116-1-oleksandr@redhat.com> <20190516094234.9116-5-oleksandr@redhat.com>
In-Reply-To: <20190516094234.9116-5-oleksandr@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 16 May 2019 12:00:24 +0200
Message-ID: <CAG48ez2yXw_PJXO-mS=Qw5rkLpG6zDPd0saMhhGk09-du2bpaA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/5] mm/ksm, proc: introduce remote merge
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg KH <greg@kroah.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 11:43 AM Oleksandr Natalenko
<oleksandr@redhat.com> wrote:
> Use previously introduced remote madvise knob to mark task's
> anonymous memory as mergeable.
>
> To force merging task's VMAs, "merge" hint is used:
>
>    # echo merge > /proc/<pid>/madvise
>
> Force unmerging is done similarly:
>
>    # echo unmerge > /proc/<pid>/madvise
>
> To achieve this, previously introduced ksm_madvise_*() helpers
> are used.

Why does this not require PTRACE_MODE_ATTACH_FSCREDS to the target
process? Enabling KSM on another process is hazardous because it
significantly increases the attack surface for side channels.

(Note that if you change this to require PTRACE_MODE_ATTACH_FSCREDS,
you'll want to use mm_access() in the ->open handler and drop the mm
in ->release. mm_access() from a ->write handler is not permitted.)

[...]
> @@ -2960,15 +2962,63 @@ static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
>  static ssize_t madvise_write(struct file *file, const char __user *buf,
>                 size_t count, loff_t *ppos)
>  {
> +       /* For now, only KSM hints are implemented */
> +#ifdef CONFIG_KSM
> +       char buffer[PROC_NUMBUF];
> +       int behaviour;
>         struct task_struct *task;
> +       struct mm_struct *mm;
> +       int err = 0;
> +       struct vm_area_struct *vma;
> +
> +       memset(buffer, 0, sizeof(buffer));
> +       if (count > sizeof(buffer) - 1)
> +               count = sizeof(buffer) - 1;
> +       if (copy_from_user(buffer, buf, count))
> +               return -EFAULT;
> +
> +       if (!memcmp("merge", buffer, min(sizeof("merge")-1, count)))

This means that you also match on something like "mergeblah". Just use strcmp().

> +               behaviour = MADV_MERGEABLE;
> +       else if (!memcmp("unmerge", buffer, min(sizeof("unmerge")-1, count)))
> +               behaviour = MADV_UNMERGEABLE;
> +       else
> +               return -EINVAL;
>
>         task = get_proc_task(file_inode(file));
>         if (!task)
>                 return -ESRCH;
>
> +       mm = get_task_mm(task);
> +       if (!mm) {
> +               err = -EINVAL;
> +               goto out_put_task_struct;
> +       }
> +
> +       down_write(&mm->mmap_sem);

Should a check for mmget_still_valid(mm) be inserted here? See commit
04f5866e41fb70690e28397487d8bd8eea7d712a.

> +       switch (behaviour) {
> +       case MADV_MERGEABLE:
> +       case MADV_UNMERGEABLE:

This switch isn't actually necessary at this point, right?

> +               vma = mm->mmap;
> +               while (vma) {
> +                       if (behaviour == MADV_MERGEABLE)
> +                               ksm_madvise_merge(vma->vm_mm, vma, &vma->vm_flags);
> +                       else
> +                               ksm_madvise_unmerge(vma, vma->vm_start, vma->vm_end, &vma->vm_flags);
> +                       vma = vma->vm_next;
> +               }
> +               break;
> +       }
> +       up_write(&mm->mmap_sem);
> +
> +       mmput(mm);
> +
> +out_put_task_struct:
>         put_task_struct(task);
>
> -       return count;
> +       return err ? err : count;
> +#else
> +       return -EINVAL;
> +#endif /* CONFIG_KSM */
>  }
