Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD91BC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9395920B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jq9kKqoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbfFRRh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:37:26 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:35552 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbfFRRhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:37:25 -0400
Received: by mail-lj1-f171.google.com with SMTP id x25so421114ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 10:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QROr5zriDXIm3C2J+ydlhxHZFPlNm4wl+giC4xaoC34=;
        b=Jq9kKqoUb2VmJTD/fdjLOpJ6OlKWK3BsI4TJY6HmQJOIFVS+PhpHzYgBzyBAx0L0yK
         yduw27Zbxw2DRpeHT4cKAoHqU+bBhUrs8jRK98LYxxMkTIZLBvDoyhW0bqQJ+rw3PyjB
         NDdxm6tS2+mh9G3uK6x47ngzO/1qfjWJOaLoYKSd0X92Wu/6iN+2jMEWWp0Ly0MBveX9
         +/U5GJfhpQbHtf74efe0DYNg1EuhdmzpByNdX1CLbkSQZ3BVOkDd9a0UV+Hu2ixYnqrw
         CPlYzaUUfJHLb9/S8+jayGwKwbXcKao0VRO3OAY+0lEXkpsXvSPP5cwSDk4SFezcxdYU
         pTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QROr5zriDXIm3C2J+ydlhxHZFPlNm4wl+giC4xaoC34=;
        b=X5fLU6pKlEm9nG5L02peZtCIa7YODmD/cahICisqCjdrqt+PN27JwvluHXQ/tBWEPK
         YNsTHj9nMmkztxshU0NDCKXmQ1fNm//ny3balS6jrPfuILbMpteJ0yORHzAZLTDXpt4G
         m47gDxWNqiiezagpYVosMX9xV9nxs8ARerQobNoQi7A1zhyuvUNgE0YJmD0IizhXmwD8
         rq8UxTL0dAFuVkE1PEB7qVXSRhQz6q9JZOQb6UTd5rYe3LzbfE9t3DWLcOzyLL4agsJA
         wK2FIfiU4oPvXfB4uZYsdWWN5W87MgtfF/z4hmPHLy7+IRumpB5EpYNi+RkbNySRwBox
         IDmA==
X-Gm-Message-State: APjAAAU93WSHG5vmpBZIm/s3BigFBOL3pbDJ99sFLeL61S0lR4v6Sc6O
        ai/kptGHWFoZW7xDrblpm9gUhnOurTG539DZ52YLIw==
X-Google-Smtp-Source: APXvYqybJbrB2HTsNMMGAvCkrzRmM0i3sLs86Si+JSvi3tk4xwxA2skoL3QUi1uzNWm7y3Vo4ZFRhnSSidXf6dCZAnI=
X-Received: by 2002:a2e:9ac6:: with SMTP id p6mr35749812ljj.100.1560879443135;
 Tue, 18 Jun 2019 10:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b6b25b058b96d5c3@google.com> <20190618121756.GL28859@kadam>
In-Reply-To: <20190618121756.GL28859@kadam>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 18 Jun 2019 10:37:10 -0700
Message-ID: <CAHRSSExL1fUNpV4jBON5qh47M8A+na0twVNEqpvkBoYVnbJSHA@mail.gmail.com>
Subject: Re: kernel BUG at drivers/android/binder_alloc.c:LINE! (4)
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     syzbot <syzbot+3ae18325f96190606754@syzkaller.appspotmail.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@android.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Todd Kjos <tkjos@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 5:18 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> It's weird that that binder_alloc_copy_from_buffer() is a void function.
> It would be easier to do the error handling at that point, instead of in
> the callers.  It feels like we keep hitting similar bugs to this.

The idea is that if it is an error that the user can cause, it is
checked by the caller of binder_alloc_copy_from_buffer(). Most uses
are kernel cases where the expected alignments should be fine and it's
a BUG if they are not.

Admittedly, a few cases (like this one) have slipped through since
they cannot happen in Android (syzkaller has been very useful to find
our bad assumptions).

-Todd

>
> regards,
> dan carpenter
>
