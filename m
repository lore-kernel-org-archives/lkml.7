Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1F8C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B6E20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dqhrWjND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfC1Tpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:45:33 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38584 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfC1Tpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:45:33 -0400
Received: by mail-vs1-f66.google.com with SMTP id s2so11547218vsi.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wrXcdpv8taoXdWmbhLrlOXzqdUnvgbeHD1ossKIFdic=;
        b=dqhrWjNDnpsE7owK5JQ52vNZ8OplZf/F+F4FvCy/ejeRSdm/dA4DfhJcQWIiV05ILp
         nSnNVnDYERrMWnFAxtXJ23SVhdFf5ettkKq4RhfAAOGt0dA3f/e4HeJOD8+DPSEuxyyT
         TQKMONB6Lsr+tjtV3cckmKpU54EcAW+GBffgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrXcdpv8taoXdWmbhLrlOXzqdUnvgbeHD1ossKIFdic=;
        b=OKxim143FdBK3S8s5Na3d12PYNPNBSrkrEL9i7ZtJijCmeVL5b9/RA7F8LK3EIyDdK
         y/mzNJbxNgCVISog8JrE7SdeRV9OMbgHvC9WZFOW1XjV5PbNWDNIHjvUBOaDVZLURYJ1
         YwgMjTzoZVDF+yXS3EZqpAbshBaGZE3PnsdqyixM4B+sgNoC24TDuVA+N3KhMUPWFF4g
         jF+Ry+jnn8Co88Ai9/vdiKfop8uwVxcK/zzj1xBN/I7+uueV5Ipts2E7AZ7Z6bctAlQy
         BBZh1MUfmdiyaNt4w9VnJ+cPEIPxZOG/hDbM4Y9gRgqm6R8LxyhbjTfPJA8wskWjhCcj
         /BQw==
X-Gm-Message-State: APjAAAWUY2H4C5glsMR4Jaaq2Tul6tHZ9lNU0Kp5xR2L3iuML/+vrXVG
        QYfSz6yjt3b+GXUSmhC4xcltyUSfYM0=
X-Google-Smtp-Source: APXvYqw5zJE2cB7hEZlv0koeHQDNwfX7Y/3n9L31TYYH8NFMGQfqd32hKqfHFfHzplQs7rrYHQ5qtQ==
X-Received: by 2002:a67:f714:: with SMTP id m20mr25973645vso.211.1553802331669;
        Thu, 28 Mar 2019 12:45:31 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id e135sm3258967vsd.27.2019.03.28.12.45.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 12:45:30 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id e1so12858702vsp.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:45:30 -0700 (PDT)
X-Received: by 2002:a67:ffce:: with SMTP id w14mr27494508vsq.111.1553802329700;
 Thu, 28 Mar 2019 12:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190327180158.10245-1-sashal@kernel.org> <20190327180158.10245-11-sashal@kernel.org>
 <20190328101342.GD19456@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20190328101342.GD19456@atrey.karlin.mff.cuni.cz>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Mar 2019 12:45:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UzS8qfC2yxep9vhp2QYw9Jy+RHsOgGF5ND2vV1OhYK5Q@mail.gmail.com>
Message-ID: <CAD=FV=UzS8qfC2yxep9vhp2QYw9Jy+RHsOgGF5ND2vV1OhYK5Q@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.0 011/262] tracing: kdb: Fix ftdump to not sleep
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 28, 2019 at 3:13 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> > From: Douglas Anderson <dianders@chromium.org>
> >
> > [ Upstream commit 31b265b3baaf55f209229888b7ffea523ddab366 ]
> >
> > As reported back in 2016-11 [1], the "ftdump" kdb command triggers a
> > BUG for "sleeping function called from invalid context".
> >
> > kdb's "ftdump" command wants to call ring_buffer_read_prepare() in
> > atomic context.  A very simple solution for this is to add allocation
> > flags to ring_buffer_read_prepare() so kdb can call it without
> > triggering the allocation error.  This patch does that.
>
> I see solution is simple, but now we have a loop with GFP_ATOMIC
> allocations inside. How many "tracing spus" is this expected to loop
> over? Will not it exhaust atomically available pages and reliably fail
> in common configurations?
>                                                                 Pavel

Each one of these allocations is ~32 bytes and you do one per CPU.
Even with systems with a lot of CPUs that's not going to be tons.
...and you only do it with GFP_ATOMIC when you're actively dropped
into kdb and debugging.  It seems like going for simplicity is the
right call here, but of course if Steven or Daniel say that it has to
be done a different way then they're the true authorities.

-Doug
