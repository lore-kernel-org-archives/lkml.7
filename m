Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A85C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DACF2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+LiQBxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfCLQJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:09:23 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53003 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCLQJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:09:22 -0400
Received: by mail-it1-f193.google.com with SMTP id g17so5282795ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cs8bpQIpyh1nWqzwuhSJny/sBnQKHVn54olgsbqWNZs=;
        b=G+LiQBxtFb/iqJ5o2oXPCROk2JVrKj1CzU4pP4cb2/1wJ0NDt0ZH4WLoSfHL/ARbCS
         wNI0duDH9CPHWb5dtLFM268/ml70Xx+sbfEGYdDY9MiTJEWH+w+mN0O895KtM5hYnid6
         1+ECNPto6EPalR4r32TmC6d3k7zNB4hhiugbo4LWS2agSt1RaNRFiE1HlJ8s2X/Go6TN
         F6rpThh2w9/H7p8oc4KUOvh5l7v4p1M8ZixYWgqjRJ+Mev2ZIDb4P+l4tGtB3+am8I3K
         vw6l8OZB0ocDVFr9hpSh7PRpqAgty3BkO+WRTKrNcavRN6Ab+qjon1dUIsbWcgzfmYck
         HTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cs8bpQIpyh1nWqzwuhSJny/sBnQKHVn54olgsbqWNZs=;
        b=OLCdgJocMn2vKlwehHnNBSK5XLw7f7/UUMUTQuQft9cpPO++shn9BKLAUCGoB6++DF
         fTmiNP1nPF1L8Iyn8/VEludEY6O8tmfhJP+gE9nmy+FjZj3XXXW3ofsrd5L/JTaW8K0z
         myw5xiSkl+PCbxhWiHJM9hDGg8cePVKCv6ykAj3pN/Mr/QDZiZUYYtLGS0hJACiBl0de
         CxwR04lXo+VL8EWk7jlSbak0kMI7zc3V1MaUH1q0AbblWpBK95Oov+mKW+q5lszJr/eU
         YnkssibRvo42/LJ9UPa5GvUOd15inHHc/v8JcHh5tY03CockeeQ0q+AVCueC7MIIeodv
         yJFw==
X-Gm-Message-State: APjAAAXvoqJRUJwVSNeV9xIkS2g9K8iy1MR/UOH1ybMqOV6+OFvMPYj9
        KjRSc4SlZcLWoFYqUsg16YJH9994KS48LlVqn9luFw==
X-Google-Smtp-Source: APXvYqz1DdBssrvfCb5IMvpIvzlIdjlOBWbyqW2snWJcrlWio439HvMts7+K/nEpL6lajPK0x3oJcsv2MauIkdJhfB8=
X-Received: by 2002:a24:674a:: with SMTP id u71mr2618056itc.12.1552406961041;
 Tue, 12 Mar 2019 09:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d7206e0583dfc6b3@google.com> <11a39c4b-9ac1-e55e-1773-534248a1d1d8@hartkopp.net>
In-Reply-To: <11a39c4b-9ac1-e55e-1773-534248a1d1d8@hartkopp.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 12 Mar 2019 17:09:08 +0100
Message-ID: <CACT4Y+ajX4nQVe-UEKCud87-bBhqL7Xaw9Gxh=JAGDg08q3Hyw@mail.gmail.com>
Subject: Re: WARNING in hsr_addr_subst_dest
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     syzbot <syzbot+b92e4f1472a54e1c7dec@syzkaller.appspotmail.com>,
        arvid.brodin@alten.se, Jens Axboe <axboe@fb.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Miller <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 1:03 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> Hi all,
>
> I'm not sure why a Kernel 4.12.0-rc2+ is used here, but I do not get any
> problems on the my latest 5.0.0-06622-g1fc1cd8399ab tree and I strongly
> assume this patch showing up in 4.12-rc6
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit?id=74b7b490886852582d986a33443c2ffa50970169
>
> fixes the problem.
>
> Best regards,
> Oliver

Hi Oliver,

You can see how bisection progressed and got to 4.12.0-rc2+ in the
bisection log.

The commit that it come up with looks unrelated.
I've started collecting such cases at:
https://github.com/google/syzkaller/issues/1051
and added for this case:

=====
Bisected to wrong commit.
Root cause: broken kernel boots, bugs that happen on all tests.
Boot is broken for several releases with "WARNING in hsr_forward_skb",
this switches to a bug that happens during every test "INFO: trying to
register non-static key in can_notifier", which then leads to a
completely random commit.
=====


> > commit ab42f35d9cb5ac49b5a2a11f940e74f58f207280
> > Author: Ming Lei <ming.lei@redhat.com>
> > Date:   Fri May 26 11:53:19 2017 +0000
> >
> >      blk-mq: merge bio into sw queue before plugging
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1681996f200000
> > start commit:   ab42f35d blk-mq: merge bio into sw queue before plugging
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=1581996f200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1181996f200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=b92e4f1472a54e1c7dec
> > userspace arch: amd64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107db700c00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12304827400000
> >
> > Reported-by: syzbot+b92e4f1472a54e1c7dec@syzkaller.appspotmail.com
> > Fixes: ab42f35d ("blk-mq: merge bio into sw queue before plugging")
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/11a39c4b-9ac1-e55e-1773-534248a1d1d8%40hartkopp.net.
> For more options, visit https://groups.google.com/d/optout.
