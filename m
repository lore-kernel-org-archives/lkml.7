Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6091C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3CC217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565286659;
	bh=z6z2k7XGC4MH4Kn/tKibaTPY7NOdKLZy10eZRNIuk5I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sRx7n7TCB69yD6RaQH6Y7UQqJjv6s8r7TPsHneD5oabK1MAZCoxDI4NISBtXDcirX
	 OGkD/7OOcB9WzlCtDN6ZpzzRU03Eywoqow64Z83lqGWYZpjPHMft7qhEx55ayQq59F
	 29myhFD/TAzpVeD30j+1nRwKFU3IlHVhVZdjMvd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733207AbfHHRu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:50:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35297 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729925AbfHHRu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:50:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id x25so89780350ljh.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PaqvtAtk6zixEgRbfRi83KAjX0fbzFPUrAlK05McGqs=;
        b=bgbHJGPTR7Koz+c795LwPw5LpjTkYHSGo/WjpWK8uhqHWX4RU/bw/U9W/Ciokdadeu
         SGeRFfN9p7jgody3HoUb/XyE+F1uRIDJUun78fKUfuAUfCCMsxPiNoI47NPA99/T2Ok4
         kVZRDdHEM2k89KQ/yjYtrD7kr74Ot3DoZ7wk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PaqvtAtk6zixEgRbfRi83KAjX0fbzFPUrAlK05McGqs=;
        b=ThkZNv1lG1x0/kqoikXlpU9jSP6IX36Sd9xvXdBXCDfzgu1beCIpcNywFvoU59UbPq
         RFbunPKa81U7vYglvrfu4C2TQ/GUQywxlq+Qt92vDpdiCaIm0iRgCqmVNUJl/HTcBtUa
         hRa1E7os8RjT9E0EoVcxVWZyAhUzHLvpJpDVwwXGW4TP/I7EKxXDHkZbtBq9XvLUC8nk
         IBh7r3DuFdPjg7psf3O+vtUvAx3WqcAKXGVvriq3idqD9UI2WnswaMdON5GHYx13MqFu
         YjHTrNHi6TNrTLbh4QOJEzr9HdSsg/gFd5UpGLP5rWLQciyTER6v9JtiIjmmPHrdJO/S
         vYAA==
X-Gm-Message-State: APjAAAXGqhl1dMK4TOKDS6+2i9Vfs5a0JI/rPsdYD4nMcT/ozG+UujSj
        wRKgMON/EreSXSUBj+SyiIEM0nJ6CAk=
X-Google-Smtp-Source: APXvYqyZuT0DMCqKkT7JRf2I6aLxcM//0inHG9YuY7ROOmF1GO73Ap2F1T8kQUmTKFv/gTfazvzK7g==
X-Received: by 2002:a2e:9951:: with SMTP id r17mr8918804ljj.125.1565286655172;
        Thu, 08 Aug 2019 10:50:55 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id u15sm19147029lje.89.2019.08.08.10.50.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 10:50:53 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id j17so13477276lfp.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 10:50:53 -0700 (PDT)
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr10385649lfp.61.1565286653238;
 Thu, 08 Aug 2019 10:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190808154240.9384-1-hch@lst.de>
In-Reply-To: <20190808154240.9384-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Aug 2019 10:50:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com>
Message-ID: <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com>
Subject: Re: cleanup the walk_page_range interface
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Steven Price <steven.price@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 8:42 AM Christoph Hellwig <hch@lst.de> wrote:
>
> this series is based on a patch from Linus to split the callbacks
> passed to walk_page_range and walk_page_vma into a separate structure
> that can be marked const, with various cleanups from me on top.

The whole series looks good to me. Ack.

> Note that both Thomas and Steven have series touching this area pending,
> and there are a couple consumer in flux too - the hmm tree already
> conflicts with this series, and I have potential dma changes on top of
> the consumers in Thomas and Steven's series, so we'll probably need a
> git tree similar to the hmm one to synchronize these updates.

I'd be willing to just merge this now, if that helps. The conversion
is mechanical, and my only slight worry would be that at least for my
original patch I didn't build-test the (few) non-x86
architecture-specific cases. But I did end up looking at them fairly
closely  (basically using some grep/sed scripts to see that the
conversions I did matched the same patterns). And your changes look
like obvious improvements too where any mistake would have been caught
by the compiler.

So I'm not all that worried from a functionality standpoint, and if
this will help the next merge window, I'll happily pull now.

             Linus
