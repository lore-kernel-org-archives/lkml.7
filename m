Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB9FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACEA20848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cd8ozTLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbfCZB3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:29:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43653 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730570AbfCZB3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:29:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id f18so9590622lja.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 18:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9rZR7CLmDE7W1CsA2uUjGFYAIsf+SIg0KHMb3XzKijg=;
        b=Cd8ozTLjKxoYOfBuJughFD/REkkG2NsrrmQACRxNkw6Jpp7SdpVw754qx8h2CF6ezA
         1aauQE3kBpXrUfxKDmf0JCdrPy3lwvtorzZIYMPLOy7l2NKAu8UZJaL5aZujea2xL4LE
         z+0nd7LuuDnoc+tq3cPzH7fQt4pedy99JDmWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9rZR7CLmDE7W1CsA2uUjGFYAIsf+SIg0KHMb3XzKijg=;
        b=P0oVjLLLfOhpUElvQUAHKz8mANJkWRGhe+g54kn/E9i+X+KQ4wwD+/Do2AZqdEIt8u
         J1J5cSyvNBf39mzjSF9haAb+bzd8tTFC1IDkmCTYfmwVCBZRGIrganyc2JjonPuANN+l
         hpTHEAAiH66k0s0oYhrq6VdVmZBijHJ/LnKpAYCVF/lQ45Y9jQZPnqQPMCQ7EGSL923G
         YPqDDNWlkJpc8WGGf97mwMYryqIkhU7pNafOgEuFioLlmnN/eXJsQi+HkBiBrBok0Sae
         U8PMhGJscjpDddqPGZqnDFqO4cZBlk1moFDVUWKcjnh65hdpFMCsP7Wpt67V0eG4/7jQ
         d5wg==
X-Gm-Message-State: APjAAAUkWEeIKvRP4zBAg0SexIstEHV7ObGhOWc4y+IQ8vjEbmxr9PeB
        CEBRaxX6b8eeB8g0fDEkUEIdddJtpSQ=
X-Google-Smtp-Source: APXvYqxa5rreCawVk9+ErDwDz6Sbmeq1Msig60vowMa0harO1cG6FLhHMyLmSvMusHq/ztBZlHipsg==
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr10036864ljb.3.1553563774005;
        Mon, 25 Mar 2019 18:29:34 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id q5sm3689405lfm.16.2019.03.25.18.29.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 18:29:33 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id k23so278705lji.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 18:29:32 -0700 (PDT)
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr5557183lja.68.1553563772042;
 Mon, 25 Mar 2019 18:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190306214730.6545-1-valleau@chromium.org> <44e151af-b6c4-d0af-3ef1-a5632d079915@kernel.org>
 <CA+ASDXMcnEfZzTjDGsDbZxX2Xknv6dt3H-3kN79WdKFzif2zsA@mail.gmail.com>
 <caee30e2-ddc4-0076-907e-558dbcfe7c52@kernel.org> <CA+ASDXOzTkXk_JtBDa4zkMhy3NyWv7Wn1i6YYtwRdeF8j_c2nA@mail.gmail.com>
 <23918a77-2694-fdae-4300-0882c7c940cf@kernel.org> <CA+ASDXOEkG36W-6rONqDntzChtq65=cQh6JVyjWhftBykXVTbw@mail.gmail.com>
 <759fcefa-974b-7430-e7cf-64eabd219d61@kernel.org>
In-Reply-To: <759fcefa-974b-7430-e7cf-64eabd219d61@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 25 Mar 2019 18:29:20 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMt97g-r3PniB4Z9+DeETdybtZ2sUneRgmetRKVZC-FBw@mail.gmail.com>
Message-ID: <CA+ASDXMt97g-r3PniB4Z9+DeETdybtZ2sUneRgmetRKVZC-FBw@mail.gmail.com>
Subject: Re: [PATCH] tools: usb: usbip: adding support for older kernel versions
To:     shuah <shuah@kernel.org>
Cc:     David Valleau <valleau@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

On Mon, Mar 25, 2019 at 5:04 PM shuah <shuah@kernel.org> wrote:
> Agreed. Let's move forward with the assumption that this won't happen
> in the future.

Great! Are you going to propose a Documentation/ABI/ patch to help
with that? e.g., Documentation/ABI/testing/sysfs-platform-vhci-hcd?
I'm frankly not that familiar with usbip (I'm just trying to help
David out) and might not be the best person for describing the details
exposed here.

And are you planning to try something else to maintain compatibility
pre-[1]? I'm not saying you have to, but you mentioned it and I'd like
to know if we're doing any duplicate work.

Regards,
Brian

[1] 1c9de5bf4286 usbip: vhci-hcd: Add USB3 SuperSpeed support
