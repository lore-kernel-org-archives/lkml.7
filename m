Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F5FC2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973AA2464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575566713;
	bh=Rw7OSMPf9yit/kp3KVKphhbKGqVjIJjjc9QupnBWMos=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=amRQGiyCee5Z0qYOTU463dKtyZ4GuJ4i/15DiXsi1QDXqYt+r+Gp0QjheKb5Z2ffQ
	 xEgQayz1S4q8Gbe4I2+Q6cq9Kvs6TX5G1hH4SPM9nnnPC6xowmoRBpLvvpdSDT0PUy
	 OlNhrJ+WVQMNoD5mIfJIq2SCepCc0LEsxkRG/81Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfLERZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:25:12 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34535 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfLERZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:25:12 -0500
Received: by mail-lj1-f193.google.com with SMTP id m6so4544734ljc.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 09:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wcGyAgv2BiiKMB4o1JPjh3c4/KLE1QL1Cs5ZGEHCDIc=;
        b=h8R8qn2a8yMheUZxZicjSxy1mjJzLS/SXEZWNWhN2n29VR1l3aKAlm1cuqN3fZyRfk
         7RiJ2tHBwlnu/dxOScE0uVy3iZQZ7SYeh67Cd1w1vNd2lAU44JJHrRfgT90jo1Vxdgk6
         hfczULjbW6MoOj6k0umoQaFr+3JFVFJeh4/gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wcGyAgv2BiiKMB4o1JPjh3c4/KLE1QL1Cs5ZGEHCDIc=;
        b=Tkbu3fxnF7e6pvNOJorJtYvHx0AjbmU2UiTMPp/7HwkjBntsUHxDdjngFN7qXuTuO3
         Vz65v5HPCjqVlBdx3RizxWQLcmGgh1MiVcUw5MbuRZqOVD2SPywlaQ9eccj5kLoDfrTm
         dkXDrKz8BgDphzkb+fzGVT6Wmk6KkaM/t7iErGPaj6IiBUWmaUsnmyfiXYe9V9exa8LR
         eLW9ILSeULlSRtfssn+gW4KWIHRFpFuwws2ASgpyqjWPnelOYHUbmXTmKGVdjegxSeOg
         OMSE5SFO0Zfqx3J9GYKGYO8pbI7BCjKjPKV0AdipZbP/EOCyIn18/nPdtaWUuS5DxqO4
         rrKQ==
X-Gm-Message-State: APjAAAXscYxw1nQZEb1FtDp8QhN2SEWUzxiiceJtIEJepxEQkBIFoFDX
        cwXgkAXzwBawMCd0bz8yJFQ5jhm9MRc=
X-Google-Smtp-Source: APXvYqz2VJM8ZVPRpDQT84rjXDNMcGWVHpGyNjWX2XLM2z7lYSPQYPUBkgTbWm8PDdNvblPuiEktGQ==
X-Received: by 2002:a2e:864f:: with SMTP id i15mr6020237ljj.29.1575566709312;
        Thu, 05 Dec 2019 09:25:09 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 145sm5266591ljj.69.2019.12.05.09.25.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 09:25:08 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id s22so4490583ljs.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 09:25:08 -0800 (PST)
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr3763207ljg.82.1575566707941;
 Thu, 05 Dec 2019 09:25:07 -0800 (PST)
MIME-Version: 1.0
References: <31452.1574721589@warthog.procyon.org.uk> <20191205125826.GK2734@twin.jikos.cz>
 <1593.1575554217@warthog.procyon.org.uk> <CAHk-=wgwwJ+ZEtycujFdNmpS8TjwCYyT+oHfV7d-GekyaX91xg@mail.gmail.com>
In-Reply-To: <CAHk-=wgwwJ+ZEtycujFdNmpS8TjwCYyT+oHfV7d-GekyaX91xg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 09:24:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi_on1EAbVi1Q01i7=0_GL=nKmz6s9677YZf74H8=Sw0g@mail.gmail.com>
Message-ID: <CAHk-=wi_on1EAbVi1Q01i7=0_GL=nKmz6s9677YZf74H8=Sw0g@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: Notification queue preparation
To:     David Howells <dhowells@redhat.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 9:12 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It would be interesting to hear if somebody else is waiting on the
> read side too.

Looking once more at that commit, I find at least one bug, but I'm
pretty sure that's not the cause of this problem.

DavidH, watch out for things like this:

-       for (idx = 0; idx < pipe->nrbufs && rem < len; idx++)
+       for (idx = tail; idx < head && rem < len; idx++)

which is a completely buggy conversion.

You can't compare tail and head with an inequality, it gets the
wraparound case wrong.

But I found only one of those, and it's fuse-specific, plus the
overflow would take a long time to trigger, so I'm pretty sure this
isn't what DavidS is reporting.

               Linus
