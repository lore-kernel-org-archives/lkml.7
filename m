Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22263CA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 04:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63892067D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 04:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTNyTkL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbfKEEOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 23:14:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35263 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbfKEEOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 23:14:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id r7so11450335ljg.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 20:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KB+te/nLoebcMQPIFtuyG/ym5HSoU7PnWgKfaQPNOE=;
        b=gTNyTkL5COxLe6mqgrHi3rTaVdO7kVoZQp01mpmI55r12uEYKWt0QJBX1E1p6C7I/l
         btHxbM50pwDG3wpnQ4m55tveqmvQ1sU5LCVbxLPyjMIU9VEwz3awilFHSrwSMLMemOxD
         xZdsRRLzbw0IXm8mE+KQJgsw2PDAQsDawCM/GfZbY2Ngk2PT/DmZ5yMBSeOEhZhHnW3z
         MsxM4eyGrq/S5zZ0ni7q91iHMVNxC9hqketMuY6Htr4dFoOrStv+OUpYCQxCH05MM9VO
         uWtuu4oEU7pecgxvZXUb23Dg+KEIWLE9/QL+qmKP0blqSuXFGFdtZ9VDSzywwSQUClpW
         378g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KB+te/nLoebcMQPIFtuyG/ym5HSoU7PnWgKfaQPNOE=;
        b=Em1dxGXc5c4QarrNukC2wi+0I9wIExeWaBSaXN7p/mgq0tAAaA53jojmwLOAiRt3nR
         DMN6IJxy5bwZbD9sXaKahPfNWC/0bXtULv5zIujbfYa4j3xD1Z1oXyMfWdrIzHfsRCMV
         ylDZk80vPzY8cVFZ6ZZ+Me7RcgccPgwnt//+yUI6De09gBCODYFgCkexGJ6EMwoWoRgl
         DQTE7csKa1Ii4uEEpHGJLYRZD4j6mo9m+mAZNK9uzjMIFrp86AQiKIj+u6tykw2Ex38D
         BuQUWOLSIZeqROI+GcTR8qd2kO55a7aE65J0aDWatqUsIDE5F6CWzYkWep0OYcTYQbbe
         cmEQ==
X-Gm-Message-State: APjAAAXwwZhM3Mh3IM+5n2yNDTqR9TKIAmh+rk9CMYS/q5x7vzyp1Gp+
        xpJRv49T1YrkKSeyeT6+kdJkUqY2ECq6+ubDByVzMQ==
X-Google-Smtp-Source: APXvYqzo8BCoI5pHogfN3mp2CXgLWA5a2xI0z1nWrz3rcFHdAQqHlzKc7jtT22WecxPiwuhFxoupOIdodhQEymY8ey0=
X-Received: by 2002:a2e:888a:: with SMTP id k10mr10715245lji.195.1572927290338;
 Mon, 04 Nov 2019 20:14:50 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsWTFQZTHXUDPToaepnKGBoh61SsA_8SHcYgYZXN_L+mg@mail.gmail.com>
In-Reply-To: <CA+G9fYsWTFQZTHXUDPToaepnKGBoh61SsA_8SHcYgYZXN_L+mg@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Nov 2019 09:44:39 +0530
Message-ID: <CA+G9fYu+6A3pYQGs2rydYtHNSCf1t9+OTRqrZeCbpc2ARLx2zA@mail.gmail.com>
Subject: Re: stable-rc-5.3.9-rc1: regressions detected - remove_proc_entry:
 removing non-empty directory 'net/dev_snmp6', leaking at least 'lo'
To:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     lkft-triage@lists.linaro.org, Dan Rue <dan.rue@linaro.org>,
        LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        Jan Stancek <jstancek@redhat.com>,
        Basil Eljuse <Basil.Eljuse@arm.com>, chrubis <chrubis@suse.cz>,
        mmarhefk@redhat.com, Netdev <netdev@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha and Greg,

On Mon, 4 Nov 2019 at 20:59, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Linux stable rc 5.3 branch running LTP reported following test failures.
> While investigating these failures I have found this kernel warning
> from boot console.
> Please find detailed LTP output log in the bottom of this email.
>
> List of regression test cases:
>   ltp-containers-tests:
>     * netns_breakns_ip_ipv6_ioctl
>     * netns_breakns_ip_ipv6_netlink
>     * netns_breakns_ns_exec_ipv6_ioctl
>     * netns_breakns_ns_exec_ipv6_netlink
>     * netns_comm_ip_ipv6_ioctl
>     * netns_comm_ip_ipv6_netlink
>     * netns_comm_ns_exec_ipv6_ioctl
>     * netns_comm_ns_exec_ipv6_netlink

These reported failures got fixed on latest stable-rc 5.3.y after
dropping a patch [1].
The kernel warning is also gone now.

metadata:
  git branch: linux-5.3.y
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git commit: 75c9913bbf6e9e64cb669236571e6af45cddfd68

ref:
[PATCH AUTOSEL 5.3 12/33] blackhole_netdev: fix syzkaller reported issue
[1] https://lkml.org/lkml/2019/10/25/794

Best regards
Naresh Kamboju
