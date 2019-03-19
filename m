Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA867C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847FE2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BH1MaezJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfCSNfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:35:21 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34860 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfCSNfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:35:20 -0400
Received: by mail-io1-f68.google.com with SMTP id x4so17770498ion.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 06:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8BJgikwPixRTAC/aBfsCOsS16RBkhpu5FTQ4DfsLnjQ=;
        b=BH1MaezJ4ub9SVKuEuEyVZUYSQCvOprmAE2z7uQnVNxwFmKNYtX1poGRXQjqTmH+Lg
         v7npOx9l6CXLKi4db2uAEf8uKj+LT+eBaZOfkAEQRjtRnt18PhDqDG7g4tkJnQMrQ+/H
         /RBZHAWUPdeTWMiu7iZs7JdMpRTAmcyG0QT1nCG2MS8nqzRrSkciZItYQaMTGlJU99o3
         iGuVLXSb/omqOKF380ydNA2qf3orTBtyR7+xdnpbjtF2bxEViceDle4zoZiBF1ny5Hb7
         TZbvZ4QsYQQM6GNQE2Mjd0s90uW4vlbQMTZI1sFqrkPbsA0TzWXG8XEE2nB0/S0IVV79
         9dfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BJgikwPixRTAC/aBfsCOsS16RBkhpu5FTQ4DfsLnjQ=;
        b=VgLmJCpFmSb9ZevHHnNe49g1OapI10QwqpZhtDU/PU/szUBPyjVP3IeNcRSRRGgzwH
         V1C+YM3xP/0hUqx4WhOvC7P+VDg9mZh73Z9Pe7VBkye4GAHaWwbiN4BHcSUzw8MlCpMD
         Pi/RorB4hFWFhKij/KHn3m14VwIoxLr/2Pl6PX6vs6+PToZ14oxu2EFs5Pb2YfiAX+mi
         7q2jtLU5zaIcz936xwTcHulw5OWXMQYvOLADwB7XEvoLtd9T4nW5XT1HNI/omXdzwvx5
         lu+mPzpCzCVNil3YXDZHWRCaxePBfFniT0WLMIsmYz1yZUsRvRciXVGZ3M+wtVbwO3uA
         q0/g==
X-Gm-Message-State: APjAAAUTYXMRU2fEGJILARaR0oztmHkrq7nPr491cSvtjxZZn15Q9LM6
        UetqBNpKkzCfznQ3XOIjQjvEbL10pLUNFBnX5myWXA==
X-Google-Smtp-Source: APXvYqz0cuMuoUUP5o5k5zdqe/xIMjcja+FyfwJG5w238Oahzo91LVZYwL8VxCjevdkNL11DeT2Bq+TvtBihjmkn6zo=
X-Received: by 2002:a6b:3709:: with SMTP id e9mr1222652ioa.282.1553002519338;
 Tue, 19 Mar 2019 06:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <2a48dee7-b649-65a4-be5d-8b3374013cee@i-love.sakura.ne.jp>
 <CACT4Y+ay7nuT-7y2JARozV1s0VisuLdN6VT+w9OsEDs1PeBRoA@mail.gmail.com>
 <201903180527.x2I5RQVp009981@www262.sakura.ne.jp> <CACT4Y+bosgWpJ=s9_hQ-Jg_XJoSHR9S-zC3es-2F=FTRppEncA@mail.gmail.com>
 <CACT4Y+aM0P-G-Oza-oYbyq2firAjvb-nJ0NX21p8U9TL3-FExQ@mail.gmail.com>
 <20190318125019.GA2686@tigerII.localdomain> <CACT4Y+ZedhD+=-YyvphZvLCcCF3FM0YAjXX54K2kMkhNmV4axw@mail.gmail.com>
 <20190318140937.GA29374@tigerII.localdomain> <CACT4Y+Z_+H09iOPzSzJfs=_D=dczk22gL02FjuZ6HXO+p0kRyA@mail.gmail.com>
 <20190319123500.GA18754@tigerII.localdomain>
In-Reply-To: <20190319123500.GA18754@tigerII.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 19 Mar 2019 14:35:07 +0100
Message-ID: <CACT4Y+ZhHvsVZh1pKzK1tn-P78rOssOz=7eWkXz7z2Sh1JscdA@mail.gmail.com>
Subject: Re: [syzbot? printk?] no WARN_ON() messages printed before "Kernel
 panic - not syncing: panic_on_warn set ..."
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 1:35 PM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> On (03/19/19 09:10), Dmitry Vyukov wrote:
>
> [..]
>
> > In some setups we read out output with "dmesg -w" (should stream
> > output as well) in absence of a better solution. Will this be affected
> > by SYSLOG_ACTION_CLEAR?
>
> There is a small chance that syslog/devkmsg can be affected
>
>         syslog_clear()
>         {
>                 clear_seq = log_next_seq;
>                 clear_idx = log_next_idx;
>         }
>
>         syslog_print_all()
>         {
>                 ...
>                 seq = clear_seq;
>                 idx = clear_idx;
>                 while (seq < log_next_seq) {
>                 ...
>                         len += msg_print_text(msg, true, time, NULL, 0);
>                 }
>                 ...
>         }
>
> devkmsg also may be affected
>
>         syslog_clear()
>         {
>                 clear_seq = log_next_seq;
>                 clear_idx = log_next_idx;
>         }
>
>         devkmsg_llseek()
>         {
>         ...
>                 case SEEK_DATA:
>                         user->idx = clear_idx;
>                         user->seq = clear_seq;
>                         break;
>         ...
>         }
>
> user->idx/user->seq then are used in devkmsg poll()/read(). syslog is
> more likely to be affected, I think.

SYSLOG_ACTION_CLEAR is disabled:
https://github.com/google/syzkaller/commit/28c04d39e052ee2960eebc16a3f7fba88920cd52
