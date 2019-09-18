Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F661C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC99C20640
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=glasnostic-com.20150623.gappssmtp.com header.i=@glasnostic-com.20150623.gappssmtp.com header.b="uviuOuUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfIRHog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 03:44:36 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:52065 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfIRHof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 03:44:35 -0400
Received: by mail-wm1-f44.google.com with SMTP id 7so1315983wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 00:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=glasnostic-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=k+g/h+Oe4nMC1JV2ZVbWMGZy/H+z15eG6upilMaTp2w=;
        b=uviuOuUAD7bDNqBeNuKtxvl6LXrPltTsWAArxs8d1yR7j9uZy/ThsDQ//d2XDr7mLb
         g3QH0FPRFoYNuKryWroKrN0f18m5qORS5Z3YdA6d0XphmXtxMvapkb+IoGD7Q1Sa3Bqp
         XLx8iYTZGKFhZFQrjpRehqbOB1RXb6GLsCIvHdHwXDr6UvqTn1Qy8hfuezRcToeCvJEO
         I/ybZRghun6zkFALGqGZOv8Q3I3JK2AKhrMBcWa7mJBNIOkzDAUujOSsOM6Gv2MBzJbD
         HaIbhkb3GuFHWpF2vSUVVpndwtW4pi1oGWzrMp87wwCq534K6oF/9RNMEcFdDtwg7NJB
         uvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=k+g/h+Oe4nMC1JV2ZVbWMGZy/H+z15eG6upilMaTp2w=;
        b=WyONQJYhUioSQvDPVYJawG8UZxHcePaakpIwZIqgEWoshwAMRQaboFBFkz3VM7eh9f
         roqb73gToUxt4pazDk3Aqds4YG1LrEGYevuAqPjVos5+Yw7C9EWkoU5K8MJ1bZWs0Sl4
         KpQuyadKDS06Jtsq3FGb6HHYyLXUkFPm8b0PaWVioqpay9owAQHnb3R657h1FV+ORSLV
         ENBwOBtqDzBvD8fSXPeTILAJ6FAszQX08t9syzAJMng2EeRzBFb3q1Tqb9O0pzp0TCYo
         J5sub0CRKkb+ttjx8hxpk1aHUcS//9QHQpHGJiMfxfWjpagKXVG+iRL48Dgkem+RatT5
         QDPw==
X-Gm-Message-State: APjAAAUJ/i6wWaoIFM4OKl8rdpI3GIpK5/9ycRE7iKWYVlmdl9INdqgC
        Ikde2kQZ5EE3aNKxoG9rwG07lllNNSKqMKJZ3RA91FoDHw4=
X-Google-Smtp-Source: APXvYqwWGcxCqOc6Z0jbPeZoRXG/cjPbr64mBRtrGw95oincDfdzmDaQDZsqDddtzJLWQ16yOy5KkFQA4Iy8Cb1sv4w=
X-Received: by 2002:a1c:5444:: with SMTP id p4mr1310668wmi.69.1568792671757;
 Wed, 18 Sep 2019 00:44:31 -0700 (PDT)
MIME-Version: 1.0
From:   Yu-han Lin <guesslin@glasnostic.com>
Date:   Wed, 18 Sep 2019 15:44:20 +0800
Message-ID: <CAAQmspMAvcs01Twa2yDyRkq4TuTOMeFFoJvQGu5F_z3zeM26mg@mail.gmail.com>
Subject: Running AF_XDP inside Docker using veth driver
To:     linux-kernel@vger.kernel.org
Cc:     Yu-han Lin <guesslin@glasnostic.com>,
        Marcus Schiesser <marcus@glasnostic.com>,
        "Shimansky, Gregory" <gregory.shimansky@intel.com>,
        "Melik-Adamyan, Areg" <areg.melik-adamyan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wrote a test case handling network traffic in user-space inside a
Docker network
by using an XDP socket with libbpf. You can find the code in

https://github.com/glasnostic/af_xdp_test

My kernel version is 5.1 with XDP_SOCK enabled.

In this example, I have an unstable result while getting packets from
the XDP socket.
We can see a significant delay (~10s) until the packets are received
by the process.
It seems that XDP processes packets in batches and only when enough
packets exist,
all of the packets are sent to the userspace process.

This is a problem for traffic consisting of one packet (e.g. ARP, PING).

What is the correct way to deal with this problem?
E.g. can we force XDP to flush packets?

Thanks for the help.
- Yu-Han
