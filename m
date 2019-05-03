Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B939EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849282081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kiSSW7aS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfECTZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 15:25:55 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36600 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfECTZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 15:25:55 -0400
Received: by mail-it1-f194.google.com with SMTP id v143so10766966itc.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 12:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rWmEMhzliXcvOCRw3oQALFdco9XMzYzIIL0waa/gPso=;
        b=kiSSW7aSQ9bW2r5VTe/j9kH3X7KcjLczLQh7LQZXDPHzWSJ2bRleyY4/rcvXuGGtP8
         h0Cyh08fdlQJAzSNhL1YqT2Kxlb/ota9cE18qbPPYJx7iiGOkRnakf0J0om8ImkSUOYF
         UiaS8qsHn/tiKdxPqd/OkpsImAVBnwBKQ93x4A94EW7b2vqPuzVuY/orAVL0Nwxi4qjS
         /OfVwDpBI0F6eq4eBLrJpZlttYqKhnPrAQs7DmJvWzdbTj/Uih6JMX6P50NbB8i3TRtn
         QhggAYwBHI07vJ3JPo7Vf7CDi5UEsDs2p03KvzViTNWxL1wWURERsP9JeoF6XvCAJTQH
         7s8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rWmEMhzliXcvOCRw3oQALFdco9XMzYzIIL0waa/gPso=;
        b=LtIjdu+bKq0Nv0i7nQNpgbqntdJymaXEEGGl55yea1XMBWlJR4vIuEaYn4XQcb6efU
         obYbN/D3qkkM+6n/A1nTKJeYzgkEwXwhkC1Oun2N3hK+5hSWvDbEsdD5H7a/x5ywOYC6
         edHnNEKywSKZngemO6LkWyGxUBS2mZCg04I7y0rYd7lEaqVz+gDIjlj8ZgN2Mm0Z8Jav
         5bE84lDGH5DMKrffRTe4HNvRqzQZvV0UYgYqjD54P2wsmrAPVxIgivStBmSPJEBFjJZS
         wjk6BCIzsq8I977Zq5fZ6dDRwvx7NJtoPAFoRSC143oJt/QEg2FHy4a7FUmoP1WTD2sl
         gxNA==
X-Gm-Message-State: APjAAAWi7uMDmwoNrSk4TlzBfHmupnk9/1SVgsjrtmdan1RMeW3ryqLs
        +jd+X0e+37ZBPtvbaCu1fjvolw==
X-Google-Smtp-Source: APXvYqxxG9koOb2FwS7bDsvoQXD5LW7BhJWcinIR8CpAmlMsv235RnRXDMhri4HVBO1mTbSuwEB++w==
X-Received: by 2002:a24:6fc4:: with SMTP id x187mr8626527itb.122.1556911554423;
        Fri, 03 May 2019 12:25:54 -0700 (PDT)
Received: from localhost (74-95-18-198-Albuquerque.hfc.comcastbusiness.net. [74.95.18.198])
        by smtp.gmail.com with ESMTPSA id o143sm1538223ito.18.2019.05.03.12.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 12:25:53 -0700 (PDT)
Date:   Fri, 3 May 2019 12:25:52 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     James Morse <james.morse@arm.com>
cc:     Yash Shah <yash.shah@sifive.com>, linux-edac@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@sifive.com, bp@alien8.de,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, mchehab@kernel.org, sachin.ghadi@sifive.com,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Subject: Re: [PATCH] edac: sifive: Add EDAC platform driver for SiFive SoCs
In-Reply-To: <4072c812-d3bf-9ad5-2b30-6b2a5060bb55@arm.com>
Message-ID: <alpine.DEB.2.21.9999.1905031206450.4777@viisi.sifive.com>
References: <1556795761-21630-1-git-send-email-yash.shah@sifive.com> <1556795761-21630-2-git-send-email-yash.shah@sifive.com> <4072c812-d3bf-9ad5-2b30-6b2a5060bb55@arm.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Thu, 2 May 2019, James Morse wrote:

> Having an separately posted dependency like this is tricky, as this code can't be
> used/tested until the other bits are merged.

...

> Looks good to me. I think this patch should go with its two dependencies, I'm not sure why
> it got split off...

The split was due to my suggestion to Yash, I think.  The motivation was 
to decouple the L2 cache controller driver's journey upstream from the 
EDAC driver's upstream path.  The patches will go up via separate trees, 
so the idea was to avoid blocking the L2 cache controller driver on the 
EDAC driver review path.

Thanks for your review,


- Paul
