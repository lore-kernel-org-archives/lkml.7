Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302FAC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DB32085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XHHvp/NM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389156AbfKGQj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:39:56 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:32824 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbfKGQj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:39:56 -0500
Received: by mail-io1-f66.google.com with SMTP id j13so3028998ioe.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 08:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmNJnREVJGnaaEVeLxsBm0Njwp2E0f+PM+J5gi1eqbs=;
        b=XHHvp/NMTOUmt9odTSBMZfZ6Fd8oFGBV5ygxerSm6CUQkj7ciP+w9t/z9I7wZ+NKvR
         sbhCHs533hdvNMpzNvR/eRFAC6rdZ+ayQz6cnV7+n4suiJP1wbEsHwXy++pN+cUxvwyC
         wItRJCyzaUHuqZJVTFYiV/Xbog9iVK/UP+R/y8iCJaWeAIg1+rM5gXj9f5WukG8IEn+x
         crAwkkOeooSkUZ6LceStLCHVMz+68i7i5aJmuCQ0oonZiiU3/Kl+XLd0CmLcpE7ow9KW
         rV+jeXdW9KSB3aukqxaBiRMkKTZ5m2kwJKqzpfV8nxjyWyymINNvWJ5AJmf9E6l7g78V
         Fzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmNJnREVJGnaaEVeLxsBm0Njwp2E0f+PM+J5gi1eqbs=;
        b=bV57vfUJIcBlooeqPiMRdGqEK1dwiCzfw7SiktNE091L1edqwBtk7cbUlUL91BXFl1
         Y6Q4c4T3/aCvp7Y8O319osM1KPaQn9IznHjETfZyymPmHPk45UuAMK0eE1Q2I9ieN+FF
         FGCP4FHvEZ+FNivChXj9wLXgadrokDPmCZ+MczPV0qVOaMDpCVtwgFrz74PZNkUEHTWi
         1XP1LEh1t+xWeKH+DogKrHPBgkEywwNW/C2OeDyEazWhBTRM4UfGVRK0JyVdiNqmPw7p
         htje7ND+rCzeEK17olloV3cAafgR2JZCcNSDMeMlGsEL1hozqe4S5G9c9Ffu9YPcniO0
         LYTQ==
X-Gm-Message-State: APjAAAXs1uiM/DTxgMFG3Q9xHVrBjZaMQOQjYQ8cC40Jh52iXpwWX5tq
        JK0I6BPa0cFfVWcaIjFMsYj5kFG587C9nD1xv7i2ld59P1g=
X-Google-Smtp-Source: APXvYqzslK910HZvTjvVCrsgd+kx9xfNphXxsz58oNZsomQI4bmdNASCvBcGbeAVvq3dsumGbkFm/cFdjK2YxkqB1yE=
X-Received: by 2002:a5d:8953:: with SMTP id b19mr4691034iot.168.1573144793781;
 Thu, 07 Nov 2019 08:39:53 -0800 (PST)
MIME-Version: 1.0
References: <20191106174804.74723-1-edumazet@google.com> <157307905904.29376.8711513726869840596.tip-bot2@tip-bot2>
 <CANn89iKXi3rWWruKoBwQ8rncwLvkbzjZJWuJL3K05fjAhcySwg@mail.gmail.com>
 <CANn89iL=xPxejRPC=wHY7q27fLOvFBK-7HtqU_HJo+go3S9UXA@mail.gmail.com>
 <20191107085255.GK20975@paulmck-ThinkPad-P72> <CANn89i+8Hq5j234zFRY05QxZU1n=Vr6S-kZCcvn3Z80xYaindg@mail.gmail.com>
 <20191107161149.GQ20975@paulmck-ThinkPad-P72> <CANn89iLMD0=tiQ181qQ=qKo=Nom-XX4MqonZw6pKiYUzTDVjQg@mail.gmail.com>
In-Reply-To: <CANn89iLMD0=tiQ181qQ=qKo=Nom-XX4MqonZw6pKiYUzTDVjQg@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 7 Nov 2019 08:39:42 -0800
Message-ID: <CANn89iLqcqKLRgfn7TDnBr9ZatiJVyezXmmZaeN2f2BT=qFe7Q@mail.gmail.com>
Subject: Re: [tip: timers/core] hrtimer: Annotate lockless access to timer->state
To:     paulmck@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 8:35 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Thu, Nov 7, 2019 at 8:11 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > OK, so this is due to timer_pending() lockless access to ->entry.pprev
> > to determine whether or not the timer is on the list.  New one on me!
> >
> > Given that use case, I don't have an objection to your patch to list.h.
> >
> > Except...
> >
> > Would it make sense to add a READ_ONCE() to hlist_unhashed()
> > and to then make timer_pending() invoke hlist_unhashed()?  That
> > would better confine the needed uses of READ_ONCE().
>
> Sounds good to me, I had the same idea but was too lazy to look at the
> history of timer_pending()
> to check if the pprev pointer check was really the same underlying idea.

Note that forcing READ_ONCE() in hlist_unhashed() might force the compiler
to read the pprev pointer twice in some cases.

This was one of the reason for me to add skb_queue_empty_lockless()
variant in include/linux/skbuff.h

/**
 * skb_queue_empty_lockless - check if a queue is empty
 * @list: queue head
 *
 * Returns true if the queue is empty, false otherwise.
 * This variant can be used in lockless contexts.
 */
static inline bool skb_queue_empty_lockless(const struct sk_buff_head *list)
{
return READ_ONCE(list->next) == (const struct sk_buff *) list;
}

So maybe add a hlist_unhashed_lockless() to clearly document why
callers are using the lockless variant ?
