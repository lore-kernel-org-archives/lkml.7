Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DBAC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC3521773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="odFNC7Hd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbfDQDia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:38:30 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40379 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbfDQDi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 23:38:29 -0400
Received: by mail-vs1-f67.google.com with SMTP id f22so12789406vso.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 20:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rYGx6iPp/rJfiem2aM806TgiKVoRirE0yBDQh5gfjRI=;
        b=odFNC7HdKvKbk7lK4gq34TSyhFSEY/GjuPqSYwN1IjF9nDTCxp1pxnPsl9Y4kau8n9
         /r9kquQ3/ztJHrT0wFsLjv9WnDIMCN49a+jIeeXrY/dx2jZnzfnJdIbi7GP0SBI1ReO7
         hIkwuLvmiKpFRZ+Sg0WtY5Cbv2A6zhefFn4C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYGx6iPp/rJfiem2aM806TgiKVoRirE0yBDQh5gfjRI=;
        b=uGCB7rrEg+1YVJ6KVF5cxykHo3LbgFX+kRwx7PuABP94OxjZ6k23kC45RizZslRPzR
         Xd2CTqdY+Bp891g8xZESvzLMi4PmDm9AUA87xJnxOFcEBeqJMLNc9/DoF3vldm/7RKW9
         eDzdXNa+YgMlz5a7R8giMAgkwzVDCuSc81fZPPlNdIZ4+I/3Vqtfntf+lWJOHipLQb3W
         +vMfgKZHA0QRmaddFIl2aW2M4TAr0lQf0pbz48+2YRdtbx/N5mJY3gGFESI/3fq7Fg9V
         F9Nkl2bTgb2kbNf62irObddydxDj8Yy66GgxhJXSfKUHEs0B58dLSOVeFKOdHEym2CN6
         N7Aw==
X-Gm-Message-State: APjAAAXoI6ZeUrD7+dulDV/8QiFPdmKqZdTnjjkIdxa5EzxnS03TXG44
        2V2EnC+dwfyfzfpofgGi4IurYdPGCTU=
X-Google-Smtp-Source: APXvYqyLa1z7qSefRDN4xWp9PzG0QgjslX9pQblrwVIozZkVak6Jd3gHhmcQLLYtKgd/Yn4aGSfrSQ==
X-Received: by 2002:a67:fe95:: with SMTP id b21mr48697772vsr.109.1555472307331;
        Tue, 16 Apr 2019 20:38:27 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id o126sm11493584vke.55.2019.04.16.20.38.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 20:38:26 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id g24so4917381vki.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 20:38:26 -0700 (PDT)
X-Received: by 2002:a1f:ab8d:: with SMTP id u135mr43542191vke.80.1555472306026;
 Tue, 16 Apr 2019 20:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <b5b9df7b-324c-8286-3a7c-e7812511772d@codeaurora.org>
In-Reply-To: <b5b9df7b-324c-8286-3a7c-e7812511772d@codeaurora.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 16 Apr 2019 22:38:13 -0500
X-Gmail-Original-Message-ID: <CAGXu5jLabRWRdknf_CSBJ316vXYrEUCPTUCsm50WEwdpVNfE3g@mail.gmail.com>
Message-ID: <CAGXu5jLabRWRdknf_CSBJ316vXYrEUCPTUCsm50WEwdpVNfE3g@mail.gmail.com>
Subject: Re: fs/proc: Crash observed in next_tgid (fs/proc/base.c)
To:     Jitendra Sharma <shajit@codeaurora.org>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 7:58 AM Jitendra Sharma <shajit@codeaurora.org> wrote:
>
> Hi Kees Cook/Luis,
>
> We are observing one kernel crash in next_tgid function through
> getdents64 path. Call stack is as shown below:
>
> -000|has_group_leader_pid(inline)
> -000|next_tgid(
> | [X20] ns = 0xFFFFFF87CABB1AC0,
> | [locdesc] iter = (
> | [locdesc] tgid = 424,
> | [locdesc] task = ?))
> | [X21] p = 0xFFFFFFD0FFFFF948
> | [X21] task = 0xFFFFFFD0FFFFF948
> -001|proc_pid_readdir(
> | [X20] file = 0xFFFFFFD1AC60FC40,
> | [X19] ctx = 0xFFFFFF8027363E40)
> | [X21] ns = 0xFFFFFF87CABB1AC0
> -002|proc_root_readdir(
> | [X20] file = 0xFFFFFFD1AC60FC40,
> | [X19] ctx = 0xFFFFFF8027363E40)
> -003|iterate_dir(
> | [X19] file = 0xFFFFFFD1AC60FC40,
> | [X22] ctx = 0xFFFFFF8027363E40)
> | [X23] inode = 0xFFFFFFD1F20246D0
> -004|SYSC_getdents64(inline)
> -004|sys_getdents64(
> | ?,
> | ?,
> | [X19] count = 4200)
> | [X19] count = 4200
> | [X20] f = ([X20] file = 0xAC60FC43AC60FC40, [X20] flags = 1207898624)
> | [X0] error = -1720
> -005|el0_svc_naked(asm)
> -->|exception
> -006|NUX:0x78C5AD7D38(asm)
> ---|end of frame
>
>
>  From this call stack,task: 0xFFFFFFD0FFFFF948, seems to be invalid.
> As(from ramdumps) it doesn't have any valid fields. And while trying to
> access the fields of this task struct in has_group_leader_pid, abort is
> happening.
>
>  From the dumps, its not clear why the task struct is coming to be some
> invalid (Possibly task has already exited).  This issue is observed
> during normal monkey testing for long hours.
>
> Could you please provide some pointers which could help in debugging
> this issue further.

Do you have any hints on how to reproduce this? I assume something is
missing proper locking or RCU handling, but I don't see anything
obvious in the surrounding code yet...

-- 
Kees Cook
