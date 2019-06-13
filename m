Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAABC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AE42080A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="gpHQ/bLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404484AbfFMQyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:54:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34137 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404474AbfFMQyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:54:49 -0400
Received: by mail-qk1-f195.google.com with SMTP id t8so9521899qkt.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 09:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yOlq9/cnKUf58RBN8U9nKcy5UZOs9qGQCumfqe7jZ8c=;
        b=gpHQ/bLmEGM/wfem9wjHlttvx5YiGjPwT/u36I7n7oSVzWpFpHjYj2L4hUjv4lm9XO
         88kzzQeW7JVz92cBQKqYiwLJEzdL4TVeLyPtZIvyGS4sTz1YMqYNAcVwAOiYu1DZ88uj
         imlKcFuW+ag52SlfM+r8drN5Rmpdu+YZCUxJJb6fQv3fEFfuOUHlloiz0kM5x8Zkl9du
         Vb03W/0Vn/7Svv9YarlOhUO3OOzNsqNb9ZENAauxnuBucS+p02IPc+Us5GhfTSTPrXwV
         tUSxOg8HGjp0M7ClHrKamigpXbDoaOSfkOuXpgz5saGaeyigGTAIJjT/pVPBCGI8LqPb
         p9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yOlq9/cnKUf58RBN8U9nKcy5UZOs9qGQCumfqe7jZ8c=;
        b=JbjnHl7lZ/w1Q8HzC9FQmeiTN2UFCO4EDO43nN8Bap8X4lyxZ+GDZpZxkdWl3g3e4x
         pUI78HXbD0xqZs/BnVEcqeIWplrDk5ToiSEIW1/aPJi+4JAI1zT13xCTJ+hfJ5nmEswA
         a3f9J2ng5ZKLnZfNBRzNa0vXm8iz62DNscqU7AXSRsscJQo5CnBwL6fj6H7+eztKJTP4
         9FMp4xKHF6wWergRh+uH5TGSgJzn1aSddE5xtK9ANMrqxCtohi6p0YzT1wLgXlEjco9u
         1L4YfSUwljeAV8EpgdQJZni27XJXselZIlPxX+S0edPbJ4IdEpLlPCCaRf7JfjGhWZKs
         mfOg==
X-Gm-Message-State: APjAAAXe74XdCRMKkjsg9vTI6u0+QVgEumwZtPnWOQ8iRqWL6N55Lx/m
        sY1q34P36HXlSAfAhmrwHDTEFg==
X-Google-Smtp-Source: APXvYqxyuH5IBObnKkcdS09bJVE6NC5rFdmbqwiDVXyLYGh2OnmAzufcVgAM1WT2j6xoZWPRgOuCnA==
X-Received: by 2002:a37:9bca:: with SMTP id d193mr72859834qke.122.1560444888347;
        Thu, 13 Jun 2019 09:54:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d1])
        by smtp.gmail.com with ESMTPSA id x10sm138866qtc.34.2019.06.13.09.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 09:54:47 -0700 (PDT)
Date:   Thu, 13 Jun 2019 12:54:46 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
        nbd@other.debian.org,
        Aleksandr Bulyshchenko <A.Bulyshchenko@globallogic.com>,
        linux-block@vger.kernel.org, axboe@kernel.dkn.org
Subject: Re: [PATCH 2/2] nbd: add support for nbd as root device
Message-ID: <20190613165444.kfd53humatuv5j2w@MacBook-Pro-91.local>
References: <20190612163144.18486-1-roman.stratiienko@globallogic.com>
 <20190612163144.18486-2-roman.stratiienko@globallogic.com>
 <20190613135241.aghcrrz7rg2au3bw@MacBook-Pro-91.local>
 <CAODwZ7v=RSsmVj5GjcvGn2dn+ejLRBHZ79x-+S9DrX4GoXuVaQ@mail.gmail.com>
 <20190613145535.tdesq3y2xy6ycpw7@MacBook-Pro-91.local>
 <CAODwZ7so4cVVJmPHXGGOxKRO_0L2NjZJac73wfaHPV7ZN6ce1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODwZ7so4cVVJmPHXGGOxKRO_0L2NjZJac73wfaHPV7ZN6ce1g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 07:21:43PM +0300, Roman Stratiienko wrote:
> > I don't doubt you have a good reason to want it, I'm just not clear on why an
> > initramfs isn't an option?  You have this special kernel with your special
> > option, and you manage to get these things to boot your special kernel right?
> > So why is a initramfs with a tiny nbd-client binary in there not an option?
> >
> > Also I mean that there are a bunch of different nbd servers out there.  We have
> > our own here at Facebook, qemu has one, IIRC there's a ceph one.  They all have
> > their own connection protocols.  The beauty of NBD is that it doesn't have to
> > know about that part, it just does the block device part, and I'd really rather
> > leave it that way.  Thanks,
> >
> > Josef
> 
> 
> The only reason I prefer embed client into the kernel is to save
> valuable engineering time creating and supporting custom initramfs,
> that is not so easy especially on Android-based systems.
> 

I'm unconvinced that creating an initramfs is any harder than building your own
kernel with this patch and providing the configuration information to the
device, especially for android where we inside of Facebook provision android
devices with a custom initramfs all the time, and have done so for many, many
years.

> Taking into account that if using NBD and creating custom initramfs
> required only for automated testing, many companies would choose
> manual deployment instead, that is bad for the human progress.
> 
> I believe that all users of non-standard NBD handshake protocols could
> continue to use custom nbd-clients.

There is no "standard NBD handshake protocol" is my point.  That part exists
outside of the NBD spec that the kernel is concerned with.  The client is happy
to do whatever it pleases.  Now there's no doubt that the standard nbd client
and server that is shipped is the reference spec, but my point is that it is
still outside the kernel and so able to change as it sees fit.

> 
> Either you accept this patch or not I would like to pass review from
> maintainers and other persons that was involved in NBD development,
> thus making a step closer to get this mainlined in some future.

...I am the maintainer, but feel free to try to get Jens to take a patch that I
think is unnecessary.  Thanks,

Josef
