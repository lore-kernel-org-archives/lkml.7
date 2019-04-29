Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5412C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 00:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7C020656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 00:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556496569;
	bh=g8nYFJs6vlrz9gmJYdlxdEYWICkiOySd4qo6d4wxN8M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CcZrgwyj5aQacJtcwkBonvZwRKiEbozGZEBCos10EU7GfFHbOVFr4ejaDnKGL/+yE
	 eyWSoBkM1zItrIxcCkmk9qiI4oSwNuSiBIv9zYEq2OUc9WvbMuk6l/6vcugGh5t/S7
	 dTcR5MsUuXyxgMTuQfY0LeSLQZdpu9RSo5zIUbuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfD2AJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 20:09:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37106 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfD2AJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 20:09:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id b12so6532770lji.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 17:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5edmKMNesOmTcxFJnf9Lz0/KQgLhzB4TUwjfxcYB3Uk=;
        b=ez30jOypMMG21KI3XNAUZsoNnolgvRzYvcCoQeA037MgleXHJRmoIb5BJbrsv3QAz/
         4TqBnEJLGefSeW+uwDduv37MKUifx7r1q8Gsfc686s9vJ8f/4YhVRGHG0P02BMeb0UFG
         YPTWymrNHQ99FODG+f5nK6n1Ql7U9d28fc6kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5edmKMNesOmTcxFJnf9Lz0/KQgLhzB4TUwjfxcYB3Uk=;
        b=gypAMBgFdu23ts2nnrCUiT2w54wWjFlmTW4loUg2E9PVRg6HTYSqtDsaBKDUVc+TaL
         sVQ/LYgsnbT01rRWgLfiv22yJgjY7YrU555hfQIvYjgviltU1zPAPMVeq1qfFjfFxAhS
         CMtD0viRQeZ8hBeBGsFV7h/nEqFvj0yjOG5IXdJ2HvvW4+McT8/5LIV3tJnpjIdUdAfB
         p2HV99/69ntXAFV5r0Uhfe/F3fsSQJNbxKCKCgYdD7526NBEPmWZ3eK0B/DVWsM7e5n1
         Lzw8fB0xDybL1sx8gucDuwb/uhgFWKx8TTmJrVnyG0tL5FfWmLNlVKCbxZcufQ/VVoZH
         0GVA==
X-Gm-Message-State: APjAAAUR55No34a4dfdqVmwTUPZBeQUzoNom7PWy45BVFoYJYKGxikCY
        wd+c3937t1ng3RgGc4xKVdhaos9Zr6I=
X-Google-Smtp-Source: APXvYqxIAiX/SDSyWx653RC1c7HneCUcO7JFQJLvqjRl3fOpKJD6JFSaVdEbNR9jMB4Qgj/yZ6J/8g==
X-Received: by 2002:a2e:9e04:: with SMTP id e4mr19885753ljk.74.1556496565425;
        Sun, 28 Apr 2019 17:09:25 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id e18sm6572689ljb.12.2019.04.28.17.09.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 17:09:24 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id w23so6431213lfc.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 17:09:24 -0700 (PDT)
X-Received: by 2002:a19:f50e:: with SMTP id j14mr4933626lfb.11.1556496564129;
 Sun, 28 Apr 2019 17:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190428115207.GA11924@ziepe.ca> <CAHk-=wj4ay=jy6wuN4d9p9v+O32i0aH9SMfu39VKP-Ai7hKp=g@mail.gmail.com>
 <20190428234935.GA15233@mellanox.com>
In-Reply-To: <20190428234935.GA15233@mellanox.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Apr 2019 17:09:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWh+5-jGmgw2HPM8XhzXzvGcLo19UGLtqYe_teJsRgRA@mail.gmail.com>
Message-ID: <CAHk-=whWh+5-jGmgw2HPM8XhzXzvGcLo19UGLtqYe_teJsRgRA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 4:49 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> It is for high availability - we have situations where the hardware
> can fault and needs some kind of destructive recovery. For instance a
> firmware reboot, or a VM migration.
>
> In these designs there may be multiple cards in the system and the
> userspace application could be using both. Just because one card
> crashed we can't send SIGBUS and kill the application, that breaks the
> HA design.

Why can't this magical application that is *so* special that it is HA
and does magic mmap's of special rdma areas just catch the SIGBUS?

Honestly, the whole "it's for HA" excuse stinks. It stinks because you
now silently just replace the mapping with *garbage*. That's not HA,
that's just random.

Wouldn't it be a lot better to just get the SIGBUS, and then that
magical application knows that "oh, it's gone", and it could - in its
SIGBUS handler - just do the dummy anonymous mmap() with /dev/zero it
if it wants to?

Whatever. It really sounds like this is yet another horrible back for
bad interfaces for all these "super-special high-end enterprise
people".

I hope that some day enterprise people will wake up and realize that
"enterprise" seems to be often a code name for "lots of random hacks".

                    Linus
