Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34794C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B78A206A1
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568220359;
	bh=FxFoVzGZnxzVmHT/ajZsQATIhSFY4/l83yxp9r3+px4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=M6tNhBHdf5rqbXULUISFTUuwQaWY3kZmdcBedHS19ipQqsEDRdNqlQlWz6svQItSm
	 iqq3aNExP24qO3Sr9ECyCa+Xi8Audx4rkwj+LVA+FFE/w70YGC7ccJh3G0AwKvu8xE
	 Z6OFq8/WR9D2T7G4E6UbxH4RpGDcBuylaEAmjhiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfIKQp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:45:58 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:47098 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbfIKQp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:45:58 -0400
Received: by mail-lj1-f170.google.com with SMTP id e17so20630941ljf.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 09:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wf1+jULNUBIRfuJ/ktIVdHO9nr5Te4e7BDdkxRDxruc=;
        b=NiGsioIWb1UrmV45MfrUxasndeSXyXrMUZYdOcd3rJFap5jXHj8y8efpflvu/A89aC
         +Eb6BGydyvMIPB/pNWEOTC2hB+shmjmGnnFt1qyQ4ahtmT/L1kXFudMp/Tn9yUYjwqW2
         ZmmpG2iBfK5s/ihr9utJJ9/iI0iLKcbwFjrTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wf1+jULNUBIRfuJ/ktIVdHO9nr5Te4e7BDdkxRDxruc=;
        b=nu/nnCso/9UgFI3vuRCZ1qKmriGth3erMSd2qWiAyJ7cAQ7CcfbssD1pu0EGF6sjYB
         AYpmwR+L1fN696seizdocxYfw5pXXMPgjdQR966VFUtjV2jLX5/Gdg9L8MzmQJQ63GW+
         fbOOyKzApJGJixPK/yGwxPwR476EGFAtQ6Ur7Xpc14rwj0sWigyENBfAe9ek17/V9Akv
         pDMxOXf1Jnv3j+FtCm18XIYj9RaOQZ95yBic05E2JT635ecyqXDdo+bYMXIONIvTk02T
         eN0CUJZMC1n4ByO6pDdQR6LsQiyMfC6fXhSDrYY/W3TnxzGeGQbnb40nZAYDauP3QFj+
         8e2g==
X-Gm-Message-State: APjAAAWSs2TgyGIAa7NYObKoODa804w/UNuau/J4KaSHfh1weBHfFWZF
        ulf8ZXi6TM/hOQQ1C4WqYsUb0KZD+9/0tA==
X-Google-Smtp-Source: APXvYqydCEeGB9c6ffHdgpk1zoW5/+K/0vu1Q+H4pVNaDDWPXHIET4VvzNTik1+ce/bdhA0FYOsGjg==
X-Received: by 2002:a2e:99c1:: with SMTP id l1mr18181222ljj.8.1568220355620;
        Wed, 11 Sep 2019 09:45:55 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id d12sm5288221lfn.93.2019.09.11.09.45.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 09:45:54 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id j16so20681890ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 09:45:54 -0700 (PDT)
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr16069144ljo.180.1568220354002;
 Wed, 11 Sep 2019 09:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc> <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc> <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu>
In-Reply-To: <20190911160729.GF2740@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Sep 2019 17:45:38 +0100
X-Gmail-Original-Message-ID: <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
Message-ID: <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 5:07 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > Ted, comments? I'd hate to revert the ext4 thing just because it
> > happens to expose a bad thing in user space.
>
> Unfortuantely, I very much doubt this is going to work.  That's
> because the add_disk_randomness() path is only used for legacy
> /dev/random [...]
>
> Also, because by default, the vast majority of disks have
> /sys/block/XXX/queue/add_random set to zero by default.

Gaah. I was looking at the input randomness, since I thought that was
where the added randomness that Ahmed got things to work with came
from.

And that then made me just look at the legacy disk randomness (for the
obvious disk IO reasons) and I didn't look further.

> So the the way we get entropy these days for initializing the CRNG is
> via the add_interrupt_randomness() path, where do something really
> fast, and we assume that we get enough uncertainity from 8 interrupts
> to give us one bit of entropy (64 interrupts to give us a byte of
> entropy), and that we need 512 bits of entropy to consider the CRNG
> fully initialized.  (Yeah, there's a lot of conservatism in those
> estimates, and so what we could do is decide to say, cut down the
> number of bits needed to initialize the CRNG to be 256 bits, since
> that's the size of the CHACHA20 cipher.)

So that's 4k interrupts if I counted right, and yeah, maybe Ahmed was
just close enough before, and the merging of the inode table IO then
took him below that limit.

> Ultimately, though, we need to find *some* way to fix userspace's
> assumptions that they can always get high quality entropy in early
> boot, or we need to get over people's distrust of Intel and RDRAND.

Well, even on a PC, sometimes rdrand just isn't there. AMD has screwed
it up a few times, and older Intel chips just don't have it.

So I'd be inclined to either lower the limit regardless - and perhaps
make the "user space asked for randomness much too early" be a big
*warning* instead of being a basically fatal hung machine?

                Linus
