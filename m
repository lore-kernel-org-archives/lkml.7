Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E87FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E7C206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJruocL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfKGUkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:40:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36524 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKGUkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:40:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id c22so4002186wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 12:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/pKH0tT7IUWPxlqReLKSDJjr+ZKqHoHFlpAU48nDsb8=;
        b=YJruocL3WMHsSdrAyY52mp704CIZlMgZTUFDzjAsr0YlHFddlJA0cTV1nlVZRLwFHb
         jUQfYrr/sRxB7PFJ4W08gutrX2v/Clmr3WpGEORKeKLuxqF/cVtZOoi5Mfq+Jc/5psVV
         SSBjEKQVrwI9IptIxB6HyM5eXh9id07j8C7r8KeprTTreRrvLqAK/qRzRmIsoetJ9xKG
         FP4C2TdMB62F4KwRRzxluS4yXYRAuFR77Xp5SAmlgh9SPA9/lrDbeT4PhAK0N9Mn4Udl
         C4lx+IzKQiOfy+WDLgquCQEJN5AAJFuuv62ZVkLB6DnuKLCNe/wDVDtIB8hUJASWVtal
         +1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/pKH0tT7IUWPxlqReLKSDJjr+ZKqHoHFlpAU48nDsb8=;
        b=KSwTucXStbg/WNH2SAtuTccxD8GoO6y0zvR8cut4xENQRWn2+2yev4joPCnUBrRQUi
         dDLN42/p2N7tB+vLaXXqTwbwRMPOYXrtNDYaKuYvFhfUG+/FFLbh6b9g/9h3bswYse9w
         x5JUc5FQOUYn1JcepavOwRLx6vAUDl258UGxF+NuR7dEjzHX27cVUbKp3ahrQmO3Z4Hb
         PyAtthZgiL3CBem81vTExltYzI8R+h/z3Ix7so1ioIAIOqQZPXwtJP+fJl2jQhowyvQO
         MSpMqplcWEd3kOtPrL598fc+minOfmrKKTEcBgFXEZJtbfSbvsj8qq06at43H0UIXT+n
         HOww==
X-Gm-Message-State: APjAAAWdAfgR0W35xQizZYTUZB0xH5WkrImVkd05hUeJOOqQy8iSCCKg
        cx2+cZobTqO4uSI7h69RVCk9HVoNPVsldaZpuJYkjt3B
X-Google-Smtp-Source: APXvYqwJSeRni4hQ3v3vC2wuYAdNlSyGM6v5AS0hn8e7JMxXC+lI4FPDSl05I/OcHMJOn0gPs4pgz+LQyi9uFGs8jEA=
X-Received: by 2002:a1c:a9cb:: with SMTP id s194mr5148663wme.92.1573159221150;
 Thu, 07 Nov 2019 12:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20191107132755.8517-1-jonas@norrbonn.se>
In-Reply-To: <20191107132755.8517-1-jonas@norrbonn.se>
From:   =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= 
        <maheshb@google.com>
Date:   Thu, 7 Nov 2019 12:40:04 -0800
Message-ID: <CAF2d9jjteagJGmt64mNFH-pFmGg_eM8_NNBrDtROcaVKhcNkRQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Add namespace awareness to Netlink methods
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     nicolas.dichtel@6wind.com, linux-netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 5:30 AM Jonas Bonn <jonas@norrbonn.se> wrote:
>
> Changed in v3:
> - added patch 6 for setting IPv6 address outside current namespace
> - address checkpatch warnings
> - address comment from Nicolas
>
> Changed in v2:
> - address comment from Nicolas
> - add accumulated ACK's
>
> Currently, Netlink has partial support for acting outside of the current
> namespace.  It appears that the intention was to extend this to all the
> methods eventually, but it hasn't been done to date.
>
> With this series RTM_SETLINK, RTM_NEWLINK, RTM_NEWADDR, and RTM_NEWNSID
> are extended to respect the selection of the namespace to work in.
>
This is nice, is there a plan to update userspace commands using this?

> /Jonas
>
> Jonas Bonn (6):
>   rtnetlink: allow RTM_SETLINK to reference other namespaces
>   rtnetlink: skip namespace change if already effect
>   rtnetlink: allow RTM_NEWLINK to act upon interfaces in arbitrary
>     namespaces
>   net: ipv4: allow setting address on interface outside current
>     namespace
>   net: namespace: allow setting NSIDs outside current namespace
>   net: ipv6: allow setting address on interface outside current
>     namespace
>
>  net/core/net_namespace.c | 19 ++++++++++
>  net/core/rtnetlink.c     | 80 ++++++++++++++++++++++++++++++++++------
>  net/ipv4/devinet.c       | 61 ++++++++++++++++++++++--------
>  net/ipv6/addrconf.c      | 13 +++++++
>  4 files changed, 145 insertions(+), 28 deletions(-)
>
> --
> 2.20.1
>
