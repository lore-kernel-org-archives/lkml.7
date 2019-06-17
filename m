Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92129C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A43C208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IxEUZuMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfFQWvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:51:37 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40069 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfFQWvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:51:36 -0400
Received: by mail-qk1-f193.google.com with SMTP id c70so7306558qkg.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 15:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R7JAr7nez95dVg1/6wJIkqeDIU+F0cp9vja/vFPRJFw=;
        b=IxEUZuMdQJp34/Puwy1PzMsfF+CNvMhDuDiizsH2lbDiry4fHprm28hX3Wlf60KF9a
         0IL4HMp0Fh9iml2DATXl+qbJ9eaK4tvMzrdvohheJ+kxkmGB5VSfsHnJ6eSC1KIhZiY0
         ivCZ1eFuKHMXPuLRc5yBNoXCPnZJqoZaMxLTGsKrrnkRSsfAgi3ngCNpNhtadAde/rJw
         3UqY+6EBG6FhPZtmgjsc8PIrJXiakc57yrnafAOzM/mWtr6r3YAqmaVduUSrGrqqAXDw
         P0qrF11SLGwankHnhduH87S6h2xyJbfn8+PeUUUSXxdp5fda36YJY9Xf3w7PtrYEaSKb
         f0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R7JAr7nez95dVg1/6wJIkqeDIU+F0cp9vja/vFPRJFw=;
        b=GRGAfLTi/H1I9fHw46pQpxIer4sSibsGABhqOXB1l+grOO6/0WdU9tQ28zKXb/drwx
         3eEapROjEuS408kKkyln2jYboRhBgJZzdKHV/v8IihQMnzcUpz0AkpqR1Cn06D170H74
         6+UzWJeY55WBkAOVvqoH9ufd1Uz0Wavbnce7DO74u9bLFJwCh7zBFpa4giZstuA4hzmG
         slRI0WDZI4JBy+mtOHpeAS5/a5u8YnCWgLhEGak0AwpiYruolINQS1Sv7G94dpJlOtRT
         bn096xziNKjvwR7rx0CnYw6/xxAZ+wMlQBg1bheENlcSoGCditPmeffw4FsuI+VuvH/d
         0FxA==
X-Gm-Message-State: APjAAAWH49ZGkB3s2OQAxUZ3xYi0IhRTsiCb3g4ZzUJKZHE1ur3+JSuH
        m68Ld6ogMw5th33bJdC9qbu6kw==
X-Google-Smtp-Source: APXvYqz94JsNDcpcmRkN70+HkHIcd6+Mz1HWtd4o8rGjA5RUlEsXqOEPsarqlnBZr+tByk/gRvP3gA==
X-Received: by 2002:a37:68ca:: with SMTP id d193mr81764803qkc.240.1560811895507;
        Mon, 17 Jun 2019 15:51:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id d141sm7926869qke.3.2019.06.17.15.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 15:51:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hd0TO-00083X-B6; Mon, 17 Jun 2019 19:51:34 -0300
Date:   Mon, 17 Jun 2019 19:51:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/8] tpm: block messages while suspended
Message-ID: <20190617225134.GA30762@ziepe.ca>
References: <20190613180931.65445-1-swboyd@chromium.org>
 <20190613180931.65445-2-swboyd@chromium.org>
 <20190613232613.GH22901@ziepe.ca>
 <5d03e394.1c69fb81.f028c.bffb@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d03e394.1c69fb81.f028c.bffb@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:12:36AM -0700, Stephen Boyd wrote:
> Quoting Jason Gunthorpe (2019-06-13 16:26:13)
> > On Thu, Jun 13, 2019 at 11:09:24AM -0700, Stephen Boyd wrote:
> > > From: Andrey Pronin <apronin@chromium.org>
> > > 
> > > Other drivers or userspace may initiate sending a message to the tpm
> > > while the device itself and the controller of the bus it is on are
> > > suspended. That may break the bus driver logic.
> > > Block sending messages while the device is suspended.
> > > 
> > > Signed-off-by: Andrey Pronin <apronin@chromium.org>
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > 
> > > I don't think this was ever posted before.
> > 
> > Use a real lock.
> > 
> 
> To make sure the bit is tested under a lock so that suspend/resume can't
> update the bit in parallel?

No, just use a real lock, don't make locks out of test bit/set bit

Jason
