Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0DAC2D0BE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC3C20675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="jTQIKrnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfLDXB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:01:59 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41415 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfLDXB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:01:58 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so879633lfp.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 15:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=J0ucEi1G0QnviAHmx5pW9x6HCfetITK2+jAEtIBDfrI=;
        b=jTQIKrnxHb/vY1zX7oguKswg6y2Sv/0RLFLCXXLBLnXxv+Mq8gGIViTnbLaifwF8QS
         bS8o2l7KJnVGLsbTPSvJb7yzHApIt8X2ZaFyq1q16oumzSWVOQfAP4HC9mv868ouRM1O
         05f2cS+n8ZB3TdYJs/drIK67c8yWqvSHYXL237lZ9Em8Jeqz8+8xjf9QVxXj78tpLNrQ
         jKJdSboYvAK38WOwwmzbbMBXwTACGNAKA5d3Xd7ErwNM+eqOhGKs6HOJvEG3+KCzU6go
         FWjQ0SUcpBy5SyPBhfw+YJ/jbD6rehZCIApmSBUOvapgn0rKsUKeB51W9ToTF+tXypv+
         gZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=J0ucEi1G0QnviAHmx5pW9x6HCfetITK2+jAEtIBDfrI=;
        b=XqkO47s3XRQqHVQsfkCDkkEUS2aKI2EmpPAXqjTMBHocye84T8jQ+ZvxLxj5dJyvey
         YKynNrBfx+iUUa8TZmjapEdowhXWlZAoKZrB6kLyEBu9i60CCpPkIuxNZy9pMr7em6NR
         WN/8GYE0a1Mz0IPXyIeqGKBbYbtKKAKw2NSd5IN9Jg/xPOEmdx9M6kddMqzYGtRIZ7mS
         JTDG9C2j1mL0rI5Kebq04U3aKVk5SWXru7eUr4zJuJa9ccKbGU3vlM6BdNh8DXnxIKu7
         LRyqSdiKOIBefJTzq06HAuHMLdrjYkPKDdLOuYnCvKSIt8aUVQhtW9Ac35JmXT+lOQVE
         qWBg==
X-Gm-Message-State: APjAAAX9r59e3/J7B372mBzG1HoiFTOfPahjQ0/64Oxr8G2cnMlguC2/
        sDjPtlPPEuU5UJ8MilKxEVtJ6w==
X-Google-Smtp-Source: APXvYqxySJ7CXdTZalDskjNmsGdbbjR3D5tX2IaT+1GugoeOTw3GDKdUgKpg4BA7d25Cv6FtxtJ9WA==
X-Received: by 2002:ac2:5107:: with SMTP id q7mr3389886lfb.177.1575500516805;
        Wed, 04 Dec 2019 15:01:56 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 138sm4101307lfa.76.2019.12.04.15.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 15:01:56 -0800 (PST)
Date:   Wed, 4 Dec 2019 15:01:36 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     David Miller <davem@davemloft.net>
Cc:     willemdebruijn.kernel@gmail.com, vvidic@valentin-vidic.from.hr,
        borisp@mellanox.com, aviadye@mellanox.com,
        john.fastabend@gmail.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/tls: Fix return values for setsockopt
Message-ID: <20191204150136.2f001242@cakuba.netronome.com>
In-Reply-To: <20191204.125135.750458923752225025.davem@davemloft.net>
References: <CA+FuTSdcDW1oJU=BK-rifxm1n4kh0tkj0qQQfOGSoUOkkBKrFg@mail.gmail.com>
        <20191204113544.2d537bf7@cakuba.netronome.com>
        <CA+FuTSdhtGZtTnuncpYaoOROF7L=coGawCPSLv7jzos2Q+Tb=Q@mail.gmail.com>
        <20191204.125135.750458923752225025.davem@davemloft.net>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Dec 2019 12:51:35 -0800 (PST), David Miller wrote:
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Wed, 4 Dec 2019 15:43:00 -0500
> > On Wed, Dec 4, 2019 at 2:36 PM Jakub Kicinski wrote:  
> >> On Wed, 4 Dec 2019 14:22:55 -0500, Willem de Bruijn wrote:  
> >> > On Tue, Dec 3, 2019 at 6:08 PM Jakub Kicinski wrote:  
> >> > > On Tue,  3 Dec 2019 23:44:58 +0100, Valentin Vidic wrote:  
> >> > > > ENOTSUPP is not available in userspace:
> >> > > >
> >> > > >   setsockopt failed, 524, Unknown error 524
> >> > > >
> >> > > > Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>  
> >> > >
> >> > > I'm not 100% clear on whether we can change the return codes after they
> >> > > had been exposed to user space for numerous releases..  
> >> >
> >> > This has also come up in the context of SO_ZEROCOPY in the past. In my
> >> > opinion the answer is no. A quick grep | wc -l in net/ shows 99
> >> > matches for this error code. Only a fraction of those probably make it
> >> > to userspace, but definitely more than this single case.
> >> >
> >> > If anything, it may be time to define it in uapi?  
> >>
> >> No opinion but FWIW I'm toying with some CI for netdev, I've added a
> >> check for use of ENOTSUPP, apparently checkpatch already sniffs out
> >> uses of ENOSYS, so seems appropriate to add this one.  
> > 
> > Good idea if not exposing this in UAPI.  
> 
> I'm trying to understand this part of the discussion.
> 
> If we have been returning a non-valid error code, this 524 internal
> kernel thing, it is _NOT_ an exposed UAPI.
> 
> It is a kernel bug and we should fix it.

I agree. We should just fix this.

As Willem points out the use of this error code has spread, but in
theory I'm a co-maintainer of the TLS code now, and my maintainer 
gut says "just fix it" :)

> If userspace anywhere is checking for 524, that is what needs to be fixed.

FWIW I did a quick grep through openssl and gnutls and fbthrift and I
see no references to ENOTSUPP or 524.

Valentin, what's the strategy you're using for this fix? There's a
bunch of ENOTSUPP in net/tls/tls_sw.c as well, could you convert those,
too?
