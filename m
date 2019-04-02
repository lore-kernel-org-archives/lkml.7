Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BED5C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75AB206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n+rV/5fG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbfDBNM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:12:28 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41856 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbfDBNM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:12:28 -0400
Received: by mail-io1-f65.google.com with SMTP id v10so10814214iom.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 06:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1Zv9oIMBlSOxaFJX75opL8ABc4nczi1pNy0lF7sSs0=;
        b=n+rV/5fGNKDJfXRpCGdiELY4+kp0GsEJYhVCmvExEaBkLWMahJ0YpeS2FnZPDACnYn
         mIRs6lR+Ml1jjfpxUkWxoGhIjKfqk1cTbxgGwin935lj6AbbjMt3JjIcd9WKu64oEON1
         GlLHkmr/MO3xCZ9y2T7W5hqlCj3m54dayZiUQSk1FXl2N1QxmRaYWx/+ay3no7RwXRAc
         ohU1edjgJkSc3Fz59r9sgL2ixwlhPGdz3IIldngwY4eUKjFaSKL1M9mCKoBKx4fmu7W3
         co+HNdoAwOogjn41hc8X6L0e0XQgbw+3pIT6cYoYPIm50VjnCISVg8dHZ5KpyauZHuzG
         ulmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1Zv9oIMBlSOxaFJX75opL8ABc4nczi1pNy0lF7sSs0=;
        b=qf/ISQXfU+7pCk4d0eJM1eoeKNHk9Ic1oc2EGa3WuoYpsGa5wHfMQ/X1mJCbzXqX+Q
         h6AxRR721EV9z2Wm76H+eO0Cr2ucZ67MGDSHvuHRUS5qq+2qttI+qhZpB/EJNuwDa8ft
         hwN0qSBP2izrfwLyZdkRJixHev3bPHvjlQSdwDIZkBBoGtj/9wZxsXvNVepugaykV9J5
         UyhLf2r83r9fzM0vSqoh6xx7cQftaSN26tvzLOeZbmsdwh8FH7sZNtsOTQZ2SpjdWbSB
         YT8Wpc1gVM8/R7Zj49d4lcapAOMpUSB+dr6lzUfjphTcfV2/BePLRr6BsPfa9V3oIg7j
         ITMA==
X-Gm-Message-State: APjAAAWpoYPzITT6VDWzcWY2NclRAdPpLz6gumfxxcXsBEFdrSd9bF6a
        XozVEqE5KXVti3KuSnjdulgsjVv4hENRHyWI2pq1DQ==
X-Google-Smtp-Source: APXvYqzsdHGACI6s8caYtfYJ9PxD/A1KvOuiC2pbr1mbrmokHKBWqTcji8zy4oja5Q66+Ultx+6VM4YDLtvSjj6pB8o=
X-Received: by 2002:a5d:855a:: with SMTP id b26mr33226530ios.151.1554210747211;
 Tue, 02 Apr 2019 06:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004f7eb00570be9f92@google.com> <0000000000002402ed05857361e0@google.com>
 <20190401192413.GQ4102@linux.ibm.com>
In-Reply-To: <20190401192413.GQ4102@linux.ibm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 2 Apr 2019 15:12:16 +0200
Message-ID: <CACT4Y+ZBxcwq+s9HbrVRFFt04Ri+MyVR9CQ=pp-5D13LzVngdg@mail.gmail.com>
Subject: Re: WARNING in port_delete
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     syzbot <syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com>,
        alsa-devel-bounces@alsa-project.org, alsa-devel@alsa-project.org,
        Colin King <colin.king@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 9:25 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> On Mon, Apr 01, 2019 at 12:58:01AM -0700, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit 63d86a7e85f84b8ac3b2f394570965aedbb03787
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Tue May 1 20:08:46 2018 +0000
> >
> >     rcu: Convert rcu_grace_period_init tracepoint to gp_seq
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f86d2f200000
> > start commit:   091a1eaa Merge branch 'akpm'
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=14046d2f200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10046d2f200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e4c8abb920efa77bace9
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102e2c91400000
> >
> > Reported-by: syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com
> > Fixes: 63d86a7e85f8 ("rcu: Convert rcu_grace_period_init tracepoint
> > to gp_seq")
>
> I could easily be suffering from a lack of imagination, but I am not
> seeing how this change to RCU's event tracing could cause this result.
> Especially given that CONFIG_RCU_TRACE=n in your .config.
>
> What am I missing here?

I don't think you are missing something here.
