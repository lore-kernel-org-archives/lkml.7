Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B181C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F94A2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L0rWdGhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbfGONde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:33:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34786 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbfGONd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:33:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so15534943edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 06:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zV3/vbwe0/Qeasu0YBAGg2gUXm0o6TWO07FywBLuSLQ=;
        b=L0rWdGhfirmWchYFN/Q49dCPtNkTSUF3ESjkzSzpadWF5LFHu4NvYRUuhk+wNwHj3D
         mv/14J1m7xMRKxXNODwINfKzMhNmgo1C9L1BadzLgwBfp/t+zEe37+/YvPAyllAg1dX/
         bvYMmwDngb7snArunyuOmk242XB7+Alu5rmPDBDT7Xb5qOZS3D2AcJ+ZLT4MIX4pYNiI
         pRzhrQ0esLbdO4/EFBbPcX4u9puEdb+OX1NjQTvGCOChvfXte34esi7oseASPbcHYMHq
         eRam9KQbFBBkUyF2ZDX8gZmem8guJOs+oiK7kcbT+RXbL024SPqXfMXOfEtMRucPhzPd
         AA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zV3/vbwe0/Qeasu0YBAGg2gUXm0o6TWO07FywBLuSLQ=;
        b=jQtoCT1EKHlh2lsa35BbCcIEXvlz+gWX+fUEGgdPOIzYsGlZGORQaD3ZLSe+R2fomu
         rC7c8v8+1R26CoJxRUjAp/i6Cns0UtLG0Frx7KuZvpHDJmIf/jqdsVyqEbeWAlA+c1jH
         4TMQk1zfg6IDuQLAikq00vcG6i7s8SJula1FbwdWDsxE5PfG7jznsqfAprVaHDjXpCV1
         hf+mzf5QA2iWIZ7PieNvBZB0wnHMrfVoN96fh0pW6SDUKIqHArmGTXlhzcmBpAWPnOS1
         tT6d5+gw9VH7zUpCN0zSRPMGWShtU0GB9uFVr14VZUPhgFE3KOWRZucplgyPQgUyIu9d
         a/0w==
X-Gm-Message-State: APjAAAW2lQY9UfJQ5mCkFhjW6NKm7xyvo24ySr3TFOqM+YheghcGrFRD
        tlJ1LF7V8Qz73ZWDuX/TrRDC0H0J3yT7eo7/R7MD6w==
X-Google-Smtp-Source: APXvYqxiyIGV3CkBm6teN0cFq4U4X8od+WIc9m+37oG40chmdHcr6+lg/DGbEVZHpjhTDNKzo6KAT/7YUwUuInGxIX4=
X-Received: by 2002:a17:906:6dd4:: with SMTP id j20mr20664132ejt.173.1563197603166;
 Mon, 15 Jul 2019 06:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190705151658.GP26519@linux.ibm.com> <CACT4Y+aNLHrYj1pYbkXO7CKESLeB-5enkSDK7ksgkMA3KtwJ+w@mail.gmail.com>
 <20190705191055.GT26519@linux.ibm.com> <20190706042801.GD11665@mit.edu>
 <20190706061631.GV26519@linux.ibm.com> <20190706150226.GG11665@mit.edu>
 <20190706180311.GW26519@linux.ibm.com> <20190707011655.GA22081@linux.ibm.com>
 <CACT4Y+asYe-uH9OV5R0Nkb-JKP4erYUZ68S9gYNnGg6v+fD20w@mail.gmail.com>
 <20190714184915.GK26519@linux.ibm.com> <20190715132911.GG3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190715132911.GG3419@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 15 Jul 2019 15:33:11 +0200
Message-ID: <CACT4Y+bmgdOExBHnLJ+jgWKWQzNK9CFT6_eTxFE3hoK=0YresQ@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in ext4_write_checks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        syzbot <syzbot+4bfbbf28a2e50ab07368@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        David Miller <davem@davemloft.net>, eladr@mellanox.com,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 3:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Jul 14, 2019 at 11:49:15AM -0700, Paul E. McKenney wrote:
> > On Sun, Jul 14, 2019 at 05:48:00PM +0300, Dmitry Vyukov wrote:
> > > But short term I don't see any other solution than stop testing
> > > sched_setattr because it does not check arguments enough to prevent
> > > system misbehavior. Which is a pity because syzkaller has found some
> > > bad misconfigurations that were oversight on checking side.
> > > Any other suggestions?
> >
> > Keep the times down to a few seconds?  Of course, that might also
> > fail to find interesting bugs.
>
> Right, if syzcaller can put a limit on the period/deadline parameters
> (and make sure to not write "-1" to
> /proc/sys/kernel/sched_rt_runtime_us) then per the in-kernel
> access-control should not allow these things to happen.

Since we are racing with emails, could you suggest a 100% safe
parameters? Because I only hear people saying "safe", "sane",
"well-behaving" :)
If we move the check to user-space, it does not mean that we can get
away without actually defining what that means.

Now thinking of this, if we come up with some simple criteria, could
we have something like a sysctl that would allow only really "safe"
parameters?
