Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72917C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317F620854
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIDyusDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfCOOO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:14:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40272 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbfCOOO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 10:14:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id r23so7732484edm.7;
        Fri, 15 Mar 2019 07:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rCdqR/c8y/ektO8gwR4sy/QJ3Hz0uA5AHVs8LKYeCe8=;
        b=sIDyusDzhYp11JXwpqD9fDG+x1DAzl1l+FDbuTCWa5EWW0daof5exdUQC9i4zgZCfL
         FvcGEBn6bTCvwDYvfULXQARrsR60BwDWCPnkU98mg2/nsJQzv/lwd60SayqxdWeh6W6I
         tdhL+AS9/KLB6ybD2mAVCXfOi4hfNIaEdaylDQtcB5id2B620hqxbzQOAtwAAmSEsAFv
         i9Vp4sSpiD3m7b7VZ8Enu3wLiIenybpj2Z9jXZCDLZqB++Qy79Z9SjXNF8zpe2s2YHKs
         unRBXN9gM/P4V29l5DcZUxXkPPDRVrrC8kz/pQpyv3E8X/wi7IT6BBoZw1Q448OI/nmN
         87iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rCdqR/c8y/ektO8gwR4sy/QJ3Hz0uA5AHVs8LKYeCe8=;
        b=bJ60uY0bvHRkdkO9HAynmBoIM1zdbj44R/TZAsULRVB7BOhfEbkJPQAioch9hkUIBy
         Eqg0JGJEHiYqa2SbLj46k9wKJ6FMn7fj2tw+kq74+2CTAvu5w7ChPomPvjBlWPUvrgxu
         ZKTXl5bBwFjMAo6k+JW2wKkQpw17x4Svy7aAExjbxXRjphV4Nu4E/+XcfnS9+kL3WlgW
         pz8gsjj+Ly/wjOWvBaCBj6FwTWiIpkuDu2mO4mCziuq2dLkBjkFkeo7L8HTzmlCzr3XV
         ijlvIrHtBv62IyqKG6J0l37QN3vcYK5CIC9pOBxR0tew4YWsx5uK9XXZ2jNVkzyihnSj
         s4ww==
X-Gm-Message-State: APjAAAXLp6zCbE9xgPrWoy6NI8uytWgjgy4w9odIIvFgDIZp6akkgpqR
        JGpBML9oed3eVb37q9X/1PbIIz+PEbGe/TLnKFc=
X-Google-Smtp-Source: APXvYqw2Dt90Z3UwWfRUgEAqU3k3x+VakgAwHjmUpQXS5gvTNtEVCQtR7BTKp6ud7qep+a5u8bR88bmMkF+AavdKdg4=
X-Received: by 2002:a50:9753:: with SMTP id d19mr2969828edb.143.1552659265038;
 Fri, 15 Mar 2019 07:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190314122450.5242-1-maxime.chevallier@bootlin.com>
 <CAF=yD-+e3f1VED3+6J7rQYac9A3w=CDQhrLq+eRLA88+vLOzDA@mail.gmail.com> <20190315100301.249cb671@bootlin.com>
In-Reply-To: <20190315100301.249cb671@bootlin.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 15 Mar 2019 10:13:49 -0400
Message-ID: <CAF=yD-LxqnEPNfKRuGsw7ckknyQ45KbMBjxX09xdSCO6icXBpw@mail.gmail.com>
Subject: Re: [RFC PATCH net] packets: Always register packet sk in the same order
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 5:03 AM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hi Willem,
>
> On Thu, 14 Mar 2019 11:24:54 -0400
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
>
> >On Thu, Mar 14, 2019 at 8:27 AM Maxime Chevallier
> ><maxime.chevallier@bootlin.com> wrote:
> >>
> >> When using fanouts with AF_PACKET, the demux functions such as
> >> fanout_demux_cpu will return an index in the fanout socket array, which
> >> corresponds to the selected socket.
> >>
> >> The ordering of this array depends on the order the sockets were added
> >> to a given fanout group, so for FANOUT_CPU this means sockets are bound
> >> to cpus in the order they are configured, which is OK.
> >>
> >> However, when stopping then restarting the interface these sockets are
> >> bound to, the sockets are reassigned to the fanout group in the reverse
> >> order, due to the fact that they were inserted at the head of the
> >> interface's AF_PACKET socket list.
> >>
> >> This means that traffic that was directed to the first socket in the
> >> fanout group is now directed to the last one after an interface restart.
> >>
> >> In the case of FANOUT_CPU, traffic from CPU0 will be directed to the
> >> socket that used to receive traffic from the last CPU after an interface
> >> restart.
> >
> >The above assumes that sockets are added to a fanout group in the
> >order in which they are created. That is a reasonable assumption,
> >though not strictly required. This can be worked around in userspace
> >by inserting in the inverse order. Still, good to fix.
> >
> >It does change the order of output of proc and diag, which is an
> >unfortunately side effect. But insertion order is less surprising and
> >I don't see a simple option to only traverse the sklist in inverse
> >order on packet_notifier NETDEV_UP (which would avoid this).
>
> Thanks for the review ! Clearly the solution proposed by this patch has
> side-effects, and as you said I don't see an easy way to do that in
> another manner.
>
> >> This commit introduces a helper to add a socket at the tail of a list,
> >> then uses it to register AF_PACKET sockets.
> >>
> >> Fixes: 808f5114a920 ("packet: convert socket list to RCU (v3)")
> >
> >Before this patch, insertion with sk_add_node is also at the head.
> >This does not seem like the right commit? This behavior has probably
> >existed as long as fanout.
>
> Yes I agree, I'm not even sure if this patch should be targeted to -net
> or -net-next. If this is OK after reviews, I can resend it without RFC
> and without this misleading Fixes tag.

Sounds good.

Since current behavior can split packets of the same flow across
multiple sockets, even for fanout_demux_hash, I think this warrants
net. Then the Fixes tag would be dc99f600698d ("packet: Add fanout
support.").

Please mention the reordering of proc and diag output in the commit message.

Thanks
