Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F05CC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 16:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAC320830
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 16:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568565018;
	bh=kmkdn52wRaAnXvKHQYx3MjH7SvbGMHnwCzy9AkiFvYo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0vwuU1kO9GJBE3WCi7lJJF5anQ1VRSLtn8cgJJgAhl6dWNpiPDJ+Uxj+hy3EO5lE6
	 c+JQKT+0WdwzeIpVKQ206YkCGfW/mZ7fCxdnDB6OiShPUNDdYyXvBGTnmdpUeC/HFP
	 RrhQQf85uiQRv994nKLcQHfa95ubAk05wsukzlWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388201AbfIOQaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 12:30:17 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36773 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388025AbfIOQaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 12:30:16 -0400
Received: by mail-lf1-f68.google.com with SMTP id x80so25596774lff.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 09:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8eXQR5cNa/rEvZ1aNPUIkNm/QbpDwPCy01MJ9nMVGXA=;
        b=X93ojoRt0fwRn6t2yZfaMbViKKNJwHwvJGGsbpHUO+NgdcUiIJ/BjYUURdYoYJHliC
         Ea5JW2CXXXcZaG4w3q6JGmNcVoRVTe4q5vshFp31k1mqZi2rff9M4H1EHgQGiLBz2Wrn
         g31xHYn3n5K+fcb4Uzc1ryw8ed/gXBjoQetbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eXQR5cNa/rEvZ1aNPUIkNm/QbpDwPCy01MJ9nMVGXA=;
        b=tc6w6dkAbHJoUcbcxVQZjCzScApDvDEvbG51l5/5a5+Pg6pzLDDLG8ZGe2fSBibNGU
         pjx401uk8O37A8bEKdFhcGLwUDaS4sLwq6GqmJHLnHdHNWSOYQiF0/Ro/OGLmYZL8imK
         fdOjnnPZitEFbgUSSaViv/jgUEy1KwYfjQ+OTElTijsXYhqW03WrqkaS4/YRk9N5UgP3
         H4zX2ofZHnrpiv6tqf8XWaDtCfnCszVae256mqu8KVkkv8X1Hcz3bEk2Myt9DkWwzWa5
         MWMF4NnC4uDL5uPOIpirFII2RXY2ZJrrX7oYU7MLrQdWYsD8R++yBmFfguNuz0vu3wgf
         xJYw==
X-Gm-Message-State: APjAAAWHNnwvphE7nzqY6P3t7tOTiWy9KkJPmRjMH98sUOr0OK6dFdQM
        kYRwlz4Qql2MKEvbfJEqPcM0ccxnW7A=
X-Google-Smtp-Source: APXvYqzgmbJfDkoZ+sfTDVxb4C0lYk7nUP4QY6VQd7+8GAWGsJjFB6vVTtcwnkO4APzDrKySAFBrPQ==
X-Received: by 2002:a19:da01:: with SMTP id r1mr37376914lfg.150.1568565014341;
        Sun, 15 Sep 2019 09:30:14 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id f21sm5569704lfm.90.2019.09.15.09.30.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 09:30:12 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id w6so25602869lfl.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 09:30:11 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr36503149lfp.134.1568565011303;
 Sun, 15 Sep 2019 09:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu> <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190915065142.GA29681@gardel-login>
In-Reply-To: <20190915065142.GA29681@gardel-login>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 09:29:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
Message-ID: <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 11:51 PM Lennart Poettering
<mzxreary@0pointer.de> wrote:
>
> Oh man. Just spend 5min to understand the situation, before claiming
> this was garbage or that was garbage. The code above does not block
> boot.

Yes it does. You clearly didn't read the thread.

> It blocks startup of services that explicit order themselves
> after the code above. There's only a few services that should do that,
> and the main system boots up just fine without waiting for this.

That's a nice theory, but it doesn't actually match reality.

There are clearly broken setups that use this for things that it
really shouldn't be used for. Asking for true randomness at boot
before there is any indication that randomness exists, and then just
blocking with no further action that could actually _generate_ said
randomness.

If your description was true that the system would come up and be
usable while the blocked thread is waiting for that to happen, things
would be fine.

But that simply isn't the case.

                  Linus
