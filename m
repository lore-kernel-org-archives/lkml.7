Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B691C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 16:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B502184B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 16:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20150623.gappssmtp.com header.i=@hev-cc.20150623.gappssmtp.com header.b="ucmSPP0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfHQQhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 12:37:00 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:40491 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfHQQg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 12:36:59 -0400
Received: by mail-lj1-f174.google.com with SMTP id e27so7923655ljb.7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 09:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gh4Uf54lGK4BZME7LVlHMNrohQu549X8RdaI8EEyc2U=;
        b=ucmSPP0TeU4H54GmmFSX4Cbw/YJZftuFiiY89vjitwPTk9KKJY5ycyYQfwfYFdHg5c
         ZMpTLVGFFJx541rvL34eMhfZM/MzoscItMRHiVw2GSlweHhfuE/GFEwcIlgjcDkwPjZb
         s91eCkJZi50Zd82fmuQtlTG7cm7+EpxqhWLQP2T53D5zMMs9Jl8FtyEfQ29/yLEaIS3L
         iAcSvON1BBiNBJXR4tHKjfD1/dlbJK09TCRh6ey1KyPlOE9wZUzx7mmnVneQMOolnM8/
         Ta+isnau03b0FOX2KMb95v8o0sVN35kL8AO9XFsQnbhGL2ArPxZx6ud9C9V5ce4GOQSU
         Pdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gh4Uf54lGK4BZME7LVlHMNrohQu549X8RdaI8EEyc2U=;
        b=oy2artkBtm65MSzWnFBTK6gRF+OM7RUB6uesgC34yQUV/D4VdDNbSJohnJ+83AjUm5
         OCsCvWh+fwPXBl+eWsr3zdyeF6pyGmfae5zqYttkoAPI5rQ2otkopOe650eIb5dbwKWO
         fhxe56WAvgAGQJQ6AvcSpmM+uYuBCz//IIt2SxCRtT91rfAnMrElvLos4euH6AgQwnaL
         mlSrkoZHNRea2V3/1d/I+aDqb4YTB61VA2EDkxWXXTi0WuOAv7xNj1XJKUtObFeaTQKW
         JCot1yg0B2VEOMSi2foEtwBXUr3c0lmB2IflRVajRTh6qG4MAn0M/btEEWsr2yJqBUZn
         tV2Q==
X-Gm-Message-State: APjAAAUiclK1NkLPwPAYDlrsQGra06gD9H3gomiewFEGgCSCf4sIj30f
        ZDbFohVsBWCWVbuM4DYu8nm4x8avUKJO8voEWFxLrwhem2eJvA==
X-Google-Smtp-Source: APXvYqykqyUbBf3gFxrxYebFwwEH7G9fHg8I2CBloFyhVPaSb9fhNy2DNaUEEsMzxIDRt18Ox0vyCgDmLwEfBQ1mEdI=
X-Received: by 2002:a2e:6393:: with SMTP id s19mr8076155lje.46.1566059817953;
 Sat, 17 Aug 2019 09:36:57 -0700 (PDT)
MIME-Version: 1.0
From:   Heiher <r@hev.cc>
Date:   Sun, 18 Aug 2019 00:36:46 +0800
Message-ID: <CAHirt9jesMHB_sXx7PyXTxrzLR=3xw9bHERueNMVkWOUkg6XXQ@mail.gmail.com>
Subject: Why the edge-triggered mode doesn't work for epoll file descriptor?
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've added a pipe file descriptor (fd1) to an epoll (fd3) with
EPOLLOUT in edge-triggered mode, and then added the fd3 to another
epoll (fd4) with EPOLLIN in edge-triggered too.

Next, waiting for fd4 without timeout. When fd1 to be writable, i
think epoll_wait(fd4, ...)  only return once, because all file
descriptors are added in edge-triggered mode.

But, the actual result is returns many and many times until do once
eopll_wait(fd3, ...).

#include <stdio.h>
#include <unistd.h>
#include <sys/epoll.h>

int
main (int argc, char *argv[])
{
    int efd[2];
    struct epoll_event e;

    efd[0] = epoll_create (1);
    if (efd[0] < 0)
        return -1;

    efd[1] = epoll_create (1);
    if (efd[1] < 0)
        return -2;

    e.events = EPOLLIN | EPOLLET;
    e.data.u64 = 1;
    if (epoll_ctl (efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
        return -3;

    e.events = EPOLLOUT | EPOLLET;
    e.data.u64 = 2;
    if (epoll_ctl (efd[1], EPOLL_CTL_ADD, 1, &e) < 0)
        return -4;

    for (;;) {
        struct epoll_event events[16];
        int nfds;

        nfds = epoll_wait (efd[0], events, 16, -1);
        printf ("nfds: %d\n", nfds);
    }

    close (efd[1]);
    close (efd[0]);

    return 0;
}

-- 
Best regards!
Hev
https://hev.cc
