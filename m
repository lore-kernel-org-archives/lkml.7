Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC150FA3740
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D31620578
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSumxHPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388052AbfKEH6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 02:58:15 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43162 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388035AbfKEH6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 02:58:15 -0500
Received: by mail-lj1-f193.google.com with SMTP id y23so9742271ljh.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 23:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0wxXarYwGq77xR0cg46b8aXGRRcSnoyv1t4jCG/d4U=;
        b=eSumxHPcOiFl7VhO3WyGBPumPC/v4Gc1aGiHdrzRvyYQ0qesyHB2lYFxyO/Qcinafd
         OzWa6Nabin/RC1XmJ2LaCrRvgbJ3xtONiPrXIcWCXFrtGGNtSY0XcVdgTyglQhj3Mx5V
         u/zy3LBOF37tj0eEzKQC2dej4Wp8Nvlx7IZRdqfYdZAzgwJdaKUIn/5zFIx7hfUrbDWz
         K4ZKtASudEh1ehCqFcnD52++70ap+jkvZDUlEAwJTkd8sp6XPG+oKtUJKCzNJjhX8OIR
         AHeITDXH8JIWVFpw3mfIygK43KkFEIR6tLl+KPIVeDMAFNtaGCBpIxQGC2ytJ30z/Z1q
         ZtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0wxXarYwGq77xR0cg46b8aXGRRcSnoyv1t4jCG/d4U=;
        b=C5WLbmPPg51mlo0aGAYVTfEpZWJ5sxSkl7mF1DH1R/bwu0EFiZJ/+7y31zckiGn4PP
         BnFVtFej0pcyGD6zqI6buP9JoGysNYt6sP+JBc9h9rxYLTZ0ATFfwtz9UoD4GKEfkB+A
         ve9Wd4wH4VxGz3xy6CxGwxj0RyxGK23Mo6W/50iZW3xaVH1AlsgadHE6pw7NxlGzijdQ
         SB7TwLVd5csqCYXudlInPtDKdcv5G9LGXxdmFstJDaOU5u7bee+4vQcIYgcXbkfFqZHx
         FyZfk7cJPs87sMpExLW6Y5b/J4msuv0yCZNpWoEZqrVXbWUAoWqt9Zur6CCc829yVeYh
         oNog==
X-Gm-Message-State: APjAAAW6UcNhhPX+laa1QoiAC44h//CblKe/2Fxx7QNC7VxxzXH08gBE
        jR7xgd2strzgXnWyLltyrCWNR5RRlubnDONhVl63hw==
X-Google-Smtp-Source: APXvYqwItRlN33Dc1rOEb3W8JxKhUBQReYULMFvISIZF6rJ0IO/3DGEZL5QxrgAUTcdO4Qxg1RzQsi4ARYRhodTeuvM=
X-Received: by 2002:a2e:9a5a:: with SMTP id k26mr12064510ljj.46.1572940692487;
 Mon, 04 Nov 2019 23:58:12 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsWTFQZTHXUDPToaepnKGBoh61SsA_8SHcYgYZXN_L+mg@mail.gmail.com>
 <CA+G9fYu+6A3pYQGs2rydYtHNSCf1t9+OTRqrZeCbpc2ARLx2zA@mail.gmail.com> <20191105073459.GB2588562@kroah.com>
In-Reply-To: <20191105073459.GB2588562@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Nov 2019 13:28:01 +0530
Message-ID: <CA+G9fYvau-CY8eeXM=atzQBjYbmUPg78MXu_GNjCyKDkW_CcVQ@mail.gmail.com>
Subject: Re: stable-rc-5.3.9-rc1: regressions detected - remove_proc_entry:
 removing non-empty directory 'net/dev_snmp6', leaking at least 'lo'
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, lkft-triage@lists.linaro.org,
        Dan Rue <dan.rue@linaro.org>, LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        Jan Stancek <jstancek@redhat.com>,
        Basil Eljuse <Basil.Eljuse@arm.com>, chrubis <chrubis@suse.cz>,
        mmarhefk@redhat.com, Netdev <netdev@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>, maheshb@google.com,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019 at 13:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> > > Linux stable rc 5.3 branch running LTP reported following test failures.
> > > While investigating these failures I have found this kernel warning
> > > from boot console.
> > > Please find detailed LTP output log in the bottom of this email.
> > >
> > > List of regression test cases:
> > >   ltp-containers-tests:
> > >     * netns_breakns_ip_ipv6_ioctl
<trim>
> > >     * netns_comm_ns_exec_ipv6_netlink
> >
> > These reported failures got fixed on latest stable-rc 5.3.y after
> > dropping a patch [1].
>
> What is the subject of the patch?

blackhole_netdev: fix syzkaller reported issue
upstream commit b0818f80c8c1bc215bba276bd61c216014fab23b

>
> > The kernel warning is also gone now.
> >
> > metadata:
> >   git branch: linux-5.3.y
> >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >   git commit: 75c9913bbf6e9e64cb669236571e6af45cddfd68
>
> The -rc tree is rebased all the time, can I get a "real" subject line to
> get a chance to figure out what you are trying to refer to here?

Linux 5.3.9-rc1 is good candidate on branch linux-5.3.y and
linux-stable-rc tree.

>
> > ref:
> > [PATCH AUTOSEL 5.3 12/33] blackhole_netdev: fix syzkaller reported issue
> > [1] https://lkml.org/lkml/2019/10/25/794
>
> lore.kernel.org is much more reliable :)

Thank you.

[ Sasha Levin <sashal@kernel.org>  wrote on Mon, 4 Nov 2019 12:13:45 -0500 ]
I've dropped this patch from 5.3 too, it was reverted upstream.
https://lore.kernel.org/netdev/20191104171345.GG4787@sasha-vm/

Ref:

Reverting below patch fixed this problem.
---
commit b0818f80c8c1bc215bba276bd61c216014fab23b
Author: Mahesh Bandewar <maheshb@google.com>
Date:   Fri Oct 11 18:14:55 2019 -0700

    blackhole_netdev: fix syzkaller reported issue

    While invalidating the dst, we assign backhole_netdev instead of
    loopback device. However, this device does not have idev pointer
    and hence no ip6_ptr even if IPv6 is enabled. Possibly this has
    triggered the syzbot reported crash.

    The syzbot report does not have reproducer, however, this is the
    only device that doesn't have matching idev created.

    Crash instruction is :

    static inline bool ip6_ignore_linkdown(const struct net_device *dev)
    {
            const struct inet6_dev *idev = __in6_dev_get(dev);

            return !!idev->cnf.ignore_routes_with_linkdown; <= crash
    }

    Also ipv6 always assumes presence of idev and never checks for it
    being NULL (as does the above referenced code). So adding a idev
    for the blackhole_netdev to avoid this class of crashes in the future.

    Signed-off-by: David S. Miller <davem@davemloft.net>
