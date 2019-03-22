Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4B0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17EE42075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mb/ocEFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbfCVM7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:59:17 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45190 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731485AbfCVM7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:59:16 -0400
Received: by mail-yw1-f66.google.com with SMTP id j128so1649397ywg.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 05:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDWsIWMC8aaswT+CuIhgDJFiCCQZ9ag1tdMcqcp9kgw=;
        b=Mb/ocEFboBLbCjLZx0UbGhC7AhK4yZPzG71szBBTl9Yo3tnSI3bjEREF7a3liX1zfH
         F8kd3tLY9UF1ZgRCXZz6VgzyZjR/Kr7AbVxkyfLu05/u97f8LTtczWRAOZZAibKzjf2S
         xp7AImrqUhYbFWy0HDeam7tIgAZu6JnbtblW7EISmDR75/ez4wCgX7ccTPx3vU9kvUwA
         hiW+b6HzXKmHcCMS5ViNbSZlP4Bj8w/Q5qdgSTSDTJuKd6sjuqGQ/1qlxjxBGg5TDU1a
         FhpJT2E3oKF4k0qNY1nDDYgKb1LutBHk8GnvgovwUc3nz2QJXM+dcaxJ6E64rzKNevdY
         dIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDWsIWMC8aaswT+CuIhgDJFiCCQZ9ag1tdMcqcp9kgw=;
        b=JPcyVlpGuka7cCbz8oKo76e8+Qu/WAFd0XZZL3Z9eEcY1ecrWQfa9FWc5Nhn8hxmST
         qFwl7AOGGHtauqFhghsmXCeHqBUpADhfAhJmHHZcWWSH1TnQ0wG58k0lnH8Ch/R/6s0P
         PQcDe/j/4qa+rP9Q6xWXlVQPBXCpYSGUFRGxGEmxxy0ETcnu02UIP4tIiH8xXnj/H49N
         9i6bhzL4DeIKpe8AIxbRgFWczojGewr3nnZPJ1WmLv7OG4ogDsXpWUjTlO7VoVQH/pnl
         +BGoQhnEmbBsOeNlcDg1zHi+oqu3N3EMIko//RHq6Bn4DrmfxUK8u/gr+gzYB11I5vmo
         OtwA==
X-Gm-Message-State: APjAAAV7C9hrPS44wZ4B1fSj606plvP31tYyHx4gFvA42XGRVb1fWP39
        q4MZXcozR9F0EwUcN9IewCp3tFuAQ0hOSyvYm89Qzw==
X-Google-Smtp-Source: APXvYqy/RS05aFeEezRkxkFJgdjOAgT4onm0XeT4+5ZUGyGfHsRJQQUAQ/yqA5KrCcP2Irm9/zIRP2hQg3O98yuYbnE=
X-Received: by 2002:a81:2002:: with SMTP id g2mr8204919ywg.60.1553259555290;
 Fri, 22 Mar 2019 05:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20170324164902.15226.48358.stgit@localhost.localdomain>
 <20170324170812.15226.97497.stgit@localhost.localdomain> <CALMXkpb3MfLbNoBgLJc0rgMDbPg9yOevKOiq9N8pzVw-aeNb3g@mail.gmail.com>
 <e532fdb97e142eca2484e5abbeca4c30d11fbad6.camel@redhat.com>
 <CAKgT0Uc68jsuPHKbxxFpeMCQAo2M69DhzA_XGw7Kvou4H3eHPg@mail.gmail.com>
 <CALMXkpZ_eB+aRx3+aKM5Bs4RwDfzPNX+XneESo2-yuMPjHV5-Q@mail.gmail.com> <0eb092b7ca67942f52e36c672d20f130f1d54e1e.camel@redhat.com>
In-Reply-To: <0eb092b7ca67942f52e36c672d20f130f1d54e1e.camel@redhat.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 22 Mar 2019 05:59:03 -0700
Message-ID: <CANn89iJhzT4hkn38oK77J0L464eNgiXZmongFnRuRnSPcVnGbQ@mail.gmail.com>
Subject: Re: [net-next PATCH v3 4/8] net: Change return type of sk_busy_loop
 from bool to void
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Christoph Paasch <christoph.paasch@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 3:33 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> Hi,
>
> On Thu, 2019-03-21 at 23:05 -0400, Christoph Paasch wrote:
> > On Thu, Mar 21, 2019 at 12:43 PM Alexander Duyck
> > <alexander.duyck@gmail.com> wrote:
> > > On Thu, Mar 21, 2019 at 2:45 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > > > The following - completely untested - should avoid the unbounded loop,
> > > > but it's not a complete fix, I *think* we should also change
> > > > sk_busy_loop_end() in a similar way, but that is a little more complex
> > > > due to the additional indirections.
> > >
> > > As far as sk_busy_loop_end we could look at just forking sk_busy_loop
> > > and writing a separate implementation for datagram sockets that uses a
> > > different loop_end function. It shouldn't take much to change since
> > > all we would need to do is pass a structure containing the sk and last
> > > pointers instead of just passing the sk directly as the loop_end
> > > argument.
> > >
> > > > Could you please test it?
> > > >
> > > > Any feedback welcome!
> > >
> > > The change below looks good to me.
> >
> > I just tried it out. Worked for me!
> >
> > You can add my Tested-by if you do a formal patch-submission:
> >
> > Tested-by: Christoph Paasch <cpaasch@apple.com>
>
> Thanks for testing!
>
> I'm trying to reproduce the issue locally, but I'm unable. I think that
> the current UDP implementation is not affected, as we always ensure
> sk_receive_queue is empty before busy polling.

But right after check is done we release the queue lock, so a packet might
come right after the test has been done.

> Unix sockets should not
> be affected, too, as busy polling should not have any effect there
> (sk_napi_id should be never >= MIN_NAPI_ID). Can you reproduce the
> issue on an unpatched, recent, upstream kernel?



>
> Can you please provide the syzkaller repro?
>
> Thanks,
>
> Paolo
>
>
>
>
>
