Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE087C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F30D20989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfCSAmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 20:42:21 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:44049 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCSAmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 20:42:21 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2J0fgXM060133;
        Tue, 19 Mar 2019 09:41:42 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Tue, 19 Mar 2019 09:41:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2J0ffTB060126;
        Tue, 19 Mar 2019 09:41:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x2J0ff1x060125;
        Tue, 19 Mar 2019 09:41:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201903190041.x2J0ff1x060125@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: =?ISO-2022-JP?B?W3N5emJvdD8gcHJpbnRrP10gbm8gV0FSTl9PTigpIG1lc3NhZ2Vz?=
 =?ISO-2022-JP?B?IHByaW50ZWQgYmVmb3JlICJLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2lu?=
 =?ISO-2022-JP?B?ZzogcGFuaWNfb25fd2FybiBzZXQgLi4uIg==?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
MIME-Version: 1.0
Date:   Tue, 19 Mar 2019 09:41:41 +0900
References: <CACT4Y+aM0P-G-Oza-oYbyq2firAjvb-nJ0NX21p8U9TL3-FExQ@mail.gmail.com> <CACT4Y+bHJDc17VZhRK4W5_zoEbbe0OO677hi6U-c-oWs+iZNLg@mail.gmail.com>
In-Reply-To: <CACT4Y+bHJDc17VZhRK4W5_zoEbbe0OO677hi6U-c-oWs+iZNLg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote:
> On Mon, Mar 18, 2019 at 1:32 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > Wait, but isn't SYSLOG_ACTION_CONSOLE_LEVEL what we are looking for?
> > syzkaller knows about the syslog syscall:
> > https://github.com/google/syzkaller/blob/13026d10f09f0e801c342e6c009ff580d49b894b/sys/linux/sys.txt#L322
> > and even though it does not know SYSLOG_ACTION_CONSOLE_LEVEL const, it
> > can guess that number.
> 
> I've restricted fuzzer from invoking SYSLOG_ACTION_CONSOLE_LEVEL.
> Let's see if it helps.
> 

Oh, coverage page says that

        /* Set level of messages printed to console */
        case SYSLOG_ACTION_CONSOLE_LEVEL:
                if (len < 1 || len > 8) /*covered*/
                        return -EINVAL;
                if (len < minimum_console_loglevel) /*covered*/
                        len = minimum_console_loglevel;
                console_loglevel = len;
                /* Implicitly re-enable logging to console */
                saved_console_loglevel = LOGLEVEL_DEFAULT;
                break;

fuzzer was indeed testing SYSLOG_ACTION_CONSOLE_LEVEL case. ;-)
