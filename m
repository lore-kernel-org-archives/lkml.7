Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77940C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415A2214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XhaK4Ig8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbfHALCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:02:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37691 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731332AbfHALBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:01:44 -0400
Received: by mail-io1-f68.google.com with SMTP id q22so23541231iog.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 04:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8p1xBR1158xbW7UpM2v3UIS0V1XEtP9FuX+Bx4DuDTA=;
        b=XhaK4Ig8AIGohl3p3pDHUFJnnjmN3mGWNxElHAJJHrj+sObqWM3V22wfWHtMjco5xS
         RlchtA/bx9bS0VhiCy37hSP8zL1OaLlJgSxR/CzfRPygmJj6gKcum3BVCkoZvIC1NlVG
         n3KUYn6fxuLO0dtS/kQ/Hx1lxjT2HyOToq5Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8p1xBR1158xbW7UpM2v3UIS0V1XEtP9FuX+Bx4DuDTA=;
        b=nSlnMZzZWrsT1tdA0+bEEL5WJBP1zH5fpS1oaT8bOPbzSl8Hk7JHBr7OETWJx/6LjC
         Je3bjKiz380DA8ZgRxWzUMXTk5hji32ZurDRyWxyo180kviJo9WI+8G2/kUGVaMIVqWS
         rRS3y9H8T1Blp5Rc7YYzGvu0p0jonytoGiRfoB/KIzFcW9wAiw5E7ZFV74+LZIdjZP9S
         AP1PU6cA10SH+g6Jc4nKspQlifDxURpoaX6ABlQ54e2RlikUYk+wtEFaJ8GzrMOFyOnr
         IO0BRHxmqWmCT/BpUDGerEH3JvetVcqakuyW45nVyhnT0Jm/BVcuA1tB9fIMByzmlybC
         zHgA==
X-Gm-Message-State: APjAAAX0rpy+DAg2/gryhpHP7AELgHa77ojtac5E5/0yNDY/PCQqyV2a
        MgN7sV7O4Z0SLHWTjkw/6rY3Lk1GjVWjZp5D++OozQ==
X-Google-Smtp-Source: APXvYqxEC4RZeeYHpD8M7AhOaln11d6KDIp7P8XEQUgwnKRLxvY0440LeYW04L8JGzzXUj9c9N+MTEzeESzFvoBdMzU=
X-Received: by 2002:a5e:cb43:: with SMTP id h3mr20920741iok.252.1564657303963;
 Thu, 01 Aug 2019 04:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <d99f78a7-31c4-582e-17f5-93e1f0d0e4c2@virtuozzo.com>
In-Reply-To: <d99f78a7-31c4-582e-17f5-93e1f0d0e4c2@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 1 Aug 2019 13:01:33 +0200
Message-ID: <CAJfpegv-EQhvJUB0AUhJ=Xx8moHHQvkDGe-yUXHENyWvboBU3A@mail.gmail.com>
Subject: Re: [PATCH] fuse: BUG_ON's correction in fuse_dev_splice_write()
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 8:33 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> commit 963545357202 ("fuse: reduce allocation size for splice_write")
> changed size of bufs array, so first BUG_ON should be corrected too.
> Second BUG_ON become useless, first one also includes the second check:
> any unsigned nbuf value cannot be less than 0.

This patch seems broken: it assumes that pipe->nrbufs doesn't change.
Have you actually tested it?

Thanks,
Miklos
