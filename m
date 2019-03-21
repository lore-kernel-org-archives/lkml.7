Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777F7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5408221874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfCUSXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:23:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35273 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfCUSXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:23:05 -0400
Received: by mail-qt1-f194.google.com with SMTP id h39so7755512qte.2;
        Thu, 21 Mar 2019 11:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QmXAKtZ9yVDHBruxl6smjOl/FBnQRtl/rZ8vXH7wuE=;
        b=Wd4YQnu2kAU/F2SNwa6uFwZSCHCAYwrVfDXqAzUFZWM837h0JRkikrscbH4FgrpK9+
         u3TK45X6uLXLn2WZsk1ocWE6jana9XotdAIJHr58nJZk+mbCdVk4IjUf0vaPncKMuLtU
         oMgjEZmUPwZZLje3F8J7aogxtNAPsSyMNhVWOH08z9f/VhdHK8iO+248kqeh2B5mrk0E
         aLc6u7SJzE9v3CJ3j+4RUbhlMTuCwd3WlvyfrriBpkdw0ytwf34rjLRFddSNd6AekrgU
         oi5jZgtm3oxC7QvcVwDXIMmoKNxz90qwc6P3l6Bpbg6/4nJKoBesznjZCwlYZ8y/JtE+
         /SrQ==
X-Gm-Message-State: APjAAAVmptvdBNzZkwdYjmS9kl0IyJedV4Jqm0nIcwpOlDARQdvugeg9
        E5Qx3b1SyX3UIb/zt0UoSWfJurY3pOXARA1M+zE=
X-Google-Smtp-Source: APXvYqyQ+XpjLp6lEdRkcL177XeFciCcGl7M7jMvTYvYq78ppAnqKCigF+TzBdku4JtAkqefY1m2eME0WF4F+5JsK8k=
X-Received: by 2002:ac8:3fbc:: with SMTP id d57mr4133770qtk.96.1553192583731;
 Thu, 21 Mar 2019 11:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190308001723.GA11197@archlinux-ryzen> <20190320190752.GA28744@archlinux-ryzen>
 <CAKwvOd=6916txvLmtEC3BcZgjLTNdtU-ou=YM+_dsd8CC-T_zw@mail.gmail.com>
 <CAK8P3a2pGo8HeHS5zcFnc_jLiLkXSPWKe4AYVm4TAmZxc_h2GA@mail.gmail.com>
 <BL0PR1501MB2003762D0D1CB08622C9244F9A420@BL0PR1501MB2003.namprd15.prod.outlook.com>
 <CAK8P3a0Pq7qN-D9OsY7NWf=vQwqqSZFFXdEZ+xNckOLLCX40QA@mail.gmail.com>
In-Reply-To: <CAK8P3a0Pq7qN-D9OsY7NWf=vQwqqSZFFXdEZ+xNckOLLCX40QA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Mar 2019 19:22:46 +0100
Message-ID: <CAK8P3a0z9sPihaCWwzJ7iEkD-tmU62=yPpHuLFH=dmkJ30Sysg@mail.gmail.com>
Subject: Re: -Wsometimes-uninitialized Clang warning in net/tipc/node.c
To:     Jon Maloy <jon.maloy@ericsson.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        Networking <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 4:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Mar 21, 2019 at 3:57 PM Jon Maloy <jon.maloy@ericsson.com> wrote:

> > >
> > > diff --git a/net/tipc/node.c b/net/tipc/node.c index
> > > 2dc4919ab23c..147786795e48 100644
> > > --- a/net/tipc/node.c
> > > +++ b/net/tipc/node.c
> > > @@ -844,7 +844,8 @@ static void tipc_node_link_down(struct tipc_node *n,
> > > int bearer_id, bool delete)
> > >         tipc_node_write_unlock(n);
> > >         if (delete)
> > >                 tipc_mon_remove_peer(n->net, n->addr, old_bearer_id);
> > > -       tipc_bearer_xmit(n->net, bearer_id, &xmitq, maddr);
> > > +       if (skb_queue_empty(xmitq))
> > > +               tipc_bearer_xmit(n->net, bearer_id, &xmitq, maddr);
> > >         tipc_sk_rcv(n->net, &le->inputq);  }
> > >
> > > This duplicates the check inside of skb_queue_empty(), but I don't know if
> > > the compiler can see through the logic behind the inlined function calls.
> >
> > Probably not, but this is not in any way time critical.
>
> I meant it's unclear whether compilers should be expected to see that
> skb_queue_empty() is true after the call to __skb_queue_head_init()
> initializes it.

I reproduced the warning now, and verified that my change
eliminates the warning. I still think that is the more logical
solution here.

      Arnd
