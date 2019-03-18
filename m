Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E63C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 06:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F31320828
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 06:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sm70s1yn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfCRG4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 02:56:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44460 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfCRG4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 02:56:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id u9so10784252lfe.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 23:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tp0gV0tq+BmhiNJ7POdrMiMAn60sM6dP9Em7UwdIHuk=;
        b=sm70s1ynaSmZ7S7rxjwbjUCo/skRJW+Vtn8DcShgcNcVOvmxzSXUA6dTl8mFhAkFh9
         DPOzfMgVbBSCZ1IJaZoYUqW5IS9BtsrjhrcwP8k/C3CH1F220vW04XnSTNMPWCcw9hCY
         HACO8Jmk6BJgfSTFJg0xd7eKJ6u7h074bN40aunM8ZA9CY0ew1n9bV5PcF03OdZU7Cvl
         bbsa1v7k/xcqW7gMSq5yqDVzbU/My0hm/mbvIS3QVL3dKs+wxQtCFlYkp7ZjSXp0WTDK
         E6Wk2dDqXcAmgPFIXNy3MS7Vs8a69t6Z3r0PkpZYLsDL38JpZKiq6m8YWBI0qjIeRc6/
         OP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tp0gV0tq+BmhiNJ7POdrMiMAn60sM6dP9Em7UwdIHuk=;
        b=KBnElr3QwSuoOwEbE26q+HsuCWlEyYpb037FmpSmHRcVzAHvzlGR56F/NGCVH6VkqQ
         eUojAcOmSvW3/eKjZylESD8QuGu+NHKG+yLZzecNgGrOLm6rpxjQi9DMmIHQYl8I4xd6
         Rc462/ywc9nsW4fNf6iam8+7FaMUFzlbaV9rQXru/wuXKz5uHiAYoCRaM72JHZ2pkof6
         RKuSiD+ISbwbBtMq1R0vjcRTbpKDyf1ygWhbwO2QHaPp+ur66vkVW6e6NWZzFl4h3+H3
         05XclU2z0MbHFx5bit3dSk/9CD53wKn2zXubsdkM17wXBH3BIeiFABvKkiKuHP+bTZUr
         E9LQ==
X-Gm-Message-State: APjAAAWwo4Jhh0ldXLfL98B01bi8Wo37bqxjG2v2gijeTtRGEc5V71K6
        Tok5b2L2TSjNqtFxfuVnt82pL1LyC/hiqv8o5WoKoZknryE=
X-Google-Smtp-Source: APXvYqx3xjgGUAxnFAgDsL4jEiC7JlCOpjIk2Q4Van711kdA+QU7tEZekCrsZnymP/GlzMJK3ana3PBaqU565yn7AS4=
X-Received: by 2002:a19:550d:: with SMTP id n13mr9252212lfe.26.1552892191900;
 Sun, 17 Mar 2019 23:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190218165620.383905466@infradead.org> <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <20190222124544.GY9565@techsingularity.net> <14a9adf7-9b50-1dfa-0c35-d04e976081c2@oracle.com>
 <CAERHkru9DzvszvdGHWp8PhEAqeUc-wVR1Gey-KtQ6aMRLx68bQ@mail.gmail.com>
 <19d5d492-a4c1-b3c8-cae4-da2fdfcb872b@oracle.com> <ac10b8fd-da1a-2cc2-afee-4e2b9b4278ee@oracle.com>
In-Reply-To: <ac10b8fd-da1a-2cc2-afee-4e2b9b4278ee@oracle.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Mon, 18 Mar 2019 14:56:20 +0800
Message-ID: <CAERHkrt+Ovsw308CX6Z6yoCC+ON6AF_LND9G0KRYTGBOp8qHhQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Fr?d?ric Weisbecker" <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 7:36 AM Subhra Mazumdar
<subhra.mazumdar@oracle.com> wrote:
>
>
> On 3/11/19 11:34 AM, Subhra Mazumdar wrote:
> >
> > On 3/10/19 9:23 PM, Aubrey Li wrote:
> >> On Sat, Mar 9, 2019 at 3:50 AM Subhra Mazumdar
> >> <subhra.mazumdar@oracle.com> wrote:
> >>> expected. Most of the performance recovery happens in patch 15 which,
> >>> unfortunately, is also the one that introduces the hard lockup.
> >>>
> >> After applied Subhra's patch, the following is triggered by enabling
> >> core sched when a cgroup is
> >> under heavy load.
> >>
> > It seems you are facing some other deadlock where printk is involved.
> > Can you
> > drop the last patch (patch 16 sched: Debug bits...) and try?
> >
> > Thanks,
> > Subhra
> >
> Never Mind, I am seeing the same lockdep deadlock output even w/o patch
> 16. Btw
> the NULL fix had something missing, following works.
>

okay, here is another one, on my system, the boot up CPUs don't match the
possible cpu map, so the not onlined CPU rq->core are not initialized, which
causes NULL pointer dereference panic in online_fair_sched_group():

And here is a quick fix.
-----------------------------------------------------------------------------------------------------
@@ -10488,7 +10493,8 @@ void online_fair_sched_group(struct task_group *tg)
        for_each_possible_cpu(i) {
                rq = cpu_rq(i);
                se = tg->se[i];
-
+               if (!rq->core)
+                       continue;
                raw_spin_lock_irq(rq_lockp(rq));
                update_rq_clock(rq);
                attach_entity_cfs_rq(se);

Thanks,
-Aubrey
