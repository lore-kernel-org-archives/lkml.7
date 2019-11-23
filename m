Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05603C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 06:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F642070E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 06:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ef4pBY7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfKWGwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 01:52:38 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42163 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfKWGwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 01:52:38 -0500
Received: by mail-qt1-f193.google.com with SMTP id t20so10606414qtn.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 22:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P+MUZ1y2xb9PhY7+WKJzGw1iInQZnQRbBnrxCn4UQzw=;
        b=ef4pBY7xeFKFfeQ/8fzoBtrVicRJxFcNv7xwZsVE9YZFB7OBVPVFbdxHC66O3jBsXS
         kSO2Qg57e2UCBOtT7P3IdscYIZRF1sAbTXGNsuv78EbZ2oNQK48+yBd0fsSK4Vw/87Jp
         ZQxW2xuyAvXmL/koRI3Bqlxh8WPdUDRqr7BR33qnH8Ri5603dDwQxHzy3UBys5pKdShU
         EfuBt6tK9bBhsB6Ryl/YyG2R3mCFm7E/BKb56qV+35we7vLeMTDcWz+OxS2WOQqjCAXG
         ny+h43woX108oFb4ptQp5vPXaCcQBbAUiACKS08iXmBdo05M6nBaczjFDA+62NNx6wFp
         KHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P+MUZ1y2xb9PhY7+WKJzGw1iInQZnQRbBnrxCn4UQzw=;
        b=hd4sa7nErDj7pfAIQtUEMf7Hxv/7N5uLHndiqAhF8CIYmdbUDJDi9DSmV8B/Wd+Fk0
         Bxud2wPLr+y30e9gYalk84wCodj8HhfYcauu4aemLlYiyxqIay2UpE6LkORhuOyJwqHw
         hB5JdFXpwieT4JUKPTemLeTspVkxFy7GGO7WxY0n4b+7KfJj/7WRt6bxEfRCrft+mxje
         Qtzb4Li6W8GIDLX7Mt/AH6sfHULkrzN6v4mZqSS/05RjnsrOl+avhUK7niMeQ1T+Rdkq
         EUnRD9l1CUL1vw8/XW02XoyXCWTtm4us2EUHlnmwx2Q4LK4nPm9f7J3uuNaE89B+o2EU
         PLVg==
X-Gm-Message-State: APjAAAV9lER0K7ezwaMsjnsn2sWO9mmHCWR5knMhxF8Md9GJLIKqi0Xw
        GoXhbMl8qW2T6lJfBrCfb1GmFqH6cHKDPuRrr8FiaA==
X-Google-Smtp-Source: APXvYqxRxRqDo8SO2OOlMLZfct/me9RRZCPwi7R45+Yk8t+IxHBz+O3PzExEgN5YTAvYjB2pKNIM8zj3NhGe7QGyzkI=
X-Received: by 2002:aed:24af:: with SMTP id t44mr4069018qtc.57.1574491957069;
 Fri, 22 Nov 2019 22:52:37 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003313f0058fea8435@google.com> <8736ek9qir.fsf@miraculix.mork.no>
 <1574159504.28617.5.camel@suse.de> <87pnho85h7.fsf@miraculix.mork.no>
In-Reply-To: <87pnho85h7.fsf@miraculix.mork.no>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 23 Nov 2019 07:52:25 +0100
Message-ID: <CACT4Y+YgLm2m0JG6qKKn9OpyXT9kKEPeyLSVGSfLbUukoCnB+g@mail.gmail.com>
Subject: Re: INFO: task hung in wdm_flush
To:     =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc:     Oliver Neukum <oneukum@suse.de>,
        syzbot <syzbot+854768b99f19e89d7f81@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 12:34 PM Bj=C3=B8rn Mork <bjorn@mork.no> wrote:
>
> Oliver Neukum <oneukum@suse.de> writes:
> > Am Dienstag, den 19.11.2019, 10:14 +0100 schrieb Bj=C3=B8rn Mork:
> >
> >> Anyway, I believe this is not a bug.
> >>
> >> wdm_flush will wait forever for the IN_USE flag to be cleared or the
> >
> > Damn. Too obvious. So you think we simply have pending output that does
> > just not complete?
>
> I do miss a lot of stuff so I might be wrong, but I can't see any other
> way this can happen.  The out_callback will unconditionally clear the
> IN_USE flag and wake up the wait_queue.
>
> >> DISCONNECTING flag to be set. The only way you can avoid this is by
> >> creating a device that works normally up to a point and then completel=
y
> >> ignores all messages,
> >
> > Devices may crash. I don't think we can ignore that case.
>
> Sure, but I've never seen that happen without the device falling off the
> bus.  Which is a disconnect.
>
> But I am all for handling this *if* someone reproduces it with a real
> device.  I just don't think it's worth the effort if it's only a
> theoretical problem.
>
> >>  but without resetting or disconnecting. It is
> >> obviously possible to create such a device. But I think the current
> >> error handling is more than sufficient, unless you show me some way to
> >> abuse this or reproduce the issue with a real device.
> >
> > Malicious devices are real. Potentially at least.
> > But you are right, we need not bend over to handle them well, but we
> > ought to be able to handle them.
>
> Sure, we need to handle malicious devices.  But only if they can be used
> for real harm.
>
> This warning requires physical acceess and is only slightly annoying.
> Like a USB device making loud farting sounds.  You'd just disconnect the
> device.  No need for Linux to detect the sound and handle it
> automatically, I think.

Hi Bj=C3=B8rn,

Besides the production use you are referring to, there are 2 cases we
should take into account as well:
1. Testing.
Any kernel testing system needs a binary criteria for detecting kernel
bugs. It seems right to detect unkillable hung tasks as kernel bugs.
Which means that we need to resolve this in some way regardless of the
production scenario.
2. Reliable killing of processes.
It's a very important property that an admin or script can reliably
kill whatever process/container they need to kill for whatever reason.
This case results in an unkillable process, which means scripts will
fail, automated systems will misbehave, admins will waste time (if
they are qualified to resolve this at all).
