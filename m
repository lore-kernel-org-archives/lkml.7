Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBB6C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F3C20862
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfEMW5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 18:57:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34771 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfEMW5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:57:36 -0400
Received: by mail-ot1-f68.google.com with SMTP id l17so13447332otq.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 15:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZl+JJzZx2AFDb2lZBN8xQ+7GyeFp75okyysAoofKkw=;
        b=n7Dybzy+kcj6HmdJBt2ma1mlozw3aOBXyKuIF4ZXdiczOUN9TyPneVFqE/0XPPTbIf
         JnHzs5ePX1y6reIezETRnejpNfHZf5amsT8r1bGDXC1Q0p3Cn5eu2hzOh1JL45COb5o0
         MKCwjP2ZjbNSMwfrDamXyLOXtedQXkH7l6ItzMuAnccZMjxb8z7kZ1pLdubqqW1sMA8J
         qmeCM0903OSkGAfSl6k8sK/rvLNhBDFAtMNqvKqA61WfJquJqsVWOzS6KDj0jL1TRlog
         cjN+iwC6qytBW3YkbfiiydfWdkRfJEOy8m98J6NS8gjaXY74wtDmnLflRC+FiAXqKzYs
         ozGw==
X-Gm-Message-State: APjAAAUfHPxicAQ30Eayz3jRiMGlcYH98L+5l0Z6hkdMxyxeasxRpHpi
        NvoX9VGwYY8ZmcZkyJ9SzjxZE7B83f/o4JKH72ee/A==
X-Google-Smtp-Source: APXvYqwXa/xUzbV2HecqFfqi9d2w5SpH6nk8apUHTk6bzR3d8Bzcbpr+9t1YrxaqHvhBUkP9YGkr0xw1NKR+yP3ShkU=
X-Received: by 2002:a9d:6a58:: with SMTP id h24mr16790402otn.190.1557788255765;
 Mon, 13 May 2019 15:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190513195904.15726-1-agruenba@redhat.com> <CAHk-=wg=yz_=6oM1r5C4pWJPac8cD1kHiki73wDciuLLoRNY=w@mail.gmail.com>
 <CAHc6FU43Fv_b9hMiRscs+cPbwLmcCBM-9R32fSsK9gUtMVMGUQ@mail.gmail.com> <CAHk-=wipiSQ=+dTssFhjYXUS0VgJYRNqy8s_YNTL8HbZ6iKsYg@mail.gmail.com>
In-Reply-To: <CAHk-=wipiSQ=+dTssFhjYXUS0VgJYRNqy8s_YNTL8HbZ6iKsYg@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 14 May 2019 00:57:24 +0200
Message-ID: <CAHc6FU7WsCx4B53d5=N114A7E22A=nmXX-4Sz=uSKEsf65v3-w@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix error path kobject memory leak
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019 at 00:47, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, May 13, 2019 at 3:37 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > Sorry, I should have been more explicit. Would you mind taking this
> > patch, please? If it's more convenient or more appropriate, I'll send
> > a pull request instead.
>
> Done.
>
> However, I'd like to point out that when I see patches from people who
> I normally get a pull request from, I usually ignore them.
>
> Particularly when they are in some thread with discussion, I'll often
> just assume that  the patch is part of the thread, not really meant
> for me in particular.
>
> In this case I happened to notice that suddenly my participation
> status changed, which is why I asked, but in general I might have just
> archived the thread with the assumption that I'll be getting the patch
> later as a git pull.
>
> Just so you'll be aware of this in the future, in case I don't react...

Thanks.

Copying Jon because this looks like useful information for other
maintainers as well.

Andreas
