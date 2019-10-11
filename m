Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ECAC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4512089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ijTDwhFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfJKO43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:56:29 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46019 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfJKO42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:56:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id 41so8180652oti.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cpz0OPVdz0lvY7YxjxR86HQw6Mhe0P0KSoHxNBSYZCk=;
        b=ijTDwhFlFn4QfgOlhEtom29w42EeeTy7Ujy2bs4ItZsaR8Uf8Uno5gRFSvhqw8UfLh
         JyrIBHwR68u6KRVzMacEGroyDb1oe2yfyTTgXNBG5wy0IfsCQDTf3GxLZdzOmQKsT3p/
         sn4OIbiIKgDNQS2WgatN3wXKK9MP997vKqjwv4CsSQ1ab0hnXuaLYjMjxTDYHPVopj7W
         9WH7yFFRzB2eidrgZaGHSST/gLbYkid2jVy7IVBpExnz0hzFdoMYnDhcnllKnil37Z5a
         7Mj7hbQzCoOWDI4ymSTAEDc9/rbnGROoTCpVJx9oLV8wy+rLTuHd3k9y2cri1mZaoWMN
         Ap/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cpz0OPVdz0lvY7YxjxR86HQw6Mhe0P0KSoHxNBSYZCk=;
        b=dMqMNJvh8fIokUD8+KIvjG9k5W/S6bpVNM0es2rkjarnhWh8QSkqVaVg09XgjZ6HnO
         8GqPK8awnCuAjHKu7AfwKyzVGjb6p6VZd/ASxdTG7lLLNaYDV3cPKExBnMBD2GN4Ntwo
         HYVf4SrsyxcFhgbWOyt4njJyjr94+kWayHflF0HfZyTZLvskSDekEahuXmBPuxqSAKAI
         MMIIR2JiTEqcgXAG41z/GQfC25hJkCo49rcg7VGWPwbwbP/785iV6qP5/KGmveW134pE
         IpkVTdE9nXKBMJcdFiVmFD1AGXn2d0e8aAkhmWx+o82N944oAXlxbuEvhdVrybnbNa5T
         dFWw==
X-Gm-Message-State: APjAAAXbfvreH9uK3CYyhdCKf53vB4TjTsTCPNqWLftGnYGXOcmjqeAr
        1Gk6cGgcKCiJ49MH/Icp5xwRV2yYjgEIcDJJehGqZw==
X-Google-Smtp-Source: APXvYqw6vJaIgJV5OcazEiTO8PBUI5gTRcpIkg06EF4EC53A7GIFnCN+6UJXJ/RMcUIwr5wyKR5qkK6DAeZoUpkSpvI=
X-Received: by 2002:a05:6830:10cc:: with SMTP id z12mr5196034oto.110.1570805787289;
 Fri, 11 Oct 2019 07:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191009160532.20674-1-ckellner@redhat.com> <20191011122323.7770-1-ckellner@redhat.com>
In-Reply-To: <20191011122323.7770-1-ckellner@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 11 Oct 2019 16:55:59 +0200
Message-ID: <CAG48ez1xNonmxwa3DRD44WJiComOHRxdHud5+LWea3OXzr4hkg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] pidfd: show pids for nested pid namespaces in fdinfo
To:     Christian Kellner <ckellner@redhat.com>,
        Christian Brauner <christian@brauner.io>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Kellner <christian@kellner.me>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 2:23 PM Christian Kellner <ckellner@redhat.com> wrote:
> The fdinfo file for a process file descriptor already contains the
> pid of the process in the callers namespaces. Additionally, if pid
> namespaces are configured, show the process ids of the process in
> all nested namespaces in the same format as in the procfs status
> file, i.e. "NSPid:\t%d\%d...". This allows the easy identification
> of the processes in nested namespaces.
[...]
>  #ifdef CONFIG_PROC_FS
> +static inline void print_pidfd_nspid(struct seq_file *m, struct pid *pid,
> +                                    struct pid_namespace *ns)

`ns` is the namespace of the PID namespace of the procfs instance
through which the file descriptor is being viewed.

> +{
> +#ifdef CONFIG_PID_NS
> +       int i;
> +
> +       seq_puts(m, "\nNSpid:");
> +       for (i = ns->level; i <= pid->level; i++) {

ns->level is the level of the PID namespace associated with the procfs
instance through which the file descriptor is being viewed. pid->level
is the level of the PID associated with the pidfd.

> +               ns = pid->numbers[i].ns;
> +               seq_put_decimal_ull(m, "\t", pid_nr_ns(pid, ns));
> +       }
> +#endif
> +}

I think you assumed that `ns` is always going to contain `pid`.
However, that's not the case. Consider the following scenario:

 - the init_pid_ns has two child PID namespaces, A and B (each with
its own mount namespace and procfs instance)
 - process P1 lives in A
 - process P2 lives in B
 - P1 opens a pidfd for itself
 - P1 passes the pidfd to P2 (e.g. via a unix domain socket)
 - P2 reads /proc/self/fdinfo/$pidfd

Now the loop will print the ID of P1 in A. I don't think that's what
you intended? You might want to bail out if "pid_nr_ns(pid, ns) == 0",
or something like that.
