Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7311ECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A7821D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lagxcqO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfKDNOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:14:53 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:34951 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfKDNOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:14:52 -0500
Received: by mail-lf1-f45.google.com with SMTP id y6so12221083lfj.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 05:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WMEf75w9oTagZRQTZzN7l66ng3i5+ieYjRbW8mGQvLE=;
        b=lagxcqO9BFG+5tBBWGjO/MIu8tH/fFE9Gxtrjq2WCr7OSpNkq9wThHjLZtIaP/Z3/d
         llCbpUKdJhZWEogUhme8/naioG5rI2AAMpsqphTfKmtvPvLF71r5wTq53R8Jm6SJagjn
         ZV3+KfhiQOeWSz5zXnjT1qzsUg8Y+bcyc6BiMXJrdaa+i0Ws2VtGKLUu3u4y9Ldgf4mR
         rPgBcWVJ2SszHsiFx26VFlwiecPFrb8b5yn3G8FPMl+PMrgHu2WIL9slyliZGjMnxeSX
         TRGmRmfPZTIvNLyLOIb0N/2PIZLCBYpo2WHhrXi3hqrwBXKYvspCj/n0pKn844SCh3Be
         NBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WMEf75w9oTagZRQTZzN7l66ng3i5+ieYjRbW8mGQvLE=;
        b=R6zbc1sKSvRpuV64sW1y0i4hg9a8MJTEzj1uWCC6ftc91UfCN6jVDIIwiGdZUtVtmy
         2jwFU9z43Zw8U6FHvQWbg1JdZsoraXGMqHi0+lIl32qKgmgl55X4tQFjPkvW7M+gP0yC
         YcsnQYvBdHYlk6WzLZh+ukplu3KsS6ICSXCT5B7DQGw9qF5nBAuM3wOw9vHxKWodZQmq
         r6+WR8Xl0rVClXOTmVnEP6IbC3mOdTzeZNMxbggd1iO7yHYMuskvu+ZxWUaI7B072JCd
         jeO5DZquWm0SxzVZC2EX6aemPUg6Iipm5ELWzSP118UZZFcGGP8b73WRGLsXPktFZyMY
         A2hA==
X-Gm-Message-State: APjAAAXgV+bwg+uii3ntvrGyHOjR0qv8PJME7uTxRAkdZeNRIDOON2o9
        kSCVvz12x4+MpQ5GfNwy8k2HZTgQZ81M3pgVimYRDg==
X-Google-Smtp-Source: APXvYqyXlHJrIntltQv8i8RV7fF+BbSZCuGIhS2LO0/Un8NILT1G3+ClWfvxx+fQbF2wluVplwQyGzi4uJCkpuEw9Jw=
X-Received: by 2002:a19:f811:: with SMTP id a17mr16390181lff.132.1572873290596;
 Mon, 04 Nov 2019 05:14:50 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 4 Nov 2019 18:44:39 +0530
Message-ID: <CA+G9fYsnRVisD=ZvuoM2FViRkXDcm_n0hZ1cceUSM=XtqJRHgQ@mail.gmail.com>
Subject: stable-rc 4.14 : net/ipv6/addrconf.c:6593:22: error:
 'blackhole_netdev' undeclared
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux- stable <stable@vger.kernel.org>
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        lkft-triage@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stable-rc 4.14 for architectures arm64, arm, x86_64 and i386 builds
failed due to below error,

net/ipv6/addrconf.c: In function 'addrconf_init':
net/ipv6/addrconf.c:6593:22: error: 'blackhole_netdev' undeclared
(first use in this function); did you mean 'alloc_netdev'?
  bdev = ipv6_add_dev(blackhole_netdev);
                      ^~~~~~~~~~~~~~~~
                      alloc_netdev
net/ipv6/addrconf.c:6593:22: note: each undeclared identifier is
reported only once for each function it appears in
net/ipv6/addrconf.c: In function 'addrconf_cleanup':
net/ipv6/addrconf.c:6667:18: error: 'blackhole_netdev' undeclared
(first use in this function); did you mean 'alloc_netdev'?
  addrconf_ifdown(blackhole_netdev, 2);
                  ^~~~~~~~~~~~~~~~
                  alloc_netdev

Build link,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.14/DISTRO=lkft,MACHINE=intel-corei7-64,label=docker-lkft/632/consoleText

- Naresh
