Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CC5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6884720989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553477151;
	bh=ldQejEjFa9xJKrOj9ljoYTibC1Rfddw7L0VQ8tWj1hE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EDWb3f7D4l2oSC11mTSPYWCNKtfz/CbVUeQkJae4MtXXg0+0zFNbT7q095sMfICV7
	 BO8gNbPojztshgAbxFdFpX1NKqYuOMOsPT4Zpq81m4y39nFttXeAK+TbmHlB2I1R4h
	 MmDDoGJOa4p1yxiuD3KcXl3UYHPMEgzhtsosUytI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfCYBZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 21:25:50 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:37218 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbfCYBZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 21:25:49 -0400
Received: by mail-lj1-f180.google.com with SMTP id v13so6320546ljk.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 18:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/uZ6qBBZKN1B+WbB1dUcc49BomhgwJyztBbifYKKE3s=;
        b=Em5+t3QWQwF71xfeNyYkcnMQCeasPx4OswleLHwsu+iHNovb1LNZg7Hrk9thZKgy0s
         LWRG1FhbgPgclPJU+ZI3OXMERh2sJjnwIr3SnHPCzRwK4kNrCa4IrA71I4tNhx0mbZRt
         xdfUWl/6vBByi2Xe7lpQgaB8hoLGf1gmrbfaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/uZ6qBBZKN1B+WbB1dUcc49BomhgwJyztBbifYKKE3s=;
        b=l25zPKDOcnenV6LbDUJqgGNKUme7u0HLvRDpN0r1Kd/RkR2knVCFJx1JHLAPNaEjt+
         l7HkyWqASSZKmGCHDUHpezJv7Wq61hiDjkIs4mg41hyk2sHe80ktW7JRg1OZT8eKwf4M
         T9eEbU/nM+gkuwZhHqr8FIl02ZWXhB3LclHiaB5rHNmceFTCE8cd999C9gUwvdVVyJ7x
         upH1vT+I215xkNsigb7cf7988ULsg7+yhB2zjVnQ55Mh0UNp84YjPc9NOSefQWBhifBD
         F5LE1LiuBEeH9t8xptwkk0blVUzQIW9CxYNb83i++4puKt9VUvBJojyz6ENXsh5Vkveg
         7NFg==
X-Gm-Message-State: APjAAAWsu3OvF0Sj2p0HfF8yZbdF5++EvmgNfjR6d1EcGM/c12RHkTn4
        rf2Ntkz2unXaBagVIVYLsJ5O10fT7Sg=
X-Google-Smtp-Source: APXvYqwWIdOExW8Ku//rdPOvyUdGW85G5ia887RL7c/olU8jc8L0bLVZcvsB/lOjL1HZhMKgNxOMLw==
X-Received: by 2002:a2e:8658:: with SMTP id i24mr11298582ljj.194.1553477147189;
        Sun, 24 Mar 2019 18:25:47 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id q5sm2388042lfn.85.2019.03.24.18.25.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 18:25:46 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id u68so4802715lff.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 18:25:46 -0700 (PDT)
X-Received: by 2002:a19:954b:: with SMTP id x72mr10791763lfd.67.1553477145866;
 Sun, 24 Mar 2019 18:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006946d2057bbd0eef@google.com> <000000000000295e0d0584e08021@google.com>
In-Reply-To: <000000000000295e0d0584e08021@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Mar 2019 18:25:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLW+b=r=z3fYGY58WV+qu2qW6Q0_K30Qat0-74-iwvJg@mail.gmail.com>
Message-ID: <CAHk-=wiLW+b=r=z3fYGY58WV+qu2qW6Q0_K30Qat0-74-iwvJg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in path_lookupat
To:     syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>
Cc:     dledford@redhat.com, Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 5:44 PM syzbot
<syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit a435393acafbf0ecff4deb3e3cb554b34f0d0664

That's wrong. It might change some timing or something to make the
race hit, but it looks entirely unrelated to the bpf path_lookupat
problem.

                 Linus
