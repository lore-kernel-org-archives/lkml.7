Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3457CC76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6B121842
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usbj8W35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388477AbfGWHjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:39:08 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34630 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732967AbfGWHjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:39:08 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so79841109iot.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 00:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tM6ZfP29yHIXHkq5iTMeXQ4AjIL/XiZWUkv0a/I2jO4=;
        b=usbj8W35wjkWL0ZjAlNlOpJnA68U6AiUa2rQqc18HYqg/292MErMPXrVu08j64WLeQ
         0w/jTSSPy0WoIa1kquvmlS805CgCn/VEtUT7IrJmyzU18EllsyifJC7GjO7DcfmHvBvR
         1lyf1QQErv083xXVI6aqrUjw1695bMtzgRStNHuET/KnHMiXJnskh/TmNxT6IawrQ+EA
         TvKJRpwMnvXZIcBT5iMCnNwriaUgwmZ36nWR+ZeyE3vz2HWijcT5QBjh0ZbBFjG2YQqK
         UQW35jMAn/z+QawL1iqDcnfIDVcdW9nW1bK0w8F4SG8Eq6M2KAJD+fHb+ywbhzEI/nMR
         8nYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tM6ZfP29yHIXHkq5iTMeXQ4AjIL/XiZWUkv0a/I2jO4=;
        b=CHyN/ITv0jbrfXQUAn28ldSMOzcV2RtmtT8qSdbDqiyLc80/wTJXcTK/r0x2aYGbAq
         L8VMbtsMHfOANSrPUl7wbYnxAPd+CDMUaEm+TtXvQ4Pp49sT+sFR+eSMpgeSRXXJ6jVd
         L3C23DwWhdjjOreNskE0SGPZgmF8rbwUUocqJ/nKfci7xHgiA2XW4fnd8Ykqs1VD5n3N
         ue+0mrltDwIjTV+zbFQGEeHOT+WgYPoHNnwnPXfGD3UiU90dCxR42ND7FkUPcsaGZkLZ
         Ms3buIKELJgaKzpK5N++SofEaak7A1rXDKca8zBezknKK46mkUCWakWHkAJofG3LM3Bl
         rNrw==
X-Gm-Message-State: APjAAAVQGs63AJIXCmuzQYKSKvKvsPHtoVWHAqW9P2qYr+WAasnfdS7z
        bl4a992o3ZdWSkRVWharenDv5uqCaH7gxEnVQJ316g==
X-Google-Smtp-Source: APXvYqxknPLPiOAbuB7jqVAi6mu/Fl77yhGj6yGal1fmI4tdBfWn6NaR9DX5QN1Ija5E6QkqejVNYiWatG5/H9GGpW4=
X-Received: by 2002:a5e:de0d:: with SMTP id e13mr45601420iok.144.1563867546989;
 Tue, 23 Jul 2019 00:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001a51c4058ddcb1b6@google.com>
In-Reply-To: <0000000000001a51c4058ddcb1b6@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Jul 2019 09:38:56 +0200
Message-ID: <CACT4Y+ZGwKP+f4esJdx60AywO9b3Y5Bxb4zLtH6EEkaHpP6Zag@mail.gmail.com>
Subject: Re: kernel panic: stack is corrupted in pointer
To:     syzbot <syzbot+79f5f028005a77ecb6bb@syzkaller.appspotmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>
Cc:     David Airlie <airlied@linux.ie>, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, Alexei Starovoitov <ast@kernel.org>,
        christian.koenig@amd.com, Daniel Borkmann <daniel@iogearbox.net>,
        david1.zhou@amd.com, DRI <dri-devel@lists.freedesktop.org>,
        leo.liu@amd.com, LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 10:58 AM syzbot
<syzbot+79f5f028005a77ecb6bb@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    1438cde7 Add linux-next specific files for 20190716
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13988058600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
> dashboard link: https://syzkaller.appspot.com/bug?extid=79f5f028005a77ecb6bb
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111fc8afa00000

From the repro it looks like the same bpf stack overflow bug. +John
We need to dup them onto some canonical report for this bug, or this
becomes unmanageable.

#syz dup: kernel panic: corrupted stack end in dput

> The bug was bisected to:
>
> commit 96a5d8d4915f3e241ebb48d5decdd110ab9c7dcf
> Author: Leo Liu <leo.liu@amd.com>
> Date:   Fri Jul 13 15:26:28 2018 +0000
>
>      drm/amdgpu: Make sure IB tests flushed after IP resume
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a46200600000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=16a46200600000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12a46200600000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+79f5f028005a77ecb6bb@syzkaller.appspotmail.com
> Fixes: 96a5d8d4915f ("drm/amdgpu: Make sure IB tests flushed after IP
> resume")
>
> Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in:
> pointer+0x702/0x750 lib/vsprintf.c:2187
> Shutting down cpus with NMI
> Kernel Offset: disabled
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
