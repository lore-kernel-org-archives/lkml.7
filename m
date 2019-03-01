Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154B6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98722085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="A3iwn/B5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfCAAJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 19:09:29 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40071 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731073AbfCAAJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 19:09:29 -0500
Received: by mail-qk1-f194.google.com with SMTP id h28so13273820qkk.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 16:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g0bEwvUEFK1J8CZ2fvgvp4/COBWyjjoGx4ZMNvvVzOc=;
        b=A3iwn/B5hHT8VVvop9P/dLzTrqF9PEl5lvECFfMRhkr1okOqGTp1MMODsDof8+2jwy
         p44XZcRw5/Vdsx3Bc8UOKheNkbLTCvDg3oO96BRQEK9E8zKeq2Ved5v/tJE1Ee3aYaby
         qvwfk3A6GdHAGTJ74xhIpUPHwryWJTSSf+dzh88qZixy+xjsMsEYnyh4CN3oQU5y2asc
         HpGgIjsxAZn8xi49SqBihWd79qF6kLbCpB1E3LqQpJsZXM1941h7j+o3bJ2IGXQ9clC0
         3ui90MogtXGm7rzyXTUn+r4xzEMWBOQ3o3HfKlMJKfrspScNhSAt2pNnLDpZRcvFties
         JS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g0bEwvUEFK1J8CZ2fvgvp4/COBWyjjoGx4ZMNvvVzOc=;
        b=aGJmrOuEGTPKFuFFfX6syP1PqueA0kq5/YmIWz1GbN5ZLnVAnYeGxHUEgkzwWQ6Q1u
         sNJoSJOBesnm/3mhiWsIDR/ZaQ3Rd+oUVcBsda6DJH2wRW2mflksPOE7PQApcsTthNkY
         ZXgXEhy0nC6LcFsKCb4Cp3uYpL4s9lSFI6e2FUfEdSJp4NNBVRiyZI5hjLPab85VzJVd
         Na/eY74v4//+Teh8DgnKLkTSYbzZYCG6Ua/tHx9sdq7re9/acd9/NZ9SONDTlLDSO+SM
         rE/hlr3S+BCQFoFlChS7/UFDh3UvDdtRxXzYptT63dClRWP0DQvgbtNKwjCr6LlJhTNY
         otMA==
X-Gm-Message-State: APjAAAXLiMVeoGMpg/pbILgrmuXKWmW6gdTmXnF4nVLLNBKMaoW1I7zL
        Wuz0FuvyhmEzPlhJefIJ/MvL39SUO+iDFhjtbvEH3g==
X-Google-Smtp-Source: APXvYqzrgnJezCXbqiGfhto3glxDayJFxKfAWdnoVkoYtS745qBUjT24/8l/NN3W67ky63iS5J6a1ybEytQfNA3a4dE=
X-Received: by 2002:a37:66c8:: with SMTP id a191mr1731696qkc.281.1551398968232;
 Thu, 28 Feb 2019 16:09:28 -0800 (PST)
MIME-Version: 1.0
References: <20190228190146.802CD95C016B@us180.sjc.aristanetworks.com>
 <20190228.130213.1481374802407995712.davem@davemloft.net> <171e33d9-ee82-6a62-693e-5d585e4eca28@gmail.com>
In-Reply-To: <171e33d9-ee82-6a62-693e-5d585e4eca28@gmail.com>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Thu, 28 Feb 2019 16:09:17 -0800
Message-ID: <CA+HUmGhBBJ+bTdAQK0bAReW0-fFWRzrx73Og_9Qa9ftDhrUWRw@mail.gmail.com>
Subject: Re: [PATCH] net: ipv6: check net in ip6_call_ra_chain
To:     David Ahern <dsahern@gmail.com>
Cc:     David Miller <davem@davemloft.net>, yoshfuji@linux-ipv6.org,
        kuznet@ms2.inr.ac.ru, Maxim Martynov <maxim@arista.com>,
        linux-kernel@vger.kernel.org, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 3:31 PM David Ahern <dsahern@gmail.com> wrote:
>
> On 2/28/19 2:02 PM, David Miller wrote:
> > From: fruggeri@arista.com (Francesco Ruggeri)
> > Date: Thu, 28 Feb 2019 11:01:46 -0800
> >
> >> ip6_call_ra_chain is called when IPv6 packet with Router Alert option
> >> is forwarded.
> >> It needs to check if the net of the socket is the same as the net of the
> >> input device, otherwise the packet gets delivered to every IPv6 socket
> >> listening for Router Alerts, no matter which network namespace it is in.
> >>
> >> Suggested-by: Maxim Martynov <maxim@arista.com>
> >> Signed-off-by: Maxim Martynov <maxim@arista.com>
> >> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
> >
> > Right now someone using such a tool does get all RAs in the system.
> >
> > Your change not only breaks them, but also gives them no method by
> > which to keep obtaining the same behavior.
> >
> > I don't know what to do or suggest in this situation, but right now
> > I'm putting this patch on hold.
> >
>
> need an equivalent to NETLINK_LISTEN_ALL_NSID

If that would be acceptable, we can look into it.

Thanks,
Francesco
