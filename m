Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED06C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5A42075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VM8lzwwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfC1IVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:21:46 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:33985 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfC1IVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:21:45 -0400
Received: by mail-it1-f196.google.com with SMTP id l4so7698231ite.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 01:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2s0o2wptDgdU1RZ20vo/vyQzS4JpdfMk071h3j4mQfo=;
        b=VM8lzwwArlqnDhvMa8tbC5yEvNN0g2LrTFRuW6RQMMKBNlbmwnnqzJNiRsmDL/8W1y
         lmIb3eGigEXP2e6mA/mptlpgYHtM63pe+ZK2KOt/0BhPKW1KtqxKZEhZHsvRQcrIerfv
         MOYe2xU1GSrcIiH7N2upE0F412SX+eQ2ztzEAboVJBkFJjiyKJXJKVbIkNW5zmUyE+1C
         qEZLNa4PUx5aI1OhSnqhZuiJa2RxgVMpq/dcTFOyt4Ps0ldf1GCZjF/d6ihptNdZnOmK
         7b66EPWszYSrGOPMu+0X/+uA1eCHQLnLPUeVoyvjvgXJ4D7BRRqn7X6Ce3QHJIamSDI6
         PNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2s0o2wptDgdU1RZ20vo/vyQzS4JpdfMk071h3j4mQfo=;
        b=Z3sqXZkom+WLN9r0TjRcSPbHCl6T6Tt9snfuISf+5TLKidQZLlR80nxoP0Vxo6aOgx
         yF3g4wsVLFhYnULjpUodpENu48jIlTbxG+gGbf2WYzyzFLE6b/QlOaSrW6EuAa5KRwhw
         isoyfmDTOxToNkuqzxVQRRN+Hf6e9HoazBupW8vSXVQ2YaJCNc1Z3GT+34oyja2w2Il3
         uv5VybnQXctwUIz2trdT+f+MsEAeaIdo0cL7rXb39bsztkaz5grFHmnO4ezwzD9pr2xZ
         ojf++LSb0gwAFV63oZziZrlZxmb9xcQuQeOOkIBQmgO/CccyjHvHvJbC+Rzx8agOiaTt
         Jikg==
X-Gm-Message-State: APjAAAVIvJi2Mg4QBtDrt/78NGsC5T6/hGfTR5j6LHlJRUHofiE0xxND
        fKAaYI1ULWSbS7hfRaODJHbRGyOcOwB8NeVaTDd4zw==
X-Google-Smtp-Source: APXvYqyRpZNY8UmDVU/v8+MIYn+n34yz+4n6tPfZednK/MYGZlOTbgk55oq1DnL11+uiJA/lIhMUYeu5aFCpTwwVZRg=
X-Received: by 2002:a24:605:: with SMTP id 5mr6223512itv.144.1553761304559;
 Thu, 28 Mar 2019 01:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000036e81e058507565b@google.com> <alpine.LNX.2.21.1903271021290.994@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1903271021290.994@nippy.intranet>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Mar 2019 09:21:33 +0100
Message-ID: <CACT4Y+Ya21HPJVEcsGRgZLK+F+Q5kV-fEp3O755GC9WWB_D=DA@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in __perf_sw_event
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     syzbot <syzbot+a41ac89a0712acde0e84@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        funaho@jurai.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        jolsa@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 12:28 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> On Tue, 26 Mar 2019, syzbot wrote:
>
> > syzbot has bisected this bug to:
> >
> > commit cf85d89562f39cc7ae73de54639f1915a9195b7a
> > Author: Finn Thain <fthain@telegraphics.com.au>
> > Date:   Fri May 25 07:34:36 2018 +0000
> >
> >    m68k/mac: Enable PDMA for PowerBook 500 series
> >
>
> Looks like a false positive. But if you really are running syzkaller on a
> PowerBook 500, you'll want to check that you have an FPU, otherwise a CPU
> erratum will probably mess up your results.

Agree. I've included it into the big bisection analysis as "hard to
reproduce" case:
https://lkml.org/lkml/2019/3/27/788


> --
>
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1226cb8b200000
> > start commit:   b0314565 Merge tag 'for_linus' of git://git.kernel.org/pub..
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=1126cb8b200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1626cb8b200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8f00801d7b7c4fe6
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a41ac89a0712acde0e84
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1707cd2f400000
> >
> > Reported-by: syzbot+a41ac89a0712acde0e84@syzkaller.appspotmail.com
> > Fixes: cf85d89562f3 ("m68k/mac: Enable PDMA for PowerBook 500 series")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/alpine.LNX.2.21.1903271021290.994%40nippy.intranet.
> For more options, visit https://groups.google.com/d/optout.
