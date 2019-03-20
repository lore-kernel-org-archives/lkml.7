Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61127C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31830218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kwckhekQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfCTUvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:51:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38775 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfCTUvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:51:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so2780954pfo.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6bBWW5lzJVi43yo3GwV4pOvldByRAqRY95Wr3nj2muY=;
        b=kwckhekQFIPvRbe+/VnH/VX/rWc1RVYDffFR7j9vTKlguk4omTWuVs0Eq8SOBJ6VKM
         Qtn/AbBreyeUVv6nX0CpM3lktplYVGyWuTjNIXTJSgakRLhcU2BEOh/dQ8nGdQ6zLNn8
         iB8Iy5q45c0SXG/cvFc7Uvh8RgD/tVeXlAcF5qvIvMZJ4XnOape524pS/UMItSfbryMN
         yV0bET4RtZRCI2zmMSyup5R+eCAp2QAi75yuwrqlx2e7gp/zDm78hk/tJlAkKgFwUdn4
         CGbQgkU1XPWPQJy0Aa9TCaOboCf4Kyvke70g4I0q6Tay7ISM7mA6dV+riQk4xNgvJHqW
         SUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6bBWW5lzJVi43yo3GwV4pOvldByRAqRY95Wr3nj2muY=;
        b=YX1tlDS5UKRSuU/W2EpjdwWFbWS+QMeh1vOWAduXcgvhujyt0NbetKMeBaTyn5GXsH
         UR9nlxgIfHt7Oms0liWAuPxERKrIAgPi1GVqXW1CwlP5tSmv96/wTEc+yOk5VL+Rk0tt
         u9m84Nm2x1HXi54WoGKhoCmUOQuNa0ZeR6IxwSVevlP8tgTVPzfcb4ZDrdValForTBdN
         bp7+31fbZfgW9T7x6kja0SCkV3EURQyHeKtN1TlKHo95AKLHpqGg0JF0IqYYertJdInQ
         q989BxSuY2nOIXUSFby50eoJ7A0nRqz9uy7IQBYIh4SnisTkmK85pwUt5lf6ytbtcHwE
         C6bg==
X-Gm-Message-State: APjAAAVf1ZmRw8Rip/Fh8IwRnOzwD4KGxmuosXxXsyz3neaUIzWTWcVN
        gbpBxwB3Uf/58ozNce4mLA5sN4LAsTXLq3KFzAP6Ig==
X-Google-Smtp-Source: APXvYqyAImv2MO/xdkxJsWg3HOhBMjSjQjwKnPMv+fnT9H4ZHvaKaC8poNU//6/M61MO4d6tbi1i+F5sj+nNJJWt7nQ=
X-Received: by 2002:a63:84c7:: with SMTP id k190mr3281666pgd.255.1553115071196;
 Wed, 20 Mar 2019 13:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190308001723.GA11197@archlinux-ryzen> <20190320190752.GA28744@archlinux-ryzen>
In-Reply-To: <20190320190752.GA28744@archlinux-ryzen>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Mar 2019 13:50:59 -0700
Message-ID: <CAKwvOd=6916txvLmtEC3BcZgjLTNdtU-ou=YM+_dsd8CC-T_zw@mail.gmail.com>
Subject: Re: -Wsometimes-uninitialized Clang warning in net/tipc/node.c
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        tipc-discussion@lists.sourceforge.net, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 12:07 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Mar 07, 2019 at 05:17:23PM -0700, Nathan Chancellor wrote:
> > Hi all,
> >
> > We are trying to get Clang's -Wsometimes-uninitialized turned on for the
> > kernel as it can catch some bugs that GCC can't. This warning came up:
> >
> > net/tipc/node.c:831:6: warning: variable 'maddr' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> >         if (!tipc_link_is_establishing(l)) {
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > net/tipc/node.c:847:46: note: uninitialized use occurs here
> >         tipc_bearer_xmit(n->net, bearer_id, &xmitq, maddr);
> >                                                     ^~~~~
> > net/tipc/node.c:831:2: note: remove the 'if' if its condition is always true
> >         if (!tipc_link_is_establishing(l)) {
> >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > net/tipc/node.c:821:31: note: initialize the variable 'maddr' to silence this warning
> >         struct tipc_media_addr *maddr;
> >                                      ^
> >                                       = NULL
> > 1 warning generated.
> >
> > This definitely appears to be a legitimate warning but I'm not sure of
> > the proper solution (should maddr be initialized to NULL or should it be
> > set to something different in the else branch). Your input would be
> > greatly appreciated.
> >
> > Cheers,
> > Nathan
>
> Gentle ping (if there was a response to this, I didn't receive it). I
> know I sent it in the middle of a merge window so I get if it slipped
> through the cracks.
>
> Thanks,
> Nathan

The use in tipc_bearer_xmit() isn't even guaranteed to set the in/out
parameter, so even if the if is taken doesn't guarantee that maddr is
always initialized before calling tipc_bearer_xmit().

At the minimum, we should initialize maddr to NULL.  I think we'd
prefer to risk the possibility of a null pointer dereference to the
possibility of working with uninitialized memory.  To be clear, both
are bad, but one is easier to spot/debug later than the other.

Thanks for bringing this up for discussion, sorry I missed it before.
-- 
Thanks,
~Nick Desaulniers
