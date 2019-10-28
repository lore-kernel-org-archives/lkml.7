Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CA9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE6720862
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Xk/vMcjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733232AbfJ1IJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:09:53 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46362 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729786AbfJ1IJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:09:52 -0400
Received: by mail-ua1-f65.google.com with SMTP id o4so1147328uat.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 01:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+J6HJzJSTXLwW+2B+amFF2JyA8VeAPbIhBSjpfVOGwQ=;
        b=Xk/vMcjpXfBASXEhn6lcrfhQjnAOagsIbQPgsDgTb87Pe1de50ed8ql9SZpqlDSi5e
         kiE3yzi16D58CjTS/0DUZ9heft3huPvobpdhuD0xwA2xp3WS4fiKZj23D+CMGkLHMilr
         vsfCmDMfBFdbaVXJ6qKtMuULt9vSifXDZpaOFkJqwOy8gtuqSyl7fgebJkXCpcBg9z4U
         QFsP+z4pLnY7T8pNJ9uwqOrrU1/4wonTNq6puqBHqAbRoATkAKaUDUcEYRJNxUVyAMDa
         FkoBGQOocs2H/CS4W0rDJxu+2KWUmg0sgvOCeECnDsQVv20WlvcUkLgW9aI9lGPfSN1E
         XJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+J6HJzJSTXLwW+2B+amFF2JyA8VeAPbIhBSjpfVOGwQ=;
        b=O6aWrYsv1KMvIFr+E9iKNNqsmGwcEtVgurmNULrBeyLtx5VujAiXEiSfK0zVPEeYTf
         R9TUY5iQKvtGqejjqyUOJdUZBlTJOdGRYCtyR7xBKnYaW0Vd+/kFJ9mBZ0LOTuusxTnV
         8wi1E292++31DcGwWvSWTUnkp0snpdmfhiIwZvYvRtbCoWlRnXyjQYyu8vw6dDs/Fzkk
         tNJKHkJjaIOFBxVoem5MsB3lh/hVvXIZDNLWyzYWxyZyEzugkKUFWUPY+viZy29+mNMk
         fHB5dyMd2OPhwOgh4ztCOlfCWlE7V2upvcZzqDLMj2uL5IAJ7F8ciDzzEe8ab1HLbqWM
         4EjQ==
X-Gm-Message-State: APjAAAXx38fXAEpzDB2g22DnT6BDwIRzQdJm/BJnc1eCqmeI1ucn2ATy
        fyzIFQU6y0pkKgHsgpG6rHWud/Y2FZwbJcfX80K3oINT
X-Google-Smtp-Source: APXvYqyEEu9BzxIt+3W5zWIXKOcOhfufRA5ryDvIgzfn1+CJ+9Vu1fLpF2p4TpNWh9wNeQs5UaS6Rx7ACEts5OlIem4=
X-Received: by 2002:ab0:55c8:: with SMTP id w8mr7291486uaa.66.1572250189669;
 Mon, 28 Oct 2019 01:09:49 -0700 (PDT)
MIME-Version: 1.0
From:   Stephan <stephanwib@googlemail.com>
Date:   Mon, 28 Oct 2019 09:09:38 +0100
Message-ID: <CABZpUSVC3id65o_gDxc9mzgSux_qb6NHBzU+3=yBy5yqyjTmFw@mail.gmail.com>
Subject: Process waiting on NFS transitions to uninterruptable sleep when
 receiving a signal with custom signal handler
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I have asked this question on Stackoverflow a while ago but
unfortunately nobody had an idea on this.

I am currently doing some research on how we can extend the monitoring
solution for Linux in our datacenter in order to detect inaccessible
NFS mounts. My idea was to look for NFS mounts in /proc/self/mountinfo
and then for each mount, call alarm(), issue a syncronous
interruptible call via stat()/fsstat() or similar, and in case of an
alarm, return an error in the signal handler. However, I experienced
the following behaviour which I am not sure how to explain or debug.

It turned out that when a process waiting in the stat system call on a
mountpoint of a diconnected NFS server, it responds to signals as
expected. For example, one can exit it pressing Strc+C, or it displays
"Alarm clock" and ends when the alarm timer fires. The same applies
e.g. to SIGUSR1/2, leading the program to display "User defined signal
1" (or "2") and end. I suspect these messages come from a general
signal dispatcher inside glibc, but it would be nice to hear some
details on how this works.

In all cases in which a custom signal handler was registered, the
process transitions to an uninterruptible sleep state when a signal
for this custom handler is scheduled; leading to no other signal being
processed anymore. Of course this applies to SIGALRM as well when the
alarm() timer sends the signal. All signals show up in
/proc/PID/status as below:


Threads:        1
SigQ:   4/31339
SigPnd: 0000000000000000
ShdPnd: 0000000000002a02
SigBlk: 0000000000000000
SigIgn: 0000000000000000
SigCgt: 0000000000000200


I looked at the information from "echo w > /proc/sysrq-trigger" but
there is nothing of help to me:

[26099350.815187] signal          D 0000000000000000     0 49633
39989 0x00000084
[26099350.815193]  ffff880001d27b88 0000000000000046 ffff88008a8184c0
ffff880001d28000
[26099350.815199]  ffff880001d27c18 ffffffff81e0a168 ffffffffa03d1df0
0000000000000000
[26099350.815204]  ffff880001d27ba0 ffffffff81619dd5 ffff88008a8184c0
0000000000000082
[26099350.815209] Call Trace:
[26099350.815213]  [<ffffffff81619dd5>] schedule+0x35/0x80
[26099350.815223]  [<ffffffffa03d1e0e>] rpc_wait_bit_killable+0x1e/0xa0 [sunrpc]
[26099350.815227]  [<ffffffff8161a1ea>] __wait_on_bit+0x5a/0x90
[26099350.815231]  [<ffffffff8161a32e>] out_of_line_wait_on_bit+0x6e/0x80
[26099350.815242]  [<ffffffffa03d2e7e>] __rpc_execute+0x14e/0x450 [sunrpc]
[26099350.815251]  [<ffffffffa03ca089>] rpc_run_task+0x69/0x80 [sunrpc]
[26099350.815259]  [<ffffffffa06dd166>]
nfs4_call_sync_sequence+0x56/0x80 [nfsv4]
[26099350.815267]  [<ffffffffa06ddc90>] _nfs4_proc_getattr+0xb0/0xc0 [nfsv4]
[26099350.815279]  [<ffffffffa06e7c83>] nfs4_proc_getattr+0x53/0xd0 [nfsv4]
[26099350.815288]  [<ffffffffa06a37c4>] __nfs_revalidate_inode+0x94/0x2a0 [nfs]
[26099350.815296]  [<ffffffffa06a3d7e>] nfs_getattr+0x7e/0x250 [nfs]
[26099350.815303]  [<ffffffff8121455a>] vfs_fstatat+0x5a/0x90
[26099350.815306]  [<ffffffff812149ca>] SYSC_newstat+0x1a/0x40
[26099350.815312]  [<ffffffff8161de61>] entry_SYSCALL_64_fastpath+0x20/0xe9
[26099350.817782] DWARF2 unwinder stuck at entry_SYSCALL_64_fastpath+0x20/0xe9


It is also not possible to access anything in usermode as it is not
possible to attach a debugger.

The development happened on SLES 12 SP4, Kernel version 4.4.162-94.72-default.

I am attaching some C and bash code for reproduction, the issue can be
triggered with SIGUSR1 (kill -USR1 PID) or any other one with changes
to the code. As for C, there is no difference in using signal() or
sigaction() to install the handler. The handlers are deliberately left
empty to be sure the is no "forbidden" function called inside.

Regards,

Stephan


C-Code:
================

#include <sys/stat.h>
#include <signal.h>

void sig_handler(int sig)
{
}


int main(void) {
  int ret;
  struct stat buf;
  signal(SIGUSR1, sig_handler);

  alarm(30);
  ret = stat("/a", &buf);

  return 0;
}


bash-Code:
=================

#!/bin/bash

sighandler() {
  declare unused
}

trap sighandler USR1

[[ -d /a ]] && echo "stat() returned"
