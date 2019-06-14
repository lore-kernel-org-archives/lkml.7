Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545DCC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2168D21721
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="RDZZZjUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfFNNiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:38:07 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34517 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbfFNNiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:38:07 -0400
Received: by mail-qt1-f193.google.com with SMTP id m29so2483254qtu.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 06:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5t38AdsOWv2f4Esw1W+MkepSRzr1WITdyAORH+5HjYw=;
        b=RDZZZjUcgP1IQISh2OS0tjJq7h2lcyaLEZF4ZlCEaiFMBb9xylkmRKTOFdBqzT4CmS
         pPUNoWCPpe3HFF/pMsbtof/jbvEp5RIksEwku+dWkHcrlYJ26kD9Dqq5vGTtWz2qLZsm
         VigUHIj4paQ6Tly6gHAio3+6dTylmk0AM/qW0Xa+828w0olfCI3nAOPWG3ZBTFlUUwjr
         9ow0YUAkq1hZQxV/aVZ/hWkdJ/YlB0EkCruIxzq+fKMxvsU6C/q0Q9meiBgvgag9IWlF
         nccl5LY9zCXLLTksQBIci7LGgigiZ7vLU/6wZgWVN3V/czpvgZ2WGFhaN6Pw1JJ3t5FP
         dI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5t38AdsOWv2f4Esw1W+MkepSRzr1WITdyAORH+5HjYw=;
        b=A5WNMmmfDMVPT4hHRs2nmO9Jl/ASCaQYw75tuIXb9Jr0nPOUUGydgnh2hFY8KclZ9m
         bW3R5qOgE4UG26IVNO9btrOVwblZt9B5cQs/ItbA8JlsFuKz+XO+w1EqmMX8NnVGkHfj
         gS0Qs51x1nmZTYYppiteEjsFUeDmh6pbKBrKxbAqwMi/OGkAD088uv55fjT0pj6d7+BA
         W1Z/Jcvw8+NtNCQJzh2RSiVN/H1mNBVO/3osmpD0HeZWV97/c7QuNh0rFsZk8Nm0jAxz
         dyPIrtT8lbkBtoftiSbweBfQewTDfPssDvpu1Lhgw45ePkcRpvh8S6IXFzyyqrVx5N9d
         h/Qw==
X-Gm-Message-State: APjAAAX6YxEhl99FM2vImDtoynFWeOMpbQOoFPiLZUmvA3PvYNEdviq7
        pWx1XDZRb1LfCceig28DZHRy5A==
X-Google-Smtp-Source: APXvYqzNmd+0+Nn6Q5ZrbPLFXLvgSb2BGcTgyraQHFgk83zTbcB39HZrH2xAznSe9nH6+xMmLCqDLg==
X-Received: by 2002:ac8:2fa8:: with SMTP id l37mr78660838qta.358.1560519486142;
        Fri, 14 Jun 2019 06:38:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a658])
        by smtp.gmail.com with ESMTPSA id t67sm1449588qkf.34.2019.06.14.06.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:38:05 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:38:04 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Wouter Verhelst <w@uter.be>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Roman Stratiienko <roman.stratiienko@globallogic.com>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        Aleksandr Bulyshchenko <A.Bulyshchenko@globallogic.com>,
        linux-block@vger.kernel.org, axboe@kernel.dkn.org
Subject: Re: [PATCH 2/2] nbd: add support for nbd as root device
Message-ID: <20190614133802.vg3w3sxpid2fpbp4@MacBook-Pro-91.local>
References: <20190612163144.18486-1-roman.stratiienko@globallogic.com>
 <20190612163144.18486-2-roman.stratiienko@globallogic.com>
 <20190613135241.aghcrrz7rg2au3bw@MacBook-Pro-91.local>
 <CAODwZ7v=RSsmVj5GjcvGn2dn+ejLRBHZ79x-+S9DrX4GoXuVaQ@mail.gmail.com>
 <20190613145535.tdesq3y2xy6ycpw7@MacBook-Pro-91.local>
 <20190614103343.GB11340@grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614103343.GB11340@grep.be>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 12:33:43PM +0200, Wouter Verhelst wrote:
> On Thu, Jun 13, 2019 at 10:55:36AM -0400, Josef Bacik wrote:
> > Also I mean that there are a bunch of different nbd servers out there.  We have
> > our own here at Facebook, qemu has one, IIRC there's a ceph one.
> 
> I can't claim to know about the Facebook one of course, but the qemu one
> uses the same handshake protocol as anyone else. The ceph ones that I've
> seen do too (but there are various implementations of that, so...).
> 

Ah, for some reason I remembered Qemu's being distinctly different.

I suppose if most of the main ones people use are using the same handshake
protocol that makes it more compelling.  But there'd have to be a really good
reason why a initramfs isn't viable, and so far I haven't heard a solid reason
that's not an option other than "it's hard and we don't want to do it."

> > They all have their own connection protocols.  The beauty of NBD is
> > that it doesn't have to know about that part, it just does the block
> > device part, and I'd really rather leave it that way.  Thanks,
> 
> Sure.
> 
> OTOH, there is definitely also a benefit to using the same handshake
> protocol everywhere, for interoperability reasons.
> 

Sure, Facebook's isn't different because we hate the protocol, we just use
Thrift for all of our services, and thus it makes sense for us to use thrift for
the client connection stuff to make it easy on all the apps that use disagg.
Thanks,

Josef
