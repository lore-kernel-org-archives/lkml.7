Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAF2C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C662176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cM7lGvan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfK1Iyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:54:31 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38986 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfK1Iy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:54:29 -0500
Received: by mail-qv1-f67.google.com with SMTP id v16so10031486qvq.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 00:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HoqmZ4ISGst+6RxBOTmccwmK74t4nIgQ0Amev8cPgJw=;
        b=cM7lGvanWO5KiySXbzZYYcyrA6cgoAnT7nFXRAyOZh1whtmTQn7+SREmxD8m2HFExg
         ZJTsDpaLLOX0RWst+X5UrTSn4MSOol0pqlgKEs2hfycLAGBl2V75cW8BAcy03nr+9UHu
         O3VSnrploTWsSndKiNJWN98XCGaKsd+dogwMqEY5xD9H5+YCUC/c0DYmEL+iL6KuKyEE
         xwdLNQ4G1Y+ixl27uFSGtaEsfRk08Jprnp6Jk507XQ2+l0SL3FqgwaSTJ7xWF7eSYDtu
         89u/jkRigRPi66mttLx1EgLjn3M2n7B+AasFgU4AFuolX7BzG6nFUEWR45Id8SavuzfE
         jRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HoqmZ4ISGst+6RxBOTmccwmK74t4nIgQ0Amev8cPgJw=;
        b=dsqgjZDtVEaxEUEju2wOd6OB9+FKGG5KsB2jNeYfKqXmqCQ3kv7anm/2/6stigcSID
         DYDiAtxs63l7f6broF7x+Wljfys65u7WmppjQMnkfDxVPlqo65EO8im9ntg5rIkRMblZ
         OM0g7Jg+QywQ7YwSxVEBJzMQD4lwbd1WD+GH2arfvgvr3wAp2/O7LQPH1PYLyweIJD6V
         nVMYfIuLNJnm1PLHEPGDQy075zASY7hIf16epf2VDBLSt9kB+2/7n0Aqudbg3yallzWG
         0xb5VMygKGQ2ZooYM+1JX+YFLk9a8wJ/wPpoFqFLLObWJiBqk11ckovtEcTJ/zyLy17P
         TzQQ==
X-Gm-Message-State: APjAAAVn3pIJM9/WztGW5yi2ujzXw/zJm6kQzMW2RSpMnOY38KzsKWtG
        xvQKPudsAtC5jgbTVHeHD5EPqhgxKd5oL4LNcfaXlA==
X-Google-Smtp-Source: APXvYqwketckvdqNsCiapXjNAvjDeAQUljd4H4OG+vca5gsS5F+c5jxbOi0LjNMMxQMyhUr3JUWAVPy9Os8b4xje1Fs=
X-Received: by 2002:a05:6214:8ee:: with SMTP id dr14mr9867650qvb.122.1574931266487;
 Thu, 28 Nov 2019 00:54:26 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009aa32205985e78b6@google.com> <2825703.dkhYCMB3mh@sven-edge>
 <CACT4Y+YwNGWCXBazm+7GHpSw-gXsxmA8NA-o7O7Mpj3d-dhGYA@mail.gmail.com> <1809369.KjlzdqruN6@sven-edge>
In-Reply-To: <1809369.KjlzdqruN6@sven-edge>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Nov 2019 09:54:15 +0100
Message-ID: <CACT4Y+abQSWfiN16BwXFOBi+d3CFGk53oj+5+zZwQPbcYu-Rew@mail.gmail.com>
Subject: Re: WARNING in mark_lock (3)
To:     Sven Eckelmann <sven@narfation.org>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        syzbot <syzbot+a229d8d995b74f8c4b6c@syzkaller.appspotmail.com>,
        a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>,
        LKML <linux-kernel@vger.kernel.org>, mareklindner@neomailbox.ch,
        netdev <netdev@vger.kernel.org>, sw@simonwunderlich.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        vinicius.gomes@intel.com, wang.yi59@zte.com.cn,
        Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 9:46 AM Sven Eckelmann <sven@narfation.org> wrote:
>
> On Thursday, 28 November 2019 09:40:32 CET Dmitry Vyukov wrote:
> > On Thu, Nov 28, 2019 at 8:25 AM Sven Eckelmann <sven@narfation.org> wrote:
> > >
> > > On Thursday, 28 November 2019 03:00:01 CET syzbot wrote:
> > > [...]
> > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132ee536e00000
> > > > start commit:   89d57ddd Merge tag 'media/v5.5-1' of git://git.kernel.org/..
> > > > git tree:       upstream
> > > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=10aee536e00000
> > >
> > > Can the syzbot infrastructure be told to ignore this crash in the bisect run?
> > > Because this should be an unrelated crash which is (hopefully) fixed in
> > > 40e220b4218b ("batman-adv: Avoid free/alloc race when handling OGM buffer").
> >
> > +syzkaller mailing list for syzbot discussion
> >
> > Hi Sven,
> >
> > There is no such functionality at the moment.
> > What exactly do you mean? Somehow telling it interactively? Or
> > hardcode some set of crashes for linux? I don't see how any of these
> > options can really work...
>
> I was thinking more about rerunning the same bisect but tell it to assume
> "crashed: general protection fault in batadv_iv_ogm_queue_add" as OK instead
> of assuming that it is a crashed like the previous "crashed: WARNING in
> mark_lock". Just to get a non-bogus bisect result. Or try to rerun the
> bisect between 40e220b4218b and 89d57dddd7d319ded00415790a0bb3c954b7e386

But... but this done by a program. What do you mean by "tell it"?
