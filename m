Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004C3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0249206A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568487615;
	bh=37IvijjFuupsgBwgNMJ+CIwvfr2qauanGY8JlDbpl6A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0qXRKGHQUyk7F+1b+N4mcTE7kkRZZjFPRKhDNG6UlKlg+SahVaUSWzlPiXCWQJgAq
	 Oxj2KGbR6MHhBJQpy6QW2n6W+rx8ph24izkXLy5lffn9WACSaLIf3DWqgWhgMsGCNL
	 7MuUv3Eyns0rKpEt1a8xPGD3PjnH0uiKgkDRscs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfINS6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 14:58:16 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:35948 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfINS6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 14:58:16 -0400
Received: by mail-lf1-f49.google.com with SMTP id x80so24490467lff.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 11:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9T2Df0KjH101ElzcVxUw1FxV6D3+L4nI+Law0dbRy4=;
        b=MOyVrEu6UmGVN4sTwsa/UWQEkUMczcxFBYYr8mVpBJvuuAF63Fm4OBytPLXkB7TXBC
         F4pS1BG12Z1TXOJj44TYpOfOGhZqXDHyM4cwTKft9zb8wq8Rx6seNb516HVcRyIl0Lru
         p3u7T22+Ubj/c8y0owXwgT+aZAvgt9Fr4pLeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9T2Df0KjH101ElzcVxUw1FxV6D3+L4nI+Law0dbRy4=;
        b=G6tO1GDut7EWI+N3Ry7ZGAXwHxokXR6WvJWeUdkFGxxQ4IvnLcjL7upxjNlM7nnSOP
         wPdOOHuEPthiUNkjVxYCyGd0JIYxoj+G7aLUXB9600QR5uqtr1ViBwFDhrBungIlhOva
         ldgumqI7Xq/lSckAmWPdV/M20LEtRZwigDDcEhEeJb0udL8XDznZjWtCizKRaZ15FVgW
         cZK1oP7MKgpPPaEV7dyhqddRXiYZ24KhT5AB0TWTuWqP+idZrw1MtM7BSmnqAZ7n8xmB
         nfWDvWHKyTsm8wTQxrzfC0cw/rsUPmXlossW5NXGfYcrMznT28FItLvczZHSOdPJtWRt
         9L7g==
X-Gm-Message-State: APjAAAWk+Ib3vQymO+DCfVhuONyku3aRYEeLEloAnt3MywOVhY+3FYlf
        dTVXUTlzPZXm8lgQJ88PUOQiaGWuAiY=
X-Google-Smtp-Source: APXvYqzYvyn0frdWRMeuG4sPmJfGL4nAb/Z4Xq5+ZraRD5ZlUp+6JuqPv9oD+Xi9S/4da0g/qNlV+w==
X-Received: by 2002:a05:6512:4dd:: with SMTP id w29mr13135117lfq.2.1568487494014;
        Sat, 14 Sep 2019 11:58:14 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id z7sm2362275ljc.9.2019.09.14.11.58.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2019 11:58:12 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id u28so3685332lfc.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 11:58:12 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr34936394lfp.61.1568487491890;
 Sat, 14 Sep 2019 11:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tws0GHMQd0Byunw3XJXq2vqsbbkoR-rqOxfL3f+Rptscw@mail.gmail.com>
In-Reply-To: <CAPM=9tws0GHMQd0Byunw3XJXq2vqsbbkoR-rqOxfL3f+Rptscw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Sep 2019 11:57:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wja+f_PCuibu+NqkTD_YL1AY2x4wgX6EwQ3oxCyMTw_9w@mail.gmail.com>
Message-ID: <CAHk-=wja+f_PCuibu+NqkTD_YL1AY2x4wgX6EwQ3oxCyMTw_9w@mail.gmail.com>
Subject: Re: drm fixes for 5.3-rc9
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 8:56 AM Dave Airlie <airlied@gmail.com> wrote:
>
> Hey Linus,
>
> From the maintainer summit, just some last minute fixes for final,
> details in the tag.

So because my mailbox was more unruly than normal (because of same
maintainer summit travel), I almost missed this email entirely.

Why? Because you don't have the normal "git pull" anywhere in the
email, so it doesn't trigger my search for important emails.

There's a "git" in the email body, but there's not a "pull" anywhere.
Could you add either a "please pull" or something to the email body -
or to make things _really_ obvious, add the "[GIT PULL]" prefix to the
subject line? Or anything, really, to whatever script or workflow you
use to generate these?

             Linus
