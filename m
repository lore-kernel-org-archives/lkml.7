Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EEAC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8ACB2077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556328463;
	bh=M4LQjJEnK+pfuuQyzRrRE3fimTdaI2Ywyh4Hrp/kXjk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=r88Qpxv7Ew54hWw9sIFApJBD/Wc/V1OFIpuDvAysr74oSLzk+kZvQnfcQzumh82K1
	 U0+vKUFFWu54oeTgcOQZXKV9+Edn02+d1QJ4tm9i5dIbuMD9ffmEu5kKxf8Rb/SuQy
	 foavyciZYbH/0FIynpf+vxo/v8OI3EimP+NagOJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfD0B1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:27:41 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:37957 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfD0B1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:27:41 -0400
Received: by mail-lf1-f49.google.com with SMTP id v1so3788624lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 18:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2EoQBKCmosLZTV3cUhOnvDE6nYwdNN71gNqlgZ5iWds=;
        b=G4F4Z9SaE8ui1QUps26GTDI6QwjdnYl94Do4hp09Yh4lJwVx7yr7BJFfMv8qfAmzKH
         stIhv4zIVbeQoW0OrJgPPW3MJsVNnzRPwMHmqTgWp9j4AUA5K2wNKTRy5v4gTOmECVKc
         HlWkObrs34pMRsPqba5Jp+5qR4J8qOD+JGMu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2EoQBKCmosLZTV3cUhOnvDE6nYwdNN71gNqlgZ5iWds=;
        b=pKyJ6V8zpeJD5JGfDQMaRfsIFP2QFeNN4b3gQ2Q+wYvV8bVmWgJul6/i+N9kmLdFvy
         pr4WpO5ujpV0N/Ea46y2pR7DsMhZezqLVVkl5jAuBhx//Jjl2PeIXdx1kXUE3kGOBcXT
         czj7oneBmwsFx45pfzyNRKGnZ00Bb5egvv3Magk5OZ5MD2/i+pZEuFWCs/9zGksjP1ks
         4X0kkw+p6mz8ZsWuAVe/BEhftVRs5ErXoWEfM4lvsSSEJc2v1Ywjx/JiwX2e1g1lEkcG
         X0I00LspAcWuHFJETi+FmvyGhK880Rxr61ZzCf+nLdQeTzMRArW5TnZ8YxphljnA6JG2
         yoHQ==
X-Gm-Message-State: APjAAAWxAt41Vyy/ld6+YgRDX8iBiu5KB2q88YglBiS+Pklgr+CaTjrX
        e6DMGQV7P6gOqlQh6KOJaDolwqp3dzQ=
X-Google-Smtp-Source: APXvYqwt2HHTJ+Faei5gdFOFD6RjvezmWIGSEbvgmtz00QSL6LfPOrrKyO0y60Ta+Xo3/IkJ3pkAvg==
X-Received: by 2002:a19:2814:: with SMTP id o20mr25860355lfo.117.1556328458807;
        Fri, 26 Apr 2019 18:27:38 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id d24sm1850296lfj.30.2019.04.26.18.27.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 18:27:37 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id o16so3772882lfl.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 18:27:37 -0700 (PDT)
X-Received: by 2002:a19:48c9:: with SMTP id v192mr25604700lfa.136.1556328456785;
 Fri, 26 Apr 2019 18:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000101b30587622a69@google.com> <CAHk-=wjp-R083To=AVbovNJWrskNfYN8rqz=nZZTPRihCohE4g@mail.gmail.com>
 <0c6ecfca6329f0d11c6962ec5875314414813ac6.camel@decadent.org.uk>
In-Reply-To: <0c6ecfca6329f0d11c6962ec5875314414813ac6.camel@decadent.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Apr 2019 18:27:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihu4ju2ARJ4K04nOKZa1Xjdm1_6nxxxcYJ1Jm1JDB=bw@mail.gmail.com>
Message-ID: <CAHk-=wihu4ju2ARJ4K04nOKZa1Xjdm1_6nxxxcYJ1Jm1JDB=bw@mail.gmail.com>
Subject: Re: BUG: unable to handle page fault for address = ADDR
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     syzbot <syzbot+45474c076a4927533d2e@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Netdev <netdev@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        peter@hurleysoftware.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        vegard.nossum@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 4:36 AM Ben Hutchings <ben@decadent.org.uk> wrote:
>
> This looks sensible to me.

I've just applied it directly to my tree. It looks like slip is
largely a thing of the past, there have been no slip-specific patches
for the last year (all changes in the last year have been due to
treewide changes that weren't slip-specific).

                   Linus
