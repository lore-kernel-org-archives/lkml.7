Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A31C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33222087C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552839368;
	bh=9xm26lN7j61ybOwdbTGDbCqqWbwl2O/J4LEZcwbq3dc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=axDBd1tsnT/Suxkclp9a3E09/iOqwBjPuDtdvwV4XsvQrHXn311I+AVTnsk2DIoyn
	 cyOiKHLnYEzVf8nhz/1KubrxqIzhCVQTpFAbZrHwlhDaKjmz+7ycGIAt5I9Q75tOHr
	 RXPymY0NBNWjNHiWKovY4v/RGbi7rpxO79DAKldI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfCQQQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 12:16:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37473 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfCQQQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 12:16:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id a17so11888608ljd.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 09:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hVWCM4XlHrgljHuZtZzee602hukWkcIq3WXBY5efN7Y=;
        b=TSvua1UH/VP2d2I4CCyp2DQBlRr6krZjyWbeis9jGcxoQjMjpz1shEz0cP1bf9rzvP
         Sr1aoNOiRp0NkC/dxC1T+zpeNFwB1r16F/Xo6CbYLmF13sK0DFymviNA8+8WKcm4ZKYq
         fRIDe/U8mDQMwexqDoafWkFXaetsiMGsLABjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hVWCM4XlHrgljHuZtZzee602hukWkcIq3WXBY5efN7Y=;
        b=fIEu2FJ+G0riR+XY75ZjCC/AZcrlNMP0GjbIQx8Z7mJz0Lh7NFBmEO74bD/MQQeU+S
         aKd67MMsqEVy3yc0szGDyUSVtUbtowxhDWJmLEa6djKvBHaro0IpUZboW11958zd7uOV
         +rWgGiAA7dg3hMGnGfE5m9wfxHSUjhmQVlIoNAuYj5n6/KdhA6PctoPR656M+9Mlg52/
         sCI11mJyyYZraukwO48BA00tTgpkiqLYiLGRAz+JkeqNorv0IwPG9NUMmpVI+lYv8lpz
         jSezfNK1U0HyhSJup+l4fRls8GUqHsRL2a83vEP6CldmcRmvocRlHzRGp4kLA2PQf3EQ
         zN3Q==
X-Gm-Message-State: APjAAAWGn6FbSxnpQG/BMDP50tohESyl65mNZBdb1H5bQGRR8Ofn4s/2
        H0rMkHMow7qjEWnyxgzzDGxO7gyfFrA=
X-Google-Smtp-Source: APXvYqzGhX+ZSLkuO1CEjNczoFYDdR+9JHwdpB+Uf8Q5qIihCPGoW+YqWgxTEluJjrxUaXHjoa87iA==
X-Received: by 2002:a2e:5b44:: with SMTP id p65mr8095178ljb.182.1552839363310;
        Sun, 17 Mar 2019 09:16:03 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id n11sm1524956lfk.59.2019.03.17.09.16.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 09:16:02 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id a6so7618374lfl.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 09:16:02 -0700 (PDT)
X-Received: by 2002:a19:2548:: with SMTP id l69mr5201932lfl.136.1552839361844;
 Sun, 17 Mar 2019 09:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190317142524.GA5136@nautica>
In-Reply-To: <20190317142524.GA5136@nautica>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Mar 2019 09:15:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgywWzGP-UszbL4csXpk4_h0w5PbkZYdaTpBzue82btfQ@mail.gmail.com>
Message-ID: <CAHk-=wgywWzGP-UszbL4csXpk4_h0w5PbkZYdaTpBzue82btfQ@mail.gmail.com>
Subject: Re: [GIT PULL] 9p updates for 5.1
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 7:25 AM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Two fixes (leak on invalid mount argument and possible deadlock on
> i_size update on 32bit smp) and a fall-through warning cleanup

Hmm. I wonder what makes it valid to have concurrent updates to
i_size? Yes, yes, you added that spinlock to make the update itself
atomic on 32-bit, but it sounds a bit odd in the first place to have
two things possibly changing the size of a file at the same time...

Anyway, pulled, but just surprised...

            Linus
