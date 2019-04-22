Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91641C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9542064A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555970240;
	bh=dY1Su9dQmYiUkU6AHwXA6nOYPbk1wnTltNut4Yp7R+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ND9bdFafoMQSvMTGCsQQnwGBRR2GCP/xwra+0YADgs7NpDMJUrRXvDR6yiELLxrfV
	 AwB+MiYhq0uWCk0PxV6NgdotEOFZBGzRr5TQHu8e64MyRgRMlSLydR3hNTFrTCBdX8
	 7j5e3mz0VFEfFvo+Q8TE6gPfVbHn7KwGSlWDk4JE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbfDVV5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:57:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41967 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbfDVV5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 17:57:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id k8so11569830lja.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 14:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4YlKYa3TQ1kuoOrxS+gPcL63NFPtXMSxMgiFITTKoOg=;
        b=ETNwPb1rfyoao4c9RzXoOH/cx7pgjLwiwAP5qP1C5hzfEX18s5fW1edRr41PQbWByx
         KzhtCB8ORq7GgFu1cr+C0FbEhbN4dR763atOiLl/2RTj0FWO5cDrXbm4NP4dq/ZRVKak
         eArbmgAeiN+Y/Cz+HP5NM8L6L1O3Excecq3cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4YlKYa3TQ1kuoOrxS+gPcL63NFPtXMSxMgiFITTKoOg=;
        b=ltlpHYgl8EKXKD5RSx3flqo8DQznopZaHU2esIdUXST4tOmGresVEtYdInA6L/XFHh
         JZ3K4adkae+4oRUSESLOFabNnQcY78bli284lUp4mzSzpGKOAtAuH4PUZQ6lrrTmWTif
         O5wprf8z6r+nccISMG4nKGL/K3c+voEpTMQarbIw1dND0sNAY1OkVBEZXFU3BDdf8ipm
         Pqv3oRWNycBoa+fPPhg6C2FDMbxNTywG2tPLe7kSwG5VKHOMmPFR1g4H8gAS4+fprG1C
         fPJihURmC7pHIvmxn2Jd4FS0Y3SIqVscDw+D7GuGpHHB/l/R4rRUKnTn6s91jTiE2rl0
         Rs/w==
X-Gm-Message-State: APjAAAWso+Dl1QFaICNXIpqRQTvInJnlZxDSu5K1WNxAwTu5WA1CxVKQ
        M1/8IuFxwP0rhbM6ektnKLPD6JUmE1M=
X-Google-Smtp-Source: APXvYqz8wjCZYYXWe0fNhMVIzhs86obUJvq4yeOinz95jsYDqvYWH1BL7vxBQID8rpRnKAdEWA9PyA==
X-Received: by 2002:a2e:8618:: with SMTP id a24mr11371058lji.192.1555970234936;
        Mon, 22 Apr 2019 14:57:14 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id n4sm3216761lfe.15.2019.04.22.14.57.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 14:57:13 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id j20so10074791lfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 14:57:13 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr11388505lfg.88.1555970233102;
 Mon, 22 Apr 2019 14:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190416174900.GT2217@ZenIV.linux.org.uk> <20190416175340.21068-1-viro@ZenIV.linux.org.uk>
 <20190416175340.21068-60-viro@ZenIV.linux.org.uk> <CAOg9mSQppnRWPnSg9eAm0NeW3XEm0LZ74Aw651QTBx0Gm1jpQA@mail.gmail.com>
In-Reply-To: <CAOg9mSQppnRWPnSg9eAm0NeW3XEm0LZ74Aw651QTBx0Gm1jpQA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Apr 2019 14:56:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjK_n2wZX3kZNgkK=wBrw+K5PvMowJ4rYDiDSrmV_aYw@mail.gmail.com>
Message-ID: <CAHk-=whjK_n2wZX3kZNgkK=wBrw+K5PvMowJ4rYDiDSrmV_aYw@mail.gmail.com>
Subject: Re: [RFC PATCH 60/62] orangefs: make use of ->free_inode()
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Martin Brandenburg <martin@omnibond.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 2:14 PM Mike Marshall <hubcap@omnibond.com> wrote:
>
> I applied your "new inode method: ->free_inode()" and
> "orangefs: make use of ->free_inode()" to our pagecache
> branch (I hope to get it pulled in the next merge window).

Actually, please don't.

Exactly because this needs that common vfs patch, I'd really prefer to
get it all through Al's tree, rather than have individual filesystems
apply their own copies of the common infrastructure commit, and then
apply their changes on top of that.

I can easily handle any trivial conflicts this causes, so that's not a
reason to have each filesystem do it either.

So if this is at the top of your tree, can you just "git reset" it
away and I'll get all the filesystems (and the common infrastructure
commit) all together from Al.

                 Linus
