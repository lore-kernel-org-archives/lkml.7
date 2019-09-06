Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F9EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C299020693
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Rb5hjLH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392501AbfIFH20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:28:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44230 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390782AbfIFH2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 03:28:25 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so10564315iog.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 00:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EPV93q9yLYIKpn8nh2t+hGtrutkW9tKqXiA9UxMOKvI=;
        b=Rb5hjLH97fWG9p+/yNu96w9UO3OKt4FmFKmAw11vyG2iZI06iEgcHhxGgyg28O20Kr
         Rbghe6XoI+sRXgV7YJBO/FPPQUesLs1FXAB+/9VWM553hR2QYn3uxlrlNjd/AL+/+wtr
         kfQn6PC4J6PQJUOSyYUVi8f0h31wY1hhPDB7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPV93q9yLYIKpn8nh2t+hGtrutkW9tKqXiA9UxMOKvI=;
        b=eBXZTcVSS7F1ao+9sS9mbdkwMN16jCIef+Bf9kLaGK9dJx8Kc0u9z1012tsMo+LJEW
         AsG01aAGse3RNThIJIzFpKGhEL1iwGFIRoir8ouSCjhtaa6TYkbgSFNmgw+47IxD7Lno
         so9SeEcYIztFkTfSz27cM4O/5FRQpOWSFuGN536lg7X3RHGAi0jWUTCtybFSUSce/zCK
         YOk9SW9VpDUW90YgLGmSfkHDHrCbDiBXM3bSpYj8Iv+8RT1oB9Nl6MQc+KEpr29V0qKO
         bgqXCwBbdSsdEyKep5wXfMifsBp0HO96zbDZvf5RDIA3EGpt0Zrb1op/fr1+okjWcMuR
         qUOA==
X-Gm-Message-State: APjAAAWqFq/sx/jAowU7rc5XXCxM7cWrjgN6cg7EwHO5E8AvF5oNnw0C
        nZ8LJW/bbDTLLVTZbTe2vjaATcgaTnpEePduB76gqA==
X-Google-Smtp-Source: APXvYqxR3pH944s5Ok7PV+C2BDLvozfEi9oSPmHQa7sH6FfFjXkuExp6qDUMbbUZDXntpKIoHTPtClMWSvVQofi6VEw=
X-Received: by 2002:a6b:5d18:: with SMTP id r24mr8826984iob.285.1567754905146;
 Fri, 06 Sep 2019 00:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190619123019.30032-1-mszeredi@redhat.com> <CAJfpegv_ezsXOLV2f7yd07=T3MenJoMKhu=MBac1-80s0BFg9A@mail.gmail.com>
 <11485.1562257188@warthog.procyon.org.uk>
In-Reply-To: <11485.1562257188@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Sep 2019 09:28:14 +0200
Message-ID: <CAJfpegutbB+kb8oOx5zHx38vGE90H=JdgkM-7bVE3wxypmfAuw@mail.gmail.com>
Subject: Re: [PATCH 01/13] vfs: verify param type in vfs_parse_sb_flag()
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 6:20 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > Ping?  Have you had a chance of looking at this series?
>
> Yeah, through due to time pressure, I haven't managed to do much with it.
>
> I don't agree with all your changes, and also I'd like them to wait till after
> the branch of mount API filesystem conversions that I've given to Al has had a
> chance to hopefully go in in this merge window, along with whatever changes Al
> has made to it.

Ping?

Thanks,
Miklos
