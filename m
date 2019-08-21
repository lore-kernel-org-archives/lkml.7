Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A65C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7892339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dj/lnu3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfHUOI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:08:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37316 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfHUOI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:08:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id y9so1145581pfl.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g8e7X/wg8+ApZ+vWe4sHZB1SNwyGdWR6g5xcxu8rV80=;
        b=Dj/lnu3ZX7p7VpkQfHD4EhbkT/zNZw2oSL1+X7i8bb9NqzWJY0w/czMeU1BacLiVoj
         ZAJhc2WMRPuSUOhcYKsKbqib75c79kEwD+vw4hNR+wcow+7GFtlYp+ik/jJPU4xKm5Ib
         z6zeHnLHM0URsW+J7gs8Cj+nePj4MlP77vzXVLwG0vsgmdYFar02I010mxL+U3JCQXdz
         Vz4die9g0DpVk8p1mkijq8zBnIGVWBSDHd/BjOI4ciOj1aFkxN32h+g04H/z8zy8j4zj
         JU3NSTVYCyFJeNDCv1IEq5CzgAMJseymRq+TGpTi2QF/g6JXY2nCqjfiY3hWai55ixWK
         Tbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g8e7X/wg8+ApZ+vWe4sHZB1SNwyGdWR6g5xcxu8rV80=;
        b=doQH55OC6AipXdlWnz6tbRwgwdfneBbYwWptoFS7AtJN2tQ7GM7C6TdtSZdGbrOpIs
         TqmAi5fBooyGJIylUKUg6I9VQRroso3MeL4dOHg5l1vCPYLx1Dg3ShIsnHDThaiRy2fa
         uUkeEa1G/bhcBOghgNjEQ7bykRXOuqg7GOYw2y008rM3q193VZ1zcdcGVUxpvJqL5lBq
         g72NP8cL6uVJ2Ob6t73rd4QyifnrrF38p8th5OLsQUhqbrfRR7KyuFhPFY4QD/hZy4si
         ijTjfmKD1QJpru8RUIzgb5oVP+ZDhpIMe4I4iA3QvLtlbdSMfK6dKPzbpEwp/NiWtovE
         QxWw==
X-Gm-Message-State: APjAAAXckxnqjm9J0W3ZYLcrvXQvER3a9GfRaLMzjP+W2ZP4pOAvoNIo
        0seIW+W7dKTlEA9UkZswBmdFAuX4hYrstCn4OROY3A==
X-Google-Smtp-Source: APXvYqxXod9xjQCe4CMS8qhhzsa2np2x+ANIzguwxuQcTl8BzLgnWiBzvlPrS5tJ/YujbXwEJcBpAn4iO1cGd69JiIU=
X-Received: by 2002:a63:c442:: with SMTP id m2mr9011032pgg.286.1566396504987;
 Wed, 21 Aug 2019 07:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+wkV7zpAHURRzdY_TMRkCv=P5=yfJqLf9tAoYJA35779A@mail.gmail.com>
 <000000000000ca63880590a046e2@google.com>
In-Reply-To: <000000000000ca63880590a046e2@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 21 Aug 2019 16:08:13 +0200
Message-ID: <CAAeHK+wmpfkPEKOoYy-LgKw88DdVsEbyoRroRpcF8ygPp3oVWw@mail.gmail.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb
To:     syzbot <syzbot+a7a6b9c609b9457c62c6@syzkaller.appspotmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 3:09 PM syzbot
<syzbot+a7a6b9c609b9457c62c6@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger
> crash:
>
> Reported-and-tested-by:
> syzbot+a7a6b9c609b9457c62c6@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         7f7867ff usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=140148ca600000
>
> Note: testing is done by a robot and is best-effort only.

Looks like the same bug:

#syz dup: general protection fault in __pm_runtime_resume
