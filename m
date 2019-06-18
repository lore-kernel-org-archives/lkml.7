Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC86C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644A320873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nO1pjUe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbfFRVpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 17:45:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39456 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfFRVps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 17:45:48 -0400
Received: by mail-io1-f68.google.com with SMTP id r185so27408829iod.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 14:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QtGsm9WX8qP+HbJjvyzMb2QakiyoOOg84hiYW3my0nw=;
        b=nO1pjUe/xoju9XQ5kDeOKFOV8VLFjaJAWlRPbUWc3MKYyfcxq3PmbZPASElNtf1Zct
         ag57MRSiicEJRy+CYsGzgLipcWGigIExuFQ5cPPumcq02+IOnBS5pzQi8LVvlMfeTkV6
         E64pRIJHmX3RVduPFvrEimQEbIsobVuUXoX28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QtGsm9WX8qP+HbJjvyzMb2QakiyoOOg84hiYW3my0nw=;
        b=ogOu44vXg85o8VKxSn8TpdmLsYrf3Zmb5DcsrQy0A3nqe/iXJFk5EuN5Jjzq54CtgY
         ElOncyv+DSBESyga5oLgRqunG7do5v788f582xiYdxe1wY5frxeo2rCr4PV9Li4e7xND
         QNYtBSovZRPLLFJwLLQd7GVHMk+eBUUvIYzqzFNzOWPcHB2H32VkFK0Sz21R2ZdHa9mr
         Kvk4Mwj82DNd6kZ7VIgP52sYAviLWoPeM6XXxDDdzbkYXa6VAUbWvHflemxAuNbwT6Zw
         WspXNltRnvSxr5gj3vIt2055lkHAwg/ZTBd43hIQRNCzietiIjzrq7tcogffsrRFs88C
         WABQ==
X-Gm-Message-State: APjAAAWqdhSda9ZqqgpLHPNjOOGm6h+rkz5ihR/nADvyPRAiZcS7BttY
        Id7qwTMdINHAHRknnUYfxXifltGkGIs=
X-Google-Smtp-Source: APXvYqxCLyNYsTuC2Na3zbKxpl5e+lQ4kTIZ7jGvkwOCGJ6203d/E+tA0ozxaJBx9ub4p106RrY0cw==
X-Received: by 2002:a6b:641a:: with SMTP id t26mr2440431iog.3.1560894347653;
        Tue, 18 Jun 2019 14:45:47 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id a2sm12818826iod.57.2019.06.18.14.45.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 14:45:46 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id s7so33277309iob.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 14:45:46 -0700 (PDT)
X-Received: by 2002:a5e:8f08:: with SMTP id c8mr6439411iok.52.1560894346193;
 Tue, 18 Jun 2019 14:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190618211440.54179-1-mka@chromium.org>
In-Reply-To: <20190618211440.54179-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 18 Jun 2019 14:45:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V6TqT93Lb2UoQdkyO2j7OHrggCn-4qwDLEFw=N7RZ2Eg@mail.gmail.com>
Message-ID: <CAD=FV=V6TqT93Lb2UoQdkyO2j7OHrggCn-4qwDLEFw=N7RZ2Eg@mail.gmail.com>
Subject: Re: [PATCH] net/ipv4: fib_trie: Avoid cryptic ternary expressions
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexander Duyck <alexander.h.duyck@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 18, 2019 at 2:14 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> empty_child_inc/dec() use the ternary operator for conditional
> operations. The conditions involve the post/pre in/decrement
> operator and the operation is only performed when the condition
> is *not* true. This is hard to parse for humans, use a regular
> 'if' construct instead and perform the in/decrement separately.
>
> This also fixes two warnings that are emitted about the value
> of the ternary expression being unused, when building the kernel
> with clang + "kbuild: Remove unnecessary -Wno-unused-value"
> (https://lore.kernel.org/patchwork/patch/1089869/):
>
> CC      net/ipv4/fib_trie.o
> net/ipv4/fib_trie.c:351:2: error: expression result unused [-Werror,-Wunused-value]
>         ++tn_info(n)->empty_children ? : ++tn_info(n)->full_children;
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> I have no good understanding of the fib_trie code, but the
> disentangled code looks wrong, and it should be equivalent to the
> cryptic version, unless I messed it up. In empty_child_inc()
> 'full_children' is only incremented when 'empty_children' is -1. I
> suspect a bug in the cryptic code, but am surprised why it hasn't
> blown up yet. Or is it intended behavior that is just
> super-counterintuitive?
>
> For now I'm leaving it at disentangling the cryptic expressions,
> if there is a bug we can discuss what action to take.
> ---
>  net/ipv4/fib_trie.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

I have no knowledge of this code either but Matthias's patch looks
sane to me and I agree with the disentangling before making functional
changes.

My own personal belief is that this is pointing out a bug somewhere.
Since "empty_children" ends up being an unsigned type it doesn't feel
like it was by-design that -1 is ever a value that should be in there.

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
