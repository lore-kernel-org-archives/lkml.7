Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACFFC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F8021841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foreca.com header.i=@foreca.com header.b="TzxGeJfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDKGve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:51:34 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43679 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKGvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:51:33 -0400
Received: by mail-yw1-f65.google.com with SMTP id j66so1683359ywc.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 23:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foreca.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fRixQD7vDHfgsw6GEBOtcvehPnub3T+YWeDpJdsQ0Qs=;
        b=TzxGeJfc2fmWtlblUnBom0NPpcwIvnDDQp26S+l122MhgN3QPGQs1Fo+wZQMCkdeUa
         flbQexZgB52FtwlB8oT3o5fx4uP/ZAt4BFcqVrtdjRgNBLMaaykIROR+GwwIF48Kzzet
         knkooeTrf5RszsO2r7Pu+CgG9Tfw8PRcoixMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRixQD7vDHfgsw6GEBOtcvehPnub3T+YWeDpJdsQ0Qs=;
        b=VCPbzklkR7MGwS+pmEGjFwUahmwA4uMDOGFqshUM+nqNyzIrkaO/PxifLu4hVQmTZE
         pqRTnjruu356mF5er29N/th9CVq2Y8KzxAphFJbl4AQO7B2wai+yPC17AtfVHF5ZIw9/
         wKTXEG+xKsx0GfyACj/AXkvLmY0iAU3UtbDQ6rJsu5r4SR3YmCk93Cdyhp37+MMVhmOP
         RgqvjFzjnp7/B+T0NK2VytaZpc8GL7P1QbQqP+sjyF9eAmYy0dk5GcgiTA2iKN1KbtH2
         oJQImom2aeXL5Om5tk1mfuH8yGtLvEGc66mQUni4uW2cs/93tZvBuvJb8dd7VXjmxNfl
         zE3g==
X-Gm-Message-State: APjAAAWYyML2EDx8ABeqnNTZSZ9BLN6rj5iMT2P2mlNskKSXOJj1yMxu
        haspiPm16hIsI97wbgLWoP6hlKvFc2O/4Y2kBwvhRw==
X-Google-Smtp-Source: APXvYqxpV1VQi8GoNc+6S1NY5zM7XUIaP+7ZJRWh94bmHNMQRCELbZ8w9K+Npca2cFyYP96Y99GfSVamuzjae7vK3OQ=
X-Received: by 2002:a81:5488:: with SMTP id i130mr38165993ywb.417.1554965492967;
 Wed, 10 Apr 2019 23:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190410101947.8603-1-juha-matti.tilli@foreca.com>
 <CANn89iK9DcDi68WQn0z2R65L1fQpa88nUnpe_di1OWGhhoqAQw@mail.gmail.com> <20190410.121125.839541085072412175.davem@davemloft.net>
In-Reply-To: <20190410.121125.839541085072412175.davem@davemloft.net>
From:   Juha-Matti Tilli <juha-matti.tilli@foreca.com>
Date:   Thu, 11 Apr 2019 09:51:21 +0300
Message-ID: <CAA1_w3_zGTXQd2dyr1EH51_avHXr5KresgM44B9bASF2CgTAcQ@mail.gmail.com>
Subject: Re: [PATCH] net: add big honking pfmemalloc OOM warning
To:     David Miller <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Juha-Matti Tilli <juha-matti.tilli@foreca.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Murphy Zhou <xzhou@redhat.com>,
        Yongcheng Yang <yoyang@redhat.com>,
        Jianhong Yin <jiyin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 10:11 PM David Miller <davem@davemloft.net> wrote:
> > SNMP counters are per netns, and more useful in the modern computing
> > era,  where a host is shared by many different containers.
>
> +1  There is no way I am applying this patch.
>
> The kernel should not "big honking" anything in the logs.

Just to check, is the opposition to the patch related to the
expectation that it will log the condition too often despite the rate
limit, if many packets are dropped? Because if it is, that might be
possible to fix.

I think it might be possible to check the SNMP counter value, and if
zero, log the first instance of pfmemalloc drop, and then omit logging
afterwards. There could be race conditions, so in the absolute worst
case, you could have let's say 2 or 3 of these log lines instead of 1,
but I don't see that as an issue, because 99% of the time there would
be just one, and 2 or 3 lines won't fill the logs.

In our case, the existence of such a log message and the helpful
suggestion to bump up vm.min_free_kbytes would have saved us
approximately one month of debugging (or 2-3 weeks if the SNMP counter
was there in this kernel version). Even one such log message would be
enough. Our production systems were hanging daily during this
debugging happening.

In my opinion, the ideal count of pfmemalloc drops is exactly 0, and
the interesting event is the first instance of pfmemalloc drop
occurring.

If there's a bug in the kernel, I think the user should be notified,
so I see this as similar to some WARN_ON line -- which is even more
"big honking" log event because it's associated with a backtrace.

BR, Juha-Matti
