Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111B9C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B812075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDCPMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:12:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35961 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCPMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:12:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id s15so19979042qtn.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 08:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=6KcqSgR7jQvYI3ZqGHsc9dGy3zUjE0GqrmZH44wkq+A=;
        b=EdNcq0LO1pBZy2CIpZ0CgxmJTVBTQJpf6HcCcGLqBlUavq0y8ODM4RX5r4sLelQ/gD
         rshNxgE/kbWTcn5OrHF5AO93NXwzYD+UPgxx9G9sO54ZGT4PibEDa0BJCkMzE8FrH+Sy
         fvKHX3nfnZCxnk5TwwT5LDJEpgih40b3V59sxdJcOJsX8tL4TcFi5gYNHw5O6x7xKT/t
         oy25kiijuajWocxopS5wd4bdpakT38RQ/1B6oCAmhsLf+EI3ySm7bnobSEhRDf6j3vzr
         b6MbnckEAMqsv6VnVIL8WIb8tnIB7YBV//Hcbgm1wR8C376+GCKvbXufEL7DbW7hW2ry
         p/ZQ==
X-Gm-Message-State: APjAAAUv5HSPTLO1zjIKxwDMnkc619uGZY6iuoUj7lRSYS9jX/kTrPUe
        INmmOMsfaj2SOTKbmLXHI08T68nqT4c=
X-Google-Smtp-Source: APXvYqx9Te0vvS+7ASHu3/bHss1DMNV64kAp0juLh0fAK86Os2ftyN6aZnUrn2tMcgJDxOy2BnGy4A==
X-Received: by 2002:ac8:3feb:: with SMTP id v40mr429083qtk.102.1554304327126;
        Wed, 03 Apr 2019 08:12:07 -0700 (PDT)
Received: from dhcp-10-20-1-165.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id t129sm8712446qkc.24.2019.04.03.08.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 08:12:06 -0700 (PDT)
Message-ID: <85ba308177f4e9ddee336d5110cb6df7a447cebf.camel@redhat.com>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
From:   Adam Jackson <ajax@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        Dave Airlie <airlied@redhat.com>
Date:   Wed, 03 Apr 2019 11:12:05 -0400
In-Reply-To: <20190403072318.31507-1-kraxel@redhat.com>
References: <20190403072318.31507-1-kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-03 at 09:23 +0200, Gerd Hoffmann wrote:

>  - Only DRM_FORMAT_RGB565 (depth 16) is supported.  The old driver does
>    that too by default.  There was a module parameter which enables 24/32
>    bpp support and disables higher resolutions (due to cirrus hardware
>    constrains).  That parameter wasn't reimplemented.

One slightly annoying aspect of this (well, initially of the patch to
clamp the default to 16bpp, but this too) is that we only have a way to
ask the driver which format it prefers, not which ones it supports at
all. For X's modesetting driver (and yes some of this is because X is
awful) this creates the following failure mode:

1: user sets up xorg.conf for depth 24
2: user upgrades kernel, reboots
3: X driver detects that depth 16 is preferred, but
4: X core respects user's xorg.conf and tries depth 24, which
5: throws -EINVAL and X won't start.

Possibly X should work around this by transparently setting up a shadow
framebuffer at the user's requested depth. The problem there is, if 565
is preferred but 8888 works, you're adding a format-conversion blit in
the middle for no reason. If I could ask the kernel for the entire list
of supported formats, I could only set up the shadow if it was
necessary.

- ajax

