Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC48CCA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6472166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ojoJPg1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393870AbfJXN6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:58:54 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42354 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfJXN6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:58:54 -0400
Received: by mail-qk1-f196.google.com with SMTP id m4so6541597qke.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 06:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UOruI0JrGFz7xrLotlBY15Zel47+fi3BtuX0TPe8v+s=;
        b=ojoJPg1vybYzGTONg5L7cUYX3/GVoymSo7uGRPUG8kfU1ldQOrWGDfUvzrRLML+CTR
         UQL7SYjkigtIrTndCk+J0sqzk13K/85JxFkzAbqUaCFWWDZI4YYySteGjhZMidl2qheO
         aZxZgnpPgNsSK15IiJgvGT5BdDnuUmbFM1hjK4ivbLNK6cThuC4D8v+qljKLKDcGN3/P
         TrIaok3VoSEirnQkvCNRUntWEgh1Q49kKUWXK0nmXE6yxBqs+k62GJVES6/h/H3bF44w
         DrykRV0/8HC4e6JMdM4e6DUtDUDxGsrOEfu5/vj1EUsnQnuoqikCl9AuRm+yaCsOmatn
         HEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UOruI0JrGFz7xrLotlBY15Zel47+fi3BtuX0TPe8v+s=;
        b=FFuj0fOYaYZEFRf/UCfvytGjVbsgyYrFVe4XGspAUTAGoqyRF9qrJMQbTeO5xoHtgE
         rzBG4HHNzHQojMFwjLyL9O4Wh9+584vkis1UokY93AJPYeTGJ2m8u2QhF3PYJe3aJdRO
         dTMT8FJYAvVPHQj6Zd2xPDykFfE9AHtJLmHnReykp3019G+BbEtg3zPoe8Dw+bdVoWBQ
         DO6Y8TVe6BsvA8prdp42D0MwBVOVcu5mYmbqJYsfSlr2F5KVRLJwMXQGEVJ3+X6noBjj
         Qub7refQ7dYUGoQ3dK0toLuRfv3w+1ri6R5/YRe+pgVJY1SdEyoLT4+WOfjrfmx1RXxt
         y5Ag==
X-Gm-Message-State: APjAAAXDuhL2l+m/fvc3e/P8TpUH/OtU0f9JQ3C4/HejgtlNN5OTHSK1
        mdk6w4EbBxD9LRcmt/VQsOC3zlm0taT4pIxQYHu2wA==
X-Google-Smtp-Source: APXvYqyJH8mQi7kWDAjmkW7fqPexv//gkSatB3x6zm5BjqDBwjBozeI+h5HyB+gfDOt4dAGZI+IarZp2cnkR7axleZ8=
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr14081580qkm.250.1571925532851;
 Thu, 24 Oct 2019 06:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191009114809.8643-1-christian.brauner@ubuntu.com>
 <20191021113327.22365-1-christian.brauner@ubuntu.com> <20191023121603.GA16344@andrea.guest.corp.microsoft.com>
 <CACT4Y+Y86HFnQGHyxv+f32tKDJXnRxmL7jQ3tGxVcksvtK3L7Q@mail.gmail.com>
 <20191024113155.GA7406@andrea.guest.corp.microsoft.com> <CACT4Y+Z2-mm6Qk0cecJdiA5B_VsQ1v8k2z+RWrDQv6dTNFXFog@mail.gmail.com>
 <20191024130502.GA11335@andrea.guest.corp.microsoft.com> <CACT4Y+ahUr11pQQ7=dw80Abj5owUPnPdufbMYvsKLM6iDg5QQg@mail.gmail.com>
 <20191024134319.GA12693@andrea.guest.corp.microsoft.com>
In-Reply-To: <20191024134319.GA12693@andrea.guest.corp.microsoft.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 24 Oct 2019 15:58:40 +0200
Message-ID: <CACT4Y+ZXQyqgBvwgb6cy7NP5FTBbktq5j4ZyySp7jrbcJwFUTA@mail.gmail.com>
Subject: Re: [PATCH v6] taskstats: fix data-race
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bsingharora@gmail.com,
        Marco Elver <elver@google.com>,
        stable <stable@vger.kernel.org>,
        syzbot <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 3:43 PM Andrea Parri <parri.andrea@gmail.com> wrote:
>
> > But why? I think kernel contains lots of such cases and it seems to be
> > officially documented by the LKMM:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/explanation.txt
> > address dependencies and ppo
>
> Well, that same documentation also alerts about some of the pitfalls
> developers can incur while relying on dependencies.  I'm sure you're
> more than aware of some of the debate surrounding these issues.

I thought that LKMM is finally supposed to stop all these
centi-threads around subtle details of ordering. And not we finally
have it. And it says that using address-dependencies is legal. And you
are one of the authors. And now you are arguing here that we better
not use it :) Can we have some black/white yes/no for code correctness
reflected in LKMM please :) If we are banning address dependencies,
don't we need to fix all of rcu uses?
