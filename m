Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E39C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853BD21874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfCUPZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:25:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36921 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:25:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id z16so5601043qtn.4;
        Thu, 21 Mar 2019 08:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GAyz0D1dcihvUAyUI0w4zfunbQRC/HhUqHJOfte7yA=;
        b=iYunvnnpVYAxvMNd2pEj+IY9T4y91x4xcgTaf+ZUbHgreSg86zHVbAp73MeSyqSzVx
         9x2kIQ1zFRGZyNNgLGfaGAZw2TvhRsEmWb+JED5TSiDG8xRU1DQ1wBXMACpz8n7Q2Vv8
         12FgOX/qRRTMiZ3uT8MN8ZEiWLTaoeSpXXA1rDW+V+5NN7Gwkh/cn+En5coylg7aEOJg
         wLqFfflo6qDYL8nTL8/t+pHbuakdWexD3D8PwKP9ykdaW9gS0H6I8hCPQ29uF+VfVqWC
         d2Kr7OuYXZ5dNRa9BgK430dLqDpHmJKxQjUdbSZLlcbBEoj7RgvVWWMwNMyXry7HIE3I
         qvMQ==
X-Gm-Message-State: APjAAAVdbgRkQlTLCThXUEB+m+t56v4BCaKy7nzSpp2wCOvViue2XGZP
        KOjCYrXg8CwO+2kajtFAqFQJ92ryDOn0F4/+/KE=
X-Google-Smtp-Source: APXvYqxcVvMyFYqOXNEwUbIWZKyfof1vQGefgvT8DoB0CfZNwOEFXPxQvBR6+4i40dLJlzSU+S5PDcBbgaqXi2ha2Rc=
X-Received: by 2002:ac8:3fbc:: with SMTP id d57mr3363333qtk.96.1553181938707;
 Thu, 21 Mar 2019 08:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190308001723.GA11197@archlinux-ryzen> <20190320190752.GA28744@archlinux-ryzen>
 <CAKwvOd=6916txvLmtEC3BcZgjLTNdtU-ou=YM+_dsd8CC-T_zw@mail.gmail.com>
 <CAK8P3a2pGo8HeHS5zcFnc_jLiLkXSPWKe4AYVm4TAmZxc_h2GA@mail.gmail.com> <BL0PR1501MB2003762D0D1CB08622C9244F9A420@BL0PR1501MB2003.namprd15.prod.outlook.com>
In-Reply-To: <BL0PR1501MB2003762D0D1CB08622C9244F9A420@BL0PR1501MB2003.namprd15.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Mar 2019 16:25:16 +0100
Message-ID: <CAK8P3a0Pq7qN-D9OsY7NWf=vQwqqSZFFXdEZ+xNckOLLCX40QA@mail.gmail.com>
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

On Thu, Mar 21, 2019 at 3:57 PM Jon Maloy <jon.maloy@ericsson.com> wrote:
> > -----Original Message-----
> > From: Arnd Bergmann <arnd@arndb.de>
> > Sent: 21-Mar-19 12:45
> > To: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Nathan Chancellor <natechancellor@gmail.com>; Jon Maloy
> > <jon.maloy@ericsson.com>; Ying Xue <ying.xue@windriver.com>; David S.
> > Miller <davem@davemloft.net>; tipc-discussion@lists.sourceforge.net;
> > Networking <netdev@vger.kernel.org>; LKML <linux-
> > kernel@vger.kernel.org>; clang-built-linux@googlegroups.com
> > Subject: Re: -Wsometimes-uninitialized Clang warning in net/tipc/node.c
> >
> > On Wed, Mar 20, 2019 at 9:51 PM 'Nick Desaulniers' via Clang Built Linux
> > <clang-built-linux@googlegroups.com> wrote:
> > > On Wed, Mar 20, 2019 at 12:07 PM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > >
> > > The use in tipc_bearer_xmit() isn't even guaranteed to set the in/out
> > > parameter, so even if the if is taken doesn't guarantee that maddr is
> > > always initialized before calling tipc_bearer_xmit().
> >
> > Right, it is only initialized in certain states. It was always initialized until
> > commit 598411d70f85 ("tipc: make resetting of links non-atomic"),
> > afterwards only if the link was not reset, and as of commit 73f646cec354
> > ("tipc: delay ESTABLISH state event when link is established") only if it's not
> > 'establishing' or 'reset'.
> >
> > > At the minimum, we should initialize maddr to NULL.  I think we'd
> > > prefer to risk the possibility of a null pointer dereference to the
> > > possibility of working with uninitialized memory.  To be clear, both
> > > are bad, but one is easier to spot/debug later than the other.
> >
> > I disagree with setting it to NULL, given that it is still an obviously incorrect
> > value. We could add a if(maddr) check before calling tipc_bearer_xmit(), but
> > I think it would be clearer to check
> > skb_queue_empty(xmitq)) if that avoids the warning:
>
> I may be wrong, but I would be surprised if that would eliminate the warning.
> To me, setting maddr to NULL and then testing for it looks both more comprehensible and is guaranteed to fix the warning.
>
> >
> > diff --git a/net/tipc/node.c b/net/tipc/node.c index
> > 2dc4919ab23c..147786795e48 100644
> > --- a/net/tipc/node.c
> > +++ b/net/tipc/node.c
> > @@ -844,7 +844,8 @@ static void tipc_node_link_down(struct tipc_node *n,
> > int bearer_id, bool delete)
> >         tipc_node_write_unlock(n);
> >         if (delete)
> >                 tipc_mon_remove_peer(n->net, n->addr, old_bearer_id);
> > -       tipc_bearer_xmit(n->net, bearer_id, &xmitq, maddr);
> > +       if (skb_queue_empty(xmitq))
> > +               tipc_bearer_xmit(n->net, bearer_id, &xmitq, maddr);
> >         tipc_sk_rcv(n->net, &le->inputq);  }
> >
> > This duplicates the check inside of skb_queue_empty(), but I don't know if
> > the compiler can see through the logic behind the inlined function calls.
>
> Probably not, but this is not in any way time critical.

I meant it's unclear whether compilers should be expected to see that
skb_queue_empty() is true after the call to __skb_queue_head_init()
initializes it.

I think recent versions of gcc do see that, not sure about clang, as it
does inlining differently. tipc_bearer_xmit() cannot be inlined here
(unless we start using LTO).

       Arnd
