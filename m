Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C05C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E002D21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oexS9agX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfCOPTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:19:39 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37656 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfCOPTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:19:38 -0400
Received: by mail-vs1-f65.google.com with SMTP id y19so5594053vsc.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 08:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UARgXvp0QWZykZpoqJygti2OP0fysMbvPm88o0+JuYg=;
        b=oexS9agXUJB65cNbAsS88Av+kkpDiBsMQXhk6YPCuMAD4w7ye3Zt7N4ZjtispSAnjn
         bTjU9Mmg6QRzSHGjDK6aGAYN+esRopye2zSx9NQ78s7RqBOgfo+ioLwMqHmH71jmyMqz
         NcBzByumZAJYiDcC6BLkm2dzfBnRKhU1C56tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UARgXvp0QWZykZpoqJygti2OP0fysMbvPm88o0+JuYg=;
        b=HacOPJlDSHXjZ3z8ilLEw5LoTpG7NE/RhWuQntGKY/n6P4q4eUEKZdCjl0p3BkeXZH
         4mo1sazRiDLOsWAoUrAno4tSB1URmMwwFihiOtkmUqtPbOZaBGriOIRp9dKAy3Onkd/Z
         9rIQQH/5UE83XZ5S8EJHpj/ZWiDLEIqHNa+uRl6rcN/nFmaRvLzDfqoAPayGiXUuShnt
         goQTHM3b15vTCTx7Sm2B6BWQv9LIuWu7aDL821f3iE5dLLup6p2+7Rju4DA78iaWQLAV
         j2bk6S2cNVsFg4ugzLfCdw3sh5YIdBb5eXdeNH7J9wjf0UA5r7567KhEdHhvlw13fCAY
         U/2Q==
X-Gm-Message-State: APjAAAUv6lSFH717gMSxDI09NLmP2L2SDdGjI0M2yKcKDC7IGTG2ruKX
        77aos0s/5gNLYZ5JMZJSm3pV4L4Me+0=
X-Google-Smtp-Source: APXvYqzYZrI/qiw1GJqQISkCmXB73vb6/MgglNjDve4JuQHGgXrvfAhWgw+zdDO216+kGjj8Zc+vfQ==
X-Received: by 2002:a67:2b44:: with SMTP id r65mr315629vsr.38.1552663176994;
        Fri, 15 Mar 2019 08:19:36 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id j4sm1869951vke.0.2019.03.15.08.19.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 08:19:35 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id v131so2282853vkd.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 08:19:35 -0700 (PDT)
X-Received: by 2002:a1f:a5d3:: with SMTP id o202mr2339880vke.40.1552663175354;
 Fri, 15 Mar 2019 08:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190314175705.11671-1-dianders@chromium.org> <CAK7LNATvfVD8RfZN37fXGKJeEuawM_7BuVrJ4xw1pZmuz5f_aw@mail.gmail.com>
In-Reply-To: <CAK7LNATvfVD8RfZN37fXGKJeEuawM_7BuVrJ4xw1pZmuz5f_aw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Mar 2019 08:19:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V=s8e12W7XiMGxwzi9gqkvAqRfKqYBv_ePhh4y77ZkUQ@mail.gmail.com>
Message-ID: <CAD=FV=V=s8e12W7XiMGxwzi9gqkvAqRfKqYBv_ePhh4y77ZkUQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: If the module stripping command fails the build
 should abort
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 15, 2019 at 7:11 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Fri, Mar 15, 2019 at 2:59 AM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > If the call to strip returns an error code then it makes sense for the
> > build to fail.  Currently we'll just chug along and ship unstripped
> > modules.
> >
> > Fixes: e2a666d52b48 ("kbuild: sign the modules at install time")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
>
> Did you see this problem in the latest kernel?
>
> Since commit q,
> $(call cmd,...) is run with 'set -e'.
>
> Any failure in a series of commands will let the build fail.
>
>
> If you have the problem in old versions ( < 4.20),

Ah!  I was in 4.19 when I saw the problem.  I then confirmed that the
code in mainline was the same and that the new version built fine with
my patch, but I didn't go back and confirm the problem there.

OK, I just checked linux/master and can confirm there's no problem
there.  Sorry for the noise then...

I wonder if perhaps we should revert commit caf6fe91ddf6 ("modsign:
Abort modules_install when signing fails") then to be consistent?

> I do not mind this patch for linux-stable.

It's probably not worth it.  In general I prefer linux-stable to be as
just cherry-picks of mainline as much as possible.  When it starts
forking then future picks get harder.  Sure in this case it's unlikely
that someone will get tripped up by an "&&" vs a ";" when picking
future changes, but given that it's not super urgent I guess I'd vote
that we skip it.


-Doug
-Doug
