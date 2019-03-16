Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01447C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 09:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23D7218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 09:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fnnUu83/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfCPJLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 05:11:30 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:33654 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfCPJLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 05:11:30 -0400
Received: by mail-it1-f196.google.com with SMTP id f186so12376582ita.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 02:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DdrMkyI296J2tH/hadTGJxp72dux7chodyRZMLxpGQw=;
        b=fnnUu83/ERwiUwiOlT5lhd1mrY0u7BGlXzkkdQsQhdbYrTjvjwuh073HIieXM8wjgz
         3o7RsDXAud+o46px7kyAXTVm3S4lzN2UbsaZ6ufRN884l25nMRx+39pYLXd8qycq/KO8
         k6kzNdeu7hX2E4ZR3WnOL/xh8miBYMzoBnoyZ5hGYHLBXmOh/1ekLLYMiZPULQox11AC
         +kL31rFyVIIx8eUYi4xjuz+O2y1K5HQglV1lziL4tDLziv3x2U2Mzsgt/M/y2wgM7BmU
         XOhF8KjMEQlcBR2nRDw8qrH5tDZyfJaNAL1iBKen7mb6jzjByBd6SysAim1V3609Z3FZ
         dvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DdrMkyI296J2tH/hadTGJxp72dux7chodyRZMLxpGQw=;
        b=WhdGZs0jiMzURyGo40o2VGk8qnIYO+22Fy3HMn0nGA8J4qnMUp+wQlY73DKPgS7aP3
         dnjTfJ6PA12WXdQ9SRgiPOyKjMK6sCb87PyMlOdj32QVwUvWJasrPPYzO6V0sYrAOwaf
         A0Jm9hM7L/nPQAIAM1ow/jr0mFZVIpo3PR2wUAF1sDbfipMAZdTVormVCfGRSWA9qY7+
         bOIPThXxsMDuCIe2jOEp0XeLj2jkLOJDbwG58bUyZJqDXNHVnHlU+dw6vcKkdCiRBlIB
         N8iQXmyO7QxnpkrN92j88d51RDqRwcKz20YA4cIYQvzXqNuEorjlA2W0pm+tY0JEdobK
         rO5Q==
X-Gm-Message-State: APjAAAWHNXsqq8QK4gQqtvvTFecf4Q9LsVubV/UrONm/2KE7jljD0LbC
        ybgvz50DFVyKOZEGhjKnujRcszJ5noePUA0SURpXWw==
X-Google-Smtp-Source: APXvYqxUiwiy3xiiFkxdYs8IkawxDErpCe/xMIV2IzD98LenKTSI/bRxBaBQRzbWfaPD1fcSIt5Guliz9nD4BEaNp5w=
X-Received: by 2002:a02:5986:: with SMTP id v6mr5105371jad.35.1552727488382;
 Sat, 16 Mar 2019 02:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <0a0d282b-6757-5f42-b888-ef52b040aaa1@i-love.sakura.ne.jp>
In-Reply-To: <0a0d282b-6757-5f42-b888-ef52b040aaa1@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 16 Mar 2019 10:11:17 +0100
Message-ID: <CACT4Y+ZBpfLpk0FRp7O8Ut=mmf-uddK_fLMDHtPkf6FnMGMqPA@mail.gmail.com>
Subject: Re: [syzbot? printk?] no WARN_ON() messages printed before "Kernel
 panic - not syncing: panic_on_warn set ..."
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 3:09 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Hello.
>
> I found a corrupted report at https://syzkaller.appspot.com/text?tag=CrashLog&x=17c6b82b200000 .
>
> The panic() was caused by by WARN_ON() from generic_make_request_checks(), but there
> was no printk() messages from WARN_ON(). Moreover, there was no printk() messages
> for (at least) nearly one minute despite syzbot's testing likely generates constant
> printk() messages. Unfortunately, since the report was truncated due to size limit,
> we can't check when was the last time prink() succeeded writing messages to consoles.
>
> ----------
> 14:27:02 executing program 1:
> (...snipped...)
> 14:28:00 executing program 3:
> (...snipped...)
> [  974.068065][T22281] Kernel panic - not syncing: panic_on_warn set ...
> [  974.085454][T22281] CPU: 1 PID: 22281 Comm: syz-executor.1 Not tainted 5.0.0+ #23
> [  974.093121][T22281] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> [  974.103193][T22281] Call Trace:
> [  974.106513][T22281]  dump_stack+0x172/0x1f0
> [  974.110893][T22281]  ? generic_make_request_checks+0x1be0/0x2160
> [  974.117235][T22281]  panic+0x2cb/0x65c
> [  974.121434][T22281]  ? __warn_printk+0xf3/0xf3
> [  974.126064][T22281]  ? generic_make_request_checks+0x1ca3/0x2160
> [  974.132257][T22281]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
> [  974.138521][T22281]  ? __warn.cold+0x5/0x45
> [  974.142877][T22281]  ? __warn+0xe8/0x1d0
> [  974.146978][T22281]  ? generic_make_request_checks+0x1ca3/0x2160
> [  974.153171][T22281]  __warn.cold+0x20/0x45
> [  974.157483][T22281]  ? vprintk_emit+0x1ce/0x6d0
> [  974.162202][T22281]  ? generic_make_request_checks+0x1ca3/0x2160
> [  974.168403][T22281]  report_bug+0x263/0x2b0
> [  974.172847][T22281]  do_error_trap+0x11b/0x200
> [  974.177646][T22281]  do_invalid_op+0x37/0x50
> [  974.182329][T22281]  ? generic_make_request_checks+0x1ca3/0x2160
> [  974.188951][T22281]  invalid_op+0x14/0x20
> [  974.193142][T22281] RIP: 0010:generic_make_request_checks+0x1ca3/0x2160
> ----------
>
> Is it possible that the reason there was no printk() messages is that
> someone kept printing messages to console from userspace such that
> console_trylock() from printk() was not able to succeed for (at least)
> nearly one minute?

Such reports showed up always with low frequency. For all that I
looked at we also always had a normal  non-truncated version, so I was
never too worried.

If something would write from userspace, that would show up in the
output, or not?

Perhaps syzkaller somehow manages to lower console output level? I
figured out that we should restrict it from doing
syslog(SYSLOG_ACTION_CONSOLE_OFF). And I also restricted its access o
/dev/console. But maybe there is something else? It _should_ not be
able to write to random sysctl's.
