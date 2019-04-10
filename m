Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CCEC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B6F20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554925503;
	bh=0cLhpq+yQ10qB9ukleJOXpSFwirvMql+mTikt2IIvCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WBQ+ZIxU1KgSTSRT7vjaf/IcnLHLcYHB+mEtv+rLvItPs75a7affrwPLWoFfNHCch
	 dVw5Ew1q/AryPxY7E6eLWuEqOlSOV0pYiVKUj3OAsE/TuLbjls3yj763qmutf0tPci
	 m1TXjZVKDvHKANMeeKDB8xHhnY1EVLXvoUQXCfXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfDJTpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:45:02 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44207 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfDJTpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:45:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id h16so3223172ljg.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsBa5M7cr66bNr57pCqY9xnSx/YPJHTWLIyNqQt1HX0=;
        b=Obu0iH5zZYljx26kyd08C8+DLbYm44jLQE7W5yMnS8jj8F8d118hGNeonhA2WrNRyk
         6FYPs+HiiL2UnpuK6OuEY8sb7YHQn6hrzVOg/OinGsYpE9qBNhzVqAeFbZOEbGs45kec
         kR3KgV93LJvr94gdAxbsQcYz29BIGyUmb8Mdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsBa5M7cr66bNr57pCqY9xnSx/YPJHTWLIyNqQt1HX0=;
        b=ks8qQ9BJlFIa4L47nUXXmTbkOHrBQ9gXzeOaqXwiU/BlHflk/RlrCvPAHl4YsgNYhM
         yo8Z40k222z1IBqy3Qh3cACBqKDRfxikWN/+w8PU93YNRflTkDZi4kN9EObn2o8Cf2VY
         E3vPYEJXXK9F3Jxq7AVq/w2DHhD1sEohbrllV81d5OvQV6YkWWLz+FJZyrYr5FNWa1Dq
         5FPc/x+RIJUG644JNe6FOWZA224TpU+AVn+eSqWrdNhdbMMy62hRkn40R3xLhLpgsE/R
         k/PCYtscyyIuh2/xdFpipOJ9xpAzmLJEJkSN5pXP9Vww90qqEB7F7HWycwr2wLuoUczj
         7buA==
X-Gm-Message-State: APjAAAU0gWy0btlO80CpTw/ipsMmRKOg1CDAclsVj3RTtp/lFWSCYml+
        lDwYwUGrsdTIeBsJ5hZ6KP5oUjOHD20=
X-Google-Smtp-Source: APXvYqwp0J2emjpyoioqIahM9DZPfK7jWmAxJTYqMKEYfGrgsuHdAwdKglqDaQNwL9wc0bDg1PrIvQ==
X-Received: by 2002:a2e:90c9:: with SMTP id o9mr25467288ljg.102.1554925499057;
        Wed, 10 Apr 2019 12:44:59 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id e18sm7400121ljb.12.2019.04.10.12.44.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 12:44:57 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id k8so3239528lja.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:44:57 -0700 (PDT)
X-Received: by 2002:a2e:9597:: with SMTP id w23mr18295781ljh.111.1554925497426;
 Wed, 10 Apr 2019 12:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006946d2057bbd0eef@google.com> <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk> <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
 <CAHk-=whJ4M5FegOLvnjUtJ0+pHv4L8UNFt+9jJDhox3Ada8kwA@mail.gmail.com>
 <20190325211405.GP2217@ZenIV.linux.org.uk> <CAHk-=wj+-e=X9cvvNwc5+QuvBOyYT7OtZTBzy-Wg8zGrUwxSbw@mail.gmail.com>
 <20190325233731.GS2217@ZenIV.linux.org.uk> <20190326014552.GY2217@ZenIV.linux.org.uk>
 <20190410181135.GA32071@ZenIV.linux.org.uk>
In-Reply-To: <20190410181135.GA32071@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Apr 2019 09:44:41 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg1hfdCE97hCCgRqW4=vbcAj8SaGhGffajg7B-aVenzNw@mail.gmail.com>
Message-ID: <CAHk-=wg1hfdCE97hCCgRqW4=vbcAj8SaGhGffajg7B-aVenzNw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in path_lookupat
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 8:11 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Both are in vfs.git#fixes.  Which way should that go - directly or
> via linux-security.git?

Just do it directly. I doubt you can trigger them for securityfs and
apparmourfs, since normal users have no way to remove any files from
them, so the race with final unlink sounds fairly irrelevant in
practice, no?

               Linus
