Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1657C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A21220685
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UKUKcSHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfDYSRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:17:09 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37499 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDYSRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:17:09 -0400
Received: by mail-ot1-f65.google.com with SMTP id c16so379871otn.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/sTePWjq2L9TZHfFnLANGY9Vc9Ld/v1fuSl15X5db4=;
        b=UKUKcSHktJDdIsxDIpDsOP4acQySLTpP8DE5287kwixieJnBuGzdsBwfDmJdUfXPHL
         tMSFOQmyjp5kjU4SweyUjk4WI2f3nCYviJ9/N0BDiB0NvwQ23oRhslvQ0T95qFjG3nVU
         vDjEEVMSfH37GVgWbyqnsYU0b/f9dZsTaL6+VzzABKmS7/AOjmLhSZimK/rdEaIijHsI
         Pdcy1R8TBRGrTV/pR9hDv4R+PvS1uIo/Y+3SIFm182aE1TFwESvEEr/kIWaVlyUbXdG+
         H2eXcMxa9mnXEb/tgz2Kw46i5ZUtbu3gcd0iDnbuie8b7to8eC3E2koZyPUuFE8kFPTH
         Qkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/sTePWjq2L9TZHfFnLANGY9Vc9Ld/v1fuSl15X5db4=;
        b=WIPxiD10aSmXVg7G1TvLJwnsR6FEZz+lui57Kq9Y6FOqtHGeIe8JlJq9p9MrFVT1HB
         tRtjfTYr0+LPyrV2INycZROHRTSNQwhpvcw66Aq8+YWO3LFPVUAgwmedQegwYTmgteXD
         9U18qyxzu9hmrlpxqxl9Gh6sskXr/TIcXYSmbPWOlZjFF+ZBBFr4codGP6LUDeon+JtG
         6eORfT5NghYgZPje3H/qeXsvsibyRI63Gy0L/9Otndt7l4eV5WnJO5tVke89LZAUQh+j
         3b2T9TyxLnkG+/WawfgdNiUReX19XNb4fl22N+RXCLXdMlOMGwL4kvjx3MxJR05E93sq
         aDFQ==
X-Gm-Message-State: APjAAAVhb3UpdrRuG9g5LUAr+eBBFdktIxxX2oH3MJJjf2SB1xnd29VK
        E6r1h9ZOMl6XTd84a7WF0ppeNcmqtyZoSDJrTaIazg==
X-Google-Smtp-Source: APXvYqy2LBPXvlss1uiHsH//34CS/I8r+sfJ3YfxiEi5z0Kbn3MIvw2kMazpQulErM4X5fXrZ0QtQkJybjc3mu9kBXk=
X-Received: by 2002:a9d:53cc:: with SMTP id i12mr3734402oth.242.1556216228160;
 Thu, 25 Apr 2019 11:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190425161416.26600-1-dima@arista.com> <20190425161416.26600-20-dima@arista.com>
In-Reply-To: <20190425161416.26600-20-dima@arista.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 25 Apr 2019 20:16:41 +0200
Message-ID: <CAG48ez1ws9qXyNHfScY1RoajG=pquFe4y9QpM1c_xtPSeC2SNA@mail.gmail.com>
Subject: Re: [PATCHv3 19/27] timens/fs/proc: Introduce /proc/pid/timens_offsets
To:     Dmitry Safonov <dima@arista.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 6:15 PM Dmitry Safonov <dima@arista.com> wrote:
> API to set time namespace offsets for children processes, i.e.:
> echo "clockid off_ses off_nsec" > /proc/self/timens_offsets
[...]
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 6a803a0b75df..76d58e9b5178 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
[...]
> @@ -1521,6 +1522,103 @@ static const struct file_operations proc_pid_sched_autogroup_operations = {
>
>  #endif /* CONFIG_SCHED_AUTOGROUP */
>
> +#ifdef CONFIG_TIME_NS
> +static int timens_offsets_show(struct seq_file *m, void *v)
> +{
> +       struct inode *inode = m->private;
> +       struct task_struct *p;
> +
> +       p = get_proc_task(inode);

(FYI, this could also be "p = get_proc_task(file_inode(m->file));".
But this works, too.)

> +       if (!p)
> +               return -ESRCH;
> +       proc_timens_show_offsets(p, m);
> +
> +       put_task_struct(p);
> +
> +       return 0;
> +}
> +
> +static ssize_t
> +timens_offsets_write(struct file *file, const char __user *buf,
> +           size_t count, loff_t *ppos)
> +{
> +       struct inode *inode = file_inode(file);
> +       struct proc_timens_offset offsets[2];
> +       char *kbuf = NULL, *pos, *next_line;
> +       struct task_struct *p;
> +       int ret, noffsets;
> +
> +       /* Only allow < page size writes at the beginning of the file */
> +       if ((*ppos != 0) || (count >= PAGE_SIZE))
> +               return -EINVAL;
> +
> +       /* Slurp in the user data */
> +       kbuf = memdup_user_nul(buf, count);
> +       if (IS_ERR(kbuf))
> +               return PTR_ERR(kbuf);
> +
> +       /* Parse the user data */
> +       ret = -EINVAL;
> +       noffsets = 0;
> +       pos = kbuf;
> +       for (; pos; pos = next_line) {
> +               struct proc_timens_offset *off = &offsets[noffsets];
> +               int err;
> +
> +               /* Find the end of line and ensure I don't look past it */
> +               next_line = strchr(pos, '\n');
> +               if (next_line) {
> +                       *next_line = '\0';
> +                       next_line++;
> +                       if (*next_line == '\0')
> +                               next_line = NULL;
> +               }
> +
> +               err = sscanf(pos, "%u %lld %lu", &off->clockid,
> +                               &off->val.tv_sec, &off->val.tv_nsec);
> +               if (err != 3 || off->val.tv_nsec >= NSEC_PER_SEC)
> +                       goto out;
> +               if (noffsets++ == ARRAY_SIZE(offsets))
> +                       break;

This is equivalent to:

if (noffsets == ARRAY_SIZE(offsets))
        break;
noffsets++;

So we can reach the start of the loop with
noffsets==ARRAY_SIZE(offsets), right? Which means that an
out-of-bounds write can happen?

I think that for code like this, it makes sense to write the increment
and the check out separately so that it's easier to spot problems;
e.g. like this:

noffsets++;
if (noffsets == ARRAY_SIZE(offsets))
        break;

> +       }
> +
> +       ret = -ESRCH;
> +       p = get_proc_task(inode);
> +       if (!p)
> +               goto out;
> +       ret = proc_timens_set_offset(p, offsets, noffsets);
> +       put_task_struct(p);
> +       if (ret)
> +               goto out;
> +
> +       ret = count;
> +out:
> +       kfree(kbuf);
> +       return ret;
> +}
> +
> +static int timens_offsets_open(struct inode *inode, struct file *filp)
> +{
> +       int ret;
> +
> +       ret = single_open(filp, timens_offsets_show, NULL);
> +       if (!ret) {
> +               struct seq_file *m = filp->private_data;
> +
> +               m->private = inode;
> +       }
> +       return ret;
> +}

Why did you write it like this? Wouldn't the following be equivalent?

static int timens_offsets_open(struct inode *inode, struct file *file)
{
        return single_open(file, timens_offsets_show, inode);
}

(But also, you can reach the inode of a seq_file as file_inode(m->file).)

[...]
> diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
> index e806accc4eaf..9ad4b63c4ed2 100644
> --- a/kernel/time_namespace.c
> +++ b/kernel/time_namespace.c
[...]
> +
> +int proc_timens_set_offset(struct task_struct *p,
> +                          struct proc_timens_offset *offsets, int noffsets)
> +{
> +       struct ns_common *ns;
> +       struct time_namespace *time_ns;
> +       struct timens_offsets *ns_offsets;
> +       struct timespec64 *offset;
> +       struct timespec64 tp;
> +       int i, err;
> +
> +       ns = timens_for_children_get(p);
> +       if (!ns)
> +               return -ESRCH;
> +       time_ns = to_time_ns(ns);
> +
> +       if (!time_ns->offsets || time_ns->initialized ||
> +           !ns_capable(time_ns->user_ns, CAP_SYS_TIME)) {

Capability checks in VFS read/write handlers are bad. Please pass
through the file pointer to this function and replace the call with
"file_ns_capable(file, time_ns->user_ns, CAP_SYS_TIME)".

> +               put_time_ns(time_ns);
> +               return -EPERM;
> +       }
[...]
> +}
