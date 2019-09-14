Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB24EC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 17:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B5220693
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 17:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568483062;
	bh=vXNgFvtiT6mF3oMIYQ54KnRjuSIhxi6Thoblz/3lbSc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=szwy1oGde9oxlWHoaDd+SYHwt2V/9vPhO+cI8LwiK+zqOeD2zCV4i5f5AIDlS8DzE
	 bR1OEEo3qDy2wuewvDN9xbOA+vA8Pyw8Sm7KlhSAsV2KU3AgKAVDe2djEVGf24LkBl
	 j3Zi5hrSGn61MVGcy6McVOAOqkJXnQMt2xPU4tyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfINRoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 13:44:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36308 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfINRoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 13:44:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id x80so24425962lff.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 10:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7rqA8gv8WBUcCizuodrqsXPHaEqxJVJcQpp9To/E3s8=;
        b=T+nBmx+uhgoJWmGl4RszArFg7xvFs3jJCRP0lXywIDlIayWnPaYPPAMIsEG7H4Y9Ab
         WEn/3QIGbPGJOKc/U2z7HqRfA+cQ9/kYyqXSf5YL10BJuW9pTebx+euQwWNe6vI2AQ7J
         5pf3tO45wpIXAEUmDBXmhagMyuYzGO5oNxHHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7rqA8gv8WBUcCizuodrqsXPHaEqxJVJcQpp9To/E3s8=;
        b=fSpDg8to+KXB0IqaaYHy5iXOtKom8XpRUzKsaTgitQ4M3RPu8OGj+mMPd+/NTgtbr2
         6+FnOba2j2Se/ClubsuyacsFagdenyB/2sXwzsA8tBMYN6lP2ayxPz1DGXYfeQNmztaC
         vDBNXRBLsiQVNxrWbmFWufJYkYzeQk9wYrTlUkmw6cNsS0zHgtDLRN0/AWPnLNjmUc8d
         kvK2qhgx+/oZMioJmP/Ze9O3RYspo7zeMatuWmKVzXhbFUgiKTJ0dsJsCRnvwQZzClfm
         oVblsr2LclmtgTtStZdBPsct8SA0NqARbaS0IAiVXKMQXIuea8PHTdrnD85DcvXLnadV
         ulsw==
X-Gm-Message-State: APjAAAV6g9acoyvWaEyAJLyRNy8VMK7iz2WS60MYP+19DekfRyh5p/o/
        gtgDmnLwMlEcRptZFdzANp4Kkh0iTcI=
X-Google-Smtp-Source: APXvYqwkHMh8YnrFJJU+UCye7xLK+5X2pOgKOZ9z75Cr4cAJhBievXWEXWleAYsZVVcAFTuDef3fmA==
X-Received: by 2002:ac2:4853:: with SMTP id 19mr33074529lfy.69.1568483057494;
        Sat, 14 Sep 2019 10:44:17 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id z9sm7133079ljn.78.2019.09.14.10.44.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2019 10:44:16 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id j16so30029609ljg.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 10:44:15 -0700 (PDT)
X-Received: by 2002:a2e:8943:: with SMTP id b3mr1420191ljk.165.1568483055484;
 Sat, 14 Sep 2019 10:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190830140805.GD13294@shell.armlinux.org.uk> <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
 <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com> <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org> <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org> <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org> <87muf7f4bf.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87muf7f4bf.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Sep 2019 10:43:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whej3MMKJBHKWp66djfEP5=kyncX7FoqJacYtmBXB6v9w@mail.gmail.com>
Message-ID: <CAHk-=whej3MMKJBHKWp66djfEP5=kyncX7FoqJacYtmBXB6v9w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] task: Making tasks on the runqueue rcu protected
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 5:30 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I have reworked these patches one more time to make it clear that the
> first 3 patches only fix task_struct so that it experiences a rcu grace
> period after it leaves the runqueue for the last time.

I remain a fan of these patches, and the added comment on the last one
is I think a sufficient clarification of the issue.

But it's patch 3 that makes me go "yeah, this is the right approach",
because it just removes subtle code in favor of something that is
understandable.

Yes, most of the lines removed may be comments, and so it doesn't
actually remove a lot of _code_, but I think the comments are a result
of just how subtle and fragile our current approach is, and the new
model not needing them as much is I think a real issue (rather than
just Eric being less verbose in the new comments and removing lines of
code that way).

Can anybody see anything wrong with the series? Because I'd love to
have it for 5.4,

             Linus
