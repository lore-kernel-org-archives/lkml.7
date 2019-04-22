Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FE4C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 23:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8CD2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 23:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="f3Jmvpkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbfDVXR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 19:17:58 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39935 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730100AbfDVXR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 19:17:57 -0400
Received: by mail-yw1-f65.google.com with SMTP id x204so1559705ywg.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 16:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rdHDnxD931SO1J9dXmaP0qBEHNWfbRG48clfVSkpIj0=;
        b=f3JmvpkvhsDkM+zsfb6yzoY9wv6PMuLHLOTNtRKwjhagCd7sYU17NCTRNQI1GBBz7n
         zo+2RXrHUzp/vxeIYPInx/5F/9Wq4rHBMxVwXgJdfc/xMykZbPkiJrr4RDLTM96qrKTz
         DgrpJwt2cAkLUPyghpim4eYL7L7YCChr7rcjBmPuA7EqubvCQTImOpkKmd4WVZQH7iFB
         v6auXjAnabic94oH5CVlZM6nLNw/4mQGw9n8yr7ysjCe9Y/Zzi8yIPTm0+SrabqrvR95
         /wOc+TxAAkijG52M20SNNKiy75trdvloUn2VCFiQWTeRFA/+EUEZ3jc4KDeNSh7AUgZj
         xq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdHDnxD931SO1J9dXmaP0qBEHNWfbRG48clfVSkpIj0=;
        b=uMSZ/pnVHc+I0K9r/MNQcZeWbLUrNOGrTDPI8DWETIsMX1zlJuZnuiZOF9S+to1K5x
         YZEFmqAR3Sm3XKj64xlmypvJAZX7RGZsNnW62DAtYZZ1laCOu1mQ4FI3iaCCZvCR0MXx
         KzCQZCjMjkTxoOSg/H3CctJKaggLHO0vHQrNTAs1DAV39gpiKwGlqrbFmeCRmzBruNyd
         RcVIqg6UsbcuMeTP4Zbaa5a3cKSImc2Fjdx2TR/9dctjhD8gAY1FbyjXzTtHDefXpmGa
         5tFQ816PbIaru0FdoFViqSbP+gnOphc1appkqZ8iZiLeY8wal2K+DOViFF7CwPHpLFaI
         mWSA==
X-Gm-Message-State: APjAAAWpnjaaonVtZ3l9ny+WCQgrdLP9CGxDwPxYP6woKdKamVPnYkIj
        P0kbhCNfBTDKzuSeTe9Fn7iely3ANmONkRmRtWknlA==
X-Google-Smtp-Source: APXvYqy/R+YYWmdblb1apznaUluA5dOpPTOo3+NdasV2IFha4Wzu5j8X7qV0T5QrKR8YhwwhkCNdZT7HCHBjk23VkyM=
X-Received: by 2002:a81:520d:: with SMTP id g13mr14735537ywb.63.1555975076351;
 Mon, 22 Apr 2019 16:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190416174900.GT2217@ZenIV.linux.org.uk> <20190416175340.21068-1-viro@ZenIV.linux.org.uk>
 <20190416175340.21068-60-viro@ZenIV.linux.org.uk> <CAOg9mSQppnRWPnSg9eAm0NeW3XEm0LZ74Aw651QTBx0Gm1jpQA@mail.gmail.com>
 <CAHk-=whjK_n2wZX3kZNgkK=wBrw+K5PvMowJ4rYDiDSrmV_aYw@mail.gmail.com> <20190422231036.GK2217@ZenIV.linux.org.uk>
In-Reply-To: <20190422231036.GK2217@ZenIV.linux.org.uk>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Mon, 22 Apr 2019 19:17:45 -0400
Message-ID: <CAOg9mSSOcA+ea6LBsRGQqV+1N6EPq6s7j2w+SAhY4knP7zDD5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 60/62] orangefs: make use of ->free_inode()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Brandenburg <martin@omnibond.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus and Al...

I just wanted Al to know I tested his patch and acked it and that it
there would be
a conflict if our pagecache code got pulled... I wasn't suggesting that I
should get that one part of Al's patch pulled...

>> I can easily handle any trivial conflicts this causes...

Thanks :-)

-Mike

On Mon, Apr 22, 2019 at 7:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Apr 22, 2019 at 02:56:57PM -0700, Linus Torvalds wrote:
> > On Mon, Apr 22, 2019 at 2:14 PM Mike Marshall <hubcap@omnibond.com> wrote:
> > >
> > > I applied your "new inode method: ->free_inode()" and
> > > "orangefs: make use of ->free_inode()" to our pagecache
> > > branch (I hope to get it pulled in the next merge window).
> >
> > Actually, please don't.
> >
> > Exactly because this needs that common vfs patch, I'd really prefer to
> > get it all through Al's tree, rather than have individual filesystems
> > apply their own copies of the common infrastructure commit, and then
> > apply their changes on top of that.
> >
> > I can easily handle any trivial conflicts this causes, so that's not a
> > reason to have each filesystem do it either.
> >
> > So if this is at the top of your tree, can you just "git reset" it
> > away and I'll get all the filesystems (and the common infrastructure
> > commit) all together from Al.
>
> What's more, seeing the changes in orangefs tree I would rather have
> static void orangefs_free_inode(struct inode *inode)
> {
>         struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
>         kmem_cache_free(orangefs_inode_cache, orangefs_inode);
> }
>
> in that series; not only less noise on merge, but with additional
> uses of orangefs_inode in the body from orangefs tree changes
> keeping the local variable clearly makes sense...
