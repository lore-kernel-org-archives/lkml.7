Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25124C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65F620848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ABq07RSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfEQKId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 06:08:33 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37185 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfEQKIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:08:32 -0400
Received: by mail-io1-f65.google.com with SMTP id u2so5032433ioc.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 03:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYic2P+6ud2BLpzg39R0w8EtXyHQz8gOx45AtfjtiR8=;
        b=ABq07RSiGAWIk0DyhQtRbQ4+sNALkDk3FtcRTZYJ5CyrBcva8qLEokN/3bAybveOCT
         txSMgGCGrnMiKYTpmCd/0+gXBoDXi0S+KaUM3JRrQTZsrykrM8UAjWof6IKTfH0GtVcO
         NZLmuMhxkSlU5E9o6voqi1E8J4alq/30kJ7RytfDbKPK2GnrdyU5zt2A4qne+bofGkRD
         CUus1EWBCw8KFV3rIq57+59sBQYphwsb1nw9VICZR5LJWX2hqsMTYIyTuv/iFOJkPMmv
         2oblBW/ztdufoKxfXglFxQv9J+1KHYof7YlVu0hmrjLPKHHUam16JJYe1ceDEaTawHQq
         yJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYic2P+6ud2BLpzg39R0w8EtXyHQz8gOx45AtfjtiR8=;
        b=duIiWLukJBQoYRsq05kThiNVG8C3sqAXsGEcVa9DusAPyo3yKNqPNflowc3I6tjuqJ
         sqc7MVRAf7zSZVN68XTjz7J/hXI+FvgfU6+DYZvFhel0IoFJkDJ7f31j2c4qjTo1/kwq
         zpRNLr0pDTsPsS8AXRqGWVo5TobQf3bimdx3P01CuaYjlo1D2gX3wRF2P1pf30epr0k3
         ALeV4kBgy/Gh3PX9LNT6WyZwax8XuyUYMtOr/lV3Zs310q0RkkdxFLfLM56ks6QcD3Ml
         8ZUvdJ50abcQyTp/PPdQC3mcNFjiiS43JJh4NtH5qrJLmsBtnoSiZD666j1c8fDkkYeb
         NsUQ==
X-Gm-Message-State: APjAAAVbZXa9DddO83nEXZw9wyczqID0Xut76Q0PiOfB9VWG1/Ev9I0W
        UOeFIHg14VZoibf1VL6edEx58Ka5mHrwn1LXCNQQgw==
X-Google-Smtp-Source: APXvYqwEEZ2yXkAnVJjBdQFDFEn8Qtyca+gitm77OgT4AIzInew3bWhqh6K5bO0rSsvDl6TnCPyWQ/h/MGw1wLEkF7g=
X-Received: by 2002:a5d:9dc2:: with SMTP id 2mr4521348ioo.3.1558087711591;
 Fri, 17 May 2019 03:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHRSSEy3od0-7HMCOjbHprc9ihu3VqkJi1-5OKew0oN-2BcPvA@mail.gmail.com>
 <0000000000001165cb058538aaee@google.com>
In-Reply-To: <0000000000001165cb058538aaee@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 May 2019 12:08:20 +0200
Message-ID: <CACT4Y+bvMEQRcxqM4c9zc-eySQBnuGipwudCNvBv5f+Dgyr3ow@mail.gmail.com>
Subject: Re: kernel BUG at drivers/android/binder_alloc.c:LINE! (3)
To:     syzbot <syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com>
Cc:     =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@android.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Todd Kjos <tkjos@android.com>, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 10:55 AM syzbot
<syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger
> crash:
>
> Reported-and-tested-by:
> syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         8c2ffd91 Linux 5.1-rc2
> git tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git master
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcdce25ea72bedf
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=10fed663200000
>
> Note: testing is done by a robot and is best-effort only.


Todd,

Should this patch fix the bug? Should we close the bug as fixed then?
In my local testing I see this BUG still fires, but if we will leave
old fixed bugs open, we will not get notifications about new crashes.
