Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C55C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEA02075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfCKMLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:11:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43554 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfCKMLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:11:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id d16so4653424qtn.10;
        Mon, 11 Mar 2019 05:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3QAA+O90f7r8NbQtZhP9wtU1gR8JJm3JN1WpqCkIhs=;
        b=FV49cDltVrBVWvPj3TWqMv/62BEH/TA1JKG3iRvZAi6Mg6ZQ67sABTMRPLPiRrgjDx
         q6JjCNGPTHH5PcCKvVkahzjzBCfWxQl1jRkDPv+gAbPb0zKts52rbZlibDKQIYAO9c2A
         CbJW86a6L+ixiLNpMIIR5rR3eVA88+Px4J4oVNsWSU9XQlaVKGseLeLnbdmpSLb5UfuY
         6Xi+ttmtHkluCdY7RCg4KdTHYy7/X2JmKbG1VeLnwkUxxvZcdKDYVVaqXUw1FwF0Td8K
         7kj/h0+5IcO9EUK3fgOlkvLXZ58SjJpavvZJJQZrUWQ7qnAtowL6UqbDV2eJSUDRBy8A
         AqAA==
X-Gm-Message-State: APjAAAXRHOeH+ihM+jWISMRMktspDuTATD4RxI8BX3gq8RdiC58SFeJG
        j4SHq1YQ0PngoVd5jHWZ/XDGk3lY565UElXFJCU=
X-Google-Smtp-Source: APXvYqxsVqRI//5TTfbN2YueL6jap/wwPHgqW0M34D5qzKflQc762i4r94eWFx0oPJHBo/qF2WEV5+/w87BpTr9E1n8=
X-Received: by 2002:a0c:b05a:: with SMTP id l26mr25236520qvc.40.1552306299491;
 Mon, 11 Mar 2019 05:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <1546173604-26066-1-git-send-email-minipli@googlemail.com>
 <20190102202938.GA26600@linux-8ccs> <CA+rthh87tutLV=857g-Nrd6gAYK8xhRJX8MqpjC+CnmsjTqqJg@mail.gmail.com>
 <CA+rthh_OnmvQQbKAG55rha56HCp2vjhZMv0ahRdgJjbjmG=xRA@mail.gmail.com> <20190311115523.GA30951@linux-8ccs>
In-Reply-To: <20190311115523.GA30951@linux-8ccs>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Mar 2019 13:11:22 +0100
Message-ID: <CAK8P3a2w0B50Nb1gu6nJ2BJJsPFyOyXXOqn5SaTZnRBS=vD+Yg@mail.gmail.com>
Subject: Re: [PATCH] vmlinux.lds.h: drop unused __vermagic
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Mathias Krause <minipli@googlemail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 12:55 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Mathias Krause [10/03/19 20:26 +0100]:
> >Hi Jessica,
> >
> >On Mon, 21 Jan 2019 at 12:39, Mathias Krause <minipli@googlemail.com> wrote:
> >>
> >> On Wed, 2 Jan 2019 at 21:29, Jessica Yu <jeyu@kernel.org> wrote:
> >> >
> >> > +++ Mathias Krause [30/12/18 13:40 +0100]:
> >> > >The reference to '__vermagic' is a relict from v2.5 times. And even
> >> > >there it had a very short life time, from v2.5.59 (commit 1d411b80ee18
> >> > >("Module Sanity Check") in the historic tree) to v2.5.69 (commit
> >> > >67ac5b866bda ("[PATCH] complete modinfo section")).
> >> > >
> >> > >Neither current kernels nor modules contain a '__vermagic' section any
> >> > >more, so get rid of it.
> >> > >
> >> > >Signed-off-by: Mathias Krause <minipli@googlemail.com>
> >> > >Cc: Rusty Russell <rusty@rustcorp.com.au>
> >> > >Cc: Jessica Yu <jeyu@kernel.org>
> >> >
> >> > Thanks for the cleanup.
> >> >
> >> > Reviewed-by: Jessica Yu <jeyu@kernel.org>
> >> >
> >>
> >> Arnd, will you carry this patch through your asm-generic tree or did
> >> the MAINTAINERS file mislead me here?
> >>
> >
> >looks like Arnd keeps ignoring my Emails. :/ Can you carry this patch
> >through your module tree? Or do you think I should ask Andrew Morton
> >instead?

Oops, sorry about this.

> Sure, I'll queue this up in modules-next shortly after the merge window.

Ok, thanks for picking it up!

     Arnd
