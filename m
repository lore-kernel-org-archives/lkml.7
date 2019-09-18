Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616D9C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2BA207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568839098;
	bh=YdvpIjv2GPgCWI1KJd2AyvCIao4JLdMAUKRahglJ0r4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=epPnqcGevfziM+W0dkQaxaJoJKffY67b5g6tLZyx2NlH7wQU7wqLYxqUvTM7oTLU8
	 3mquBfxle6nya7I67cXURj2zusOUmmtStvWlpPi5cUbj+mS3piHuooKWTJQJ3+Opie
	 qola7zhalHPirlBHw3iycCGlKprDzlN3eDhYHkoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfIRUiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:38:17 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41062 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfIRUiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:38:16 -0400
Received: by mail-lf1-f67.google.com with SMTP id r2so640687lfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 13:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8d3VeqPtlNlv0WuasAX2KSDyKn49IVs0wboF0oBdy0=;
        b=KtDqZ/EyRDsRZvNpzA+6SvvsSBqH5Nh4NM9sAvPOPMqLFSdIKv6VGVPEzdkLtNZAc5
         kM8tmtk6cq36Xz59IqtmG+wwA1iHU8rVJEJGHPTdyZ108JDBp/bdumT/tYHsHpcumbxW
         U3sgpWYzExaPl5iCdQG6oWit9ehKQVmEbmVWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8d3VeqPtlNlv0WuasAX2KSDyKn49IVs0wboF0oBdy0=;
        b=RvaME1T4gv7EFErtTGiZBL6qawD0LlZBQnc9btunU1svxI/JGWr1c3bAXCmkrGmq0M
         gD4dghpEojXdnvu/o9v/uRTwYPSFWVxAvUixr0ski3bSmaNxRw8Rh+d47x8iuvjurkxw
         yYQAJQZlmhsJyLBQtEd+lL0Bshd13gfOe1a97VU6ym4bPzruzRbDt38uShxiVkAxCl4V
         5UNR3tXExUrcexT/jyGFy/FJ9/41ZbXIfKxRGB5yqyhHal9nA6ab/Cki+ZXaEHoMsFJ2
         g0e5+wBtFqZZm7+BLltacPI1O5y6O4qzlL2/LmzF3ibSfQzmW15euoss0ODWJpP9oaEN
         EnFQ==
X-Gm-Message-State: APjAAAUfeA7SQvPSCd95SCeDIBkzG+oPdba8vq5fbLVfO1ofkU+R9w+r
        yCftsQ790U6RXs8/Z17ahgjy8FgRY8Q=
X-Google-Smtp-Source: APXvYqxp5q0wH9MowKOa2NOUD75INx59QoTfRvElW03F3ZdX04NOVnSvzIkm56H7PHLZbabvA+Ja5A==
X-Received: by 2002:a19:c14a:: with SMTP id r71mr3012943lff.55.1568839094275;
        Wed, 18 Sep 2019 13:38:14 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id u10sm1156793lfk.34.2019.09.18.13.38.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 13:38:13 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id l21so1300430lje.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 13:38:13 -0700 (PDT)
X-Received: by 2002:a2e:3e07:: with SMTP id l7mr3339346lja.180.1568839093075;
 Wed, 18 Sep 2019 13:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190918.003903.2143222297141990229.davem@davemloft.net>
In-Reply-To: <20190918.003903.2143222297141990229.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 13:37:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSTx4ofABCgWVe_2Kfo3CV6kSkBSRQBR-o5=DefgXnUQ@mail.gmail.com>
Message-ID: <CAHk-=whSTx4ofABCgWVe_2Kfo3CV6kSkBSRQBR-o5=DefgXnUQ@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     David Miller <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. This adds that NET_TC_SKB_EXT config thing, and makes it "default y".

Why?

It's also done in a crazy way:

+       depends on NET_CLS_ACT
+       default y if NET_CLS_ACT

yeah, that's some screwed-up thinking right there. First it depends on
another config variable, and then it defaults to "y" if that variable
is set.

That's all kinds of messed up:

 - we shouldn't "default y" for new features unless those features are
somehow critical (ie typically maybe it was a feature we already had,
but that now grew a config option to configure it _away_)

 - that's a very confused way of saying "default y" (which you
shouldn't say in the first place)

 - there's no explanation for why it should be enabled by default anyway.

I've obviously already pulled this (and only noticed when I was
testing further on my laptop), but please explain or fix.

              Linus
